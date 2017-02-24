Received: from eggs.gnu.org ([2001:4830:134:3::10]:38137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGXi-0002OH-2a
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGXF-0004uV-Vr
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:08:17 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chGXF-0004tg-Mj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:07:49 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u47so13807480wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:07:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpcflmmb.fsf@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
	<87wpcflmmb.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:07:26 +0000
Message-ID: <CAFEAcA-OhSMFKgRYsCWUrb6OBxxrWokkkpJyioveEur-p4-g2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/13] Rewrite NVIC to not
 depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 24 February 2017 at 13:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Even this branch is failing the tests for me:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Testing test9-kern.bin =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> not ok 9 - 00000000 =3D=3D 00000800 icsr

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Testing test10-kern.bin =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> not ok 1 - 00000000 =3D=3D 00000800 ICSR

> not ok 9 - 00000000 =3D=3D 00000800 ICSR

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Testing test4-kern.bin =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> not ok 5 - 00000000 =3D=3D 00000800 ICSR

> not ok 9 - 00410000 =3D=3D 00410800 ICSR

Ah, I missed the test failures, but these are all test bugs.
All of these failures are for reads of ICSR when we're not
in an exception handler and the mismatch is because the
expected value of RETTOBASE differs. The bit is architecturally
UNKNOWN, and we did a late swap from making it be clear to
making it be set, because that seemed to be more in line
with the Cortex-M3 documented behaviour.

I didn't notice that the tests needed to be updated to
mask out the UNKNOWN bit before comparison.

thanks
-- PMM
