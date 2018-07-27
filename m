Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4qG-0003ph-Md
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4qC-0007LI-C9
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:39:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4qC-0007Kq-7J
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:39:40 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-12-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7f00a3d-37ab-8ba3-5fbb-28c229da2690@redhat.com>
Date: Fri, 27 Jul 2018 10:39:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/23] tests: Clean up string
 interpolation into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> When you build QMP input manually like this
>=20
>      cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>                            "'arguments': { 'uri': '%s' } }",
>                            uri);
>      rsp =3D qmp(cmd);
>      g_free(cmd);
>=20
> you're responsible for escaping the interpolated values for JSON.  Not
> done here, and therefore works only for sufficiently nice @uri.  For
> instance, if @uri contained a single "'", qobject_from_vjsonf_nofail()
> would abort.  A sufficiently nasty @uri could even inject unwanted
> members into the arguments object.
>=20
> Leaving interpolation into JSON to qmp() is more robust:
>=20
>      rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }"=
, uri);
>=20
> It's also more concise.
>=20
> Clean up the simple cases where we interpolate exactly a JSON value.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

>  =20
> -    cmd =3D g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
> -                          "'arguments': { 'value': %g } }", value);
> -    rsp =3D qtest_qmp(who, cmd);
> -    g_free(cmd);
> +    rsp =3D qtest_qmp(who,
> +                    "{ 'execute': 'migrate_set_downtime',"
> +                    " 'arguments': { 'value': %f } }", value);

Looks a bit awkward changing %g to %f, but matches the limited subset=20
that our parser accepts and doesn't change the accuracy needed for the=20
test to pass.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
