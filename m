Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epD0B-0006BW-0e
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epD06-0005xh-8O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:03:03 -0500
Date: Fri, 23 Feb 2018 14:02:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180223140247.75ad7493.cohuck@redhat.com>
In-Reply-To: <1519390265-15576-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519390265-15576-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] s390x/sclp: 64 bit event masks
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

On Fri, 23 Feb 2018 13:51:02 +0100
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
> v2 -> v3
> * fixed some typos in the first patch description
> * updated an existing comment in the third patch: newer Linux versions
>   will support masks larger than 4 bytes.

Update looks good to me.

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
>  hw/s390x/event-facility.c         | 157 ++++++++++++++++++++++++++++++--------
>  hw/s390x/s390-virtio-ccw.c        |   8 +-
>  hw/s390x/sclpcpu.c                |   4 +-
>  hw/s390x/sclpquiesce.c            |   4 +-
>  include/hw/s390x/event-facility.h |  22 +++---
>  7 files changed, 155 insertions(+), 48 deletions(-)
> 
