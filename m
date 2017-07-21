Received: from eggs.gnu.org ([2001:4830:134:3::10]:44501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYTtV-0006wh-Fs
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYTtS-0003xg-Bb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dYTtS-0003xV-2a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:06:42 -0400
Date: Fri, 21 Jul 2017 11:06:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170721110636.19412e6c@nial.brq.redhat.com>
In-Reply-To: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org
	qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

On Thu, 20 Jul 2017 21:29:33 +0200
Phil Dennis-Jordan <lists@philjordan.eu> wrote:

> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
> <programmingkidx@gmail.com> wrote:
> > I noticed that Windows 2000 does not boot up in QEMU recently. After bisecting the issue I found the offending commit:
w2k is very ancient (and long time EOLed), I can't even download it from msdn to test
(oldest available is XP)

do we really care about it?

 
> Ouch. I reckon we have 2 options for fixing this:
> 
> 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
> to be pointed to by an XSDT, which Qemu currently doesn't implement at
> all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
> this? Any likely other OS regressions?
> 
> 2. Select FADT version with an option. This one is definitely safe,
> but adds yet another option.
the 3rd simpler option is:
  force rev1 on old machine types (2.9 and older),
  using machine compat machinery and use rev3 on newer machines


> 
> Thoughts?
> 
> 
> > commit 77af8a2b95b79699de650965d5228772743efe84
> > Author: Phil Dennis-Jordan <phil@philjordan.eu>
> > Date:   Wed Mar 15 19:20:26 2017 +1300
> >
> >     hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.
> >
> >     This updates the FADT generated for x86/64 machine types from Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The intention is to expose the reset register information to guest operating systems which require it, specifically OS X/macOS. Revision 1 FADTs do not contain the fields relating to the reset register.
> >
> >     The new layout and contents remains backwards-compatible with operating systems which only support ACPI 1.0, as the existing fields are not modified by this change, as the 64-bit and 32-bit variants are allowed to co-exist according to the ACPI 2.0 standard. No regressions became apparent in tests with a range of Windows (XP-10) and Linux versions.
> >
> >     The BIOS tables test suite's FADT checksum test has also been updated to reflect the new FADT layout and content.
> >
> >     Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >     Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan.eu>
> >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > :040000 040000 40063761c0b86f87e798e03ea48eff9ea0753425 6d2a94150cf1eafb16f0ccf6325281415fef64a6 M      hw
> > :040000 040000 fe3f1480a91b76fea238c765f0725e715932d96d 68f9368d8d78fd3267f609b603f97e8a74bdf528 M      include
> > :040000 040000 895e961b0a160100aa95b2f557cfe6b87a7d9bff 8ed08cef10fddee7814e38ad62be11371592a75a M      tests
> >
> >  
> 
