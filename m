Received: from eggs.gnu.org ([2001:4830:134:3::10]:39984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVMrl-0005CR-D2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVMrf-0007S4-1X
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:04:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVMre-0007R1-Sy
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C03C400225D
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 20:04:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180619163552.18206-1-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Jun 2018 17:35:52
	+0100")
References: <20180619163552.18206-1-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 19 Jun 2018 22:04:25 +0200
Message-ID: <87h8lyy246.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> The way we determine if we can start the incoming migration was
> changed to use migration_has_all_channels() in:
>
>   commit 428d89084c709e568f9cd301c2f6416a54c53d6d
>   Author: Juan Quintela <quintela@redhat.com>
>   Date:   Mon Jul 24 13:06:25 2017 +0200
>
>     migration: Create migration_has_all_channels
>
> This method in turn calls multifd_recv_all_channels_created()
> which is hardcoded to always return 'true' when multifd is
> not in use. This is a latent bug...
>
> ...activated in in a following commit where that return result
> ends up acting as the flag to indicate whether it is possible
> to start processing the migration:
>
>   commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
>   Author: Juan Quintela <quintela@redhat.com>
>   Date:   Wed Mar 7 08:40:52 2018 +0100
>
>     migration: Delay start of migration main routines
>
> This means that if channel initialization fails with normal
> migration, it'll never notice and attempt to start the
> incoming migration regardless and crash on a NULL pointer.
>
> This can be seen, for example, if a client connects to a server
> requiring TLS, but has an invalid x509 certificate:
>
> qemu-system-x86_64: The certificate hasn't got a known issuer
> qemu-system-x86_64: migration/migration.c:386: process_incoming_migration=
_co: Assertion `mis->from_src_file' failed.
>
>  #0  0x00007fffebd24f2b in raise () at /lib64/libc.so.6
>  #1  0x00007fffebd0f561 in abort () at /lib64/libc.so.6
>  #2  0x00007fffebd0f431 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
>  #3  0x00007fffebd1d692 in  () at /lib64/libc.so.6
>  #4  0x0000555555ad027e in process_incoming_migration_co (opaque=3D<optim=
ized out>) at migration/migration.c:386
>  #5  0x0000555555c45e8b in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>) at util/coroutine-ucontext.c:116
>  #6  0x00007fffebd3a6a0 in __start_context () at /lib64/libc.so.6
>  #7  0x0000000000000000 in  ()
>
> To handle the non-multifd case, we check whether mis->from_src_file
> is non-NULL. With this in place, the migration server drops the
> rejected client and stays around waiting for another, hopefully
> valid, client to arrive.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
