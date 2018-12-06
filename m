Received: from eggs.gnu.org ([2001:4830:134:3::10]:60590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUtEt-0002jM-C0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUtEp-0000za-8y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:58:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUtEp-0000yu-2U
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:58:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so367567wrs.10
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:58:43 -0800 (PST)
References: <20181206121830.6177-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c593e3d0-1e2f-a523-ea36-b1bf159c509d@redhat.com>
Date: Thu, 6 Dec 2018 13:58:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181206121830.6177-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Hanselmann <public@hansmi.ch>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/6/18 1:18 PM, P J P wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>              if (!read && s->smb_index == s->smb_data0) {
>                  uint8_t prot = (s->smb_ctl >> 2) & 0x07;
>                  uint8_t cmd = s->smb_cmd;
> 
