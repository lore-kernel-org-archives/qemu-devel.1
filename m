Received: from eggs.gnu.org ([2001:4830:134:3::10]:59212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fYTej-00017v-Oc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fYTef-0002qz-SC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:56:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48284
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fYTef-0002o5-Jy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:55:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5S9s4IJ018835
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:55:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jvw4091c9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:55:54 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Thu, 28 Jun 2018 10:55:53 +0100
Date: Thu, 28 Jun 2018 15:25:47 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180627125604.15275-1-quintela@redhat.com>
	<20180627125604.15275-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180627125604.15275-17-quintela@redhat.com>
Message-Id: <20180628095547.GA24412@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 16/16] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 02:56:04PM +0200, Juan Quintela wrote:
> From: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
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
> not in use. This is a latent bug...
>=20
> ...activated in a following commit where that return result
> ends up acting as the flag to indicate whether it is possible
> to start processing the migration:
>=20
>   commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
>   Author: Juan Quintela <quintela@redhat.com>
>   Date:   Wed Mar 7 08:40:52 2018 +0100
>=20
>     migration: Delay start of migration main routines
>=20
> This means that if channel initialization fails with normal
> migration, it'll never notice and attempt to start the
> incoming migration regardless and crash on a NULL pointer.
>=20
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
> is non-NULL. With this in place, the migration server drops the
> rejected client and stays around waiting for another, hopefully
> valid, client to arrive.

Hi Juan,

I tried to perform multifd enabled migration and from qemu monitor
enabled mutlifd capability on source and target,
(qemu) migrate_set_capability x-multifd on
(qemu) migrate -d tcp:127.0.0.1:4444

The migration succeeds and its cool to have the feature :)
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-block=
s: off compress: off events: off postcopy-ram: off x-colo: off release-ra=
m: off block: off return-path: off pause-before-switchover: off x-multifd=
: on dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off
Migration status: completed
total time: 1051 milliseconds
downtime: 260 milliseconds
setup: 17 milliseconds
transferred ram: 8270 kbytes
throughput: 143.91 mbps
remaining ram: 0 kbytes
total ram: 4194560 kbytes
duplicate: 940989 pages
skipped: 0 pages
normal: 109635 pages
normal bytes: 438540 kbytes
dirty sync count: 3
page size: 4 kbytes


But when I just enable the multifd in souce but not in target

source:
x-multifd: on

target:
x-multifd: off

when migration is triggered with,
migrate -d tcp:127.0.0.1:4444 (port I used)

The VM is lost in source with Segmentation fault.

I think the correct way is to enable multifd on both source and target
similar to postcopy, but in this negative scenario we should consider
the right way of handling not to loose the VM instead error out
appropriately.

Please correct me if I miss something.


-- Bala
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Message-Id: <20180619163552.18206-1-berrange@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index d075c27886..94d71f8b24 100644
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
> 2.17.1
>=20
>=20
