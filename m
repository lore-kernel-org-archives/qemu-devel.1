Received: from eggs.gnu.org ([2001:4830:134:3::10]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eiG6M-0004M5-D2
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eiG6L-0002gI-LC
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:56:42 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eiG6L-0002fy-FI
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:56:41 -0500
Received: by mail-ot0-x243.google.com with SMTP id s4so102946oth.7
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 00:56:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 4 Feb 2018 09:56:40 +0100
Message-ID: <CABLmASF=wyYqLesbLPNPSwJOG4k8Sbn4fTJJBocrTMU3UBgBfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] re-factor and add fp16 using glibc
 soft-fp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, cota@braap.org

On Sun, Feb 4, 2018 at 5:11 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> As discussed on list, the structure and inline function solution that
> Alex and I have been writing from scratch introduces a sizeable
> performance regression.  Alex and I have done some work earlier
> in the week that improved things some, but not enough.
>
> Which leaves us with a bit of a problem.  The were two existing
> code bases that we originally considered:
>
> There's softfloat v3, which would need a large structural reorg in
> order to be able to handle multiple float_status contexts.  But when
> Alex communicated with upstream they weren't ready to accept patches.
>
> Or there's the code from glibc.  I know Peter didn't like the idea;
> debugging this code is fairly painful -- the massive preprocessor
> macros mean that you can't step through anything.  But at least we
> have a good relationship with glibc, so merging patches back and
> forth should be easy.
>
> The result seems to perform slightly better than mainline.
> With an aarch64 guest and a i7-8550U host, nbench gives
>
> - FLOATING-POINT INDEX: 3.095
> + FLOATING-POINT INDEX: 3.438
>
> I've also run this through my usual set of aarch64 RISU tests.
>
> Thoughts?
>
>
Hi,

Thanks for looking into this. It seems this code does not build on OSX
Sierra nor while cross compiling for Windows on Fedora 27:

In file included from /Users/hsp/src/qemu-softfloatglibc/fpu/float16.c:20:
/Users/hsp/src/qemu-softfloatglibc/fpu/soft-fp.h:50:4: error:
"endianness not defined by sfp-machine.h"
#  error "endianness not defined by sfp-machine.h"

Best,
Howard
