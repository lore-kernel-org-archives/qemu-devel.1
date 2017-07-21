Received: from eggs.gnu.org ([2001:4830:134:3::10]:33589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYVLX-0004BC-BY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYVLV-000870-Nr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:39:47 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:34448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1dYVLV-00086f-HP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:39:45 -0400
Received: by mail-ua0-x233.google.com with SMTP id q25so23691599uah.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:39:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721114623.57b3be1d@nial.brq.redhat.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721092026.GD17693@redhat.com>
	<20170721114623.57b3be1d@nial.brq.redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 21 Jul 2017 12:39:24 +0200
Message-ID: <CAGCz3vvFyOEqbnEScZvmgOts+LNQ=vob5LwhSGURZMfPWZJf1Q@mail.gmail.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 21, 2017 at 11:46 AM, Igor Mammedov <imammedo@redhat.com> wrote=
:
> On Fri, 21 Jul 2017 10:20:26 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>
>> On Thu, Jul 20, 2017 at 09:29:33PM +0200, Phil Dennis-Jordan wrote:
>> > On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>> > <programmingkidx@gmail.com> wrote:
>> > > I noticed that Windows 2000 does not boot up in QEMU recently. After=
 bisecting the issue I found the offending commit:
>> >
>> > Ouch. I reckon we have 2 options for fixing this:
>> >
>> > 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
>> > to be pointed to by an XSDT, which Qemu currently doesn't implement at
>> > all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
>> > this? Any likely other OS regressions?
>> >
>> > 2. Select FADT version with an option. This one is definitely safe,
>> > but adds yet another option.
>> >
>> > Thoughts?
>>
>> The original comit below claims the change does not impact guest ABI
>> compatibility, so do we understand why Windows broke ?
> Author made a reasonable effort to test with variety of guest OSes upto
> vanilla WinXP, we can't blame ourselves for not testing OS that's is not
> available.
>
> Well we don't know why w2k breaks, only that it bisects to this commit.

Short of having access to Win2K source or reverse engineering, we can
only guess - but it's almost certainly got to be one or more of these:

1. It can't handle FADT revision !=3D 1 (as opposed to later systems
which evidently test for >=3D 1)
2. It can't handle if FADT length !=3D sizeof(ACPI 1.0 FADT) (again, as
opposed to testing for >=3D)
3. It only computes the checksum over the hardcoded ACPI 1.0 FADT
length, not over the number of bytes in the length field.

There isn't a way to reconcile these with a valid ACPI 2.0 FADT.

I've found these presentation slides from Intel's IDF 2001:
http://www.acpi.info/presentations/S01USMOBS169_OS%20new.ppt
On slide 10, "ACPI 2.0 System Description Tables (Windows 2000
Compatibility)" it indicates that two FADTs are required for Win2k,
with the RSDT pointing to an ACPI 1.0 FADT, and the XSDT pointing to a
2.0 one. (This is my "option 1")

Presumably this is how shipping Win2K-compatible hardware implemented
it, so I'd expect FOSS operating systems to be able to deal with this
kind of setup too. Moreover, the ACPI 2.0 spec says (5.2.7) "An ACPI
2.0-compatible OS must use the XSDT if present." which also suggests
that the RSDT should be ignored if the OS can handle the XSDT. Whether
ALL proprietary OSes can deal with it in practice is another question.

>> If the commit message was inaccurate, and *does* in fact change ABI,
>> then we should have added an option to toggle FADT version, and used
>> machine type versioning to ensure we didn't regress existing machine
>> types. IOW option 2.
>>
>> That would still, however, leave Windows 2k broken on new machine
>> types which is pretty poor experiance, but is probably all that
>> we have time for in the current freeze period.
>>
>> If we can do option 1 in the 2.11 release that would potentially
>> give better user experiance by not being broken out of the box
>> with the latest machine type.
> option 1 might confuse/break OVMF.
>
> I've just posted patch to unconditionally force rev1 for pc-i440fx-2.9
> and older machines, while q35 and newer pc would use rev3.
>
>>
>>
>> > > commit 77af8a2b95b79699de650965d5228772743efe84
>> > > Author: Phil Dennis-Jordan <phil@philjordan.eu>
>> > > Date:   Wed Mar 15 19:20:26 2017 +1300
>> > >
>> > >     hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve gue=
st OS support.
>> > >
>> > >     This updates the FADT generated for x86/64 machine types from Re=
vision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The intention is=
 to expose the reset register information to guest operating systems which =
require it, specifically OS X/macOS. Revision 1 FADTs do not contain the fi=
elds relating to the reset register.
>> > >
>> > >     The new layout and contents remains backwards-compatible with op=
erating systems which only support ACPI 1.0, as the existing fields are not=
 modified by this change, as the 64-bit and 32-bit variants are allowed to =
co-exist according to the ACPI 2.0 standard. No regressions became apparent=
 in tests with a range of Windows (XP-10) and Linux versions.
>> > >
>> > >     The BIOS tables test suite's FADT checksum test has also been up=
dated to reflect the new FADT layout and content.
>> > >
>> > >     Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> > >     Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan.e=
u>
>> > >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> > >
>> > > :040000 040000 40063761c0b86f87e798e03ea48eff9ea0753425 6d2a94150cf1=
eafb16f0ccf6325281415fef64a6 M      hw
>> > > :040000 040000 fe3f1480a91b76fea238c765f0725e715932d96d 68f9368d8d78=
fd3267f609b603f97e8a74bdf528 M      include
>> > > :040000 040000 895e961b0a160100aa95b2f557cfe6b87a7d9bff 8ed08cef10fd=
dee7814e38ad62be11371592a75a M      tests
>> > >
>> > >
>> >
>>
>> Regards,
>> Daniel
>
