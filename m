Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIfc3-0003tp-6g
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIfbz-0001XS-SU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:27:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIfbz-0001Wx-LG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:27:51 -0400
Received: by mail-wr0-x243.google.com with SMTP id q3-v6so1306480wrj.6
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 12:27:51 -0700 (PDT)
References: <20180515172729.24564-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515172729.24564-1-peter.maydell@linaro.org>
Date: Tue, 15 May 2018 20:27:49 +0100
Message-ID: <87zi10en2i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memfd: Avoid Coverity warning about
 integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Coverity complains about qemu_memfd_create() (CID 1385858) because
> we calculate a bit position htsize which could be up to 63, but
> then use it in "1 << htsize" which is a 32-bit integer calculation
> and could push the 1 off the top of the value.
>
> Silence the complaint bu using "1ULL"; this isn't a bug in
> practice since a hugetlbsize of 4GB is not very plausible.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  util/memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index b3ecbac19e..d248a53c3c 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -66,7 +66,7 @@ int qemu_memfd_create(const char *name, size_t size, bo=
ol hugetlb,
>  {
>      int htsize =3D hugetlbsize ? ctz64(hugetlbsize) : 0;
>
> -    if (htsize && 1 << htsize !=3D hugetlbsize) {
> +    if (htsize && 1ULL << htsize !=3D hugetlbsize) {
>          error_setg(errp, "Hugepage size must be a power of 2");
>          return -1;
>      }


--
Alex Benn=C3=A9e
