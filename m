Received: from eggs.gnu.org ([2001:4830:134:3::10]:53425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNb73-0006Qg-4D
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 04:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNb6y-00079o-3J
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 04:08:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNb6x-000794-Qx
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 04:07:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-25-marcandre.lureau@redhat.com>
Date: Sat, 09 Dec 2017 10:07:50 +0100
In-Reply-To: <20170911110623.24981-25-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:05:57 +0200")
Message-ID: <87609g6zh5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/50] qapi: add some struct member tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/Makefile.include                    |  2 ++
>  tests/qapi-schema/struct-if-invalid.err   |  1 +
>  tests/qapi-schema/struct-if-invalid.exit  |  1 +
>  tests/qapi-schema/struct-if-invalid.json  |  3 +++
>  tests/qapi-schema/struct-if-invalid.out   |  0
>  tests/qapi-schema/struct-member-type.err  |  0
>  tests/qapi-schema/struct-member-type.exit |  1 +
>  tests/qapi-schema/struct-member-type.json |  2 ++
>  tests/qapi-schema/struct-member-type.out  | 12 ++++++++++++
>  9 files changed, 22 insertions(+)
>  create mode 100644 tests/qapi-schema/struct-if-invalid.err
>  create mode 100644 tests/qapi-schema/struct-if-invalid.exit
>  create mode 100644 tests/qapi-schema/struct-if-invalid.json
>  create mode 100644 tests/qapi-schema/struct-if-invalid.out
>  create mode 100644 tests/qapi-schema/struct-member-type.err
>  create mode 100644 tests/qapi-schema/struct-member-type.exit
>  create mode 100644 tests/qapi-schema/struct-member-type.json
>  create mode 100644 tests/qapi-schema/struct-member-type.out
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 0aa532f029..44a3d8895e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -520,7 +520,9 @@ qapi-schema +=3D returns-whitelist.json
>  qapi-schema +=3D struct-base-clash-deep.json
>  qapi-schema +=3D struct-base-clash.json
>  qapi-schema +=3D struct-data-invalid.json
> +qapi-schema +=3D struct-if-invalid.json
>  qapi-schema +=3D struct-member-invalid.json
> +qapi-schema +=3D struct-member-type.json
>  qapi-schema +=3D trailing-comma-list.json
>  qapi-schema +=3D trailing-comma-object.json
>  qapi-schema +=3D type-bypass-bad-gen.json
> diff --git a/tests/qapi-schema/struct-if-invalid.err b/tests/qapi-schema/=
struct-if-invalid.err
> new file mode 100644
> index 0000000000..42245262a9
> --- /dev/null
> +++ b/tests/qapi-schema/struct-if-invalid.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/struct-if-invalid.json:2: Member 'bar' of 'data' for s=
truct 'TestIfStruct' should be a type name
> diff --git a/tests/qapi-schema/struct-if-invalid.exit b/tests/qapi-schema=
/struct-if-invalid.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/struct-if-invalid.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/struct-if-invalid.json b/tests/qapi-schema=
/struct-if-invalid.json
> new file mode 100644
> index 0000000000..466cdb61e1
> --- /dev/null
> +++ b/tests/qapi-schema/struct-if-invalid.json
> @@ -0,0 +1,3 @@
> +# check missing 'type'
> +{ 'struct': 'TestIfStruct', 'data':
> +  { 'foo': 'int', 'bar': { 'if': 'defined(TEST_IF_STRUCT_BAR)' } } }

Hmm.  This tests the previous patch's change to check_type().  It
demonstrates that the "should be a type name" error message can be
suboptimal: it gets triggered when

    not isinstance(value, str)
    and not (isinstance(value, dict) and 'type' in value)

Fine when the value is neither str not dict.  Suboptimal when it's dict
and 'type' is missing.  A more obvious example of suboptimality would be

   'bar': { 'tvpe': 'int' }

The previous patch's

        if isinstance(value, dict) and 'type' in value:
            check_type(info, source, value['type'], allow_array,
                       allow_dict, allow_optional, allow_metas)
            if 'if' in value:
                check_if(value, info)
            check_unknown_keys(info, value, {'type', 'if'})
            return
        else:
            raise QAPISemError(info, "%s should be a type name" % source)

should be improved to something like

        if not isinstance(value, dict):
            raise QAPISemError(
                info, "%s should be a type name or dictionary" % source)
        if 'type' not in value:
            raise QAPISemError(
                info, "%s must have a member 'type'" % source)
        check_type(info, source, value['type'], allow_array,
                   allow_dict, allow_optional, allow_metas)
        if 'if' in value:
            check_if(value, info)
        check_unknown_keys(info, value, {'type', 'if'})
        return

producing

    struct-if-invalid.json:2: Member 'bar' of 'data' for struct 'TestIfStru=
ct' must have a member 'type'

The fact that I missed this in review of the code, but noticed it in the
tests is why I want tests added together with the code they test.

Nitpick: the file name struct-if-invalid makes me expect an invalid if.
Not the case.  It's a missing type.  Let's rename accordingly.

> diff --git a/tests/qapi-schema/struct-if-invalid.out b/tests/qapi-schema/=
struct-if-invalid.out
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/struct-member-type.err b/tests/qapi-schema=
/struct-member-type.err
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/struct-member-type.exit b/tests/qapi-schem=
a/struct-member-type.exit
> new file mode 100644
> index 0000000000..573541ac97
> --- /dev/null
> +++ b/tests/qapi-schema/struct-member-type.exit
> @@ -0,0 +1 @@
> +0
> diff --git a/tests/qapi-schema/struct-member-type.json b/tests/qapi-schem=
a/struct-member-type.json
> new file mode 100644
> index 0000000000..8b33027817
> --- /dev/null
> +++ b/tests/qapi-schema/struct-member-type.json
> @@ -0,0 +1,2 @@
> +# check member 'a' with 'type' key only
> +{ 'struct': 'foo', 'data': { 'a': { 'type': 'str' } } }
> diff --git a/tests/qapi-schema/struct-member-type.out b/tests/qapi-schema=
/struct-member-type.out
> new file mode 100644
> index 0000000000..04b969d2e3
> --- /dev/null
> +++ b/tests/qapi-schema/struct-member-type.out
> @@ -0,0 +1,12 @@
> +enum QType
> +    prefix QTYPE
> +    member none:
> +    member qnull:
> +    member qnum:
> +    member qstring:
> +    member qdict:
> +    member qlist:
> +    member qbool:
> +object foo
> +    member a: str optional=3DFalse
> +object q_empty

This is a positive test, isn't it?  Positive tests go into
qapi-schema-test.json.
