Received: from eggs.gnu.org ([2001:4830:134:3::10]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dorTk-0004DB-Mp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dorT0-0003Sv-W6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dorT0-0003S0-Ns
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:31:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-17-marcandre.lureau@redhat.com>
Date: Mon, 04 Sep 2017 15:31:02 +0200
In-Reply-To: <20170822132255.23945-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:17 +0200")
Message-ID: <87mv6ah9pl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/54] qapi: add a test for invalid 'if'
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
>  tests/Makefile.include        | 1 +
>  tests/qapi-schema/bad-if.err  | 1 +
>  tests/qapi-schema/bad-if.exit | 1 +
>  tests/qapi-schema/bad-if.json | 3 +++
>  tests/qapi-schema/bad-if.out  | 0
>  5 files changed, 6 insertions(+)
>  create mode 100644 tests/qapi-schema/bad-if.err
>  create mode 100644 tests/qapi-schema/bad-if.exit
>  create mode 100644 tests/qapi-schema/bad-if.json
>  create mode 100644 tests/qapi-schema/bad-if.out
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3653c7b40a..1f1d8f075b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -396,6 +396,7 @@ qapi-schema +=3D args-unknown.json
>  qapi-schema +=3D bad-base.json
>  qapi-schema +=3D bad-data.json
>  qapi-schema +=3D bad-ident.json
> +qapi-schema +=3D bad-if.json
>  qapi-schema +=3D bad-type-bool.json
>  qapi-schema +=3D bad-type-dict.json
>  qapi-schema +=3D bad-type-int.json
> diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
> new file mode 100644
> index 0000000000..8054fbb143
> --- /dev/null
> +++ b/tests/qapi-schema/bad-if.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/bad-if.json:2: 'if' condition requires a string or a l=
ist of string
> diff --git a/tests/qapi-schema/bad-if.exit b/tests/qapi-schema/bad-if.exit
> new file mode 100644
> index 0000000000..d00491fd7e
> --- /dev/null
> +++ b/tests/qapi-schema/bad-if.exit
> @@ -0,0 +1 @@
> +1
> diff --git a/tests/qapi-schema/bad-if.json b/tests/qapi-schema/bad-if.json
> new file mode 100644
> index 0000000000..3edd1a0bf2
> --- /dev/null
> +++ b/tests/qapi-schema/bad-if.json
> @@ -0,0 +1,3 @@
> +# check invalid 'if' type
> +{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
> +  'if': { 'value': 'defined(TEST_IF_STRUCT)' } }
> diff --git a/tests/qapi-schema/bad-if.out b/tests/qapi-schema/bad-if.out
> new file mode 100644
> index 0000000000..e69de29bb2

Adding a test for each error is good practice.  You did, but your error
is a bit of a catch-all.  The code I proposed in my review of the
previous patch splits it up.  To keep up good practice, we need a test
case for each shard.

I'd squash this into the previous patch to stop "you're lacking tests"
review comments :)
