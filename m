Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhkR-0000ur-0h
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhkQ-0003IG-0x
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:42:03 -0400
References: <20180321173714.14741-1-kwolf@redhat.com>
	<20180321173714.14741-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1815227-3a5b-1272-3d38-cbe9cee75f1c@redhat.com>
Date: Wed, 21 Mar 2018 12:41:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180321173714.14741-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2 01/12] vdi: Change 'static'
 create option to 'preallocation' in QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/21/2018 12:37 PM, Kevin Wolf wrote:
> What static=on really does is what we call metadata preallocation for
> other block drivers. While we can still change the QMP interface, make
> it more consistent by using 'preallocation' for VDI, too.
> 
> This doesn't implement any new functionality, so the only supported
> preallocation modes are 'off' and 'metadata' for now.

Disagrees with:

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  7 +++----
>   block/vdi.c          | 24 ++++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 6 deletions(-)

> +# @preallocation    Preallocation mode for the new image (allowed values: off,
> +#                   full; default: off)

this.


> +    if (!vdi_opts->has_preallocation) {
> +        vdi_opts->preallocation = PREALLOC_MODE_OFF;
> +    }
> +    switch (vdi_opts->preallocation) {
> +    case PREALLOC_MODE_OFF:
> +        image_type = VDI_TYPE_DYNAMIC;
> +        break;
> +    case PREALLOC_MODE_METADATA:
>           image_type = VDI_TYPE_STATIC;
> +        break;
> +    default:
> +        error_setg(errp, "Preallocation mode not supported for vdi");

but matches this.  Fix your QMP documentation with s/full/metadata/ and 
you can have:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
