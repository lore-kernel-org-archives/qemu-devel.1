Received: from eggs.gnu.org ([209.51.188.92]:46258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gosDI-00064w-AW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gosDG-00071N-LN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gosDG-0006vC-9U
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6614C80E7B
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:55:32 +0000 (UTC)
References: <20190130120616.5260-1-quintela@redhat.com>
	<20190130120616.5260-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <711166e7-e8de-9335-5a7f-63cf86a62524@redhat.com>
Date: Wed, 30 Jan 2019 09:55:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190130120616.5260-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sF49psVAnr7pphIn36DfQJvQ9HbkJxP0Y"
Subject: Re: [Qemu-devel] [PATCH v11 2/4] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sF49psVAnr7pphIn36DfQJvQ9HbkJxP0Y
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <711166e7-e8de-9335-5a7f-63cf86a62524@redhat.com>
Subject: Re: [PATCH v11 2/4] migration: Create socket-address parameter
References: <20190130120616.5260-1-quintela@redhat.com>
 <20190130120616.5260-3-quintela@redhat.com>
In-Reply-To: <20190130120616.5260-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 6:06 AM, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20

> +++ b/hmp.c
> @@ -166,6 +166,26 @@ void hmp_info_mice(Monitor *mon, const QDict *qdic=
t)
>      qapi_free_MouseInfoList(mice_list);
>  }
> =20
> +static char *SocketAddress_to_str(SocketAddress *addr)
> +{
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup_printf("tcp:%s:%s",
> +                               addr->u.inet.host,
> +                               addr->u.inet.port);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup_printf("unix:%s",
> +                               addr->u.q_unix.path);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup_printf("fd:%s", addr->u.fd.str);
> +        break;
> +    default:
> +        abort();

Is abort()ing on SOCKET_ADDRESS_TYPE_VSOCK intentional?

> +    }
> +}
> +
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  {
>      MigrationInfo *info;
> @@ -306,6 +326,17 @@ void hmp_info_migrate(Monitor *mon, const QDict *q=
dict)
>          g_free(str);
>          visit_free(v);
>      }
> +    if (info->has_socket_address) {
> +        SocketAddressList *addr;
> +
> +        monitor_printf(mon, "socket address: [\n");
> +
> +        for (addr =3D info->socket_address; addr; addr =3D addr->next)=
 {
> +            char *s =3D SocketAddress_to_str(addr->value);
> +            monitor_printf(mon, "\t%s\n", s);
> +        }
> +        monitor_printf(mon, "]\n");
> +    }

Leaks 's'.

>      qapi_free_MigrationInfo(info);
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index 37e06b76dc..ef1d53cde2 100644
> --- a/migration/migration.c

> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
> =20
>  { 'include': 'common.json' }
> +{ 'include': 'sockets.json' }
> =20
>  ##
>  # @MigrationStats:
> @@ -199,6 +200,8 @@
>  # @compression: migration compression statistics, only returned if com=
pression
>  #           feature is on and status is 'active' or 'completed' (Since=
 3.1)
>  #
> +# @socket-address: Only used for tcp, to know what the real port is (S=
ince 3.1)
> +#

s/3.1/4.0/

>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -213,7 +216,8 @@
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats'} }
> +           '*compression': 'CompressionStats',
> +           '*socket-address': ['SocketAddress'] } }
> =20
>  ##
>  # @query-migrate:
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..d7f77984af 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -152,3 +152,16 @@
>              'unix': 'UnixSocketAddress',
>              'vsock': 'VsockSocketAddress',
>              'fd': 'String' } }
> +
> +##
> +# @DummyStruct:
> +#
> +# Both block-core and migration needs SocketAddressList
> +# I am open to comments about how to share it
> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 3.1

s/3.1/4.0/
This matches how we force list types elsewhere for use in C code even
when the type is not exposed through QMP. But do you still need to force
the generation, given that ['SocketAddress'] used in MigrationInfo is
visible through QMP?

> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sF49psVAnr7pphIn36DfQJvQ9HbkJxP0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxRyPIACgkQp6FrSiUn
Q2ozIQf9FmemOGZPY/GlCpjn/B5G3mF0ParIBWdidy9VActd7xi0oyHibbTeN7wn
FrNOaTerXrZ5AdpKUay9bnqFJrBdx4Pidzj2FMndMD6lrp6OCYF/EFFq5tjSr6ox
pYSbTI1aVMFxdq2pHlXi+31lGoX4EjufWMaybUAmXQ+3j1dqkA403WLeEzrYMtwZ
75FWj4qRh+/H3qs/QIFXcwfQuIHzr/9sVqZYePDHXXzftisbtizMMGXOGO7t/xYj
jbsqYSEv1pjt2TqMxYRiJKMONpYTxU564iKaJD0/+7PCAK45sgaQWua2jz8ejWdG
1lDIJZSPlx0rqQmMSeBBiXXomOkaWQ==
=pc70
-----END PGP SIGNATURE-----

--sF49psVAnr7pphIn36DfQJvQ9HbkJxP0Y--
