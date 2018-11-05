Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJf8l-00064a-5I
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJf2u-0003Hh-O5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:36:02 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:46931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJf2u-0003FS-E9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:36:00 -0500
Received: by mail-ot1-x334.google.com with SMTP id q5so7890647otl.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 05:35:58 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 13:35:36 +0000
Message-ID: <CAFEAcA_mT2FT=t+Fw7=7aUgDkX1b64oqFS99_jFN7_12MRCx+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] coverity-spotted memory leak in hw/riscv/spike.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-riscv@nongnu.org

Hi; Coverity has noticed a memory leak in hw/riscv/spike.c:
it malloc()s memory into config_string(), but never frees it.
(CID 1391015). This isn't a very serious leak since the function
only ever runs once, but it would be nice to fix this for 3.1
(it is the only coverity error in the riscv code, and one of
just 8 unaddressed for QEMU as a whole).

Incidentally, "malloc and then snprintf" would be better
done using g_strdup_printf(), which automatically allocates
sufficient memory for the string, avoiding the need to
try to pre-calculate the right size.

thanks
-- PMM
