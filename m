Received: from eggs.gnu.org ([2001:4830:134:3::10]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsUm-0004qV-Ra
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsUk-0000G2-7u
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfsUj-0000Fn-Td
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BEECC05A1A8
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 18:47:44 +0000 (UTC)
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
Date: Thu, 10 Aug 2017 13:47:42 -0500
MIME-Version: 1.0
In-Reply-To: <1502389816-29772-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E4pT72XpblXrOvmTR6BdkKt531go2LVBM"
Subject: Re: [Qemu-devel] [PATCH] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: crosa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E4pT72XpblXrOvmTR6BdkKt531go2LVBM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: crosa@redhat.com
Message-ID: <17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/qmp-test: Add generic, basic test of
 query commands
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1502389816-29772-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 01:30 PM, Markus Armbruster wrote:
> A command is a query if it has no side effect and yields a result.
> Such commands are typically named query-FOO, but there are exceptions.
>=20
> The basic idea is to find candidates with query-qmp-schema, filter out
> the ones that aren't queries with an explicit blacklist, and test the
> remaining ones against a QEMU with no special arguments.
>=20
> The current blacklist is just add-fd.

I guess this is because it has no mandatory parameters.  Hmm - I wonder
if introspection should flag WHICH commands require an fd over SCM
rights (I guess just add-fd) - as that is a USEFUL piece of information
to know (I can't call command XYZ unlss I also pass an fd) - and then
you could use that real bit of the introspection rather than your
blacklist as the mechanism for filtering this command (since anything
that requires an fd is obviously not a query).

>=20
> query-qmp-schema reports a few commands that aren't actually
> available.  See qmp_unregister_commands_hack() for details.  Work
> around this flaw by accepting CommandNotFound errors, but add a TODO
> to drop this when the flaw is fixed.
>=20
> The test can't do queries with arguments, because it knows nothing
> about the arguments.  No coverage for query-cpu-model-baseline,
> query-cpu-model-comparison and query-cpu-model-expansion, because

s/because//

> query-rocker, query-rocker-ports, query-rocker-of-dpa-flows and
> query-rocker-of-dpa-groups.
>=20
> We get basic test coverage for the following commands:

Cool!

>=20
>     qom-list-types
>     query-acpi-ospm-status
>     query-balloon               (expected to fail)

>     query-vm-generation-id      (expected to fail)

> Most tested commands are expected to succeed.  The test does not check
> the return value then.  A few commands are expected to fail because
> they need special arguments to succeed, and this test is too dumb to
> supply them.

Sounds like it would just be a matter of adding additional command line
parameters to the qemu being invoked for testing those commands?

> =20
> +static int query_error_class(const char *cmd)
> +{
> +    static struct {
> +        const char *cmd;
> +        int err_class;
> +    } fails[] =3D {
> +        { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
> +        { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },

But even THIS level of testing of those commands is pretty good!


> +static void test_query(const void *data)
> +{
> +    const char *cmd =3D data;
> +    int expected_error_class =3D query_error_class(cmd);
> +    QDict *resp, *error;
> +    const char *error_class;
> +
> +    qtest_start("-nodefaults");
> +
> +    resp =3D qmp("{ 'execute': %s }", cmd);

Oh fun - your patch and my libqtest cleanup series will collide :)

> +static void qmp_schema_init(QmpSchema *schema)
> +{
> +    QDict *resp;
> +    Visitor *qiv;
> +    SchemaInfoList *tail;
> +
> +    qtest_start("-nodefaults");
> +    resp =3D qmp("{ 'execute': 'query-qmp-schema' }");
> +
> +    qiv =3D qobject_input_visitor_new(qdict_get(resp, "return"));
> +    visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);=


It's always fun to see this in action!  Our efforts to add automated
introspection code generation have been WELL worth the cost in time.

Overall, I like the patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E4pT72XpblXrOvmTR6BdkKt531go2LVBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMqk4ACgkQp6FrSiUn
Q2oISAf/S1DeLQtqSlPYSUzXqOswtmqXYgbcmPk3fQupqUnWNIdjMQx/hiKDARV4
UyvqPI3mRIdfyOULcfm2vSJS09HcA31ynmhD/CP6cE38mralDd/cZBbGRvg1sclu
xoReO8Wh2L8XYk/W2c2vx2zjxkziSdAbtgMmdEenNoBq5cAnZwZIQB/oh3NvOf6I
7hoFZE1wwSqIpYfubhVR/dMJNeBBO6i4EoKECoQETqve/6zzMqsO+6iVG+HjTF0i
qEhwhnLzFDl8bf6n0rW2pg3pHx/Q8TgrvSxwo1/2j8Io5i8LGe09P/s9KawcnXKa
B4gBJ4mE6EMwJLADkCMBFlTM9orNHg==
=YTO2
-----END PGP SIGNATURE-----

--E4pT72XpblXrOvmTR6BdkKt531go2LVBM--
