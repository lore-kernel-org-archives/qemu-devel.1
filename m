Received: from eggs.gnu.org ([2001:4830:134:3::10]:35403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dnROX-0001OD-Ld
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dnROU-0000zR-FT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dnROU-0000z2-7B
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89D106146D
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 15:28:32 +0000 (UTC)
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-5-marcandre.lureau@redhat.com>
	<87val5gta4.fsf@dusky.pond.sub.org>
	<844220409.5983155.1504095111596.JavaMail.zimbra@redhat.com>
	<8760d5dx8f.fsf@dusky.pond.sub.org>
	<243440747.6086481.1504099179043.JavaMail.zimbra@redhat.com>
	<878ti0ku0n.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1cf6ce88-0dd4-6d40-60bf-8b78f02a2fa0@redhat.com>
Date: Thu, 31 Aug 2017 17:28:28 +0200
MIME-Version: 1.0
In-Reply-To: <878ti0ku0n.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/31/17 10:42, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Hi
>>
>> ----- Original Message -----
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>
>>>> Hi
>>>>
>>>> ----- Original Message -----
>>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>>>
>>>>>> They are not considered constant expressions in C, producing an er=
ror
>>>>>> when compiling a const QLit.
>>>>>
>>>>> A const QLit?  Do you mean a non-const one?
>>>>
>>>> Really a const QLitObject:
>>>>
>>>>
>>>> const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>>>>              QLIT_QNULL,
>>>>              {}
>>>>          }));
>>>>
>>>> qmp-introspect.c:17:63: error: initializer element is not constant
>>>>   const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>>>>                                                                 ^
>>>> Removing the "compound literals" fixes this error.
>>>
>>> Does QLIT_QLIST(((const QLitObject[]) { ... } work?
>>
>> No. Even if I put "const" all over the place (in member, in compound t=
ype etc).
>>
>> Give it a try, see if you can make it const, I am out of luck.
>=20
> The commit message's explanation is wrong.  This isn't about const at
> all, it's about "constant expressions", which are something else
> entirely.
>=20
> For what it's worth, clang is cool with the compound literals.  On
> Fedora 26 with a minimized test case (appended):
>=20
>     $ clang -c -g -O -Wall compound-lit.c
>     $ gcc -c -g -O -Wall compound-lit.c
>     compound-lit.c:30:37: error: initializer element is not constant
>          .value.qdict =3D (QLitDictEntry[]){
>                                          ^
>     compound-lit.c:30:37: note: (near initialization for =E2=80=98(anon=
ymous).value=E2=80=99)
>=20
> GCC bug or not?  A search of the GCC Bugzilla finds
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D71713
>=20
> Copying a few notorious language lawyers^W^W^Wtrusted advisers.
>=20
> Even if this turns out to be a gcc bug, we'll have to work around it.
> But the work-around needs a comment then.
>=20
> In any case, the commit message needs fixing.
>=20
>=20
>=20
> enum {
>     QTYPE_NONE, QTYPE_QSTRING, QTYPE_QDICT,
> };
>=20
> typedef struct QLitDictEntry QLitDictEntry;
> typedef struct QLitObject QLitObject;
>=20
> struct QLitObject {
>     int type;
>     union {
>         const char *qstr;
>         QLitDictEntry *qdict;
>     } value;
> };
>=20
> struct QLitDictEntry {
>     const char *key;
>     QLitObject value;
> };
>=20
> QLitObject qlit1 =3D (QLitObject){
>     .type =3D QTYPE_QDICT,
>     .value.qdict =3D (QLitDictEntry[]){
> 	{ "foo", {} },
> 	{}
>     }};
>=20
> QLitObject qlit2 =3D (QLitObject){
>     .type =3D QTYPE_QDICT,
>     .value.qdict =3D (QLitDictEntry[]){
> 	{ "foo", (QLitObject){} },
> 	{}
>     }};
>=20

(1) When discussing standards conformance, please drop the {} construct;
it is a GNUism. Replacing it with { 0 } works in all contexts, and
conforms to the standard. (Not trying to be pedantic here, but it does
elicit extra warnings from my gcc command line

gcc -std=3Dc99 -pedantic -Wall -Wextra -fsyntax-only


(2) Let's see what the standard says:

  6.5.2.5 Compound literals
  Constraints
  3 If the compound literal occurs outside the body of a function, the
    initializer list shall consist of constant expressions.

In the initialization of "qlit1", one element of the initializer list
(namely for .value.qdict) is

[1] (QLitDictEntry[]) {
      { "foo", { 0 } },
      { 0 }
    }

Is this a constant expression?

  6.6 Constant expressions
  7 More latitude is permitted for constant expressions in initializers.
    Such a constant expression shall be, or evaluate to, one of the
    following:
    - an arithmetic constant expression,
    - a null pointer constant,
    - an address constant, or
    - an address constant for an object type plus or minus an integer
      constant expression.

Now, is [1] an address constant?

  6.6 Constant expressions
  9 An address constant is a null pointer, a pointer to an lvalue
    designating an object of static storage duration, or a pointer to a
    function designator; it shall be created explicitly using the unary
    & operator or an integer constant cast to pointer type, or
    implicitly by the use of an expression of array or function type.
    The array-subscript [] and member-access . and -> operators, the
    address & and indirection * unary operators, and pointer casts may
    be used in the creation of an address constant, but the value of an
    object shall not be accessed by use of these operators.

"expression of array [...] type" applies; question is:
- is [1] an lvalue designating an object of static storage duration?

  6.5.2.5 Compound literals
  Semantics
  5 If the type name specifies an array of unknown size, the size is
    determined by the initializer list as specified in 6.7.8, and the
    type of the compound literal is that of the completed array type.
    Otherwise (when the type name specifies an object type), the type
    of the compound literal is that specified by the type name. In
    either case, the result is an lvalue.

So, an lvalue [1] is.

  6 The value of the compound literal is that of an unnamed object
    initialized by the initializer list. If the compound literal occurs
    outside the body of a function, the object has static storage
    duration; otherwise, it has automatic storage duration associated
    with the enclosing block.

Static storage duration is therefore also proven; the initializer [1]
that we provide for ".value.qdict" *is* a constant expression.


(3) However, on my side at least -- RHEL-7.4 --, the initializer for
".value.qdict" is not what gcc complains about, in the initialization of
"qlit1"!

The problem is the *outer* compound literal. *That* is indeed not a
constant expression; if you review 6.6p7 above, it does not fit any of
the allowed cases.

However, the outer compound literal doesn't buy us anything! If you
change the code like this, it compiles without a hitch:

--- xx.c        2017-08-31 17:23:05.145481557 +0200
+++ yy.c        2017-08-31 17:25:14.839088894 +0200
@@ -18,7 +18,7 @@
     QLitObject value;
 };

-QLitObject qlit1 =3D (QLitObject){
+QLitObject qlit1 =3D {
     .type =3D QTYPE_QDICT,
     .value.qdict =3D (QLitDictEntry[]){
       { "foo", { 0 } },


(I ignored "qlit2" for this discussion.)

Thanks
Laszlo
