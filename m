Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eF3XN-00015P-Lc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eF3XI-0001ff-Vr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:39:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eF3XI-0001et-MN
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:39:48 -0500
Date: Wed, 15 Nov 2017 19:39:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171115193943.GA14688@work-vm>
References: <212a9227-5a56-7a0e-1149-2d1bc884b4f0@huawei.com>
	<CAJ+F1CJcdTHe-_ZK1YEgobwMx7jEH4kVB0BFeCpZWV-dY2tH5g@mail.gmail.com>
	<bbabe94a-bcb3-5ad5-7dfb-72327f8178b4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbabe94a-bcb3-5ad5-7dfb-72327f8178b4@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU abort when network serivce is restarted
 during live migration with vhost-user as the network backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yori Fang <fangying1@huawei.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Yori Fang (fangying1@huawei.com) wrote:
>=20
>=20
> =E5=9C=A8 2017/11/14 19:40, Marc-Andr=C3=A9 Lureau =E5=86=99=E9=81=93:
> > Hi
> >=20
> > On Tue, Nov 14, 2017 at 8:09 AM, fangying <fangying1@huawei.com> wrot=
e:
> >> Hi all,
> >>
> >> We have a vm running migration with vhost-user as network backend, w=
e notice that qemu will abort when openvswitch is restarted
> >> when MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward) is calle=
d. The reasion is clear that vhost_dev_set_log returns -1 because
> >> the network connection is temporarily lost due to the restart of ope=
nvswitch service.
> >>
> >> Below is the trace of the call stack.
> >>
> >> #0  0x00007f868ed971d7 in raise() from /usr/lib64/libc.so.6
> >> #1  0x00007f868ed988c8 in abort() from /usr/lib64/libc.so.6
> >> #2  0x00000000004d0d35 in vhost_log_global_start (listener=3D<optimi=
zed out>) at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:794
> >> #2  0x0000000000486bd2 in memory_global_dirty_log_start at /usr/src/=
debug/qemu-kvm-2.8.1/memory.c:2304
> >> #3  0x0000000000486dcd in ram_save_init_globals at /usr/src/debug/qe=
mu-kvm-2.8.1/migration/ram.c:2072
> >> #4  0x000000000048c185 in ram_save_setup (f=3D0x25e6ac0, opaque=3D<o=
ptimized out>) at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2093
> >> #5  0x00000000004fbee2 in qemu_savevm_state_begin at /usr/src/debug/=
qemu-kvm-2.8.1/migration/savevm.c:956
> >> #6  0x000000000083d8f8 in migration_thread at migration/migration.c:=
2198
> >>
> >> static void vhost_log_global_start(MemoryListener *listener)
> >> {
> >>     int r;
> >>
> >>     r =3D vhost_migration_log(listener, true);
> >>     if (r < 0) {
> >>         abort();   /* branch taken */
> >>     }
> >> }
> >>
> >> What confuse me is that
> >> 1. do we really need to abort here ?
> >=20
> > Not if we have a sane way to handle the situation. It make sense
> > though to not want to support that use case (restarting the vhost-use=
r
> > process during migration).
> >=20
> >> 2. all member of callbacks in MemoryListener returned with type void=
, we cannot judge in any upper function on the call stack.
> >> Can we just cancel migration here instead of calling abort ? like:
> >=20
> > That would be acceptable to me, but there should be a better way than
> > calling qmp_migrate_cancel() (we need to give a reason for cancelling=
,
> > and report it to user). Juan should be able to help.
>=20
> I agree with you, we'd better give more details here instead of passing=
 NULL in qmp_migrate_cancel.

This is an unfortunate place to want to kill the migration; cancel is
the wrong call to use though (it's for users to cancel it).
I think the only way to do it is to call
migrate_fd_error(migrate_get_current(),...)

It's not nice though, but the only one I can think of from here.

Dave

> >=20
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index ddc42f0..27ae4a2 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -27,6 +27,7 @@
> >>  #include "hw/virtio/virtio-access.h"
> >>  #include "migration/blocker.h"
> >>  #include "sysemu/dma.h"
> >> +#include "qmp-commands.h"
> >>
> >>  /* enabled until disconnected backend stabilizes */
> >>  #define _VHOST_DEBUG 1
> >> @@ -885,7 +886,7 @@ static void vhost_log_global_start(MemoryListene=
r *listener)
> >>
> >>      r =3D vhost_migration_log(listener, true);
> >>      if (r < 0) {
> >> -        abort();
> >> +        qmp_migrate_cancel(NULL);
> >>      }
> >>  }
> >>
> >> @@ -895,7 +896,7 @@ static void vhost_log_global_stop(MemoryListener=
 *listener)
> >>
> >>      r =3D vhost_migration_log(listener, false);
> >>      if (r < 0) {
> >> -        abort();
> >> +        qmp_migrate_cancel(NULL);
> >>      }
> >>  }
> >>
> >>
> >>
> >>
> >=20
> >=20
> >=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
