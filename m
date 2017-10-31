Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Wfq-0001WE-KU
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Wfm-0004HU-Hv
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:33:46 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:46517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9Wfm-0004Gv-B0
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:33:42 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m72so22646071wmc.1
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 06:33:41 -0700 (PDT)
References: <20171031122824.25686-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171031122824.25686-1-f4bug@amsat.org>
Date: Tue, 31 Oct 2017 13:33:39 +0000
Message-ID: <87375zigr0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: add python stdlib dependency
 (required by keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Since 927128222b0a QEMU depends of keycodemapdb, which uses the python 'c=
sv'
> module from stdlib to parse keymaps.csv.
>
> Without this package the build fails:
>
>     GEN     ui/input-keymap-linux-to-qcode.c
>   Traceback (most recent call last):
>     File "ui/keycodemapdb/tools/keymap-gen", line 15, in <module>
>       import csv
>   ImportError: No module named csv
>     GEN     ui/input-keymap-qcode-to-qnum.c
>   Traceback (most recent call last):
>     File "ui/keycodemapdb/tools/keymap-gen", line 15, in <module>
>       import csv
>   ImportError: No module named csv
>   [...]
>     CC      ui/input-keymap.o
>   ui/input-keymap.c:8:44: fatal error: ui/input-keymap-linux-to-qcode.c: =
No such file or directory
>   make: *** [ui/input-keymap.o] Error 1
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> this might affect native MinGW builds.
>
> (master broken since a4faa26857694fa87d96d15ad5b6afa8fbc2c900)

It did - interesting that the python breakage doesn't halt the build
there and then.

Applied to travis/next

>
> we didn't notice Shippable failures:
> https://app.shippable.com/github/qemu/qemu/runs/501/summary/console and n=
ext
>
>  tests/docker/dockerfiles/debian8-mxe.docker | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/d=
ockerfiles/debian8-mxe.docker
> index 7bf1b59e54..9b8e577b03 100644
> --- a/tests/docker/dockerfiles/debian8-mxe.docker
> +++ b/tests/docker/dockerfiles/debian8-mxe.docker
> @@ -13,6 +13,7 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --recv=
-keys D43A795B73B16ABE964
>  RUN apt-get update
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> +        libpython2.7-stdlib \
>          $(apt-get -s install -y --no-install-recommends gw32.shared-ming=
w-w64 gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  =
-f2)
>
>  ENV PATH $PATH:/usr/lib/mxe/usr/bin/


--
Alex Benn=C3=A9e
