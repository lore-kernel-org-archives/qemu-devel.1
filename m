Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnL3v-0001oK-8e
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnL3u-0004If-2h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnL3t-0004IV-RU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 558641B9856
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:42:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
	<87val5gta4.fsf@dusky.pond.sub.org>
	<844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
	<8760d5dx8f.fsf@dusky.pond.sub.org>
	<243440747.6086481.1504099179043.JavaMail.zimbra@redhat.com>
Date: Thu, 31 Aug 2017 10:42:48 +0200
In-Reply-To: <243440747.6086481.1504099179043.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 30 Aug 2017
	09:19:39 -0400 (EDT)")
Message-ID: <878ti0ku0n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > Hi
>> >
>> > ----- Original Message -----
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >>=20
>> >> > They are not considered constant expressions in C, producing an err=
or
>> >> > when compiling a const QLit.
>> >>=20
>> >> A const QLit?  Do you mean a non-const one?
>> >
>> > Really a const QLitObject:
>> >
>> >
>> > const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>> >              QLIT_QNULL,
>> >              {}
>> >          }));
>> >
>> > qmp-introspect.c:17:63: error: initializer element is not constant
>> >   const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>> >                                                                 ^
>> > Removing the "compound literals" fixes this error.
>>=20
>> Does QLIT_QLIST(((const QLitObject[]) { ... } work?
>
> No. Even if I put "const" all over the place (in member, in compound type=
 etc).
>
> Give it a try, see if you can make it const, I am out of luck.

The commit message's explanation is wrong.  This isn't about const at
all, it's about "constant expressions", which are something else
entirely.

For what it's worth, clang is cool with the compound literals.  On
Fedora 26 with a minimized test case (appended):

    $ clang -c -g -O -Wall compound-lit.c
    $ gcc -c -g -O -Wall compound-lit.c
    compound-lit.c:30:37: error: initializer element is not constant
         .value.qdict =3D (QLitDictEntry[]){
                                         ^
    compound-lit.c:30:37: note: (near initialization for =E2=80=98(anonymou=
s).value=E2=80=99)

GCC bug or not?  A search of the GCC Bugzilla finds
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D71713

Copying a few notorious language lawyers^W^W^Wtrusted advisers.

Even if this turns out to be a gcc bug, we'll have to work around it.
But the work-around needs a comment then.

In any case, the commit message needs fixing.



enum {
    QTYPE_NONE, QTYPE_QSTRING, QTYPE_QDICT,
};

typedef struct QLitDictEntry QLitDictEntry;
typedef struct QLitObject QLitObject;

struct QLitObject {
    int type;
    union {
        const char *qstr;
        QLitDictEntry *qdict;
    } value;
};

struct QLitDictEntry {
    const char *key;
    QLitObject value;
};

QLitObject qlit1 =3D (QLitObject){
    .type =3D QTYPE_QDICT,
    .value.qdict =3D (QLitDictEntry[]){
	{ "foo", {} },
	{}
    }};

QLitObject qlit2 =3D (QLitObject){
    .type =3D QTYPE_QDICT,
    .value.qdict =3D (QLitDictEntry[]){
	{ "foo", (QLitObject){} },
	{}
    }};
