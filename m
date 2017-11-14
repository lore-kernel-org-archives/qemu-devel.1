Received: from eggs.gnu.org ([2001:4830:134:3::10]:34494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEZZl-0002CV-2S
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEZZj-0000hV-7z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:40:20 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:52896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEZZi-0000gL-Vh
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:40:19 -0500
Received: by mail-wr0-x22a.google.com with SMTP id j23so17218608wra.9
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 03:40:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <212a9227-5a56-7a0e-1149-2d1bc884b4f0@huawei.com>
References: <212a9227-5a56-7a0e-1149-2d1bc884b4f0@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2017 12:40:17 +0100
Message-ID: <CAJ+F1CJcdTHe-_ZK1YEgobwMx7jEH4kVB0BFeCpZWV-dY2tH5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: fangying <fangying1@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, Gonglei <arei.gonglei@huawei.com>, king.wang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Tue, Nov 14, 2017 at 8:09 AM, fangying <fangying1@huawei.com> wrote:
> Hi all,
>
> We have a vm running migration with vhost-user as network backend, we not=
ice that qemu will abort when openvswitch is restarted
> when MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward) is called. Th=
e reasion is clear that vhost_dev_set_log returns -1 because
> the network connection is temporarily lost due to the restart of openvswi=
tch service.
>
> Below is the trace of the call stack.
>
> #0  0x00007f868ed971d7 in raise() from /usr/lib64/libc.so.6
> #1  0x00007f868ed988c8 in abort() from /usr/lib64/libc.so.6
> #2  0x00000000004d0d35 in vhost_log_global_start (listener=3D<optimized o=
ut>) at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:794
> #2  0x0000000000486bd2 in memory_global_dirty_log_start at /usr/src/debug=
/qemu-kvm-2.8.1/memory.c:2304
> #3  0x0000000000486dcd in ram_save_init_globals at /usr/src/debug/qemu-kv=
m-2.8.1/migration/ram.c:2072
> #4  0x000000000048c185 in ram_save_setup (f=3D0x25e6ac0, opaque=3D<optimi=
zed out>) at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2093
> #5  0x00000000004fbee2 in qemu_savevm_state_begin at /usr/src/debug/qemu-=
kvm-2.8.1/migration/savevm.c:956
> #6  0x000000000083d8f8 in migration_thread at migration/migration.c:2198
>
> static void vhost_log_global_start(MemoryListener *listener)
> {
>     int r;
>
>     r =3D vhost_migration_log(listener, true);
>     if (r < 0) {
>         abort();   /* branch taken */
>     }
> }
>
> What confuse me is that
> 1. do we really need to abort here ?

Not if we have a sane way to handle the situation. It make sense
though to not want to support that use case (restarting the vhost-user
process during migration).

> 2. all member of callbacks in MemoryListener returned with type void, we =
cannot judge in any upper function on the call stack.
> Can we just cancel migration here instead of calling abort ? like:

That would be acceptable to me, but there should be a better way than
calling qmp_migrate_cancel() (we need to give a reason for cancelling,
and report it to user). Juan should be able to help.

>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ddc42f0..27ae4a2 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/blocker.h"
>  #include "sysemu/dma.h"
> +#include "qmp-commands.h"
>
>  /* enabled until disconnected backend stabilizes */
>  #define _VHOST_DEBUG 1
> @@ -885,7 +886,7 @@ static void vhost_log_global_start(MemoryListener *li=
stener)
>
>      r =3D vhost_migration_log(listener, true);
>      if (r < 0) {
> -        abort();
> +        qmp_migrate_cancel(NULL);
>      }
>  }
>
> @@ -895,7 +896,7 @@ static void vhost_log_global_stop(MemoryListener *lis=
tener)
>
>      r =3D vhost_migration_log(listener, false);
>      if (r < 0) {
> -        abort();
> +        qmp_migrate_cancel(NULL);
>      }
>  }
>
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
