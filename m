Received: from eggs.gnu.org ([2001:4830:134:3::10]:43141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ewAlt-0003Aa-S5
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ewAlo-0007jg-UR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:05:05 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ewAlo-0007it-Ng
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:05:00 -0400
Received: by mail-wr0-x243.google.com with SMTP id z73so1427020wrb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:05:00 -0700 (PDT)
References: <20180314120906.30872-1-berrange@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180314120906.30872-1-berrange@redhat.com>
Date: Wed, 14 Mar 2018 18:04:57 +0000
Message-ID: <87k1uebkja.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] configure: shorthand for only enabling
 native softmmu target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> With the huge number of QEMU targets, a default configuration will take
> a very long time to rebuild. When developing most code changes, it is
> sufficient to test compilation with a single target - rebuilding all
> targets just extends compile times while not detecting any new problems.
>
> Developers will often thus specify a single target for configure,
> commonly matching the host architecture. eg
>
>   ./configure --target-list=3Dx86_64-softmmu

A while back I messed with a patch that allowed stems in --target-list
so you could quickly select targets with stems:

  Subject: [PATCH 0/4] Current Travis queue
  Date: Fri, 15 Apr 2016 16:56:57 +0100
  Message-Id: <1460735821-12775-1-git-send-email-alex.bennee@linaro.org>

but if I recall Peter was worried about it breaking existing configure
lines.

>
> This works fine, but is a bit of a verbose thing to type out everytime
> configure is invoked. There are already short-hand args to disable all
> user targets, all softmmu targets, or all tcg targets. This adds one
> further shorthand to disable all non-native architecture targets.
>
>   ./configure --native

I'm not sure this is really the case. My history tends to be littered
with things like:

  ./configure --enable-debug --enable-debug-tcg --extra-cflags=3D"-O0 -g3" =
--target-list=3Daarch64-linux-user

when compile time is an issue although my development box is an x86.
Normally I do compile all targets and rely on ccache to keep the compile
time reasonable.

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> Suggestions welcomed for better names than --native, but bear in mind
> the goal is to minimise amount of typing so nothing too verbose, hence
> why I didn't do something like --disable-non-native ...

I would argue it's "almost" equivalent to --disable-tcg as most native
users in my experience aren't looking to run X on X via TCG. I could be
wrong of course.

>
>  configure | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/configure b/configure
> index af72fc852e..807af93116 100755
> --- a/configure
> +++ b/configure
> @@ -233,6 +233,22 @@ supported_whpx_target() {
>      return 1
>  }
>
> +supported_native_target() {
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}:$cpu" in
> +        arm:arm | aarch64:aarch64 | \
> +        i386:i386 | i386:x32 | \
> +        x86_64:x86_64 | \
> +        mips:mips | mipsel:mips | \
> +        ppc:ppc | ppcemb:ppc | \
> +        ppc64:ppc64 | \
> +        s390x:s390x)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +

This strikes me as another place to mess about with when doing target
specific changes to configure.

>  supported_target() {
>      case "$1" in
>          *-softmmu)
> @@ -254,6 +270,10 @@ supported_target() {
>              return 1
>              ;;
>      esac
> +    if test "$native" =3D "yes"
> +    then
> +	supported_native_target "$1" || return 1
> +    fi
>      test "$tcg" =3D "yes" && return 0
>      supported_kvm_target "$1" && return 0
>      supported_xen_target "$1" && return 0
> @@ -390,6 +410,7 @@ cocoa=3D"no"
>  softmmu=3D"yes"
>  linux_user=3D"no"
>  bsd_user=3D"no"
> +native=3D"no"
>  blobs=3D"yes"
>  pkgversion=3D""
>  pie=3D""
> @@ -1112,6 +1133,8 @@ for opt do
>        cocoa=3D"yes" ;
>        audio_drv_list=3D"coreaudio $(echo $audio_drv_list | sed s,coreaud=
io,,g)"
>    ;;
> +  --native) native=3D"yes"
> +  ;;
>    --disable-system) softmmu=3D"no"
>    ;;
>    --enable-system) softmmu=3D"yes"
> @@ -1540,6 +1563,7 @@ Advanced options (experts only):
>                             xen pv domain builder
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
> +  --native                 only enable the softmmu target matching host =
architecture
>
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:


--
Alex Benn=C3=A9e
