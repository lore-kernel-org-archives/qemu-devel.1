Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2iI-0001f4-7d
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2iH-0004Tx-B0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:42:58 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2iH-0004TZ-5o
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:42:57 -0400
Received: by mail-ot0-x229.google.com with SMTP id l22-v6so1866570otj.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:42:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1517858941-5538-39-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
	<1517858941-5538-39-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:42:35 +0100
Message-ID: <CAFEAcA_G=rp1nVOKgdQQb0bgunHktnsfP2-dPcm2eOq0BDm4pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 38/47] memfd: add hugetlbsize argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 5 February 2018 at 19:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Learn to specificy hugetlb size as qemu_memfd_create() argument.

>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
> -                      unsigned int seals, Error **errp)
> +                      uint64_t hugetlbsize, unsigned int seals, Error **=
errp)
>  {
> +    int htsize =3D hugetlbsize ? ctz64(hugetlbsize) : 0;
> +
> +    if (htsize && 1 << htsize !=3D hugetlbsize) {
> +        error_setg(errp, "Hugepage size must be a power of 2");
> +        return -1;
> +    }
> +
> +    htsize =3D htsize << MFD_HUGE_SHIFT;

Hi; Coverity complains about this function (CID 1385858) because
we calculate a bit poisition htsize which could be up to 63, but
then use it in "1 << htsize" which is a 32-bit integer calculation
and could push the 1 off the top of the value.

This should be "1ULL", though of course a hugetlbsize of 4GB
is not very plausible.

PS: the variable name is "hugetlbsize" but the error message
says "hugepage size" -- is it a TLB size or a page size ?

thanks
-- PMM
