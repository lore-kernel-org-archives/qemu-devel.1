Received: from eggs.gnu.org ([2001:4830:134:3::10]:59662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f800j-00064S-8e
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f800Y-00032b-TZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:01:17 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f800Y-000328-Ir
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:01:06 -0400
Received: by mail-wr0-x242.google.com with SMTP id z73so23707860wrb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 02:01:06 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-10-alex.bennee@linaro.org>
	<9011098f-f881-8426-6781-ca088bb8e32d@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9011098f-f881-8426-6781-ca088bb8e32d@amsat.org>
Date: Mon, 16 Apr 2018 10:01:03 +0100
Message-ID: <878t9nbk4w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 09/24] tests/tcg: move architecture
 independent tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>> We will want to build these for all supported guest architectures so
>> lets move them all into one place. We also drop test_path at this
>> point because it needs qemu utils and glib bits which is hard to
>> support for cross compiling.
>
> Can we keep it for the $target=3D=3D$host case (or when NOT cross
> compiling)? Maybe move it to tests/tcg/host/test_path.c

I'd rather not have tests/tcg/ including anything from QEMU as that
implies more libraries and hence a trickier cross-compile environment.
That said I didn't actually dig into what exactly
init_paths("/tmp/qemu-test_path") was intended to achieve.

