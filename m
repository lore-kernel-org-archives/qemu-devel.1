Received: from eggs.gnu.org ([2001:4830:134:3::10]:44753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gdD-0001zW-1E
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gd9-0004lI-SP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:15:10 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gd9-0004jf-M6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:15:07 -0400
Received: by mail-wm0-x229.google.com with SMTP id 142so60990266wma.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:15:07 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-18-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-18-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:15:50 +0100
Message-ID: <87zien8uqh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/23] shippable: use dtc submodule if
 distrib packages are too old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> shippable output:
> ----------------
>   LINK    mips64el-softmmu/qemu-system-mips64el
> ../hw/core/loader-fit.o: In function `load_fit':
> /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:278: undefined reference to `fdt_first_subnode'
> /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:286: undefined reference to `fdt_next_subnode'
> /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:277: undefined reference to `fdt_first_subnode'
> collect2: error: ld returned 1 exit status
> Makefile:201: recipe for target 'qemu-system-mips64el' failed
> make[1]: *** [qemu-system-mips64el] Error 1
> Makefile:327: recipe for target 'subdir-mips64el-softmmu' failed
> make: *** [subdir-mips64el-softmmu] Error 2
>
> having this too old libfdt version (required version >= 1.4.2):
>  # dpkg-query --showformat='${Version}\n' --show libfdt-dev
> 1.4.0+dfsg-1
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index b3cbca458c..6601243060 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -27,5 +27,13 @@ build:
>      options: "-e HOME=/root"
>    ci:
>      - unset CC
> +    # some targets require newer up to date packages, for example TARGET_LIST matching
> +    # aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
> +    # see the configure script:
> +    #    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:"
> +    #    "  (1) Preferred: Install the DTC (libfdt) devel package"
> +    #    "  (2) Fetch the DTC submodule, using:"
> +    #    "      git submodule update --init dtc"
> +    - dpkg --compare-versions `dpkg-query --showformat='${Version}' --show libfdt-dev` ge 1.4.2 || git submodule update --init dtc
>      - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
>      - make -j$(getconf _NPROCESSORS_ONLN)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>



--
Alex Bennée
