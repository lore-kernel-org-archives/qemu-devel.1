Received: from eggs.gnu.org ([2001:4830:134:3::10]:37687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI5Vb-00046y-OO
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI5Va-0007eZ-MR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:50:19 -0400
Date: Tue, 6 Jun 2017 11:50:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170606035004.GB23580@pxdev.xzpeter.org>
References: <20170605104851.61818-1-haoqf@linux.vnet.ibm.com>
	<20170605104851.61818-2-haoqf@linux.vnet.ibm.com>
	<20170606030334.GA23580@pxdev.xzpeter.org>
	<0bd5e8d9-9182-8680-3d75-05a122eb811f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bd5e8d9-9182-8680-3d75-05a122eb811f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com

On Tue, Jun 06, 2017 at 11:38:05AM +0800, QingFeng Hao wrote:
>=20
>=20
> =E5=9C=A8 2017/6/6 11:03, Peter Xu =E5=86=99=E9=81=93:
> >On Mon, Jun 05, 2017 at 12:48:51PM +0200, QingFeng Hao wrote:
> >>In load_vmstate, mis->from_src_file is freed twice, the first free is=
 by
> >>qemu_fclose, the second is by migration_incoming_state_destroy and
> >>it causes Illegal instruction exception. The fix is just to remove th=
e
> >>first free.
> >>
> >>This problem is found by qemu-iotests case 068 since commit
> >>"660819b migration: shut src return path unconditionally". The error =
is:
> >>068 1s ... - output mismatch (see 068.out.bad)
> >>     --- tests/qemu-iotests/068.out	2017-05-06 01:00:26.417270437 +02=
00
> >>     +++ 068.out.bad	2017-06-03 13:59:55.360274640 +0200
> >>     @@ -6,6 +6,8 @@
> >>      QEMU X.Y.Z monitor - type 'help' for more information
> >>      (qemu) savevm 0
> >>      (qemu) quit
> >>     +./common.config: line 107: 242472 Illegal instruction     (core=
 dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
> >>     +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"=
;
> >>     +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
> >>      QEMU X.Y.Z monitor - type 'help' for more information
> >>     -(qemu) quit
> >>     -*** done
> >>     +(qemu) *** done
> >>
> >>Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> >>---
> >>  migration/savevm.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >>diff --git a/migration/savevm.c b/migration/savevm.c
> >>index 9c320f59d0..853e14e34e 100644
> >>--- a/migration/savevm.c
> >>+++ b/migration/savevm.c
> >>@@ -2290,7 +2290,6 @@ int load_snapshot(const char *name, Error **err=
p)
> >>      aio_context_acquire(aio_context);
> >>      ret =3D qemu_loadvm_state(f);
> >>-    qemu_fclose(f);
> >>      aio_context_release(aio_context);
> >>      migration_incoming_state_destroy();
> >Thanks QingFeng for the fix!
> >
> >Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> >Though here instead of removing the fclose(), not sure whether this is
> >nicer:
> >
> >diff --git a/migration/savevm.c b/migration/savevm.c
> >index 9c320f5..1feb519 100644
> >--- a/migration/savevm.c
> >+++ b/migration/savevm.c
> >@@ -2233,7 +2233,6 @@ int load_snapshot(const char *name, Error **errp=
)
> >      QEMUFile *f;
> >      int ret;
> >      AioContext *aio_context;
> >-    MigrationIncomingState *mis =3D migration_incoming_get_current();
> >
> >      if (!bdrv_all_can_snapshot(&bs)) {
> >          error_setg(errp,
> >@@ -2286,7 +2285,6 @@ int load_snapshot(const char *name, Error **errp=
)
> >      }
> >
> >      qemu_system_reset(SHUTDOWN_CAUSE_NONE);
> >-    mis->from_src_file =3D f;
> >
> >      aio_context_acquire(aio_context);
> >      ret =3D qemu_loadvm_state(f);
> Thanks Peter. I have a doubt on this change because I see there are sev=
eral
> places
> referencing from_src_file e.g. loadvm_postcopy_ram_handle_discard, and =
it
> seems to
> get byte from the file and it's called by qemu_loadvm_state.
> Anyway, you remind me for the description that is "In load_snapshot" ra=
ther
> than
> "In load_vmstate". thanks

Oh I didn't really notice that. :)

It shouldn't affect imho since load snapshot won't trigger postcopy
codes. But sure current fix is good enough for me at least.

Thanks,

--=20
Peter Xu