>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/README                       |  10 +--
>>  tests/tcg/multiarch/README             |   1 +
>>  tests/tcg/{ =3D> multiarch}/linux-test.c |   0
>>  tests/tcg/{ =3D> multiarch}/sha1.c       |   0
>>  tests/tcg/{ =3D> multiarch}/test-mmap.c  |   0
>>  tests/tcg/{ =3D> multiarch}/testthread.c |   0
>>  tests/tcg/test_path.c                  | 157 --------------------------=
-------
>>  7 files changed, 5 insertions(+), 163 deletions(-)
>>  create mode 100644 tests/tcg/multiarch/README
>>  rename tests/tcg/{ =3D> multiarch}/linux-test.c (100%)
>>  rename tests/tcg/{ =3D> multiarch}/sha1.c (100%)
>>  rename tests/tcg/{ =3D> multiarch}/test-mmap.c (100%)
>>  rename tests/tcg/{ =3D> multiarch}/testthread.c (100%)
>>  delete mode 100644 tests/tcg/test_path.c
>>=20
>> diff --git a/tests/tcg/README b/tests/tcg/README
>> index 5dcfb4852b..0890044cf0 100644
>> --- a/tests/tcg/README
>> +++ b/tests/tcg/README
>> @@ -1,9 +1,7 @@
>> -This directory contains various interesting programs for
>> -regression testing.
>> -
>> -The target "make test" runs the programs and, if applicable,
>> -runs "diff" to detect mismatches between output on the host and
>> -output on QEMU.
>> +This directory contains various interesting guest programs for
>> +regression testing. Tests are either multi-arch, meaning they can be
>> +built for all guest architectures that support linux-user executable,
>> +or they are architecture specific.
>>=20=20
>>  i386
>>  =3D=3D=3D=3D
>> diff --git a/tests/tcg/multiarch/README b/tests/tcg/multiarch/README
>> new file mode 100644
>> index 0000000000..522c9d2ea3
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/README
>> @@ -0,0 +1 @@
>> +Multi-architecture linux-user tests
>> diff --git a/tests/tcg/linux-test.c b/tests/tcg/multiarch/linux-test.c
>> similarity index 100%
>> rename from tests/tcg/linux-test.c
>> rename to tests/tcg/multiarch/linux-test.c
>> diff --git a/tests/tcg/sha1.c b/tests/tcg/multiarch/sha1.c
>> similarity index 100%
>> rename from tests/tcg/sha1.c
>> rename to tests/tcg/multiarch/sha1.c
>> diff --git a/tests/tcg/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
>> similarity index 100%
>> rename from tests/tcg/test-mmap.c
>> rename to tests/tcg/multiarch/test-mmap.c
>> diff --git a/tests/tcg/testthread.c b/tests/tcg/multiarch/testthread.c
>> similarity index 100%
>> rename from tests/tcg/testthread.c
>> rename to tests/tcg/multiarch/testthread.c
>> diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
>> deleted file mode 100644
>> index 1c29bce263..0000000000
>> --- a/tests/tcg/test_path.c
>> +++ /dev/null
>> @@ -1,157 +0,0 @@
>> -/* Test path override code */
>> -#include "config-host.h"
>> -#include "util/cutils.c"
>> -#include "util/hexdump.c"
>> -#include "util/iov.c"
>> -#include "util/path.c"
>> -#include "util/qemu-timer-common.c"
>> -#include <stdarg.h>
>> -#include <sys/stat.h>
>> -#include <fcntl.h>
>> -
>> -void qemu_log(const char *fmt, ...);
>> -
>> -/* Any log message kills the test. */
>> -void qemu_log(const char *fmt, ...)
>> -{
>> -    va_list ap;
>> -
>> -    fprintf(stderr, "FATAL: ");
>> -    va_start(ap, fmt);
>> -    vfprintf(stderr, fmt, ap);
>> -    va_end(ap);
>> -    exit(1);
>> -}
>> -
>> -#define NO_CHANGE(_path)						\
>> -	do {								\
>> -	    if (strcmp(path(_path), _path) !=3D 0) return __LINE__;	\
>> -	} while(0)
>> -
>> -#define CHANGE_TO(_path, _newpath)					\
>> -	do {								\
>> -	    if (strcmp(path(_path), _newpath) !=3D 0) return __LINE__;	\
>> -	} while(0)
>> -
>> -static void cleanup(void)
>> -{
>> -    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE");
>> -    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE2");
>> -    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE3");
>> -    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE4");
>> -    unlink("/tmp/qemu-test_path/DIR1/DIR2/FILE5");
>> -    rmdir("/tmp/qemu-test_path/DIR1/DIR2");
>> -    rmdir("/tmp/qemu-test_path/DIR1/DIR3");
>> -    rmdir("/tmp/qemu-test_path/DIR1");
>> -    rmdir("/tmp/qemu-test_path");
>> -}
>> -
>> -static unsigned int do_test(void)
>> -{
>> -    if (mkdir("/tmp/qemu-test_path", 0700) !=3D 0)
>> -	return __LINE__;
>> -
>> -    if (mkdir("/tmp/qemu-test_path/DIR1", 0700) !=3D 0)
>> -	return __LINE__;
>> -
>> -    if (mkdir("/tmp/qemu-test_path/DIR1/DIR2", 0700) !=3D 0)
>> -	return __LINE__;
>> -
>> -    if (mkdir("/tmp/qemu-test_path/DIR1/DIR3", 0700) !=3D 0)
>> -	return __LINE__;
>> -
>> -    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE", 0600)) !=3D 0)
>> -	return __LINE__;
>> -
>> -    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE2", 0600)) !=3D =
0)
>> -	return __LINE__;
>> -
>> -    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE3", 0600)) !=3D =
0)
>> -	return __LINE__;
>> -
>> -    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE4", 0600)) !=3D =
0)
>> -	return __LINE__;
>> -
>> -    if (close(creat("/tmp/qemu-test_path/DIR1/DIR2/FILE5", 0600)) !=3D =
0)
>> -	return __LINE__;
>> -
>> -    init_paths("/tmp/qemu-test_path");
>> -
>> -    NO_CHANGE("/tmp");
>> -    NO_CHANGE("/tmp/");
>> -    NO_CHANGE("/tmp/qemu-test_path");
>> -    NO_CHANGE("/tmp/qemu-test_path/");
>> -    NO_CHANGE("/tmp/qemu-test_path/D");
>> -    NO_CHANGE("/tmp/qemu-test_path/DI");
>> -    NO_CHANGE("/tmp/qemu-test_path/DIR");
>> -    NO_CHANGE("/tmp/qemu-test_path/DIR1");
>> -    NO_CHANGE("/tmp/qemu-test_path/DIR1/");
>> -
>> -    NO_CHANGE("/D");
>> -    NO_CHANGE("/DI");
>> -    NO_CHANGE("/DIR");
>> -    NO_CHANGE("/DIR2");
>> -    NO_CHANGE("/DIR1.");
>> -
>> -    CHANGE_TO("/DIR1", "/tmp/qemu-test_path/DIR1");
>> -    CHANGE_TO("/DIR1/", "/tmp/qemu-test_path/DIR1");
>> -
>> -    NO_CHANGE("/DIR1/D");
>> -    NO_CHANGE("/DIR1/DI");
>> -    NO_CHANGE("/DIR1/DIR");
>> -    NO_CHANGE("/DIR1/DIR1");
>> -
>> -    CHANGE_TO("/DIR1/DIR2", "/tmp/qemu-test_path/DIR1/DIR2");
>> -    CHANGE_TO("/DIR1/DIR2/", "/tmp/qemu-test_path/DIR1/DIR2");
>> -
>> -    CHANGE_TO("/DIR1/DIR3", "/tmp/qemu-test_path/DIR1/DIR3");
>> -    CHANGE_TO("/DIR1/DIR3/", "/tmp/qemu-test_path/DIR1/DIR3");
>> -
>> -    NO_CHANGE("/DIR1/DIR2/F");
>> -    NO_CHANGE("/DIR1/DIR2/FI");
>> -    NO_CHANGE("/DIR1/DIR2/FIL");
>> -    NO_CHANGE("/DIR1/DIR2/FIL.");
>> -
>> -    CHANGE_TO("/DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE");
>> -    CHANGE_TO("/DIR1/DIR2/FILE2", "/tmp/qemu-test_path/DIR1/DIR2/FILE2"=
);
>> -    CHANGE_TO("/DIR1/DIR2/FILE3", "/tmp/qemu-test_path/DIR1/DIR2/FILE3"=
);
>> -    CHANGE_TO("/DIR1/DIR2/FILE4", "/tmp/qemu-test_path/DIR1/DIR2/FILE4"=
);
>> -    CHANGE_TO("/DIR1/DIR2/FILE5", "/tmp/qemu-test_path/DIR1/DIR2/FILE5"=
);
>> -
>> -    NO_CHANGE("/DIR1/DIR2/FILE6");
>> -    NO_CHANGE("/DIR1/DIR2/FILE/X");
>> -
>> -    CHANGE_TO("/DIR1/../DIR1", "/tmp/qemu-test_path/DIR1");
>> -    CHANGE_TO("/DIR1/../DIR1/", "/tmp/qemu-test_path/DIR1");
>> -    CHANGE_TO("/../DIR1", "/tmp/qemu-test_path/DIR1");
>> -    CHANGE_TO("/../DIR1/", "/tmp/qemu-test_path/DIR1");
>> -    CHANGE_TO("/DIR1/DIR2/../DIR2", "/tmp/qemu-test_path/DIR1/DIR2");
>> -    CHANGE_TO("/DIR1/DIR2/../DIR2/../../DIR1/DIR2/FILE", "/tmp/qemu-tes=
t_path/DIR1/DIR2/FILE");
>> -    CHANGE_TO("/DIR1/DIR2/../DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2=
/FILE");
>> -
>> -    NO_CHANGE("/DIR1/DIR2/../DIR1");
>> -    NO_CHANGE("/DIR1/DIR2/../FILE");
>> -
>> -    CHANGE_TO("/./DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE"=
);
>> -    CHANGE_TO("/././DIR1/DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FIL=
E");
>> -    CHANGE_TO("/DIR1/./DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE"=
);
>> -    CHANGE_TO("/DIR1/././DIR2/FILE", "/tmp/qemu-test_path/DIR1/DIR2/FIL=
E");
>> -    CHANGE_TO("/DIR1/DIR2/./FILE", "/tmp/qemu-test_path/DIR1/DIR2/FILE"=
);
>> -    CHANGE_TO("/DIR1/DIR2/././FILE", "/tmp/qemu-test_path/DIR1/DIR2/FIL=
E");
>> -    CHANGE_TO("/./DIR1/./DIR2/./FILE", "/tmp/qemu-test_path/DIR1/DIR2/F=
ILE");
>> -
>> -    return 0;
>> -}
>> -
>> -int main(int argc, char *argv[])
>> -{
>> -    int ret;
>> -
>> -    ret =3D do_test();
>> -    cleanup();
>> -    if (ret) {
>> -	fprintf(stderr, "test_path: failed on line %i\n", ret);
>> -	return 1;
>> -    }
>> -    return 0;
>> -}
>>=20


--=20
Alex Benn=C3=A9e
