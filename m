Received: from eggs.gnu.org ([2001:4830:134:3::10]:57016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK2u-00079y-Vl
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK2u-0004Ot-2V
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:43:09 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRK2t-0004OK-RQ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:43:07 -0500
Received: by mail-wr0-x241.google.com with SMTP id q9so19701519wre.7
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:43:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <48823054-88be-e115-1b76-d772947170e8@amsat.org>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-2-marcandre.lureau@redhat.com>
	<48823054-88be-e115-1b76-d772947170e8@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Dec 2017 16:43:06 +0100
Message-ID: <CAJ+F1CLhJcar2L43pLQHm4A1SatjSqeGoX+YUQVFq2Jx5o0FVA@mail.gmail.com>
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
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Dec 15, 2017 at 7:21 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
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
>>
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
>
> Hmm why not add it later, around line 4270:

This is check place for librt usage, better to keep it around pthread check=
s.

>
> if compile_prog "" "" ; then
>   :
> # we need pthread for static linking. use previous pthread test result
> elif compile_prog "" "$pthread_lib -lrt" ; then
>   LIBS=3D"$LIBS -lrt"
>   libs_qga=3D"$libs_qga -lrt" #  <-- here
> fi
>



--=20
Marc-Andr=C3=A9 Lureau
