Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVIoi-000739-6e
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVIof-0006bJ-3F
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:45:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVIoe-0006b4-Tc
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62C6D7DAC3
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 15:45:08 +0000 (UTC)
Date: Tue, 19 Jun 2018 16:45:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180619154504.GI2368@work-vm>
References: <20180619151719.17002-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180619151719.17002-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> The way we determine if we can start the incoming migration was
> changed to use migration_has_all_channels() in:
>=20
>   commit 428d89084c709e568f9cd301c2f6416a54c53d6d
>   Author: Juan Quintela <quintela@redhat.com>
>   Date:   Mon Jul 24 13:06:25 2017 +0200
>=20
>     migration: Create migration_has_all_channels
>=20
> This method in turn calls multifd_recv_all_channels_created()
> which is hardcoded to always return 'true' when multifd is
> not in use.
>=20
> This means that if channel initialization fails with normal
> migration, it'll never notice and attempt to start the
> incoming migration regardless.

I'm not sure if that was actually the cause, because older versions
had no check at all in socket_accept_incoming_migration.

> This can be seen, for example, if a client connects to a server
> requiring TLS, but has an invalid x509 certificate:
>=20
> qemu-system-x86_64: The certificate hasn't got a known issuer
> qemu-system-x86_64: migration/migration.c:386: process_incoming_migrati=
on_co: Assertion `mis->from_src_file' failed.
>=20
>  #0  0x00007fffebd24f2b in raise () at /lib64/libc.so.6
>  #1  0x00007fffebd0f561 in abort () at /lib64/libc.so.6
>  #2  0x00007fffebd0f431 in _nl_load_domain.cold.0 () at /lib64/libc.so.=
6
>  #3  0x00007fffebd1d692 in  () at /lib64/libc.so.6
>  #4  0x0000555555ad027e in process_incoming_migration_co (opaque=3D<opt=
imized out>) at migration/migration.c:386
>  #5  0x0000555555c45e8b in coroutine_trampoline (i0=3D<optimized out>, =
i1=3D<optimized out>) at util/coroutine-ucontext.c:116
>  #6  0x00007fffebd3a6a0 in __start_context () at /lib64/libc.so.6
>  #7  0x0000000000000000 in  ()
>=20
> To handle the non-multifd case, we check whether mis->from_src_file
> is non-NULL.

So, what happens with this fix, does the destination exit cleanly, or
stay to accept another connection or what?

Dave

> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index e1eaa97df4..38ad818b23 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -518,11 +518,12 @@ void migration_ioc_process_incoming(QIOChannel *i=
oc)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
>      bool all_channels;
> =20
>      all_channels =3D multifd_recv_all_channels_created();
> =20
> -    return all_channels;
> +    return all_channels && mis->from_src_file !=3D NULL;
>  }
> =20
>  /*
> --=20
> 2.17.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
