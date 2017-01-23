Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVg68-0003LZ-Kr
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cVg67-0006A7-Ng
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:59:56 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cVg67-0006A3-J6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:59:55 -0500
Received: by mail-it0-x241.google.com with SMTP id o185so10429694itb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 06:59:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8cS8DMbHsVU8oWVtB1JsSQJGi1igyFZVMcuzXXjpVkEQ@mail.gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
	<1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA8=gKjbo9YaRAzGHi-tP6AWY08ps_tEPOSzpNFXBC6M+Q@mail.gmail.com>
	<CACXAS8COsHWMAqoQTDqs6zh=-f0_u7posLQ1nUe6TKRfBaBSEg@mail.gmail.com>
	<CAFEAcA8cS8DMbHsVU8oWVtB1JsSQJGi1igyFZVMcuzXXjpVkEQ@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 23 Jan 2017 15:59:34 +0100
Message-ID: <CACXAS8ALUZAxQn6y6G+aowfHCPQppovOmC67HGUsa-01Dng_4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 30/30] target-sparc: fix up niagara machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 23, 2017 at 3:24 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 January 2017 at 14:10, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
>> On Mon, Jan 23, 2017 at 1:40 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> I see that 'make check' now warns:
>>>   GTESTER check-qtest-sparc64
>>> Could not open option rom 'nvram1': No such file or directory
>>> Could not open option rom '1up-md.bin': No such file or directory
>>> Could not open option rom '1up-hv.bin': No such file or directory
>>> Could not open option rom 'reset.bin': No such file or directory
>>> Could not open option rom 'q.bin': No such file or directory
>>> Could not open option rom 'openboot.bin': No such file or directory
>>>
>>> (though the tests still pass).
>>>
>>> Could we either ship these images in pc-bios if they're
>>> necessary, or not complain that they don't exist if they're
>>> not necessary, please?
>>
>> I wonder what would be the best option  here. The images are
>> necessary, so the last option - not complaining - can be misleading
>> for a user.
>
> If they're actually necessary then perhaps we should refuse
> to start entirely?

Yes, I think it's a best option. Don't load any images with the
-nodefaults option and fail on missing ones wintout -nodefaults.

Is there a failing variant of rom_add_file_fixed (I guess it's not
uncommon, but I don't find it in include/hw/loader.h) or do I just
check the return status?

>> Concerning shipping them.
>> Pros:
>> - the images are obviously freely distributable (the link above).
>> - the corresponding source code was open-sourced by Sun under various
>> licenses (GPL for hypervisor, BSD for openboot).
>> Cons:
>> - there is no exact tag the the OpenSPARC source tree which would
>> correspond to the binaries.
>> - building them is tricky, because it requires Solaris 9 / SPARC.
>>
>> What do you think would be a better option?
>
> One thing we could do is only warn if !qtest_enabled().
> We do this for some other boards that otherwise fail entirely
> when their BIOS image is not present. This is sufficient for
> the qtest checks which don't actually try to run code on the
> guest, but merely interact with it via the qtest protocol.
>
> We do ship some other ROMs that are only buildable on the
> right host hardware, so it's not impossible, but I don't know
> the details of our rules about what we put in pc-bios/.

Who may know them? I see no general maintainer for the pc-bios
directory as such in our MAINTAINERS file.

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
