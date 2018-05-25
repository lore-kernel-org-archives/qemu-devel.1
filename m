Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMDNv-0002FT-55
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMDNq-000377-6x
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:59 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:32916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMDNp-00036Y-Td
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:54 -0400
Received: by mail-pl0-x233.google.com with SMTP id n10-v6so3239435plp.0
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:07:53 -0700 (PDT)
References: <CABoDooMwdGR7fJKc=b9zjFGgxPniXyZ8vevKg7fjuWEDioTB9Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <666d7574-6d61-e490-08a5-702ea3d65fb3@linaro.org>
Date: Fri, 25 May 2018 07:07:48 -0700
MIME-Version: 1.0
In-Reply-To: <CABoDooMwdGR7fJKc=b9zjFGgxPniXyZ8vevKg7fjuWEDioTB9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AArch64: ZCR and ARM_CP_SVE/ARM_CP_FPU flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 05/22/2018 11:49 PM, Laurent Desnogues wrote:
> ZCR system registers are both flagged as ARM_CP_SVE and ARM_CP_FPU,
> which results in an assertion failure in fp_access_check due to the
> check of these flags in handle_sys:
> 
>     if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
>         return;
>     }
>     if ((ri->type & ARM_CP_FPU) && !fp_access_check(s)) {
>         return;
>     }
> 
> sve_access_check calls fp_access_check so the assert
> !s->fp_access_checked in the second call to fp_access_check will fail.

Hah.  Yes, these checks have migrated a bit since I first wrote them, and I
have (perhaps obviously) done zero system-level testing so far.

> I took a quick look at sve_exception_el and given that it checks that
> FPU is enabled, can't we just remove the ARM_CP_FPU flag from ZCR?
> 
> Alternatively the second call to fp_access_check when ARM_CP_FPU is
> defined could be skipped if ARM_CP_SVE is set.

I would say the first -- removing FPU -- but will defer to Peter.


r~
