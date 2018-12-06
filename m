Received: from eggs.gnu.org ([2001:4830:134:3::10]:41190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUqQc-0006jC-NB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUqQY-0007r7-Nc
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:58:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gUqQY-0007qb-Hk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:58:38 -0500
Date: Thu, 6 Dec 2018 10:58:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181206105830.43eb1d05@redhat.com>
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
References: <20181206084816.30485-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Hanselmann <public@hansmi.ch>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu,  6 Dec 2018 14:18:16 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While performing block transfer write in smb_ioport_writeb(),
> 'smb_index' is incremented and used to index smb_data[] array.
> Check 'smb_index' value to avoid OOB access.
> 
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
pls squash in:

Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability

> ---
>  hw/i2c/pm_smbus.c | 3 +++
>  1 file changed, 3 insertions(+)
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
>              if (!read && s->smb_index == s->smb_data0) {
>                  uint8_t prot = (s->smb_ctl >> 2) & 0x07;
>                  uint8_t cmd = s->smb_cmd;
