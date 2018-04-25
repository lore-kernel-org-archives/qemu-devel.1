Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBNpq-0006uD-Kf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBNpp-0000nU-Mt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:04:02 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBNpp-0000nB-Hr
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:04:01 -0400
Received: by mail-ot0-x242.google.com with SMTP id w4-v6so26129662ote.12
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 10:04:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-4-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Apr 2018 18:03:40 +0100
Message-ID: <CAFEAcA9m1nhCdVW=yjctkO9jYoqXYEtRxne=nfkBa7P=j_ZSfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
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
Cc: "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2018 at 16:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This allows us to specify cross compilers for our guests. This is
> useful for building test images/programs. Currently we re-run the
> compile test for each target. I couldn't think of a way to cache the
> value for a given arch without getting messier configure code.
>
> The cross compiler for the guest is visible to each target as
> CROSS_CC_GUEST in config-target.mak.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit...
>   - --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*=
}
>   - add remaining target_compiler definitions
> ---
>  configure | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/configure b/configure
> index b0ae632ee4..caa838a0d0 100755
> --- a/configure
> +++ b/configure
> @@ -453,6 +453,13 @@ vxhs=3D""
>  libxml2=3D""
>  docker=3D"no"
>
> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
> +
> +enabled_cross_compilers=3D""
> +
>  supported_cpu=3D"no"
>  supported_os=3D"no"
>  bogus_os=3D"no"
> @@ -483,6 +490,11 @@ for opt do
>    ;;
>    --disable-debug-info) debug_info=3D"no"
>    ;;
> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO=
 option"
> +  ;;
> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
> +                eval "cross_cc_${cc_arch}=3D\$optarg"
> +  ;;

Could we have --help text for the new configure options,
please?

thanks
-- PMM
