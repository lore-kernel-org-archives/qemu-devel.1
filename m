Received: from eggs.gnu.org ([2001:4830:134:3::10]:35322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfca-0005Zl-CA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfcV-0004c3-F8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfcV-0004bc-8b
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13EAC61468
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 19:04:14 +0000 (UTC)
Date: Wed, 6 Sep 2017 20:04:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170906190408.GH2215@work-vm>
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170906115143.27451-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 06/22] migration: Improve migration
 thread error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We now report errors also when we finish migration, not only on info
> migrate.  We plan to use this error from several places, and we want
> the first error to happen to win, so we add an mutex to order it.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I think this is OK for errors from the migration code itself;
I'd prefer not to lost any multiplelayers of errors we get
=66rom devices (e.g.we see an error about a particular bit, and then
see it's from a PCI device etc)

> diff --git a/migration/ram.c b/migration/ram.c
> index e18b3e2d4f..e0179fc838 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1789,7 +1789,7 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
>      RAMBlock *rb =3D qemu_ram_block_by_name(rbname);
> =20
>      if (!rb) {
> -        error_report("ram_discard_range: Failed to find block '%s'", rbn=
ame);
> +        error_report("ram_discard_rang0e: Failed to find block '%s'", rb=
name);

Typo!

Dave

>          goto err;
>      }
> =20
> diff --git a/migration/tls.c b/migration/tls.c
> index 596e8790bd..026a008667 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -119,7 +119,6 @@ static void migration_tls_outgoing_handshake(QIOTask =
*task,
>      if (qio_task_propagate_error(task, &err)) {
>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(er=
r));
>          migrate_fd_error(s, err);
> -        error_free(err);
>      } else {
>          trace_migration_tls_outgoing_handshake_complete();
>          migration_channel_connect(s, ioc, NULL);
> --=20
> 2.13.5
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
