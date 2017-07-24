Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkot-0005y0-C7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkos-0003Ng-G0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:23:15 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkos-0003NH-89
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:23:14 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so29891375wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:23:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-34-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-34-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:22:52 +0100
Message-ID: <CAFEAcA-zk-PcOAeo_sshBi9iPc=zF9SD=38Zsx1hf1YwQJYT3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 33/35] configure: clang does
 not support -Wexpansion-to-defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 6b52e19ee3..48295aa1e6 100755
> --- a/configure
> +++ b/configure
> @@ -1582,8 +1582,12 @@ gcc_flags=3D"-Wold-style-declaration -Wold-style-d=
efinition -Wtype-limits"
>  gcc_flags=3D"-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualif=
iers $gcc_flags"
>  gcc_flags=3D"-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gc=
c_flags"
>  gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
> -gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flag=
s"
> +gcc_flags=3D"-Wno-initializer-overrides $gcc_flags"
>  gcc_flags=3D"-Wno-string-plus-int $gcc_flags"
> +# clang does not support -Wexpansion-to-defined
> +if ! echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
> +    gcc_flags=3D"-Wexpansion-to-defined $gcc_flags"
> +fi

We already have a mechanism for testing that the warning
flags we pass here are actually supported by the compiler
(the cc_has_warning_flag() function, which we run on
every flag in $gcc_flags). Why does -Wexpansion-to-defined
need special casing?

thanks
-- PMM
