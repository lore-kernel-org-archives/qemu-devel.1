Received: from eggs.gnu.org ([2001:4830:134:3::10]:53410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dio3g-0000oj-N2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dio3f-0002OJ-BE
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:39:56 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dio3f-0002NR-23
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:39:55 -0400
Received: by mail-wr0-x244.google.com with SMTP id 49so8119802wrw.5
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:39:53 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <b162f9c5-8f49-45ba-751e-de7f832ebfa4@amsat.org>
References: <cover.1503077821.git.alistair.francis@xilinx.com>
	<54e6458745493d10901964624479a7d9a872f481.1503077821.git.alistair.francis@xilinx.com>
	<b162f9c5-8f49-45ba-751e-de7f832ebfa4@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 18 Aug 2017 13:39:21 -0700
Message-ID: <CAKmqyKPMx3R7v9jMf=fmtJkhc2KB_R82WYJJxmtg-FZkbNTLkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Makefile: Remove libqemustub.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Aug 18, 2017 at 12:29 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Hi Alistair,
>
>
> On 08/18/2017 03:47 PM, Alistair Francis wrote:
>>
>> Using two libraries (libqemuutil.a and libqemustub.a) would sometimes
>> result in circular dependencies. To avoid these issues let's just
>> combine both into a single library that functions as both.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>   Makefile                    |  7 +++----
>>   Makefile.target             |  2 +-
>>   docs/devel/build-system.txt | 14 +++++---------
>>   tests/Makefile.include      |  6 +++---
>>   4 files changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 81447b1f08..f111e93c63 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -344,7 +344,7 @@ subdir-dtc:dtc/libfdt dtc/tests
>>   dtc/%:
>>         mkdir -p $@
>>   -$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y)
>> $(chardev-obj-y) \
>> +$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
>>         $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>>     ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
>> @@ -364,12 +364,11 @@ Makefile: $(version-obj-y)
>>   ######################################################################
>>   # Build libraries
>>   -libqemustub.a: $(stub-obj-y)
>> -libqemuutil.a: $(util-obj-y) $(trace-obj-y)
>> +libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>>     ####################################################################=
##
>>   -COMMON_LDADDS =3D libqemuutil.a libqemustub.a
>> +COMMON_LDADDS =3D libqemuutil.a
>>     qemu-img.o: qemu-img-cmds.h
>>   diff --git a/Makefile.target b/Makefile.target
>> index 7f42c45db8..0a80caf79c 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -193,7 +193,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
>>     $(QEMU_PROG_BUILD): config-devices.mak
>>   -COMMON_LDADDS =3D ../libqemuutil.a ../libqemustub.a
>> +COMMON_LDADDS =3D ../libqemuutil.a
>>     # build either PROG or PROGW
>>   $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
>> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
>> index 2af1e668c5..5f32e53248 100644
>> --- a/docs/devel/build-system.txt
>> +++ b/docs/devel/build-system.txt
>> @@ -232,15 +232,11 @@ The utility code that is used by all binaries is
>> built into a
>>   static archive called libqemuutil.a, which is then linked to all the
>>   binaries. In order to provide hooks that are only needed by some of th=
e
>>   binaries, code in libqemuutil.a may depend on other functions that are
>> -not fully implemented by all QEMU binaries. To deal with this there is =
a
>> -second library called libqemustub.a which provides dummy stubs for all
>> -these functions. These will get lazy linked into the binary if the real
>> -implementation is not present. In this way, the libqemustub.a static
>> -library can be thought of as a portable implementation of the weak
>> -symbols concept. All binaries should link to both libqemuutil.a and
>> -libqemustub.a. e.g.
>> -
>> - qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a libqemustub.a
>> +not fully implemented by all QEMU binaries. To deal with this there are
>> +dummy stubs for all these functions in libqemuutil.a.
>> +All binaries should link to both libqemuutil.a and libqemustub.a. e.g.
>
>
> still libqemustub.a

Ah, I missed this. I'll fix this up.

>
>> +
>> + qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
>
>
> changed a bit:
>
> The utility code that is used by all binaries is built into a
> static archive called libqemuutil.a, which is then linked to all the
> binaries. In order to provide hooks that are only needed by some of the
> binaries, code in libqemuutil.a may depend on other functions that are
> not fully implemented by all QEMU binaries. Dummy stubs for all  these
> functions are also provided by this library, and will get lazy linked
> into the binary if the real implementation is not present. In this way,
> this static library can be thought of as a portable implementation of
> the weak symbols concept. All binaries should link to libqemuutil.a. e.g.
>
>  qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
>
> This or removing "libqemustub.a":
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!
Alistair

>
>
>>   Windows platform portability
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 37c1bed683..80527a8763 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -553,7 +553,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
>>       # Deps that are common to various different sets of tests below
>> -test-util-obj-y =3D libqemuutil.a libqemustub.a
>> +test-util-obj-y =3D libqemuutil.a
>>   test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
>>   test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
>>         tests/test-qapi-event.o tests/test-qmp-introspect.o \
>> @@ -608,8 +608,8 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
>>         $(test-io-obj-y)
>>   tests/test-timed-average$(EXESUF): tests/test-timed-average.o
>> $(test-util-obj-y)
>>   tests/test-base64$(EXESUF): tests/test-base64.o \
>> -       libqemuutil.a libqemustub.a
>> -tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs=
.o
>> hw/core/ptimer.o libqemustub.a
>> +       libqemuutil.a
>> +tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs=
.o
>> hw/core/ptimer.o $(test-util-obj-y)
>>     tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
>>
