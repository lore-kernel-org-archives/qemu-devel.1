Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziOE-0004j4-Hm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziO8-0007sy-Rs
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:03:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dziO8-0007sf-MU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:02:56 -0400
Received: by mail-oi0-x241.google.com with SMTP id f3so6367647oia.2
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 05:02:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-16-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-16-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 14:02:54 +0200
Message-ID: <CAJ+F1CKSuJ2Zk6B4baESAdmM6RNeGFszJ1H41ZWxg+dXEcW7zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/32] tests/qapi-schema: Improve
 simple union coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> This demonstrates a bug in the lowering of simple unions: if more than
> one schema uses the same built-in type T for a simple union member,
> they all generate the same q_obj_T_wrapper into their qapi-types.h.
> They clash when you include more than one schema's qapi-types.h.

Ah, I don't remember seeing that when I splitted the schema in my
qapi-if / conditional series.

Could it happen with non-built-in types ?

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/qapi-schema/qapi-schema-test.json |  6 ++++++
>  tests/qapi-schema/qapi-schema-test.out  | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index c72dbd8050..c091626635 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -82,6 +82,12 @@
>    'base': 'UserDefZero',
>    'data': { 'string': 'str', 'enum1': 'EnumOne' } }
>
> +{ 'union': 'UserDefSimpleUnion',
> +  'data': { 'value1': 'UserDefA',
> +# FIXME generated q_obj_int_wrapper clashes with qapi-schema.json's
> +#           'value2': 'int',
> +            'value3': 'UserDefB' } }
> +
>  # this variant of UserDefFlatUnion defaults to a union that uses members=
 with
>  # allocated types to test corner cases in the cleanup/dealloc visitor
>  { 'union': 'UserDefFlatUnion2',
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 4b42db23b2..97bb02f2fd 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -108,6 +108,12 @@ object UserDefOptions
>      member u16: uint16List optional=3DTrue
>      member i64x: int optional=3DTrue
>      member u64x: uint64 optional=3DTrue
> +object UserDefSimpleUnion
> +    member type: UserDefSimpleUnionKind optional=3DFalse
> +    tag type
> +    case value1: q_obj_UserDefA-wrapper
> +    case value3: q_obj_UserDefB-wrapper
> +enum UserDefSimpleUnionKind ['value1', 'value3']
>  object UserDefTwo
>      member string0: str optional=3DFalse
>      member dict1: UserDefTwoDict optional=3DFalse
> @@ -169,6 +175,10 @@ object q_obj_EVENT_D-arg
>      member b: str optional=3DFalse
>      member c: str optional=3DTrue
>      member enum3: EnumOne optional=3DTrue
> +object q_obj_UserDefA-wrapper
> +    member data: UserDefA optional=3DFalse
> +object q_obj_UserDefB-wrapper
> +    member data: UserDefB optional=3DFalse
>  object q_obj_UserDefFlatUnion2-base
>      member integer: int optional=3DTrue
>      member string: str optional=3DFalse
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
