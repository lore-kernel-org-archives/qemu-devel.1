Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYX0O-0000Er-QZ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYX0M-0004Wl-8j
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:58:20 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYX0L-0004UI-Tp
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:58:18 -0500
Received: by mail-wm0-x242.google.com with SMTP id 9so13906402wme.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 04:58:17 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-5-alex.bennee@linaro.org>
	<c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
	<87d13b6uo4.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87d13b6uo4.fsf@linaro.org>
Date: Mon, 08 Jan 2018 12:58:14 +0000
Message-ID: <87fu7go6c9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 12/11/2017 04:56 AM, Alex Benn=C3=A9e wrote:
>>> +static inline float16 float16_set_sign(float16 a, int sign)
>>> +{
>>> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>>> +}
>>> +
>>
>> 1) Do we use this anywhere?
>
> Yes in the target specific helpers
>
>>
>> 2) While this is probably in line with the other implementations,
>> but going to a more qemu-ish style this should use deposit32.
>
> OK, will do.
>

It turns out doing this unleashes a weird circular dependency at we need
qemu/bitops.h but that brings in host-utils.h and bswap.h which tries
to include softfloat.h again.

          CHK version_gen.h
    CC      qga/main.o
  In file included from /home/alex/lsrc/qemu/qemu.git/include/qemu/bitops.h=
:16:0,
                   from /home/alex/lsrc/qemu/qemu.git/include/fpu/softfloat=
.h:85,
                   from /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:=
4,
                   from qga/main.c:28:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h: In function =E2=
=80=98revbit16=E2=80=99:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:293:9: error: imp=
licit declaration of function =E2=80=98bswap16=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
       x =3D bswap16(x);
           ^
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:293:5: error: nes=
ted extern declaration of =E2=80=98bswap16=E2=80=99 [-Werror=3Dnested-exter=
ns]
       x =3D bswap16(x);
       ^
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h: In function =E2=
=80=98revbit32=E2=80=99:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:312:9: error: imp=
licit declaration of function =E2=80=98bswap32=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
       x =3D bswap32(x);
           ^
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:312:5: error: nes=
ted extern declaration of =E2=80=98bswap32=E2=80=99 [-Werror=3Dnested-exter=
ns]
       x =3D bswap32(x);
       ^
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h: In function =E2=
=80=98revbit64=E2=80=99:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:331:9: error: imp=
licit declaration of function =E2=80=98bswap64=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
       x =3D bswap64(x);
           ^
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:331:5: error: nes=
ted extern declaration of =E2=80=98bswap64=E2=80=99 [-Werror=3Dnested-exter=
ns]
       x =3D bswap64(x);
       ^
  In file included from qga/main.c:28:0:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h: At top level:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:14:24: error: conflict=
ing types for =E2=80=98bswap16=E2=80=99
   static inline uint16_t bswap16(uint16_t x)
                          ^
  In file included from /home/alex/lsrc/qemu/qemu.git/include/qemu/bitops.h=
:16:0,
                   from /home/alex/lsrc/qemu/qemu.git/include/fpu/softfloat=
.h:85,
                   from /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:=
4,
                   from qga/main.c:28:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:293:9: note: prev=
ious implicit declaration of =E2=80=98bswap16=E2=80=99 was here
       x =3D bswap16(x);
           ^
  In file included from qga/main.c:28:0:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:19:24: error: conflict=
ing types for =E2=80=98bswap32=E2=80=99
   static inline uint32_t bswap32(uint32_t x)
                          ^
  In file included from /home/alex/lsrc/qemu/qemu.git/include/qemu/bitops.h=
:16:0,
                   from /home/alex/lsrc/qemu/qemu.git/include/fpu/softfloat=
.h:85,
                   from /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:=
4,
                   from qga/main.c:28:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:312:9: note: prev=
ious implicit declaration of =E2=80=98bswap32=E2=80=99 was here
       x =3D bswap32(x);
           ^
  In file included from qga/main.c:28:0:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:24:24: error: conflict=
ing types for =E2=80=98bswap64=E2=80=99
   static inline uint64_t bswap64(uint64_t x)
                          ^
  In file included from /home/alex/lsrc/qemu/qemu.git/include/qemu/bitops.h=
:16:0,
                   from /home/alex/lsrc/qemu/qemu.git/include/fpu/softfloat=
.h:85,
                   from /home/alex/lsrc/qemu/qemu.git/include/qemu/bswap.h:=
4,
                   from qga/main.c:28:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:331:9: note: prev=
ious implicit declaration of =E2=80=98bswap64=E2=80=99 was here
       x =3D bswap64(x);
           ^
  cc1: all warnings being treated as errors
  /home/alex/lsrc/qemu/qemu.git/rules.mak:66: recipe for target 'qga/main.o=
' failed
  make: *** [qga/main.o] Error 1

  Compilation exited abnormally with code 2 at Mon Jan  8 12:57:41


--
Alex Benn=C3=A9e
