Received: from eggs.gnu.org ([209.51.188.92]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjPll-0005kH-4b
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjPlj-00049M-6K
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjPli-000476-Km
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:32:43 -0500
References: <1547487921-605-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-tPoQK+7GTesyqAVmoKm7g3SHoP2iz3R8k7WX=PW5q4w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cdf8a1ab-c99b-789f-8325-f63d6da5e0c1@redhat.com>
Date: Tue, 15 Jan 2019 15:32:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tPoQK+7GTesyqAVmoKm7g3SHoP2iz3R8k7WX=PW5q4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/27] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, Eduardo Otubo <otubo@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2019-01-15 14:16, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 17:45, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter!
>>
>> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26=
b8b16:
>>
>>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3=
.2-part2' into staging (2019-01-14 11:41:43 +0000)
>>
>> are available in the git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-14v2
>>
>> for you to fetch changes up to 650db715681ad1a042705484776e1974f288f3d=
4:
>>
>>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (=
2019-01-14 18:21:29 +0100)
>>
>> ----------------------------------------------------------------
>> - Remove deprecated "ivshmem" legacy device
>> - Bug fix for vhost-user-test
>> - Use more CONFIG Makefile switches for qtests
>> - Get rid of global_qtests in some more qtests
>> - typedef cleanups
>> - Fixes for compiling with Clang
>> - Force C standard to gnu99
>> ----------------------------------------------------------------
>=20
> Hi; another compile failure on that ppc64 system, I'm afraid:
>=20
> /home/pm215/qemu/qemu-seccomp.c:45:1: error: initializer element is not=
 constant
>  };
>  ^
> /home/pm215/qemu/qemu-seccomp.c:45:1: error: (near initialization for
> =E2=80=98sched_setscheduler_arg[0]=E2=80=99)
>=20
> (I did a quick check with 'make -k' and it looks like there aren't
> any more lurking after that one.)
>=20
> The system libseccomp is libseccomp-2.3.1-3.el7.

Darn, I think this time it is a compiler bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63567

It's only fixed in GCC >=3D v5.0 :-(

I see two options:

1) Expand the macro manually:

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -41,7 +41,7 @@ struct QemuSeccompSyscall {
 };

 const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
-    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
+    { .arg =3D 1, .op =3D SCMP_CMP_NE, .datum_a =3D SCHED_IDLE }
 };

... then it compiles fine for me in gnu99 mode, too.

2) Scratch the whole idea with gnu99 again ...

Opinions?

 Thomas
