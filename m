Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dQWCN-0001Zd-77
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dQWCM-0005R9-26
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:57:19 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1dQWCL-0005Qd-S1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:57:17 -0400
Received: by mail-oi0-x243.google.com with SMTP id d77so8209016oig.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 02:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <98c8f099-fd1b-4f50-97f9-00c8a5f88503@ilande.co.uk>
References: <4e41c60b-53b8-b917-108a-7cea8cb9e591@oracle.com>
	<98c8f099-fd1b-4f50-97f9-00c8a5f88503@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 29 Jun 2017 11:56:56 +0200
Message-ID: <CACXAS8AYCVWV+OeHziWf1EWpTNj-wVDu==V931tMZ01SWUBfFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SPARC64 supported processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Pasha Tatashin <pasha.tatashin@oracle.com>, qemu-devel <qemu-devel@nongnu.org>

 Hi Mark,

On Thu, Jun 29, 2017 at 8:57 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 27/06/17 18:59, Pasha Tatashin wrote:
>
> Hi Pasha,
>
>> Hi,
>>
>> I am trying to evaluate the current qemu support for sparc64 processors.
>> First, it seems -smp is not supported for any processor, is this
>> correct? When I set -smp greater than 1, I am getting:
>>
>> qemu-system-sparc64: Number of SMP CPUs requested (2) exceeds max CPUs
>> supported by machine 'sun4u' (1)
>
> Yes, that is correct for the moment. Before the MTTCG patches were
> merged, TCG only ran one thread so -smp 2 would effectively split your
> single host CPU into 2 virtual CPUs which doesn't give much benefit.
>
> Now MTTCG has been included multi CPUs become much more useful and
> really for SPARC64 there are 2 main tasks (for sun4u): reviewing the
> atomic instructions and marking them with the appropriate barriers in
> TCG, and then updating OpenBIOS (and possibly fw_cfg) to handle multiple
> CPUs on startup.
>
> The other point to note here is that since the default sun4u CPU doesn't
> have the equivalent of a "sleep until interrupt" instruction then the
> guest processes will run at 100% CPU on the host since there is no way
> for the guest to indicate that it should yield.

Well, it should be possible to recognize the scheduler loops for the
popular OSes at the translation time and halt or throttle down if
nothing happens. But I'm not sure the hack is worth the effort.

> I would expect that this
> would be possible with other CPUs though.

The IIIi has ways to reduce the frequency, but not halt completely.
Not sure about IV(+).

>> I've done some testing for all available sparc64 cpus + latest linux
>> kernel:
>>
>> Fujitsu Sparc64        Working
>> Fujitsu Sparc64 III Exception 0x30 (DAE_side_effect_page) in OpenBios
>> Fujitsu Sparc64 IV  Working
>> Fujitsu Sparc64 V   Working
>> TI UltraSparc I     Working
>> TI UltraSparc II    Working
>> TI UltraSparc IIi   Working
>> TI UltraSparc IIe   Exception 0x28 (division_by_zero) in init_tick_ops
>>   Can make it to work if is_hummingbird() is changed
>>   to return 0. The IO stick, and OpenBios stick properties
>>   are absent, so we have to default to %tick for now.
>>
>> Sun UltraSparc III  Illegal instruction in cheetah_boot():
>>   wr  %g0, %g1, %dcr
>>   It appears dispatch control register is not implemented.
>>
>> Sun UltraSparc IIIi
>> Sun UltraSparc IV
>> Sun UltraSparc IV+
>> Sun UltraSparc IIIi+
>>  In these four CPUs, I am getting exception 0x32 in
>>  cheetah_generic_boot: stxa  %g0, [ %g3 ] #ASI_DMMU
>>
>> Sun UltraSparc T1
>> Sun UltraSparc T2
>>
>> Both of the above boot pretty far but fail in this function when tmpfs
>> is mounted:
>>     direct_pcr_write(unsigned long reg_num, u64 val)
>>     __asm__ __volatile__("wr %0, 0x0, %%pcr" : : "r" (val));
>>
>>     Seems like performance counter registers are not supported.
>>
>>     needed to add these to kernel parameters:
>>     keep_bootcon -> to see where we are panicking
>>     lpj=1000 -> jiffers could not calculate for some reason.
>>
>> NEC UltraSparc I    Working
>>
>> Does this look right or may be I have missed something, and we can get
>> some of the Sun UltraSparc to work for example?
>
> That's certainly a very comprehensive set of tests :) I'd say that it's
> a fairly accurate reflection of where we are at the moment in that the
> basic SPARC64 core is working well and it's the CPU-specific parts which
> need more work.
>
> Currently myself and Artyom (CCd) are the SPARC maintainers and we tend
> to focus on different areas: my interest is with the sun4u machine as I
> have some legacy Solaris images I'm trying to run whilst Artyom has
> recently contributed niagara support to the 2.9 release. Note that I do
> try and keep the wiki page at
> http://wiki.qemu.org/Documentation/Platforms/SPARC up to date so that
> people can track current progress.
>
> Yes we can certainly look at trying to support more of the UltraSPARC
> CPUs if that is of interest. In reality the main reason that things
> haven't progressed further is due to lack of available time: whilst both
> myself and Artyom have done bits of work for particular clients, the
> majority of the work takes place in our own time outside of work and
> home which is, of course, limited.
>
> If there are particular features you would like added to QEMU's SPARC
> emulation then offers of help in terms of
> people/documentation/sponsorship are always welcome. Feel free to
> follow-up with both myself and Artyom off-list if this is something of
> interest to you.
>
>

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
