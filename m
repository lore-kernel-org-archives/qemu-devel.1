Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLi0-0003Dv-M3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLhw-0005j0-Oa
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:39:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chLhw-0005hh-HQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:39:12 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F1344E4D8
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 19:39:12 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc882971-0828-079b-e0b1-0d50fad215d3@redhat.com>
Date: Fri, 24 Feb 2017 13:39:10 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kk5jSDF63sTidB47uQTDt5GOT8fiX5pME"
Subject: Re: [Qemu-devel] [PATCH 04/21] qmp: Dumb down how we run QMP
 command registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kk5jSDF63sTidB47uQTDt5GOT8fiX5pME
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bc882971-0828-079b-e0b1-0d50fad215d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] qmp: Dumb down how we run QMP command
 registration
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> The way we get QMP commands registered is high tech:
>=20
> * qapi-commands.py generates qmp_init_marshal() that does the actual wo=
rk
>=20
> * it also generates the magic to register it as a MODULE_INIT_QAPI
>   function, so it runs when someone calls
>   module_call_init(MODULE_INIT_QAPI)
>=20
> * main() calls module_call_init()
>=20
> QEMU needs to register a few non-qapified commands.  Same high tech
> works: monitor.c has its own qmp_init_marshal() along with the magic
> to make it run in module_call_init(MODULE_INIT_QAPI).

Eww. Two static functions with the same name, which really messes with
gdb debugging.

>=20
> QEMU also needs to unregister commands that are not wanted in this
> build's configuration (commit 5032a16).  Simple enough:
> qmp_unregister_commands_hack().  The difficulty is to make it run
> after the generated qmp_init_marshal().  We can't simply run it in
> monitor.c's qmp_init_marshal(), because the order in which the
> registered functions run is indeterminate.  So qmp_init_marshal()
> registers qmp_init_marshal() separately.  Since registering *appends*

Another case of "A sets up A" when you meant "A sets up B", but this
time, I'm fairly certain you mean qmp_init_marshal() registers
qmp_unregister_commands_hack() separately.

> to the list of registered functions, this will make it run after all
> the functions that have been registered already.
>=20
> I suspect it takes a long and expensive computer science education to
> not find this silly.

ROFL
(does that mean I didn't spend enough on my education? I'm sure you
could arrange to sell me an online certificate if I wanted more... :)

>=20
> Dumb it down as follows:
>=20
> * Drop MODULE_INIT_QAPI entirely
>=20
> * Give the generated qmp_init_marshal() external linkage.
>=20
> * Call it instead of module_call_init(MODULE_INIT_QAPI)
>=20
> * Except in QEMU proper, call new monitor_init_qmp_commands() that in
>   turn calls the generated qmp_init_marshal(), registers the
>   additional commands and unregisters the unwanted ones.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> -static void qmp_init_marshal(void)
> +void monitor_init_qmp_commands(void)
>  {
> +    qmp_init_marshal();
> +
>      qmp_register_command("query-qmp-schema", qmp_query_qmp_schema,
>                           QCO_NO_OPTIONS);
>      qmp_register_command("device_add", qmp_device_add,
> @@ -1004,12 +1006,9 @@ static void qmp_init_marshal(void)
>      qmp_register_command("netdev_add", qmp_netdev_add,
>                           QCO_NO_OPTIONS);
> =20
> -    /* call it after the rest of qapi_init() */
> -    register_module_init(qmp_unregister_commands_hack, MODULE_INIT_QAP=
I);
> +    qmp_unregister_commands_hack();

We could inline this function now, but keeping the _hack() name around
reminds us to consider conditional-compilation support in the generator
at a later date, so I'm fine with the approach you took.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kk5jSDF63sTidB47uQTDt5GOT8fiX5pME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsIveAAoJEKeha0olJ0NqgWwIAK2qMpjCzbXxl3hs7i79JeQp
X8b3OWhoQIwOXsGaoqVvAvI1XJhQ58p+nQg79XF9Fllx1hXLfnctTw0d0jkcl51m
bdBrfy49dm92Saut+d2nU2BXSHzi1VJuS5TRPw7+P8JH7rlFOPx9R5OMxSH4ZSJa
qxNIE8PxyzWGowu4pgtELTWISe/JFhpEYwTBoAhv5ZdlvjqC3zIAyel7Pisy/VOp
swZZRb4dzGW4WX1uQTkT9AcqMPCZem3ZpSU6p1dmAkVE0fF2EyMErTRSA/KQZvnS
nMKBh441vznb7irVnY7XjoCHKdzgBhPDGP26b/A9+PUdCLHgrBoQAAysFBa9Ix4=
=Jk5T
-----END PGP SIGNATURE-----

--kk5jSDF63sTidB47uQTDt5GOT8fiX5pME--
