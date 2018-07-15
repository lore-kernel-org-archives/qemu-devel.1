Received: from eggs.gnu.org ([2001:4830:134:3::10]:34669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fehxu-0003El-68
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fehxr-0002PY-1x
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fehxq-0002Ny-Pk
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:25:30 -0400
References: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
	<20180714135327.GA16925@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdc07adc-920f-71dd-ba91-06ea08e73f7c@redhat.com>
Date: Sun, 15 Jul 2018 16:25:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180714135327.GA16925@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] bcm2835_aux: Swap RX and TX interrupt assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org

On 14/07/2018 15:53, Guenter Roeck wrote:
> ping ...

Queued, thanks.

Paolo

> On Mon, Jun 18, 2018 at 02:04:06PM -0700, Guenter Roeck wrote:
>> RX and TX interrupt bits were reversed, resulting in an endless sequence
>> of serial interupts in the emulated system and the following repeated
>> error message when booting Linux.
>>
>> serial8250: too much work for irq61
>>
>> This results in a boot failure most of the time.
>>
>> Qemu command line used to reproduce the problem:
>>
>> 	qemu-system-aarch64 -M raspi3 -m 1024 \
>> 	-kernel arch/arm64/boot/Image \
>> 	--append "rdinit=/sbin/init console=ttyS1,115200"
>> 	-initrd rootfs.cpio \
>> 	-dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb \
>> 	-nographic -monitor null -serial null -serial stdio
>>
>> This is with arm64:defconfig. The root file system was generated using
>> buildroot.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  hw/char/bcm2835_aux.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
>> index 370dc7e..0364596 100644
>> --- a/hw/char/bcm2835_aux.c
>> +++ b/hw/char/bcm2835_aux.c
>> @@ -39,8 +39,8 @@
>>  #define AUX_MU_BAUD_REG 0x68
>>  
>>  /* bits in IER/IIR registers */
>> -#define TX_INT  0x1
>> -#define RX_INT  0x2
>> +#define RX_INT  0x1
>> +#define TX_INT  0x2
>>  
>>  static void bcm2835_aux_update(BCM2835AuxState *s)
>>  {
