Received: from eggs.gnu.org ([2001:4830:134:3::10]:47407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5Ssz-0001KA-RI
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5Ssz-0000dd-3O
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:42:33 -0400
Date: Fri, 20 Oct 2017 10:42:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020084221.GA3667@localhost.localdomain>
References: <20171004114008.14849-1-berrange@redhat.com>
	<20171004114008.14849-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004114008.14849-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] ide: support reporting of rotation
 rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

[ Cc: qemu-block ]

Am 04.10.2017 um 13:40 hat Daniel P. Berrange geschrieben:
> The Linux kernel will query the ATA IDENTITY DEVICE data, word 217
> to determine the rotations per minute of the disk. If this has
> the value 1, it is taken to be an SSD and so Linux sets the
> 'rotational' flag to 0 for the I/O queue and will stop using that
> disk as a source of random entropy. Other operating systems may
> also take into account rotation rate when setting up default
> behaviour.
> 
> Mgmt apps should be able to set the rotation rate for virtualized
> block devices, based on characteristics of the host storage in use,
> so that the guest OS gets sensible behaviour out of the box. This
> patch thus adds a 'rotation-rate' parameter for 'ide-hd' device
> types.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/ide/core.c             | 1 +
>  hw/ide/qdev.c             | 1 +
>  include/hw/ide/internal.h | 8 ++++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 5f1cd3b91f..a04766aee7 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -208,6 +208,7 @@ static void ide_identify(IDEState *s)
>      if (dev && dev->conf.discard_granularity) {
>          put_le16(p + 169, 1); /* TRIM support */
>      }
> +    put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */

Coverity points out that all other dereferences of dev have a NULL check
first. Are we sure that it is always non-NULL?

A follow-up patch is necessary either way. Either fix the missing NULL
check here or remove useless NULL checks in the other places.

Kevin
