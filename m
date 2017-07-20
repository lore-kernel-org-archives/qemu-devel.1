Received: from eggs.gnu.org ([2001:4830:134:3::10]:51759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYEV1-0007kE-JU
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYEUy-0003ed-EL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:40:27 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYEUy-0003eT-9M
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:40:24 -0400
Received: by mail-it0-x242.google.com with SMTP id j81so2215386ita.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:40:24 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
Date: Thu, 20 Jul 2017 12:40:20 -0400
Subject: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84 breaks
 Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, phil@philjordan.eu
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

I noticed that Windows 2000 does not boot up in QEMU recently. After =
bisecting the issue I found the offending commit:

commit 77af8a2b95b79699de650965d5228772743efe84
Author: Phil Dennis-Jordan <phil@philjordan.eu>
Date:   Wed Mar 15 19:20:26 2017 +1300

    hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest =
OS support.
   =20
    This updates the FADT generated for x86/64 machine types from =
Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The =
intention is to expose the reset register information to guest operating =
systems which require it, specifically OS X/macOS. Revision 1 FADTs do =
not contain the fields relating to the reset register.
   =20
    The new layout and contents remains backwards-compatible with =
operating systems which only support ACPI 1.0, as the existing fields =
are not modified by this change, as the 64-bit and 32-bit variants are =
allowed to co-exist according to the ACPI 2.0 standard. No regressions =
became apparent in tests with a range of Windows (XP-10) and Linux =
versions.
   =20
    The BIOS tables test suite's FADT checksum test has also been =
updated to reflect the new FADT layout and content.
   =20
    Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
    Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan.eu>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

:040000 040000 40063761c0b86f87e798e03ea48eff9ea0753425 =
6d2a94150cf1eafb16f0ccf6325281415fef64a6 M	hw
:040000 040000 fe3f1480a91b76fea238c765f0725e715932d96d =
68f9368d8d78fd3267f609b603f97e8a74bdf528 M	include
:040000 040000 895e961b0a160100aa95b2f557cfe6b87a7d9bff =
8ed08cef10fddee7814e38ad62be11371592a75a M	tests
