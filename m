Received: from eggs.gnu.org ([2001:4830:134:3::10]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fLNa4-0000Tc-43
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fLNa3-0008JQ-FW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:49:04 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:42652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fLNa3-0008JG-9X
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:49:03 -0400
Received: by mail-ot0-x236.google.com with SMTP id l13-v6so23931123otk.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 23:49:03 -0700 (PDT)
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 23 May 2018 08:49:01 +0200
Message-ID: <CABoDooMwdGR7fJKc=b9zjFGgxPniXyZ8vevKg7fjuWEDioTB9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] AArch64: ZCR and ARM_CP_SVE/ARM_CP_FPU flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

ZCR system registers are both flagged as ARM_CP_SVE and ARM_CP_FPU,
which results in an assertion failure in fp_access_check due to the
check of these flags in handle_sys:

    if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
        return;
    }
    if ((ri->type & ARM_CP_FPU) && !fp_access_check(s)) {
        return;
    }

sve_access_check calls fp_access_check so the assert
!s->fp_access_checked in the second call to fp_access_check will fail.

I took a quick look at sve_exception_el and given that it checks that
FPU is enabled, can't we just remove the ARM_CP_FPU flag from ZCR?

Alternatively the second call to fp_access_check when ARM_CP_FPU is
defined could be skipped if ARM_CP_SVE is set.

Thanks,

Laurent
