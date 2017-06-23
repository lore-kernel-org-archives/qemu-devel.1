Received: from eggs.gnu.org ([2001:4830:134:3::10]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOV5L-0000cQ-VM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOV5I-000683-PS
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:21:43 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:34977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOV5I-00067r-Ju
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:21:40 -0400
Received: by mail-qk0-x22f.google.com with SMTP id 16so44314450qkg.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 13:21:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
	<20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
	<ecb7491d-6446-a9fa-49d1-f4aaade16470@amsat.org>
	<CAEz5UgGWxLNg+3Qg02H9Mpzkpy=MwP8YFYamZ8LdxK1gMuWq=g@mail.gmail.com>
	<CAEz5UgEQ1=RM2+v8ocUsZxA88jdk5Z+A0eo-G6=iD_CGoZQ2Sw@mail.gmail.com>
	<20170623192243.eb5bnfy2qqy3dqa4@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f0adf44-a0f0-2dd4-9f53-0c6280257ba6@amsat.org>
Date: Fri, 23 Jun 2017 17:21:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170623192243.eb5bnfy2qqy3dqa4@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Vinicius Maciel <viniciusfre@gmail.com>
Cc: qemu-devel@nongnu.org

Hi Vinicius,

On 06/23/2017 04:22 PM, Aurelien Jarno wrote:
> On 2017-06-23 15:14, Vinicius Maciel wrote:
>> Hi everyone,
>>
>> I'm having a problem similar to the reported in this email, but now I'm
>> trying to emulate a MIPS 24KEc,
>> ralink RT5350F.
>>
>> Assembly Code:
>> 0x802006a0 <reset+672>: lui t5,0xb011
>> 0x802006a4 <reset+676>: ori t5,t5,0x168
>> 0x802006a8 <reset+680>: li t6,23
>> 0x802006ac <reset+684>: nop
>> 0x802006b0 <reset+688>: sw t6,0(t5) <---
>>
>> The instruction "sw t6,0(t5)" try to write to address 0xb0110168 (0x10110168),
>> but Qemu decodes
>> this address to 2952790112 (0xb0000060). Is this address right?
> 
> sw is a write instruction...
[...]
> ... while helper_le_ldul_mmu and io_readl are read functions. The
> assembly code and the backtrace do not match. We can not conclude
> anything.
> 
> Aurelien

Looking at the RT5350 datasheet:
http://www.mouser.com/ds/2/813/RT5350-1022839.pdf

pp.19>
3.2 Memory Map Summary
1000.0000 - 1000.00FF 256 Mbps    SYSCTL
1011.0000 - 1011.7FFF  32 Kbps    Ethernet switch

pp.22>
3.4 System Control
3.4.3 Register Description (base: 0x1000_0000)
GPIOMODE: GPIO Purpose Select (offset: 0x0060)

pp.122>
3.19 Ethernet Switch
3.19.4 Register Description (base: 0x1011_0000)
LEDC: LED Control Register  (offset: 0x0168)
LED Polarity Control for each port: 1’b1: High active

having 23=0b10111 my guess is your reset() function try to toggle on 4 
leds. everything seems fine on QEMU side, now it depends how you 
implemented the SYSCTL and EthernetSwitch devices.

eventually you are missing some EthernetSwitch mapped registers and an 
exception is generated, ending reading some SYSCTL register...

running qemu-system with '-d in_asm,int,unimp' helps to understand if 
them problem comes from your model, before from QEMU core code.

regards,

Phil.
