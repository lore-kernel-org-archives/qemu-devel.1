Received: from eggs.gnu.org ([2001:4830:134:3::10]:43548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gL3qu-0007SE-Cm
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gL3qn-0001nM-Pa
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:17:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40001
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gL3qn-0001dG-Fc
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:17:17 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8a4b7981-cc1f-d2a7-2d92-9bf54a4bb42a@ilande.co.uk>
Date: Fri, 9 Nov 2018 10:17:02 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/11/2018 18:43, Peter Maydell wrote:

> I had an idea for how to get a rough list of source files
> containing devices that haven't been QOMified. The theory
> is that a pre-QOM device generally has an "init" function
> which allocates memory for the device struct. So looking in
> hw/ for files which call g_new*() or g_malloc*() should get
> us all the non-QOM devices (as well as a pile of false
> positives, of course). The following link is the result of
> doing that and then eyeballing the results for false positives
> and throwing those out. It might have missed one or two
> files or included one or two by mistake. But I think it's
> pretty close, and it seems to have caught all the obvious
> ones I knew about. There are 61 files on this list.
> 
> I am also suspicious about hw/bt/ but don't know enough
> about that subsystem to say if it could benefit from
> using QOM objects more.

> hw/ppc/prep.c

I had a quick look at this and AFAICT it's in the old -M prep code which is
deprecated and hopefully scheduled for removal soon, so I think we can leave this one.

> hw/sparc64/sparc64.c

This would appear to be from sparc64_cpu_devinit() which sets up a ResetData
structure like this:

    reset_info = g_malloc0(sizeof(ResetData));
    reset_info->cpu = cpu;
    reset_info->prom_addr = prom_addr;
    qemu_register_reset(main_cpu_reset, reset_info);

Presumably this can now be handled by using CPUClass's reset() method? The prom_addr
field is a per-machine parameter that is used to derive the starting PC for the CPU,
so I believe converting this to a qdev parameter on the SPARC CPU should suffice.


ATB,

Mark.
