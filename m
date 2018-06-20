Received: from eggs.gnu.org ([2001:4830:134:3::10]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVewv-0006V6-BP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVewu-0003Sb-Ek
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:23:09 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:36999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVewu-0003SP-9I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:23:08 -0400
Received: by mail-ot0-x233.google.com with SMTP id 101-v6so4126576oth.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619154435.18898-2-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
	<20180619154435.18898-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 16:22:47 +0100
Message-ID: <CAFEAcA94=9Dn=XgHr_qbszCe-5Yi8AJK48NRovtpULkESu5mGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 01/56] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On 19 June 2018 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This allows us to specify cross compilers for our guests. This is
> useful for building test images/programs. Currently we re-run the
> compile test for each target. I couldn't think of a way to cache the
> value for a given arch without getting messier configure code.
>
> The cross compiler for the guest is visible to each target as
> CROSS_CC_GUEST in config-target.mak.
>
> +# Do we have a cross compiler for this target?
> +if has $target_compiler; then
> +
> +    write_c_skeleton
> +
> +    if ! do_compiler $target_compiler -o $TMPE $TMPC -static ; then

Need quotes around "$target_compiler"


> +        # For host systems we might get away with building without -stat=
ic
> +        if ! do_compiler $target_compiler -o $TMPE $TMPC ; then

Ditto

> +            target_compiler=3D""
> +        else
> +            enabled_cross_compilers=3D"${enabled_cross_compilers} ${targ=
et_compiler}"
> +            target_compiler_static=3D"n"
> +        fi
> +    else
> +        enabled_cross_compilers=3D"${enabled_cross_compilers} ${target_c=
ompiler}"
> +        target_compiler_static=3D"y"
> +    fi
> +else
> +    target_compiler=3D""
> +fi
>

> +if test -n "$enabled_cross_compilers"; then
> +    echo
> +    echo "NOTE: cross-compilers enabled:"
> +    printf '%s\n' $enabled_cross_compilers | sort -u
> +fi

This is going to do weird things in the case where one of the
target compilers is something like 'ccache gcc'.

thanks
-- PMM
