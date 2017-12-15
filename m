Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePulx-0000Uy-1T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePulw-0002mR-50
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:31:49 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePulv-0002lo-Uy
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:31:48 -0500
Received: by mail-oi0-x244.google.com with SMTP id o64so6780076oia.9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:31:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <48823054-88be-e115-1b76-d772947170e8@amsat.org>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-2-marcandre.lureau@redhat.com>
	<48823054-88be-e115-1b76-d772947170e8@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 18:31:26 +0000
Message-ID: <CAFEAcA_Gd45HrXeZ6VR_4--tEhHFwSbJyab=2N4Q4n3TKPE1yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/13] build-sys: fix qemu-ga -pthread
 linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 December 2017 at 18:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Hi Marc-Andr=C3=A9,
>
> On 12/15/2017 12:06 PM, Marc-Andr=C3=A9 Lureau wrote:
>> When linking qemu-ga under some configuration (when gthread-2.0.pc
>> doesn't have -pthread, as happening atm with meson build), you may
>> have this linking issue:
>>
>> /usr/bin/ld: libqemuutil.a(qemu-thread-posix.o): undefined reference to =
symbol 'pthread_setname_np@@GLIBC_2.12'
>> /usr/lib64/libpthread.so.0: error adding symbols: DSO missing from comma=
nd line
>>
>> Make sure qemu-ga links with the pthread library, by adding correct
>> flags to libs_qga.

This commit message misled me temporarily, because it suggests
that the problem is with the gthread-2.0.pc pkg-config file.
But this is really a QEMU bug, because it's QEMU code that's
using pthread functions, and so we must explicitly link against
pthreads. The bug was just masked by the fact that often some
pkg-config or another for one of our dependencies will add
-pthread to the link line anyway.

>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  configure | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configure b/configure
>> index 0c6e7572db..2b8c71f522 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3436,6 +3436,7 @@ else
>>        done
>>        if test "$found" =3D "no"; then
>>          LIBS=3D"$pthread_lib $LIBS"
>> +        libs_qga=3D"$pthread_lib $libs_qga"
>>        fi
>>        PTHREAD_LIB=3D"$pthread_lib"
>>        break

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


> Hmm why not add it later, around line 4270:
>
> if compile_prog "" "" ; then
>   :
> # we need pthread for static linking. use previous pthread test result
> elif compile_prog "" "$pthread_lib -lrt" ; then
>   LIBS=3D"$LIBS -lrt"
>   libs_qga=3D"$libs_qga -lrt" #  <-- here
> fi

Because that's a different test, which is checking whether we
need to link against librt. We might need to link against pthread
even if we don't need to link against librt.

thanks
-- PMM
