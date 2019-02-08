Received: from eggs.gnu.org ([209.51.188.92]:60637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gs8j6-0000fR-01
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gs8j5-0006vT-5j
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:10:03 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47240
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gs8j3-0006te-BZ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:10:03 -0500
References: <20190103154810.GB32032@Red>
	<3a375dc6-f0ba-c3f0-6e86-2fd5cdf3ee35@ilande.co.uk>
	<8c302745-5097-afed-5c7e-9a992da03cf6@ilande.co.uk>
	<20190205091115.GA27918@Red>
	<2a85b239-7117-71aa-b921-86c42a54aeba@ilande.co.uk>
	<20190206072850.GA4295@Red>
	<8da59b77-eef2-4897-5254-0f6fb22539a6@ilande.co.uk>
	<20190206193824.GA1909@Red>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8be18f45-9ee1-c8b3-d818-efc808cbfa1c@ilande.co.uk>
Date: Fri, 8 Feb 2019 16:09:52 +0000
MIME-Version: 1.0
In-Reply-To: <20190206193824.GA1909@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sparc: crash when using initrd > 5M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: sparclinux@vger.kernel.org, qemu-devel@nongnu.org

On 06/02/2019 19:38, Corentin Labbe wrote:

> On Wed, Feb 06, 2019 at 07:37:29AM +0000, Mark Cave-Ayland wrote:
>> On 06/02/2019 07:28, Corentin Labbe wrote:
>>
>>>>> Hello
>>>>>
>>>>> Sorry even with the patch I still hit the issue.
>>>>>
>>>>> I have added some debug and at least qemu set initrd_size correctly now.
>>>>>
>>>>> I have tried to compile openbios-sparc32 for debugging but fail with
>>>>> arch/sparc32/context.c:116:5: error: PIC register clobbered by 'l7' in 'asm'
>>>>>      asm __volatile__ ("\n\tcall __switch_context"
>>>>>      ^~~
>>>>> make[1]: *** [rules.mak:219: target/arch/sparc32/context.o] Error 1
>>>>> (gcc 7.2 and gc 6.4 with binutils 2.30)
>>>>
>>>> Hmmm. One other thing I've noticed is that newer kernels tend need a minimum of 256M
>>>> RAM to start up - does it work if you add -m 256 to your command line?
>>>>
>>>>
>>>
>>> I have already set 256M of RAM. (and tried 512)
>>
>> I wonder then if this is being triggered by a recent kernel change? I tend to test
>> using the latest Debian ports ISOs which are currently running 4.9 and that booted
>> fine when I was testing the patches above.
>>
>> Can you try with a few older kernels to see if this is the case?
>>
> 
> Hello
> 
> In fact the problem was due to .config since a defconfig works fine on next-20190205
> After lots of diff I found that CONFIG_LOG_BUF_SHIFT=18 cause this behaviour.
> 
> Note that values of 16,17 cause also the same problem.

Okay, thanks for the feedback. I will aim to merge the OpenBIOS/QEMU patches before
the upcoming QEMU 4.0 release since even if it happens to work now, not passing the
memory allocations/translations via the DT seems a little fragile.


ATB,

Mark.
