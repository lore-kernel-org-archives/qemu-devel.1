Received: from eggs.gnu.org ([2001:4830:134:3::10]:57544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mfabian@redhat.com>) id 1cYYDL-0007ZO-SP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mfabian@redhat.com>) id 1cYYDH-0007aV-U3
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:11:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mfabian@redhat.com>) id 1cYYDH-0007aC-Lx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:11:11 -0500
From: Mike FABIAN <mfabian@redhat.com>
References: <20170131100945.8189-1-kwolf@redhat.com>
	<w51mve7o4n1.fsf@maestria.local.igalia.com>
Date: Tue, 31 Jan 2017 14:11:07 +0100
In-Reply-To: <w51mve7o4n1.fsf@maestria.local.igalia.com> (Alberto Garcia's
	message of "Tue, 31 Jan 2017 12:22:42 +0100")
Message-ID: <s9dlgtr8jdg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com

Alberto Garcia <berto@igalia.com> =E3=81=95=E3=82=93=E3=81=AF=E3=81=8B=E3=
=81=8D=E3=81=BE=E3=81=97=E3=81=9F:

> On Tue 31 Jan 2017 11:09:45 AM CET, Kevin Wolf <kwolf@redhat.com> wrote=
:
>
>> Recently, however, glibc introduced a new locale "C.utf-8" that just
>> uses UTF-8 as its charset, but otherwise leaves the semantics alone.
>> Just setting the right character set is enough for our use case, so we
>> can just hardcode this one without having to be afraid of nasty side
>> effects.
>
>>     setlocale(LC_MESSAGES, "");
>> +   setlocale(LC_CTYPE, "C.utf-8");
>>     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
>
> A couple of quick questions:
>
> - Is it C.utf-8 or C.UTF-8 ? 'locale -a' shows only the latter in my
>   system.

Both work:

mfabian@taka:~
$ LC_ALL=3DC.utf-8 strace -eopen ls 2>&1 |  grep LC_CTYPE
open("/usr/lib/locale/C.utf-8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D -1 ENOEN=
T (No such file or directory)
open("/usr/lib/locale/C.utf8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D 3
mfabian@taka:~
$ LC_ALL=3DC.UTF-8 strace -eopen ls 2>&1 |  grep LC_CTYPE
open("/usr/lib/locale/C.UTF-8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D -1 ENOEN=
T (No such file or directory)
open("/usr/lib/locale/C.utf8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D 3
mfabian@taka:~
$ LC_ALL=3DC.UTF8 strace -eopen ls 2>&1 |  grep LC_CTYPE
open("/usr/lib/locale/C.UTF8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT=
 (No such file or directory)
open("/usr/lib/locale/C.utf8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D 3
mfabian@taka:~
$ LC_ALL=3DC.utf8 strace -eopen ls 2>&1 |  grep LC_CTYPE
open("/usr/lib/locale/C.utf8/LC_CTYPE", O_RDONLY|O_CLOEXEC) =3D 3
mfabian@taka:~
$=20

I like C.UTF-8 because =E2=80=9CUTF-8=E2=80=9D is the official spelling
of that encoding:

https://en.wikipedia.org/wiki/UTF-8#Official_name_and_variants

Using =E2=80=9CC.utf8=E2=80=9D uses one stat less though because it is th=
e last
fallback, as you can see in the strace.

> - When was this added? This bug seems to be still open:
>   https://sourceware.org/bugzilla/show_bug.cgi?id=3D17318

Fedora has it since Fedora 24 (spring 2016), Debian for a while longer.

I=E2=80=99ll ping again to get it included upstream.

It needs 1.5MB at runtime only because of

https://sourceware.org/bugzilla/show_bug.cgi?id=3D18978

as soon as that sorting bug is fixed, the C.UTF-8 locale will need
less than 200k.

> Berto

--=20
Mike FABIAN <mfabian@redhat.com>
=E7=9D=A1=E7=9C=A0=E4=B8=8D=E8=B6=B3=E3=81=AF=E3=81=84=E3=81=84=E4=BB=95=E4=
=BA=8B=E3=81=AE=E6=95=B5=E3=81=A0=E3=80=82
