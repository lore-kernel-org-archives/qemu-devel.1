Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqLoq-0004gK-Tw
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqLom-0008Cw-TD
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:40:04 -0500
Date: Mon, 26 Feb 2018 17:39:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180226173940.0b5fdf60.cohuck@redhat.com>
In-Reply-To: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] s390x/sclp: 64 bit event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Fri, 23 Feb 2018 18:42:55 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
> we only supported 32bit sclp event masks, even though the archiecture
> allows the guests to set up sclp event masks up to 1021 bytes in length.
> With that patch the behaviour was almost compliant, but some issues were
> still remaining, in particular regarding the handling of selective reads
> and migration.
> 
> This patchset fixes migration and the handling of selective reads, and
> puts in place the support for 64-bit sclp event masks internally.
> 
> A new property of the sclp-event device switches between the 32bit masks
> and the compliant behaviour. The property is bound to the machine
> version, so older machines keep the old broken behaviour, allowing for
> migration, but the default is the compliant implementation.
> 
> Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
> 
> v3 -> v4
> * removed all pre_load hooks
> * split the internal represntation of the receive mask into an array of
>   uint32_t and added accessors; the union would not work on little
>   endian hosts!

Oops. Did you test under a le host? How can I test this (I guess using
the current s390/features branch as guest)?

> * fixed the pre-existing documentation comment for copy_mask
> 
> v2 -> v3
> * fixed some typos in the first patch description
> * updated an existing comment in the third patch: newer Linux versions
>   will support masks larger than 4 bytes.
> 
> v1 -> v2 
> * improved comments and patch descriptions to better explain why we need
>   this, including better description of the old broken behaviour
> * rename SCLPEVMSK to SCLP_EVMASK to improve readability
> * removed some unneded variable initializations
> * fixed a pre-existing typo
> 
> Claudio Imbrenda (3):
>   s390x/sclp: proper support of larger send and receive masks
>   s390x/sclp: clean up sclp masks
>   s390x/sclp: extend SCLP event masks to 64 bits
> 
>  hw/char/sclpconsole-lm.c          |   4 +-
>  hw/char/sclpconsole.c             |   4 +-
>  hw/s390x/event-facility.c         | 153 ++++++++++++++++++++++++++++++--------
>  hw/s390x/s390-virtio-ccw.c        |   8 +-
>  hw/s390x/sclpcpu.c                |   4 +-
>  hw/s390x/sclpquiesce.c            |   4 +-
>  include/hw/s390x/event-facility.h |  22 +++---
>  7 files changed, 148 insertions(+), 51 deletions(-)
> 
