Received: from eggs.gnu.org ([2001:4830:134:3::10]:54246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fIeTN-00087r-4z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fIeTM-000663-AL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:14:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fIeTM-00065p-3N
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:14:52 -0400
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so2828344wmc.4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515172729.24564-1-peter.maydell@linaro.org>
References: <20180515172729.24564-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 May 2018 20:14:49 +0200
Message-ID: <CAJ+F1C+-K4FgPu3O0gU484z96qM0Lj6U30aJnZX6G1mBa_coUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On Tue, May 15, 2018 at 7:27 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> Coverity complains about qemu_memfd_create() (CID 1385858) because
> we calculate a bit position htsize which could be up to 63, but
> then use it in "1 << htsize" which is a 32-bit integer calculation
> and could push the 1 off the top of the value.
>
> Silence the complaint bu using "1ULL"; this isn't a bug in
> practice since a hugetlbsize of 4GB is not very plausible.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks Peter for the fix,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
> --
> 2.17.0
>
>



--=20
Marc-Andr=C3=A9 Lureau
