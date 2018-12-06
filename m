Received: from eggs.gnu.org ([2001:4830:134:3::10]:50783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUuDd-000078-Ai
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUuAT-00043w-N3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUuAT-000420-G7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:58:17 -0500
Date: Thu, 6 Dec 2018 08:58:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181206085609-mutt-send-email-mst@kernel.org>
References: <20181206121830.6177-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206121830.6177-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Hanselmann <public@hansmi.ch>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Thu, Dec 06, 2018 at 05:48:30PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While performing block transfer write in smb_ioport_writeb(),
> 'smb_index' is incremented and used to index smb_data[] array.
> Check 'smb_index' value to avoid OOB access.
> 
> Note that this bug is exploitable by a guest to escape
> from the virtual machine. However the commit which
> introduced the bug was only made after the 3.0 release,
> and so it is not present in any released QEMU versions.
> 
> Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i2c/pm_smbus.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Update v1: add note about issue being introduced after 3.0 release
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01115.html
> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 685a2378ed..03062740cc 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -240,6 +240,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>              uint8_t read = s->smb_addr & 0x01;
>  
>              s->smb_index++;
> +            if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
> +                s->smb_index = 0;
> +            }

when I see patterns like these I always think "what about spectre".
But not a new issue and not the only place, so we can leave this
for another day.

>              if (!read && s->smb_index == s->smb_data0) {
>                  uint8_t prot = (s->smb_ctl >> 2) & 0x07;
>                  uint8_t cmd = s->smb_cmd;
> -- 
> 2.19.2
