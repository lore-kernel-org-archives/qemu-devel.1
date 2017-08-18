Received: from eggs.gnu.org ([2001:4830:134:3::10]:40183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimy4-00033m-0J
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimy0-0002eL-R2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:30:04 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dimy0-0002e6-LR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:30:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id i19so9779609qte.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 12:30:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1503077821.git.alistair.francis@xilinx.com>
	<54e6458745493d10901964624479a7d9a872f481.1503077821.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b162f9c5-8f49-45ba-751e-de7f832ebfa4@amsat.org>
Date: Fri, 18 Aug 2017 16:29:56 -0300
MIME-Version: 1.0
In-Reply-To: <54e6458745493d10901964624479a7d9a872f481.1503077821.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Makefile: Remove libqemustub.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair23@gmail.com, pbonzini@redhat.com

Hi Alistair,

On 08/18/2017 03:47 PM, Alistair Francis wrote:
> Using two libraries (libqemuutil.a and libqemustub.a) would sometimes
> result in circular dependencies. To avoid these issues let's just
> combine both into a single library that functions as both.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>   Makefile                    |  7 +++----
>   Makefile.target             |  2 +-
>   docs/devel/build-system.txt | 14 +++++---------
>   tests/Makefile.include      |  6 +++---
>   4 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 81447b1f08..f111e93c63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -344,7 +344,7 @@ subdir-dtc:dtc/libfdt dtc/tests
>   dtc/%:
>   	mkdir -p $@
>   
> -$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj-y) \
> +$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
>   	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>   
>   ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
> @@ -364,12 +364,11 @@ Makefile: $(version-obj-y)
>   ######################################################################
>   # Build libraries
>   
> -libqemustub.a: $(stub-obj-y)
> -libqemuutil.a: $(util-obj-y) $(trace-obj-y)
> +libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>   
>   ######################################################################
>   
> -COMMON_LDADDS = libqemuutil.a libqemustub.a
> +COMMON_LDADDS = libqemuutil.a
>   
>   qemu-img.o: qemu-img-cmds.h
>   
> diff --git a/Makefile.target b/Makefile.target
> index 7f42c45db8..0a80caf79c 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -193,7 +193,7 @@ all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
>   
>   $(QEMU_PROG_BUILD): config-devices.mak
>   
> -COMMON_LDADDS = ../libqemuutil.a ../libqemustub.a
> +COMMON_LDADDS = ../libqemuutil.a
>   
>   # build either PROG or PROGW
>   $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
> index 2af1e668c5..5f32e53248 100644
> --- a/docs/devel/build-system.txt
> +++ b/docs/devel/build-system.txt
> @@ -232,15 +232,11 @@ The utility code that is used by all binaries is built into a
>   static archive called libqemuutil.a, which is then linked to all the
>   binaries. In order to provide hooks that are only needed by some of the
>   binaries, code in libqemuutil.a may depend on other functions that are
> -not fully implemented by all QEMU binaries. To deal with this there is a
> -second library called libqemustub.a which provides dummy stubs for all
> -these functions. These will get lazy linked into the binary if the real
> -implementation is not present. In this way, the libqemustub.a static
> -library can be thought of as a portable implementation of the weak
> -symbols concept. All binaries should link to both libqemuutil.a and
> -libqemustub.a. e.g.
> -
> - qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a libqemustub.a
> +not fully implemented by all QEMU binaries. To deal with this there are
> +dummy stubs for all these functions in libqemuutil.a.
> +All binaries should link to both libqemuutil.a and libqemustub.a. e.g.

still libqemustub.a

> +
> + qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a

changed a bit:

The utility code that is used by all binaries is built into a
static archive called libqemuutil.a, which is then linked to all the
binaries. In order to provide hooks that are only needed by some of the
binaries, code in libqemuutil.a may depend on other functions that are
not fully implemented by all QEMU binaries. Dummy stubs for all  these
functions are also provided by this library, and will get lazy linked
into the binary if the real implementation is not present. In this way,
this static library can be thought of as a portable implementation of
the weak symbols concept. All binaries should link to libqemuutil.a. e.g.

  qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a

This or removing "libqemustub.a":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   Windows platform portability
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 37c1bed683..80527a8763 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -553,7 +553,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
>   
>   
>   # Deps that are common to various different sets of tests below
> -test-util-obj-y = libqemuutil.a libqemustub.a
> +test-util-obj-y = libqemuutil.a
>   test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
>   test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
>   	tests/test-qapi-event.o tests/test-qmp-introspect.o \
> @@ -608,8 +608,8 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
>   	$(test-io-obj-y)
>   tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
>   tests/test-base64$(EXESUF): tests/test-base64.o \
> -	libqemuutil.a libqemustub.a
> -tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemustub.a
> +	libqemuutil.a
> +tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o $(test-util-obj-y)
>   
>   tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
>   
> 
