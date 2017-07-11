Received: from eggs.gnu.org ([2001:4830:134:3::10]:58590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlqi-0004Cd-Lw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlqe-0003UB-OI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:28:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlqe-0003U7-JS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:28:28 -0400
Received: by mail-it0-f68.google.com with SMTP id k3so1211646ita.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:28:28 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <12cda13a-cdba-c480-6f6c-67811135a8a1@twiddle.net>
References: <20170711015524.22936-1-f4bug@amsat.org>
	<12cda13a-cdba-c480-6f6c-67811135a8a1@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:27:25 -0300
Message-ID: <CAAdtpL6dNsEtutF3Tj0s1X-ZYepMWfLYNsAUMsgcA=BTvdLDiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util/cacheinfo: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Geert Martin Ijewski <gm.ijewski@web.de>

Hi Richard,

On Mon, Jul 10, 2017 at 11:38 PM, Richard Henderson <rth@twiddle.net> wrote=
:
> On 07/10/2017 03:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> This include was forgotten when splitting cacheinfo.c out of
>> tcg/ppc/tcg-target.inc.c (see commit b255b2c8).
>>
>> While compiling on powerpc:
>>
>>        CC      util/cacheinfo.o
>>      qemu/util/cacheinfo.c: In function 'arch_cache_info':
>>      qemu/util/cacheinfo.c:137:33: error: 'AT_ICACHEBSIZE' undeclared
>> (first use in this function)
>>               *isize =3D qemu_getauxval(AT_ICACHEBSIZE);
>>                                       ^
>>      qemu/util/cacheinfo.c:137:33: note: each undeclared identifier is
>> reported only once for each function it appears in
>>      qemu/util/cacheinfo.c:140:33: error: 'AT_DCACHEBSIZE' undeclared
>> (first use in this function)
>>               *dsize =3D qemu_getauxval(AT_DCACHEBSIZE);
>>                                       ^
>>      qemu/rules.mak:66: recipe for target 'util/cacheinfo.o' failed
>>      make: *** [util/cacheinfo.o] Error 1
>
>
> For the record, what is the os version?
> Because this doesn't happen here for Centos7.

Oops true I forgot to log this info in the commit.

This happens on debian/powerpc Jessie, using GCC 4.9.2-10

$ make subdir-ppc-softmmu
  CC      util/cacheinfo.o
/home/phil/source/qemu/util/cacheinfo.c: In function 'arch_cache_info':
/home/phil/source/qemu/util/cacheinfo.c:137:33: error:
'AT_ICACHEBSIZE' undeclared (first use in this function)
         *isize =3D qemu_getauxval(AT_ICACHEBSIZE);
                                 ^

compiling with -dU:

#define _ARCH_PPC 1
# 134 "/home/phil/source/qemu/util/cacheinfo.c"
static void arch_cache_info(int *isize, int *dsize)
{
    if (*isize =3D=3D 0) {
        *isize =3D qemu_getauxval(AT_ICACHEBSIZE);
    }
    if (*dsize =3D=3D 0) {
        *dsize =3D qemu_getauxval(AT_DCACHEBSIZE);
    }
}

Regards,

Phil.
