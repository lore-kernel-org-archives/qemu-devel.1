Received: from eggs.gnu.org ([2001:4830:134:3::10]:49430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2w3p-0005uC-Pr
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2w3o-0002qO-Vr
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:43:01 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2w3o-0002ob-OX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:43:00 -0400
Received: by mail-wm0-x233.google.com with SMTP id m123so89149209wma.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:43:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
References: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 09:42:39 +0100
Message-ID: <CAFEAcA-dD=DZmtvMDAz2Z8u6Qb2ozGWNroPQhwXr+zczvtjqVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] configure: fix clang failure for
 libatomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 25 April 2017 at 09:35, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> Travis builds failure was reported for powernv boot-serial test with
> qemu built with clang.
>
> Debugging revealed that CONFIG_ATOMIC64 wasnt getting set for the clang
> build because of that atomic operations weren't being used and was
> resulting in MTTCG failure in the powernv boot-serial test.
>
> libatomic is required to successfully test atomic64 and atomic128 for
> clang. Introduced newer checks for the same. And on failure default to
> single threaded tcg support in PPC64.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Do we really need libatomic? I thought the intention here was
that atomic operations were only done on types of width of the
pointer or less, which should all be doable by the compiler inline,
and thus don't need the external library. In the past "doesn't
work without libatomic" usually meant "accidentally tried to
do an atomic operation on a type that is too wide".

thanks
-- PMM
