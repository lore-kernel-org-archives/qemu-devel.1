Received: from eggs.gnu.org ([2001:4830:134:3::10]:59364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Tor-0006YW-DH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Toq-0006KV-4J
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:22:13 -0400
Date: Fri, 5 May 2017 13:22:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170505032200.GM14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-18-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <1493816238-33120-18-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/24] tests: numa: add case for QMP
 command query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:57:11PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>  * fix checkpatch error, move { to newline
> ---
>  tests/numa-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index f5da0c8..2722687 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -87,6 +87,50 @@ static void test_mon_partial(const void *data)
>      g_free(cli);
>  }
> =20
> +static QList *get_cpus(QDict **resp)
> +{
> +    *resp =3D qmp("{ 'execute': 'query-cpus' }");
> +    g_assert(*resp);
> +    g_assert(qdict_haskey(*resp, "return"));
> +    return  qdict_get_qlist(*resp, "return");
> +}
> +
> +static void test_query_cpus(const void *data)
> +{
> +    char *cli;
> +    QDict *resp;
> +    QList *cpus;
> +    const QObject *e;
> +
> +    cli =3D make_cli(data, "-smp 8 -numa node,cpus=3D0-3 -numa node,cpus=
=3D4-7");
> +    qtest_start(cli);
> +    cpus =3D get_cpus(&resp);
> +    g_assert(cpus);
> +
> +    while ((e =3D qlist_pop(cpus))) {
> +        QDict *cpu, *props;
> +        int64_t cpu_idx, node;
> +
> +        cpu =3D qobject_to_qdict(e);
> +        g_assert(qdict_haskey(cpu, "CPU"));
> +        g_assert(qdict_haskey(cpu, "props"));
> +
> +        cpu_idx =3D qdict_get_int(cpu, "CPU");
> +        props =3D qdict_get_qdict(cpu, "props");
> +        g_assert(qdict_haskey(props, "node-id"));
> +        node =3D qdict_get_int(props, "node-id");
> +        if (cpu_idx >=3D 0 && cpu_idx < 4) {
> +            g_assert_cmpint(node, =3D=3D, 0);
> +        } else {
> +            g_assert_cmpint(node, =3D=3D, 1);
> +        }
> +    }
> +
> +    QDECREF(resp);
> +    qtest_end();
> +    g_free(cli);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *args =3D NULL;
> @@ -101,6 +145,7 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/numa/mon/default", args, test_mon_default);
>      qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explic=
it);
>      qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial=
);
> +    qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cp=
us);
> =20
>      return g_test_run();
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZC+/YAAoJEGw4ysog2bOSSTIQALBo/OvAvax/yZ2WxNMbV0Uf
2YlijRA7OwyWbggNRuf9qYkY7BNDzvUSqgxdiwysMFodswz0zSrSsvUSnv8ZxB9U
JW3CRZe1KTechFudXb1JoNj4cgReF0vExPeLeY39LWLK9cWJeZ/FERZ4EyVEmc3I
Y4abqL7KHYahBZD9edj2ShPsws5Mo6QHqp0ZZo5SZHt23R1mWYHzYPdJLaA/5S7q
/WRhsqziOwvMErDNt7DLt+UjmzkMN4qeoVYdspGXxSAaYx6QSpaiZBB1c870IqjZ
SI6B+Z/cPqXEAd6FV6kKQg9qotHmzSf51emjFpH4afw2TFFmaIQdciGM6/iTIfjv
AoWI8Y2cLoDGFsDSjKRhsCZIhhV8sdaxE0B4Gj2F0kNKNiV/sjkTXX1EUTpVE+03
g3MHDJ0gOjcXmiVwsI2rqz0u5ZOMKYS/L4Ms1A/yOTFmjkEEmllWeyulpRKMZAZN
EPQqMbbh+CAI8BQph+APtvN7cZcgiq1XhEaNNFaoWH7sJahZOjqSkki/CWKcebY0
t7H9FAj+Mjz3Mgerg8M7JsBqjGIzGj9fc9QnNjZe5xLGJno6F2U+a0hxxXShko0/
3qc3DZHWYQhYWeLwDKa2ls47x8YAT0rF5qI3+rYRk9Sr2gqHU/lhL8JD5qIn9r2R
mkupdpwwViQvZyZx1Tl3
=hh7b
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
