Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnE9R-0000Va-5L
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnE9P-00016w-HQ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:20:09 -0400
Date: Thu, 31 Aug 2017 09:19:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831011955.GB17741@lemon.lan>
References: <20170830100605.22694-1-famz@redhat.com>
	<87mv6h5l87.fsf@secure.mitica> <20170830131847.GP4208@lemon.lan>
	<87efrt5ezs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87efrt5ezs.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 08/30 16:04, Juan Quintela wrote:
> Fam Zheng <famz@redhat.com> wrote:
> > On Wed, 08/30 13:49, Juan Quintela wrote:
> >> Fam Zheng <famz@redhat.com> wrote:
> >> > This fixes the assertion due to op blockers added by BMDS:
> >> >
> >> > block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' =
failed.
> >> >
> >> > Reproducer: simply start block migration and quit QEMU before it end=
s.
> >> >
> >> > Cc: qemu-stable@nongnu.org
> >> > Signed-off-by: Fam Zheng <famz@redhat.com>
> >>=20
> >> No need for one stub, see later.
> >>=20
> >>=20
> >> > ---
> >> >  block.c                 | 2 ++
> >> >  migration/block.c       | 2 +-
> >> >  migration/block.h       | 1 +
> >> >  stubs/Makefile.objs     | 1 +
> >> >  stubs/block-migration.c | 6 ++++++
> >> >  5 files changed, 11 insertions(+), 1 deletion(-)
> >> >  create mode 100644 stubs/block-migration.c
> >> >
> >> > diff --git a/block.c b/block.c
> >> > index 3308814bba..508a57274d 100644
> >> > --- a/block.c
> >> > +++ b/block.c
> >> > @@ -43,6 +43,7 @@
> >> >  #include "qemu/cutils.h"
> >> >  #include "qemu/id.h"
> >> >  #include "qapi/util.h"
> >> > +#include "migration/block.h"
> >>=20
> >> this should be misc.h
> >>=20
> >> > =20
> >> >  #ifdef CONFIG_BSD
> >> >  #include <sys/ioctl.h>
> >> > @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
> >> > =20
> >> >  void bdrv_close_all(void)
> >> >  {
> >> > +    block_migration_cleanup_bmds();
> >> >      block_job_cancel_sync_all();
> >> >      nbd_export_close_all();
> >> > =20
> >>=20
> >> > diff --git a/migration/block.h b/migration/block.h
> >> > index 22ebe94259..8bae1cf55a 100644
> >> > --- a/migration/block.h
> >> > +++ b/migration/block.h
> >> > @@ -42,4 +42,5 @@ static inline uint64_t blk_mig_bytes_total(void)
> >> >  #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
> >> > =20
> >> >  void migrate_set_block_enabled(bool value, Error **errp);
> >> > +void block_migration_cleanup_bmds(void);
> >> >  #endif /* MIGRATION_BLOCK_H */
> >> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> >> > index e69c217aff..7540913767 100644
> >> > --- a/stubs/Makefile.objs
> >> > +++ b/stubs/Makefile.objs
> >> > @@ -19,6 +19,7 @@ stub-obj-y +=3D is-daemonized.o
> >> >  stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
> >> >  stub-obj-y +=3D machine-init-done.o
> >> >  stub-obj-y +=3D migr-blocker.o
> >> > +stub-obj-y +=3D block-migration.o
> >> >  stub-obj-y +=3D change-state-handler.o
> >> >  stub-obj-y +=3D monitor.o
> >> >  stub-obj-y +=3D notify-event.o
> >> > diff --git a/stubs/block-migration.c b/stubs/block-migration.c
> >> > new file mode 100644
> >> > index 0000000000..855f15c757
> >> > --- /dev/null
> >> > +++ b/stubs/block-migration.c
> >> > @@ -0,0 +1,6 @@
> >> > +#include "qemu/osdep.h"
> >> > +#include "migration/block.h"
> >> > +
> >> > +void block_migration_cleanup_bmds(void)
> >> > +{
> >> > +}
> >>=20
> >> You can add this inside include/migration/misc.h
> >>=20
> >> #ifdef CONFIG_LIVE_BLOCK_MIGRATION
> >> void blk_mig_init(void);
> >> #else
> >> static inline void blk_mig_init(void) {}
> >>=20
> >> // And then you add the stub here?
> >
> > This doesn't work.  The function is not stubbed for !CONFIG_LIVE_BLOCK_=
MIGRATION
> > configs, but for tools that don't link to common-obj-y. For example wit=
h your
> > proposed change, I get:
> >
> >   LINK    qemu-nbd
> > block.o: In function `bdrv_close_all':
> > /home/fam/work/qemu/block.c:3115: undefined reference to
> > `block_migration_cleanup_bmds'
> > collect2: error: ld returned 1 exit status
> > make: *** [/home/fam/work/qemu/rules.mak:121: qemu-nbd] Error 1
> > make: Leaving directory '/home/fam/work/q/build'
>=20
>=20
> This works for me, for both CONFIG_LIVE_BLOCK_MIGRATION enabled and not.
> For qemu-system-x86_64 and qemu-nbd.  Could you test?

I get the same error:

  LINK    qemu-nbd
block.o: In function `bdrv_close_all':
/home/fam/work/qemu/block.c:3115: undefined reference to `block_migration_c=
leanup_bmds'
collect2: error: ld returned 1 exit status
make: *** [/home/fam/work/qemu/rules.mak:121: qemu-nbd] Error 1
make: Leaving directory '/home/fam/work/q/build'

(also applies to qemu-img etc.)

Fam

---

$ cat config.status=20
#!/bin/sh
# Generated by configure.
# Run this file to recreate the current configuration.
# Compiler output produced by configure, useful for debugging
# configure, is in config.log if it exists.
exec '/home/fam/work/qemu/configure' '--prefix=3D/home/fam/work/q/install/b=
drv_close_all-bmds' '--enable-debug' '--extra-cflags=3D-Wno-error=3Dformat-=
truncation' '--target-list=3Dx86_64-softmmu' "$@"

$ grep CONFIG_LIVE_BLOCK_MIGRATION config-host.h
#define CONFIG_LIVE_BLOCK_MIGRATION 1

$ make qemu-nbd V=3D1
(cd /home/fam/work/qemu; printf '#define QEMU_PKGVERSION '; if test -n ""; =
then printf '""\n'; else if test -d .git; then printf '" ('; git describe -=
-match 'v*' 2>/dev/null | tr -d '\n'; if ! git diff-index --quiet HEAD &>/d=
ev/null; then printf -- '-dirty'; fi; printf ')"\n'; else printf '""\n'; fi=
; fi) > qemu-version.h.tmp
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv qemu-version.h.tmp q=
emu-version.h; else rm qemu-version.h.tmp; fi
c++ -I/usr/include/pixman-1   -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/=
usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -DNCURSES_WIDECHAR -D_G=
NU_SOURCE -D_DEFAULT_SOURCE  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_=
OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls =
-Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fn=
o-common -fwrapv  -Wno-error=3Dformat-truncation -Wexpansion-to-defined -We=
ndif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-bod=
y -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qua=
lifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstac=
k-protector-strong  -I/usr/include/p11-kit-1    -I/usr/include/libpng16  -I=
/usr/include/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/u=
sr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/us=
r/include/nspr4 -pthread -I/usr/include/pixman-1  -I/usr/include/cacard -I/=
usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/u=
sr/include/nspr4  -I/usr/include/libusb-1.0   -I/home/fam/work/qemu/tests -=
g  -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g  -o qemu-nbd qemu=
-nbd.o block.o blockjob.o qemu-io-cmds.o replication.o block/raw-format.o b=
lock/qcow.o block/vdi.o block/vmdk.o block/cloop.o block/bochs.o block/vpc.=
o block/vvfat.o block/dmg.o block/qcow2.o block/qcow2-refcount.o block/qcow=
2-cluster.o block/qcow2-snapshot.o block/qcow2-cache.o block/qcow2-bitmap.o=
 block/qed.o block/qed-l2-cache.o block/qed-table.o block/qed-cluster.o blo=
ck/qed-check.o block/vhdx.o block/vhdx-endian.o block/vhdx-log.o block/quor=
um.o block/parallels.o block/blkdebug.o block/blkverify.o block/blkreplay.o=
 block/block-backend.o block/snapshot.o block/qapi.o block/file-posix.o blo=
ck/linux-aio.o block/null.o block/mirror.o block/commit.o block/io.o block/=
throttle-groups.o block/nbd.o block/nbd-client.o block/sheepdog.o block/isc=
si-opts.o block/accounting.o block/dirty-bitmap.o block/write-threshold.o b=
lock/backup.o block/replication.o block/crypto.o nbd/server.o nbd/client.o =
nbd/common.o block/iscsi.o block/curl.o block/rbd.o block/gluster.o block/s=
sh.o block/dmg-bz2.o crypto/init.o crypto/hash.o crypto/hash-nettle.o crypt=
o/hmac.o crypto/hmac-nettle.o crypto/aes.o crypto/desrfb.o crypto/cipher.o =
crypto/tlscreds.o crypto/tlscredsanon.o crypto/tlscredsx509.o crypto/tlsses=
sion.o crypto/secret.o crypto/random-gnutls.o crypto/pbkdf.o crypto/pbkdf-n=
ettle.o crypto/ivgen.o crypto/ivgen-essiv.o crypto/ivgen-plain.o crypto/ivg=
en-plain64.o crypto/afsplit.o crypto/xts.o crypto/block.o crypto/block-qcow=
=2Eo crypto/block-luks.o io/channel.o io/channel-buffer.o io/channel-comman=
d.o io/channel-file.o io/channel-socket.o io/channel-tls.o io/channel-watch=
=2Eo io/channel-websock.o io/channel-util.o io/dns-resolver.o io/task.o qom=
/object.o qom/container.o qom/qom-qobject.o qom/object_interfaces.o  libqem=
uutil.a libqemustub.a  -lz -laio -L/usr/lib64/iscsi -liscsi -lcurl -lrbd -l=
rados -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -lssh2 -lbz2 -lm -lg=
thread-2.0 -pthread -lglib-2.0   -lz -lrt -lz -lnettle  -lgnutls   -lutil

$ nm migration/block.o | grep block_migration_cleanup_bmds
00000000000011e8 T block_migration_cleanup_bmds


>=20
> gcommit 2888b96dfe5ea9c7901990f54e14b1a7ed3e46b9
> Author: Fam Zheng <famz@redhat.com>
> Date:   Wed Aug 30 18:06:05 2017 +0800
>=20
>     block: Cleanup BMDS in bdrv_close_all
>    =20
>     This fixes the assertion due to op blockers added by BMDS:
>    =20
>     block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' f=
ailed.
>    =20
>     Reproducer: simply start block migration and quit QEMU before it ends.
>    =20
>     Cc: qemu-stable@nongnu.org
>     Signed-off-by: Fam Zheng <famz@redhat.com>
>    =20
>     --
>    =20
>     Don't use stub
>=20
> diff --git a/block.c b/block.c
> index 3615a6809e..4268f892da 100644
> --- a/block.c
> +++ b/block.c
> @@ -43,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/id.h"
>  #include "qapi/util.h"
> +#include "migration/misc.h"
> =20
>  #ifdef CONFIG_BSD
>  #include <sys/ioctl.h>
> @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
> =20
>  void bdrv_close_all(void)
>  {
> +    block_migration_cleanup_bmds();
>      block_job_cancel_sync_all();
>      nbd_export_close_all();
> =20
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index c079b7771b..6ecb7068d9 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -24,8 +24,10 @@ void ram_mig_init(void);
> =20
>  #ifdef CONFIG_LIVE_BLOCK_MIGRATION
>  void blk_mig_init(void);
> +void block_migration_cleanup_bmds(void);
>  #else
>  static inline void blk_mig_init(void) {}
> +static inline void block_migration_cleanup_bmds(void) {}
>  #endif
> =20
>  #define SELF_ANNOUNCE_ROUNDS 5
> diff --git a/migration/block.c b/migration/block.c
> index 9171f60028..c059e48484 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -673,7 +673,7 @@ static int64_t get_remaining_dirty(void)
> =20
> =20
>  /* Called with iothread lock taken.  */
> -static void block_migration_cleanup_bmds(void)
> +void block_migration_cleanup_bmds(void)
>  {
>      BlkMigDevState *bmds;
>      AioContext *ctx;
>=20
>=20
