Received: from eggs.gnu.org ([209.51.188.92]:33332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz3V6-000501-0y
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz3V4-0001m8-C9
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:00:11 -0500
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d0180c5-32f9-8efd-1256-68ca893661d0@redhat.com>
Date: Wed, 27 Feb 2019 11:59:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190227172256.30368-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/20] qcow2: Extend spec for external data
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

On 2/27/19 11:22 AM, Kevin Wolf wrote:
> This adds external data file to the qcow2 spec as a new incompatible
> feature.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/interop/qcow2.txt | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index fb5cb47245..1c1849dc26 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -97,7 +97,19 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
>  
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      External data file bit.  If this bit is set, an
> +                                external data file is used. Guest clusters are
> +                                then stored in the external data file. For such
> +                                images, clusters in the external data file are
> +                                not refcounted. The offset field in the
> +                                Standard Cluster Descriptor must match the
> +                                guest offset and neither compressed clusters
> +                                nor internal snapshots are supported.
> +
> +                                An external data file name header extension may
> +                                be present if this bit is set.
> +
> +                    Bits 3-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -126,7 +138,17 @@ in the description of a field.
>                                  bit is unset, the bitmaps extension data must be
>                                  considered inconsistent.
>  
> -                    Bits 1-63:  Reserved (set to 0)
> +                    Bit 1:      If this bit is set, the external data file can
> +                                be read as a consistent standalone raw image
> +                                without looking at the qcow2 metadata.
> +
> +                                Setting this bit has a performance impact for
> +                                some operations on the image (e.g. writing
> +                                zeros requires writing to the data file instead
> +                                of only setting the zero flag in the L2 table
> +                                entry) and conflicts with backing files.

Is it an error if an image has this bit set but not the 'external data
file bit' in the incompatible bits?

> +
> +                    Bits 2-63:  Reserved (set to 0)
>  
>           96 -  99:  refcount_order
>                      Describes the width of a reference count block entry (width
> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like the following:
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
> +                        0x44415441 - External data file name

Likewise, should it be an explicit error if this header is present
without the 'external data file bit'?

>                          other      - Unknown header extension, can be safely
>                                       ignored
>  
> @@ -437,6 +460,11 @@ L2 table entry:
>                      This information is only accurate in L2 tables
>                      that are reachable from the active L1 table.
>  
> +                    With external data files, all guest clusters have an
> +                    implicit refcount of 1 (because of the fixed host = guest
> +                    mapping for guest cluster offsets), so this bit should be 1
> +                    for all allocated clusters.
> +
>  Standard Cluster Descriptor:
>  
>      Bit       0:    If set to 1, the cluster reads as all zeros. The host
> @@ -450,8 +478,10 @@ Standard Cluster Descriptor:
>           1 -  8:    Reserved (set to 0)
>  
>           9 - 55:    Bits 9-55 of host cluster offset. Must be aligned to a
> -                    cluster boundary. If the offset is 0, the cluster is
> -                    unallocated.
> +                    cluster boundary. If the offset is 0 and bit 63 is clear,
> +                    the cluster is unallocated. The offset may only be 0 with
> +                    bit 63 set (indicating a host cluster offset of 0) when an
> +                    external data file is used.

Looks good, modulo any additions you want to make based on answering my
questions above.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
