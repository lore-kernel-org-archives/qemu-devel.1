Received: from eggs.gnu.org ([2001:4830:134:3::10]:36676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gLV4L-0006ZF-UC
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 10:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gLV4F-0008Ss-Cw
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 10:21:05 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43587
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gLV4F-0008ML-3F
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 10:20:59 -0500
Received: from host86-161-196-117.range86-161.btcentralplus.com
	([86.161.196.117] helo=[192.168.1.65])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gLV4M-00073N-HV
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 15:21:07 +0000
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<8a4b7981-cc1f-d2a7-2d92-9bf54a4bb42a@ilande.co.uk>
	<CAFEAcA_L_L-NiqS98P9n4LShHyBBujNrkQXThEgQ0C7nVC86cQ@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a92fc500-6c7c-d995-744d-cf7e36d76e0b@ilande.co.uk>
Date: Sat, 10 Nov 2018 15:20:44 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_L_L-NiqS98P9n4LShHyBBujNrkQXThEgQ0C7nVC86cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/11/2018 10:31, Peter Maydell wrote:

> On 9 November 2018 at 10:17, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> On 06/11/2018 18:43, Peter Maydell wrote:
>>
>>> I had an idea for how to get a rough list of source files
>>> containing devices that haven't been QOMified. The theory
>>> is that a pre-QOM device generally has an "init" function
>>> which allocates memory for the device struct. So looking in
>>> hw/ for files which call g_new*() or g_malloc*() should get
>>> us all the non-QOM devices (as well as a pile of false
>>> positives, of course).
> 
>>> hw/sparc64/sparc64.c
>>
>> This would appear to be from sparc64_cpu_devinit() which sets up a ResetData
>> structure like this:
>>
>>     reset_info = g_malloc0(sizeof(ResetData));
>>     reset_info->cpu = cpu;
>>     reset_info->prom_addr = prom_addr;
>>     qemu_register_reset(main_cpu_reset, reset_info);
> 
> I think the code I saw that looked like a non-QOMified
> device was cpu_timer_create().
> 
> The ResetData stuff is just working around the fact that
> CPUs don't get reset unless the board code does something
> to arrange for that to happen, so it's OK. (I would like
> us to eventually tackle properly overhauling our approach
> to reset, but that's a separate body of work.)

Ah okay. The above timers are certainly internal CPU timers rather than external, so
should they still be QOMified? How are timers modelled for other CPUs?


ATB,

Mark.
