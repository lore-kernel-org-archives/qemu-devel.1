Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etFIA-0001oc-Ig
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etFI7-0001WW-Fa
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:18:18 -0500
Date: Tue, 6 Mar 2018 16:18:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306161812.GO31045@stefanha-x1.localdomain>
References: <20180305155926.25858-1-stefanha@redhat.com>
	<ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSMU0HVueUMCAvn0"
Content-Disposition: inline
In-Reply-To: <ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: fix 203
 migration completion race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--oSMU0HVueUMCAvn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 05:04:52PM +0100, Max Reitz wrote:
> On 2018-03-05 16:59, Stefan Hajnoczi wrote:
> > There is a race between the test's 'query-migrate' QMP command after the
> > QMP 'STOP' event and completing the migration:
> >=20
> > The test case invokes 'query-migrate' upon receiving 'STOP'.  At this
> > point the migration thread may still be in the process of completing.
> > Therefore 'query-migrate' can return 'status': 'active' for a brief
> > window of time instead of 'status': 'completed'.  This results in
> > qemu-iotests 203 hanging.
> >=20
> > Solve the race by enabling the 'events' migration capability, which
> > causes QEMU to emit migration-specific QMP events that do not suffer
> > from this race condition.  Wait for the QMP 'MIGRATION' event with
> > 'status': 'completed'.
> >=20
> > Reported-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/203     | 15 +++++++++++----
> >  tests/qemu-iotests/203.out |  5 +++++
> >  2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> So much for "the ppoll() dungeon"...

It was still a pain to debug :).

I put a ring buffer into the QMP monitor input/output code.  Then it was
possible to figure out the issue via GDB on a hung QEMU:

  (gdb) p current_run_state
  RUN_STATE_POSTMIGRATE
  (gdb) p current_migration->status
  MIGRATION_STATUS_COMPLETED
  (gdb) p monitor_out_ring
  ...'STOP' event...
  (gdb) p monitor_in_ring
  ...query-migrate...  <-- okay, the test checked if migration finished

Then looking at the code:

  static void migration_completion(MigrationState *s)
  {
      ...
      if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
          qemu_mutex_lock_iothread();
          s->downtime_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
          qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
          s->vm_was_running =3D runstate_is_running();
          ret =3D global_state_store();

          if (!ret) {
              bool inactivate =3D !migrate_colo_enabled();

	        v---- The stop event comes from here
              ret =3D vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
	      ...
          }
          qemu_mutex_unlock_iothread(); <--- oh, no!
      ...
      if (!migrate_colo_enabled()) {
          migrate_set_state(&s->state, current_active_state,
                            MIGRATION_STATUS_COMPLETED); <-- too late!
      }

      return;

--oSMU0HVueUMCAvn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanr9EAAoJEJykq7OBq3PIKr0IAJ+nJjqgI8A0BxDo3YYVmuUG
+Z5W5TfW3rxMxjNTflJWconukD8iCeifAW+oTkKyb41fQ9Y5FGQgMba1OUzylAkT
GLz8u7Urxn1OxiFm2r3agkiXRiM91LukXGJv7RxJvtB+9CCrk7VO9p/UwgH7cZQd
ihplmwsGVSV08PfIxtw2vUA3m86UOU9wytgNG0s9fGXo7NzghIDatvMOc4xnI+g0
Fx+2/awGbQsM+b95/LgE9Xmgh7b6vXrlNvYa4MrvckbTSzr+8DqgqfHwdxD2AgRp
g8Qy4o2qRufW+ZPj6EEkTgq2brp0rnneiy7zWLOcmXAcYEPGoHYtk5fRzUUArXg=
=ZGrz
-----END PGP SIGNATURE-----

--oSMU0HVueUMCAvn0--
