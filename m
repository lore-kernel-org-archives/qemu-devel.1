Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL454-00086Q-Hz
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL452-0007Hv-Fq
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:32:02 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gL451-0007Gp-4v
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:31:59 -0500
Received: by mail-ot1-x32d.google.com with SMTP id f24so1184425otl.5
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 02:31:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8a4b7981-cc1f-d2a7-2d92-9bf54a4bb42a@ilande.co.uk>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<8a4b7981-cc1f-d2a7-2d92-9bf54a4bb42a@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 10:31:37 +0000
Message-ID: <CAFEAcA_L_L-NiqS98P9n4LShHyBBujNrkQXThEgQ0C7nVC86cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 November 2018 at 10:17, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 06/11/2018 18:43, Peter Maydell wrote:
>
>> I had an idea for how to get a rough list of source files
>> containing devices that haven't been QOMified. The theory
>> is that a pre-QOM device generally has an "init" function
>> which allocates memory for the device struct. So looking in
>> hw/ for files which call g_new*() or g_malloc*() should get
>> us all the non-QOM devices (as well as a pile of false
>> positives, of course).

>> hw/sparc64/sparc64.c
>
> This would appear to be from sparc64_cpu_devinit() which sets up a ResetData
> structure like this:
>
>     reset_info = g_malloc0(sizeof(ResetData));
>     reset_info->cpu = cpu;
>     reset_info->prom_addr = prom_addr;
>     qemu_register_reset(main_cpu_reset, reset_info);

I think the code I saw that looked like a non-QOMified
device was cpu_timer_create().

The ResetData stuff is just working around the fact that
CPUs don't get reset unless the board code does something
to arrange for that to happen, so it's OK. (I would like
us to eventually tackle properly overhauling our approach
to reset, but that's a separate body of work.)

thanks
-- PMM
