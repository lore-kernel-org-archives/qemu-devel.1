Received: from eggs.gnu.org ([2001:4830:134:3::10]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq16r-0002kK-At
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq16m-0003y3-BM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dq16m-0003xm-13
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05A5D80F79
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 18:00:55 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-28-eblake@redhat.com>
	<ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea485554-e4fd-44e1-f0ab-579ca0ead575@redhat.com>
Date: Thu, 7 Sep 2017 13:00:48 -0500
MIME-Version: 1.0
In-Reply-To: <ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AMJko6aG5E1oK9sjmvthTUQA25FT4wuiw"
Subject: Re: [Qemu-devel] [PATCH v6 27/29] libqtest: Make qtest_init()
 accept format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMJko6aG5E1oK9sjmvthTUQA25FT4wuiw
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <ea485554-e4fd-44e1-f0ab-579ca0ead575@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 27/29] libqtest: Make qtest_init() accept
 format string
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-28-eblake@redhat.com>
 <ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
In-Reply-To: <ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 07:46 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> Several callers were formatting a string into a temporary
>> variable before calling qtest_init(); factor that into the
>> common code.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> -QTestState *qtest_init(const char *extra_args);
>> +QTestState *qtest_init(const char *extra_args, ...) GCC_FMT_ATTR(1, 2=
);
>=20
> Maybe the parameter should be called "fmt" or "format" now instead?
> (similar to printf() and friends)

Sure.

>=20
>>  /**
>>   * qtest_init_without_qmp_handshake:
>> @@ -518,7 +519,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const vo=
id *data);
>>   */
>>  static inline QTestState *qtest_start(const char *args)
>>  {
>> -    global_qtest =3D qtest_init(args);
>> +    global_qtest =3D qtest_init("%s", args);
>=20
> That's a little bit sad that there are some spots which need an explici=
t
> "%s" now ... maybe it would be nicer to add a new function called
> qtest_initf() instead and keep the old one (without the "f") as it is?

Indeed, and looking back over my series, I see we could also benefit
from a va_list form.

Also, since you already questioned me on the churn from qtest_start() =3D=
>
qtest_init() =3D> qtest_start(), I can make less churn in the next spin b=
y
converging on qtest_start() from the get-go.

So I will go with qtest_start() (plain string), qtest_startf()
(formatted like sprintf), and qtest_vstartf() (formatted like vsprintf).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AMJko6aG5E1oK9sjmvthTUQA25FT4wuiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxiVAACgkQp6FrSiUn
Q2oj4wf+LK4/x4wZ3fIJEOPkMH1fUT8R9fmfXSNJedjQhORNd+IeGRlItQ1ws8ud
ZLPA39shrwMEZnRewjk3Ou7ZJi84qvFJRJ3BAXs1SMXtVwDXldSUNFl7xB9qVpok
mQgwxDSAeDdRWEETB8kQf0BOM14XginvrM8uGEVULWATdAoiNwLdexcJvGkkJsOz
5RSxQUGOZrtA1YTkrGNmtHB1h1TRclBhPMGUf+31gio9qn7GnBKHkzRxfr36gEO+
8kzXEFPJQW+7neQ4/zL3O668iSOkjhhys9EdTGHC4PpQ1hXOkXb2s0tTdUZuDlTL
mncSJGkS3Fcj7jPb6AeZEPwhMoLfIw==
=5yvl
-----END PGP SIGNATURE-----

--AMJko6aG5E1oK9sjmvthTUQA25FT4wuiw--
