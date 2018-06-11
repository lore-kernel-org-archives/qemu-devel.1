Received: from eggs.gnu.org ([2001:4830:134:3::10]:55026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSI2G-0001tg-NG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSI2C-0006fl-OE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:18:44 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fSI2C-0006fS-89
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:18:40 -0400
Received: by mail-wm0-x244.google.com with SMTP id l15-v6so10001895wmc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 01:18:40 -0700 (PDT)
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-41-alex.bennee@linaro.org>
	<abdbe000-3b80-d116-1183-10dae22fbd9e@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <abdbe000-3b80-d116-1183-10dae22fbd9e@amsat.org>
Date: Mon, 11 Jun 2018 09:18:37 +0100
Message-ID: <878t7l20te.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 40/49] tests/tcg: enable building for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 06/08/2018 09:32 AM, Alex Benn=C3=A9e wrote:
>> Now we have restored debian-image-powerpc-cross using Debian SID
>> compilers we can build for 32 bit powerpc. Although PPC32 supports a
>> range of pages sizes currently only 4k works so the others are
>> commented out for now.
>>
>> We can also merge the ppc64 support under the base architecture
>> directory to avoid too much proliferation of directories.
>
> ppc64el doesn't seem to work:
>
> $ make subdir-ppc64le-linux-user build-tcg-tests-ppc64el-linux-user -j1
> make[1]: *** ppc64el-linux-user: No such file or directory.  Stop.
> make: *** [tests/Makefile.include:947:
> build-tcg-tests-ppc64el-linux-user] Error 2

09:17:30 [alex@zen:~/l/q/qemu.git] testing/tcg-testing-revival-v7 + make ru=
n-tcg-tests-ppc64le-linux-user
  BUILD   debian9
  BUILD   debian-ppc64el-cross
  CROSS-BUILD ppc64le guest-tests with docker qemu:debian-ppc64el-cross
  BUILD   debian9
  BUILD   debian-ppc64el-cross
  CROSS-BUILD ppc64le guest-tests with docker qemu:debian-ppc64el-cross
  CC      ppc64le-linux-user/linux-user/main.o
  LINK    ppc64le-linux-user/qemu-ppc64le
  RUN-TESTS for ppc64le
  TEST    test-mmap (default) on ppc64le
  TEST    sha1 on ppc64le
  TEST    linux-test on ppc64le
  TEST    testthread on ppc64le
  TEST    test-mmap (4096 byte pages) on ppc64le

The Debian and QEMU naming conventions switch....

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ppc32:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>
>> ---
>> v5
>>   - new for v5
>> ---
>>  tests/tcg/ppc/Makefile.include     |  7 +++++++
>>  tests/tcg/ppc/Makefile.target      | 12 ++++++++++++
>>  tests/tcg/ppc64le/Makefile.include |  2 --
>>  3 files changed, 19 insertions(+), 2 deletions(-)
>>  create mode 100644 tests/tcg/ppc/Makefile.include
>>  create mode 100644 tests/tcg/ppc/Makefile.target
>>  delete mode 100644 tests/tcg/ppc64le/Makefile.include
>>
>> diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.inc=
lude
>> new file mode 100644
>> index 0000000000..b062c30dd3
>> --- /dev/null
>> +++ b/tests/tcg/ppc/Makefile.include
>> @@ -0,0 +1,7 @@
>> +ifeq ($(TARGET_NAME),ppc)
>> +DOCKER_IMAGE=3Ddebian-powerpc-cross
>> +DOCKER_CROSS_COMPILER=3Dpowerpc-linux-gnu-gcc
>> +else ifeq ($(TARGET_NAME),ppc64le)
>> +DOCKER_IMAGE=3Ddebian-ppc64el-cross
>> +DOCKER_CROSS_COMPILER=3Dpowerpc64le-linux-gnu-gcc
>> +endif
>> diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.targ=
et
>> new file mode 100644
>> index 0000000000..f5e08c7376
>> --- /dev/null
>> +++ b/tests/tcg/ppc/Makefile.target
>> @@ -0,0 +1,12 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# PPC - included from tests/tcg/Makefile
>> +#
>> +
>> +ifneq (,$(findstring 64,$(TARGET_NAME)))
>> +# On PPC64 Linux can be configured with 4k (default) or 64k pages (curr=
ently broken)
>> +EXTRA_RUNS+=3Drun-test-mmap-4096 #run-test-mmap-65536
>> +else
>> +# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
>> +EXTRA_RUNS+=3Drun-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-655=
36 run-test-mmap-262144
>> +endif
>> diff --git a/tests/tcg/ppc64le/Makefile.include b/tests/tcg/ppc64le/Make=
file.include
>> deleted file mode 100644
>> index d71cfc9aa7..0000000000
>> --- a/tests/tcg/ppc64le/Makefile.include
>> +++ /dev/null
>> @@ -1,2 +0,0 @@
>> -DOCKER_IMAGE=3Ddebian-ppc64el-cross
>> -DOCKER_CROSS_COMPILER=3Dpowerpc64le-linux-gnu-gcc
>>


--
Alex Benn=C3=A9e
