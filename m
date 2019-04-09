Received: from eggs.gnu.org ([209.51.188.92]:39057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDwG2-0006lD-5s
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDwG1-00021m-5n
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:18:10 -0400
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <e61c4a17-910b-0066-92ae-3fabf4a4e3e3@weilnetz.de>
Date: Tue, 9 Apr 2019 21:12:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Misaligned memory writes on ARM and other runtime
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

When QEMU for ARM is compiled with sanitizers
(--extra-cflags=3D-fsanitize=3Daddress,undefined), I see runtime errors f=
or
qemu-arm which indicate misaligned memory writes:

/qemu/linux-user/fd-trans.c:1389:18: runtime error: store to misaligned
address 0x42ff4b34 for type 'uint64_t', which requires 8 byte alignment

The full sanitizer report is available from
https://qemu.weilnetz.de/doc/sanitizer.txt. Some of the reported runtime
errors can easily be fixed, for example by replacing "1 << 31"
(currently 188 matches) by "1U << 31" (currently only 70 matches).

The test results are from running "arm-linux-user/qemu-arm
/usr/bin/scite" on Ubuntu ARM, but running other binaries with qemu-arm
shows similar runtime errors.

Regards,
Stefan Weil
