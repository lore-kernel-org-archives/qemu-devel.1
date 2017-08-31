Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dnLYo-0000bt-4m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dnLYm-0006Tw-NV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:50 -0400
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:34997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dnLYm-0006Tf-Hg
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:14:48 -0400
Received: by mail-vk0-x233.google.com with SMTP id z187so326857vkd.2
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
	<87val5gta4.fsf@dusky.pond.sub.org>
	<844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
	<8760d5dx8f.fsf@dusky.pond.sub.org>
	<243440747.6086481.1504099179043.JavaMail.zimbra@redhat.com>
	<878ti0ku0n.fsf@dusky.pond.sub.org>
In-Reply-To: <878ti0ku0n.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 Aug 2017 09:14:36 +0000
Message-ID: <CAJ+F1CJ5b3izZgZxD4RXyq00yxi3xN+WADu-MeuyPb-3yLxiVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/14] qlit: remove compound literals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org

Hi

On Thu, Aug 31, 2017 at 10:43 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > ----- Original Message -----
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Hi
> >> >
> >> > ----- Original Message -----
> >> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >> >>
> >> >> > They are not considered constant expressions in C, producing an
> error
> >> >> > when compiling a const QLit.
> >> >>
> >> >> A const QLit?  Do you mean a non-const one?
> >> >
> >> > Really a const QLitObject:
> >> >
> >> >
> >> > const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
> >> >              QLIT_QNULL,
> >> >              {}
> >> >          }));
> >> >
> >> > qmp-introspect.c:17:63: error: initializer element is not constant
> >> >   const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
> >> >                                                                 ^
> >> > Removing the "compound literals" fixes this error.
> >>
> >> Does QLIT_QLIST(((const QLitObject[]) { ... } work?
> >
> > No. Even if I put "const" all over the place (in member, in compound
> type etc).
> >
> > Give it a try, see if you can make it const, I am out of luck.
>
> The commit message's explanation is wrong.  This isn't about const at
> all, it's about "constant expressions", which are something else
> entirely.
>

The point was that declaring a non const QLit with those "compound
literals" worked vs with const.


> For what it's worth, clang is cool with the compound literals.  On
> Fedora 26 with a minimized test case (appended):
>
>     $ clang -c -g -O -Wall compound-lit.c
>     $ gcc -c -g -O -Wall compound-lit.c
>     compound-lit.c:30:37: error: initializer element is not constant
>          .value.qdict =3D (QLitDictEntry[]){
>                                          ^
>     compound-lit.c:30:37: note: (near initialization for
> =E2=80=98(anonymous).value=E2=80=99)
>
> GCC bug or not?  A search of the GCC Bugzilla finds
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D71713
>
> Copying a few notorious language lawyers^W^W^Wtrusted advisers.
>
> Even if this turns out to be a gcc bug, we'll have to work around it.
> But the work-around needs a comment then.
>
> In any case, the commit message needs fixing.
>

What about adapting the bug comment:

qlit: remove compound literals

A compound literal (i.e., "(struct Str1){1}"), is not a constant
expression, and so it cannot be used to initialize an object with static
storage duration.

$ gcc -c -g -O -Wall compound-lit.c
    compound-lit.c:30:37: error: initializer element is not constant
         .value.qdict =3D (QLitDictEntry[]){
                                         ^
    compound-lit.c:30:37: note: (near initialization for
=E2=80=98(anonymous).value=E2=80=99)

clang accepts it. In some cases, gcc accepts compound literals as
initializer, but not in this nested case. There is a gcc bug about it:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D71713.

Feel free to adapt on commit

thanks


>
>
> enum {
>     QTYPE_NONE, QTYPE_QSTRING, QTYPE_QDICT,
> };
>
> typedef struct QLitDictEntry QLitDictEntry;
> typedef struct QLitObject QLitObject;
>
> struct QLitObject {
>     int type;
>     union {
>         const char *qstr;
>         QLitDictEntry *qdict;
>     } value;
> };
>
> struct QLitDictEntry {
>     const char *key;
>     QLitObject value;
> };
>
> QLitObject qlit1 =3D (QLitObject){
>     .type =3D QTYPE_QDICT,
>     .value.qdict =3D (QLitDictEntry[]){
>         { "foo", {} },
>         {}
>     }};
>
> QLitObject qlit2 =3D (QLitObject){
>     .type =3D QTYPE_QDICT,
>     .value.qdict =3D (QLitDictEntry[]){
>         { "foo", (QLitObject){} },
>         {}
>     }};
>
> --
Marc-Andr=C3=A9 Lureau
