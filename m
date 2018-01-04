Received: from eggs.gnu.org ([2001:4830:134:3::10]:43793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX982-0002ik-Ul
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX97m-0000He-CB
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:16:30 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX97m-0000Gc-34
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:16:14 -0500
Received: by mail-qk0-x243.google.com with SMTP id o126so2754588qke.12
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:16:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51af594d-5798-6998-a5ed-1598c8b001ba@amsat.org>
Date: Thu, 4 Jan 2018 14:16:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/18] tests/docker: add test-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 01/04/2018 01:05 PM, Marc-André Lureau wrote:
> Add a new test with --enable-debug using clang/asan/ubsan, remove
> --enable-debug from test-clang & test-mingw.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/test-clang |  2 +-
>  tests/docker/test-debug | 26 ++++++++++++++++++++++++++
>  tests/docker/test-mingw |  2 --
>  3 files changed, 27 insertions(+), 3 deletions(-)
>  create mode 100755 tests/docker/test-debug
> 
> diff --git a/tests/docker/test-clang b/tests/docker/test-clang
> index 1eb61a3af7..e90a793178 100755
> --- a/tests/docker/test-clang
> +++ b/tests/docker/test-clang
> @@ -17,7 +17,7 @@ requires clang
>  
>  cd "$BUILD_DIR"
>  
> -OPTS="--enable-debug --cxx=clang++ --cc=clang --host-cc=clang"
> +OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
>  # -fsanitize=undefined is broken on Fedora 23, skip it for now
>  # See also: https://bugzilla.redhat.com/show_bug.cgi?id=1263834
>  #OPTS="$OPTS --extra-cflags=-fsanitize=undefined \


> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
> new file mode 100755
> index 0000000000..d020b06917
> --- /dev/null
> +++ b/tests/docker/test-debug
> @@ -0,0 +1,26 @@
> +#!/bin/bash -e
> +#
> +# Compile and check with clang & --enable-debug.
> +#
> +# Copyright (c) 2016-2018 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#  Marc-André Lureau <marcandre.lureau@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +requires clang asan
> +
> +cd "$BUILD_DIR"
> +
> +OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
> +OPTS="--enable-debug $OPTS"
> +
> +build_qemu $OPTS
> +make $MAKEFLAGS check
> +install_qemu


> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index 39a1da448e..503a6bc6f7 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -22,7 +22,6 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>      TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>          build_qemu --cross-prefix=$prefix \
>          --enable-trace-backends=simple \
> -        --enable-debug \
>          --enable-gnutls \
>          --enable-nettle \
>          --enable-curl \
> @@ -35,4 +34,3 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>      make clean
>  
>  done
> -
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
