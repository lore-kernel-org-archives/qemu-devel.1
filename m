Received: from eggs.gnu.org ([208.118.235.92]:46792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsrg-0007rH-Fs
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsYu-0006Mk-UH
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gcsYu-0006Kj-KW
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:52:28 -0500
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62ec6c1d-4ed8-11ad-f8a6-dd85f4fe53ab@redhat.com>
Date: Fri, 28 Dec 2018 14:52:19 +0100
MIME-Version: 1.0
In-Reply-To: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] smbus_eeprom: Limit data writes to 255
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Hanselmann <public@hansmi.ch>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 27/12/18 12:51, Michael Hanselmann wrote:
> The "eeprom_write_data" function in "smbus_eeprom.c" had no provisions
> to limit the length of data written. If a caller were able to manipulate
> the "len" parameter they could potentially write before or after the
> target buffer.
> ---
>  hw/i2c/smbus_eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3de35..74fa1c328c 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -76,6 +76,7 @@ static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int l
>         It is a block write without a length byte.  Fortunately we
>         get the full block anyway.  */
>      /* TODO: Should this set the current location?  */
> +    len &= 0xff;
>      if (cmd + len > 256)
>          n = 256 - cmd;
>      else
> 

Note that len is limited to 33 bytes (smbus_do_write and smbus_i2c_send).

Paolo
