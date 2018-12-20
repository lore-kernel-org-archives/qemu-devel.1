Received: from eggs.gnu.org ([2001:4830:134:3::10]:37150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZwKW-0000xT-GK
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZwKT-0004du-6z
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:17:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZwKS-0004Ct-Se
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:17:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id r24so11671246wmh.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 03:17:15 -0800 (PST)
References: <20181210152850.435-1-peter.maydell@linaro.org>
	<20181219183902.27273-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181219183902.27273-1-alex.bennee@linaro.org>
Date: Thu, 20 Dec 2018 11:17:13 +0000
Message-ID: <87efaca1mu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add barrier test for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This is a port of my kvm-unit-tests barrier test. A couple of things
> are done in a more user-space friendly way but the tests are the same.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
> +
> +# Barrier tests need atomic definitions, steal QEMUs
> +barrier: CFLAGS+=3D-I$(SRC_PATH)/include/qemu

Hmm that should be:

modified   tests/tcg/arm/Makefile.target
@@ -10,7 +10,7 @@ VPATH                 +=3D $(ARM_SRC)

 ARM_TESTS=3Dhello-arm test-arm-iwmmxt

-TESTS +=3D $(ARM_TESTS) fcvt
+TESTS +=3D $(ARM_TESTS) fcvt barrier

 hello-arm: CFLAGS+=3D-marm -ffreestanding
 hello-arm: LDFLAGS+=3D-nostdlib
@@ -30,3 +30,7 @@ endif

 # On ARM Linux only supports 4k pages
 EXTRA_RUNS+=3Drun-test-mmap-4096
+
+# Barrier tests need aqrel
+barrier: CFLAGS+=3D-march=3Darmv8-a
+barrier: LDFLAGS+=3D-lpthread


--
Alex Benn=C3=A9e
