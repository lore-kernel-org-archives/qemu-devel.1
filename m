Received: from eggs.gnu.org ([2001:4830:134:3::10]:42118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etdOI-0003py-Ut
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etdOH-00048k-RI
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:02:15 -0500
References: <20180305155926.25858-1-stefanha@redhat.com>
	<ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
	<20180306161812.GO31045@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f3a2ddf-d77e-4400-5795-93d33d08ab74@redhat.com>
Date: Wed, 7 Mar 2018 19:01:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180306161812.GO31045@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GCzeBXE5rZeCltkIpK9y38pLETVXAMQV2"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCzeBXE5rZeCltkIpK9y38pLETVXAMQV2
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <2f3a2ddf-d77e-4400-5795-93d33d08ab74@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-iotests: fix 203 migration completion
 race
References: <20180305155926.25858-1-stefanha@redhat.com>
 <ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
 <20180306161812.GO31045@stefanha-x1.localdomain>
In-Reply-To: <20180306161812.GO31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-03-06 17:18, Stefan Hajnoczi wrote:
> On Mon, Mar 05, 2018 at 05:04:52PM +0100, Max Reitz wrote:
>> On 2018-03-05 16:59, Stefan Hajnoczi wrote:
>>> There is a race between the test's 'query-migrate' QMP command after =
the
>>> QMP 'STOP' event and completing the migration:
>>>
>>> The test case invokes 'query-migrate' upon receiving 'STOP'.  At this=

>>> point the migration thread may still be in the process of completing.=

>>> Therefore 'query-migrate' can return 'status': 'active' for a brief
>>> window of time instead of 'status': 'completed'.  This results in
>>> qemu-iotests 203 hanging.
>>>
>>> Solve the race by enabling the 'events' migration capability, which
>>> causes QEMU to emit migration-specific QMP events that do not suffer
>>> from this race condition.  Wait for the QMP 'MIGRATION' event with
>>> 'status': 'completed'.
>>>
>>> Reported-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  tests/qemu-iotests/203     | 15 +++++++++++----
>>>  tests/qemu-iotests/203.out |  5 +++++
>>>  2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> So much for "the ppoll() dungeon"...
>=20
> It was still a pain to debug :).
>=20
> I put a ring buffer into the QMP monitor input/output code.

Oh, wow.

>                                                              Then it wa=
s
> possible to figure out the issue via GDB on a hung QEMU:
>=20
>   (gdb) p current_run_state
>   RUN_STATE_POSTMIGRATE
>   (gdb) p current_migration->status
>   MIGRATION_STATUS_COMPLETED
>   (gdb) p monitor_out_ring
>   ...'STOP' event...
>   (gdb) p monitor_in_ring
>   ...query-migrate...  <-- okay, the test checked if migration finished=

>=20
> Then looking at the code:
>=20
>   static void migration_completion(MigrationState *s)
>   {
>       ...
>       if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
>           qemu_mutex_lock_iothread();
>           s->downtime_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);=

>           qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
>           s->vm_was_running =3D runstate_is_running();
>           ret =3D global_state_store();
>=20
>           if (!ret) {
>               bool inactivate =3D !migrate_colo_enabled();
>=20
> 	        v---- The stop event comes from here
>               ret =3D vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> 	      ...
>           }
>           qemu_mutex_unlock_iothread(); <--- oh, no!
>       ...
>       if (!migrate_colo_enabled()) {
>           migrate_set_state(&s->state, current_active_state,
>                             MIGRATION_STATUS_COMPLETED); <-- too late!
>       }
>=20
>       return;

OK...  I guess the answer to this just is "the stop event doesn't mean
anything, use the migration events instead" (i.e. what your patch does).

Thanks a lot, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--GCzeBXE5rZeCltkIpK9y38pLETVXAMQV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgKRESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A64cH/3tLXU1Nqo2u/zR0vkRe3eQbSliZbko2
bzE5MRiV52ojxOe6dbwRlcTGpuQmdpz9cJZez2ArFNxmZaoyH6P8g3mNEzJZBXIp
E5uR+58JturDC0klbCoFoI5bJfCNLHT5n41FTmFU7WppYP70/JMjOUgd3SSPflX7
lkIl26nbmoj2YYNFHdgulU2V8dravGp2YA89IFci2f7v/hkDn2YNwV2VzLJjzT8G
X012KmwWH9Q80bIcBFYpe7muSh+Mzw8YmNrxaftxOK9MJEtFsmdbHJ1GlhU9vmad
gryFBAsoIpMYB+SgoI35aDoEtsoTf31s3gB8GyT5y1ujjpCbIJmMOGo=
=KUzI
-----END PGP SIGNATURE-----

--GCzeBXE5rZeCltkIpK9y38pLETVXAMQV2--
