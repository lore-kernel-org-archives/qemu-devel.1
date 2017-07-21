Received: from eggs.gnu.org ([2001:4830:134:3::10]:38377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYcgM-0005oM-34
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYcgI-0002SF-QA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:29:46 -0400
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1dYcgI-0002Rw-FC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:29:42 -0400
Received: by mail-ua0-x231.google.com with SMTP id 80so51711356uas.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 11:29:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721143432.0e888800@nial.brq.redhat.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 21 Jul 2017 20:29:20 +0200
Message-ID: <CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>

On Fri, Jul 21, 2017 at 2:34 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 21 Jul 2017 10:23:38 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>
>> On Fri, Jul 21, 2017 at 11:06:36AM +0200, Igor Mammedov wrote:
>> > On Thu, 20 Jul 2017 21:29:33 +0200
>> > Phil Dennis-Jordan <lists@philjordan.eu> wrote:
>> >
>> > > On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>> > > <programmingkidx@gmail.com> wrote:
>> > > > I noticed that Windows 2000 does not boot up in QEMU recently. Aft=
er bisecting the issue I found the offending commit:
>> > w2k is very ancient (and long time EOLed), I can't even download it fr=
om msdn to test
>> > (oldest available is XP)
>> >
>> > do we really care about it?
>>
>> From a Red Hat, we don't care about it, because we're only targetting
>> modern OS in RHEL, but from a QEMU community POV ability to run pretty
>> much any guest OS you care to find is definitely in scope.
> As far as someone is willing to maintain it and test it regularly,
> otherwise it will beak someday anyway.
> (I'm not really willing to do it as I don't have access to w2k and
> interested in reducing maintainable code, but maybe someone would
> like to step up, feel free to post patch to amend acpi maintaners)
>
> currently option 1 looks like the most compatible approach
> but there is no way to predict if it will break some other OS
> and it is not trivial to implement and maintain.
>
> CCing Laszlo, to get his opinion if option 1 is viable from
> old/new OVMF standpoint (is it possible in 2.10 time frame?).

I've not done a deep investigation yet, but I've put together a really
quick prototype for the split RSDT/XSDT with 2 FADTs. I tested my
existing WinXP x86, Win10 x64, and Ubuntu 16.04 x86-64 test images
with SeaBIOS and they all worked.

With OVMF, neither Windows 10 nor macOS would boot with this change -
I don't currently know if that's OVMF's fault or if my prototype is
broken. I don't have time right now to dig deeper into this, but
hopefully I can look at it on Monday and also dig out a Win2000 disc
then as well and test with that.

The prototype patch is at https://github.com/pmj/qemu/tree/xsdt right
now for anyone curious, or with more time on their hands to test it
with Win2K and figure out why it's not working with OVMF. I'll try to
do a proper RFC patch submission on Monday once I have a better handle
on what's going on.

I don't have any strong release policy opinions - I'll leave that to
those with more experience. I'd be disappointed though if we had to
entirely revert the Rev3 FADT patch for 2.10.

>> > > Ouch. I reckon we have 2 options for fixing this:
>> > >
>> > > 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would ne=
ed
>> > > to be pointed to by an XSDT, which Qemu currently doesn't implement =
at
>> > > all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would hand=
le
>> > > this? Any likely other OS regressions?
>> > >
>> > > 2. Select FADT version with an option. This one is definitely safe,
>> > > but adds yet another option.
>> > the 3rd simpler option is:
>> >   force rev1 on old machine types (2.9 and older),
>> >   using machine compat machinery and use rev3 on newer machines
>>
>> That's not really a 3rd option - it is something that applies to
>> both option 1 and 2.
>>
>> The original commit, and both these options involve changes are
>> sensitive to guest ABI. So all machine types from 2.9 and earlier
>> *must* be configured to stick with the ACPI 1.0 FADT only.
> It's not per se ABI change, ABI is still the same but BIOS
> supplied ACPI tables changed (nowdays they are generated by QEMU)
> to new ones. Currently QEMU does not support versioned firmware,
> i.e. each new release ships updated firmware and old machines
> also use it. The same typically applies to ACPI tables.
>
> Alternative workaround, for w2k user (management), doesn't even
> requires any fixes to qemu, he/she should just use old enough bios
> with new QEMU (bios from 1.7 or 1.6 should work as it doesn't fetch
> ACPI tables from QEMU).
>
> Another alternative is just keep just using old QEMU version with w2k,
> the sources are available.
> If user's figured out that he/she needs to force FADT(rev1) for w2k
> not to crash (he is either able to bisect/compile QEMU or read this
> thread at which point he/she should be able to his poison i.e.
> compiling vs old bios)
>
>
>> Whether we then have an option to turn on ACPI 2.0, or instead
>> expose 1.0 and 2.0 at the same time, both must only happen on
>> the 2.10 machine type (or newer if it misses this release).
>>
>>
>> > > > commit 77af8a2b95b79699de650965d5228772743efe84
>> > > > Author: Phil Dennis-Jordan <phil@philjordan.eu>
>> > > > Date:   Wed Mar 15 19:20:26 2017 +1300
>> > > >
>> > > >     hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve g=
uest OS support.
>> > > >
>> > > >     This updates the FADT generated for x86/64 machine types from =
Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The intention =
is to expose the reset register information to guest operating systems whic=
h require it, specifically OS X/macOS. Revision 1 FADTs do not contain the =
fields relating to the reset register.
>> > > >
>> > > >     The new layout and contents remains backwards-compatible with =
operating systems which only support ACPI 1.0, as the existing fields are n=
ot modified by this change, as the 64-bit and 32-bit variants are allowed t=
o co-exist according to the ACPI 2.0 standard. No regressions became appare=
nt in tests with a range of Windows (XP-10) and Linux versions.
>> > > >
>> > > >     The BIOS tables test suite's FADT checksum test has also been =
updated to reflect the new FADT layout and content.
>> > > >
>> > > >     Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> > > >     Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan=
.eu>
>> > > >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> > > >
>> > > > :040000 040000 40063761c0b86f87e798e03ea48eff9ea0753425 6d2a94150c=
f1eafb16f0ccf6325281415fef64a6 M      hw
>> > > > :040000 040000 fe3f1480a91b76fea238c765f0725e715932d96d 68f9368d8d=
78fd3267f609b603f97e8a74bdf528 M      include
>> > > > :040000 040000 895e961b0a160100aa95b2f557cfe6b87a7d9bff 8ed08cef10=
fddee7814e38ad62be11371592a75a M      tests
>> > > >
>> > > >
>> > >
>> >
>> >
>>
>> Regards,
>> Daniel
>
