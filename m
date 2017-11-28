Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJeOi-0004zu-S6
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJeOf-0007Nn-N3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJeOf-0007NA-GT
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:49:53 -0500
References: <20171128113204.22912-1-pbonzini@redhat.com>
	<CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2323fa20-ea6e-7895-3a68-1dacf32dcab8@redhat.com>
Date: Tue, 28 Nov 2017 12:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>, fweimer@redhat.com

On 28/11/2017 12:42, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Nov 28, 2017 at 12:32 PM, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>> Recent glibc added memfd_create in sys/mman.h.  This conflicts with
>> the definition in util/memfd.c:
>>
>>     /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: s=
tatic declaration of memfd_create follows non-static declaration
>>
>> Fix the configure test, and remove the sys/memfd.h inclusion since the
>> file actually does not exist---it is a typo in the memfd_create(2) man
>> page.
>>
>=20
> It is introduced by this commit, right?
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D59d2cbb1fe4b86=
01d5cbd359c3806973eab6c62d
>=20
> (I added Florian Weimer in cc)
>=20
> So it's not part of glibc release yet.
>=20
> Couldn't the declarations be put in sys/memfd.h like the man claimed
> it would be for > 1y?

Yeah, that would have been better---certainly other software than QEMU
is likely to have a static memfd_create declaration, and polluting
sys/mman.h is going to trigger the same error.  However, at least
systemd seems to have changed the test to sys/mman.h
(https://github.com/systemd/systemd/pull/7468), so I think we should
follow their lead now

Thanks,

Paolo

>=20
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  configure    | 2 +-
>>  util/memfd.c | 4 +---
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/configure b/configure
>> index e31d6a7fee..11eac205ec 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3910,7 +3910,7 @@ fi
>>  # check if memfd is supported
>>  memfd=3Dno
>>  cat > $TMPC << EOF
>> -#include <sys/memfd.h>
>> +#include <sys/mman.h>
>>
>>  int main(void)
>>  {
>> diff --git a/util/memfd.c b/util/memfd.c
>> index 4571d1aba8..412e94a405 100644
>> --- a/util/memfd.c
>> +++ b/util/memfd.c
>> @@ -31,9 +31,7 @@
>>
>>  #include "qemu/memfd.h"
>>
>> -#ifdef CONFIG_MEMFD
>> -#include <sys/memfd.h>
>> -#elif defined CONFIG_LINUX
>> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
>>  #include <sys/syscall.h>
>>  #include <asm/unistd.h>
>> --
>> 2.14.3
>>
>>
>=20
>=20
>=20
