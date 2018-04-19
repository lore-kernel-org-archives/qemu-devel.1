Received: from eggs.gnu.org ([2001:4830:134:3::10]:38455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GeS-0003PT-8a
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GeP-0004Gg-8T
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:59:32 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GeP-0004GW-2j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:59:29 -0400
Received: by mail-pg0-x243.google.com with SMTP id e9so3057068pgr.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:59:28 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <134cca04-e56c-ed4a-d175-b6c4d574761c@linaro.org>
Date: Thu, 19 Apr 2018 10:59:23 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/43] configure: move i386_cc to
 cross_cc_i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> -cc_i386=i386-pc-linux-gnu-gcc
>  libs_qga=""
>  debug_info="yes"
>  stack_protector=""
> @@ -457,6 +456,8 @@ docker="no"
>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
>  cross_cc_arm="arm-linux-gnueabihf-gcc"
>  cross_cc_powerpc="powerpc-linux-gnu-gcc"
> +cross_cc_i386="i386-pc-linux-gnu-gcc"
> +cross_cc_cflags_i386=""
...
>  
>  enabled_cross_compilers=""
>  
> @@ -687,12 +688,10 @@ case "$cpu" in
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu="i386"
>      supported_cpu="yes"
> -    cross_cc_i386=gcc
>    ;;
>    x86_64|amd64)
>      cpu="x86_64"
>      supported_cpu="yes"
> -    cross_cc_x86_64=gcc
>    ;;
>    armv*b|armv*l|arm)
>      cpu="arm"
> @@ -1435,7 +1434,6 @@ case "$cpu" in
>      i386)
>             CPU_CFLAGS="-m32"
>             LDFLAGS="-m32 $LDFLAGS"
> -           cc_i386='$(CC) -m32'

Why is the i386 case not handled like...

>             ;;
>      x86_64)
>             # ??? Only extremely old AMD cpus do not have cmpxchg16b.
> @@ -1443,12 +1441,14 @@ case "$cpu" in
>             # runtime and generate the fallback to serial emulation.
>             CPU_CFLAGS="-m64 -mcx16"
>             LDFLAGS="-m64 $LDFLAGS"
> -           cc_i386='$(CC) -m32'
> +           cross_cc_x86_64=$cc
> +           cross_cc_cflags_x86_64=$CPU_CFLAGS

... the x86_64 case?

Also, does cross_cc_cflags_foo really have value over including the flags
directly in the cross_cc_foo variable?


r~
