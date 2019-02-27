Received: from eggs.gnu.org ([209.51.188.92]:52022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gz6wt-0007Ms-W7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gz6ws-0003PA-Cc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:41:07 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gz6ws-0002H6-3J
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:41:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id r5so19659815wrg.9
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:40:05 -0800 (PST)
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
	<87h8cpkmra.fsf@zen.linaroharston>
	<56298ace-a6f7-2b2a-acc2-0e09615c121b@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <56298ace-a6f7-2b2a-acc2-0e09615c121b@redhat.com>
Date: Wed, 27 Feb 2019 21:40:03 +0000
Message-ID: <87fts8lxl8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


David Hildenbrand <david@redhat.com> writes:

> On 27.02.19 21:19, Alex Benn=C3=A9e wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 27.02.19 12:14, David Hildenbrand wrote:
>>>> We want to make use of vectors, so use -march=3Dz13. To make it compil=
e,
>>>> use a reasonable optimization level (-O2), which seems to work just fi=
ne
>>>> with all tests.
>>>>
>>>> Add some infrastructure for checking if SIGILL will be properly
>>>> triggered.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  tests/tcg/s390x/Makefile.target     |  3 ++-
>>>>  tests/tcg/s390x/helper.h            | 28 +++++++++++++++++++++
>>>>  tests/tcg/s390x/signal_helper.inc.c | 39 +++++++++++++++++++++++++++++
>>>>  tests/tcg/s390x/vlgv.c              | 37 +++++++++++++++++++++++++++
>>>>  4 files changed, 106 insertions(+), 1 deletion(-)
>>>>  create mode 100644 tests/tcg/s390x/helper.h
>>>>  create mode 100644 tests/tcg/s390x/signal_helper.inc.c
>>>>  create mode 100644 tests/tcg/s390x/vlgv.c
>>>>
>>>> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefil=
e.target
>>>> index 151dc075aa..d1ae755ab9 100644
>>>> --- a/tests/tcg/s390x/Makefile.target
>>>> +++ b/tests/tcg/s390x/Makefile.target
>>>> @@ -1,8 +1,9 @@
>>>>  VPATH+=3D$(SRC_PATH)/tests/tcg/s390x
>>>> -CFLAGS+=3D-march=3DzEC12 -m64
>>>> +CFLAGS+=3D-march=3Dz13 -m64 -O2
>>>>  TESTS+=3Dhello-s390x
>>>>  TESTS+=3Dcsst
>>>>  TESTS+=3Dipm
>>>>  TESTS+=3Dexrl-trt
>>>>  TESTS+=3Dexrl-trtr
>>>>  TESTS+=3Dpack
>>>> +TESTS+=3Dvlgv
>>>> diff --git a/tests/tcg/s390x/helper.h b/tests/tcg/s390x/helper.h
>>>> new file mode 100644
>>>> index 0000000000..845b8bb504
>>>> --- /dev/null
>>>> +++ b/tests/tcg/s390x/helper.h
>>>> @@ -0,0 +1,28 @@
>>>> +#ifndef TEST_TCG_S390x_VECTOR_H
>>>> +#define TEST_TCG_S390x_VECTOR_H
>>>> +
>>>> +#include <stdint.h>
>>>> +
>>>> +#define ES_8    0
>>>> +#define ES_16   1
>>>> +#define ES_32   2
>>>> +#define ES_64   3
>>>> +#define ES_128  4
>>>> +
>>>> +typedef union S390Vector {
>>>> +    __uint128_t v;
>>>> +    uint64_t q[2];
>>>> +    uint32_t d[4];
>>>> +    uint16_t w[8];
>>>> +    uint8_t h[16];
>>>> +} S390Vector;
>>>> +
>>>> +static inline void check(const char *s, bool cond)
>>>> +{
>>>> +    if (!cond) {
>>>> +        fprintf(stderr, "Check failed: %s\n", s);
>>>> +        exit(-1);
>>>> +    }
>>>> +}
>>>> +
>>>> +#endif /* TEST_TCG_S390x_VECTOR_H */
>>>> diff --git a/tests/tcg/s390x/signal_helper.inc.c b/tests/tcg/s390x/sig=
nal_helper.inc.c
>>>> new file mode 100644
>>>> index 0000000000..5bd69ca76a
>>>> --- /dev/null
>>>> +++ b/tests/tcg/s390x/signal_helper.inc.c
>>>> @@ -0,0 +1,39 @@
>>>> +#include <stdlib.h>
>>>> +#include <stdio.h>
>>>> +#include <stdbool.h>
>>>> +#include <signal.h>
>>>> +#include <setjmp.h>
>>>> +#include "helper.h"
>>>> +
>>>> +jmp_buf jmp_env;
>>>> +
>>>> +static void sig_sigill(int sig)
>>>> +{
>>>> +    if (sig !=3D SIGILL) {
>>>> +        check("Wrong signal received", false);
>>>> +    }
>>>> +    longjmp(jmp_env, 1);
>>>> +}
>>>> +
>>>> +#define CHECK_SIGILL(STATEMENT)                             \
>>>> +do {                                                        \
>>>> +    struct sigaction act;                                   \
>>>> +                                                            \
>>>> +    act.sa_handler =3D sig_sigill;                            \
>>>> +    act.sa_flags =3D 0;                                       \
>>>> +    if (sigaction(SIGILL, &act, NULL)) {                    \
>>>> +        check("SIGILL handler not registered", false);      \
>>>> +    }                                                       \
>>>> +                                                            \
>>>> +    if (setjmp(jmp_env) =3D=3D 0) {                             \
>>>> +        STATEMENT;                                          \
>>>> +        check("SIGILL not triggered", false);               \
>>>> +    }                                                       \
>>>> +                                                            \
>>>> +    act.sa_handler =3D SIG_DFL;                               \
>>>> +    sigemptyset(&act.sa_mask);                              \
>>>> +    act.sa_flags =3D 0;                                       \
>>>> +    if (sigaction(SIGILL, &act, NULL)) {                    \
>>>> +        check("SIGILL handler not unregistered", false);    \
>>>> +    }                                                       \
>>>> +} while (0)
>>>
>>> Now this is some interesting hackery.
>>>
>>> I changed it to
>>>
>>> jmp_buf jmp_env;
>>>
>>> static void sig_sigill(int sig)
>>> {
>>>     if (sig !=3D SIGILL) {
>>>         check("Wrong signal received", false);
>>>     }
>>>     longjmp(jmp_env, 1);
>>> }
>>>
>>> #define CHECK_SIGILL(STATEMENT)                  \
>>> do {                                             \
>>>     if (signal(SIGILL, sig_sigill) =3D=3D SIG_ERR) { \
>>>         check("SIGILL not registered", false);   \
>>>     }                                            \
>>>     if (setjmp(jmp_env) =3D=3D 0) {                  \
>>>         STATEMENT;                               \
>>>         check("SIGILL not triggered", false);    \
>>>     }                                            \
>>>     if (signal(SIGILL, SIG_DFL) =3D=3D SIG_ERR) {    \
>>>         check("SIGILL not registered", false);   \
>>>     }                                            \
>>> } while (0)
>>>
>>>
>>> However it only works once. During the second signal, QEMU decides to
>>> set the default handler.
>>>
>>> 1. In a signal handler that signal is blocked. We leave that handler via
>>> a longjump. So after the first signal, the signal is blocked.
>>>
>>> 2. In QEMU, we decide that synchronous signals cannot be blocked and
>>> simply override the signal handler to default handler. So on the second
>>> signal, we execute the default handler and not our defined handler.
>>>
>>> Multiple ways to fix:
>>>
>>> 1. We have to manually unblock the signal in that hackery above.
>>> 2. In QEMU, don't block synchronous signals.
>>> 3. In QEMU, don't set the signal handler to the default handler in case
>>> a synchronous signal is blocked.
>>
>>
>> This all seems a little over-engineered. This is a single-threaded test
>> so what's wrong with a couple of flags:
>
> I have to jump over the actual broken instruction and want to avoid
> patching it. Otherwise I'll loop forever ...

So from:

  Subject: [PATCH  v2 6/6] tests/tcg/aarch64: userspace system register test
  Date: Tue,  5 Feb 2019 19:02:24 +0000
  Message-Id: <20190205190224.2198-7-alex.bennee@linaro.org>

Where I had to do something similar:

  bool should_fail;
  int should_fail_count;
  int should_not_fail_count;
  uintptr_t failed_pc[10];

  void sigill_handler(int signo, siginfo_t *si, void *data)
  {
      ucontext_t *uc =3D (ucontext_t *)data;

      if (should_fail) {
          should_fail_count++;
      } else {
          uintptr_t pc =3D (uintptr_t) uc->uc_mcontext.pc;
          failed_pc[should_not_fail_count++] =3D  pc;
      }
      uc->uc_mcontext.pc +=3D 4;
  }

But that does depend on arch making pc hackable:

  /* Hook in a SIGILL handler */
  memset(&sa, 0, sizeof(struct sigaction));
  sa.sa_flags =3D SA_SIGINFO;
  sa.sa_sigaction =3D &sigill_handler;
  sigemptyset(&sa.sa_mask);

And crucially have nice regular sized instructions. Is that not an option?

--
Alex Benn=C3=A9e
