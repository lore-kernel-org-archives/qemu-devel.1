Received: from eggs.gnu.org ([2001:4830:134:3::10]:47039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBBZ-0002bn-6f
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBBU-0006Uc-OB
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:33:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBBU-0006UJ-I2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:33:32 -0400
Received: by mail-qt0-x241.google.com with SMTP id f16-v6so21298776qth.0
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:33:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d668a3a2-1742-d5d7-7f1c-5bbfa08aa754@amsat.org>
Date: Wed, 25 Apr 2018 00:33:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 18/46] tests/tcg: enable building for
 i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> While you can construct a compile command that does work using the
> x86_64 host compiler that most people use this is flakey. Different
> distros handle this is different ways so we default to using a known
> good i386 compiler via docker.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - add runner for runcom
> ---
>  tests/tcg/i386/Makefile.include | 9 +++++++++
>  tests/tcg/i386/Makefile.target  | 9 +++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 tests/tcg/i386/Makefile.include
> 
> diff --git a/tests/tcg/i386/Makefile.include b/tests/tcg/i386/Makefile.include
> new file mode 100644
> index 0000000000..be1c3008dd
> --- /dev/null
> +++ b/tests/tcg/i386/Makefile.include
> @@ -0,0 +1,9 @@
> +#
> +# Makefile.include for all i386
> +#
> +# There is enough brokeness in x86_64 compilers that we don't default
> +# to using the x86_64 system compiler for i386 binaries.
> +#
> +
> +DOCKER_IMAGE=fedora-i386-cross
> +DOCKER_CROSS_COMPILER=gcc
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 2f27b65e2d..39a1627650 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -28,3 +28,12 @@ hello-i386: LDFLAGS+=-nostdlib
>  test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
>  	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
> +
> +# Specialist test runners
> +.PHONY: pi_10.com
> +pi_10.com:
> +	cp $(I386_SRC)/pi_10.com .
> +
> +run-runcom: runcom pi_10.com
> +	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
> +
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

"make run-tcg-tests-i386-linux-user" without ASan:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
