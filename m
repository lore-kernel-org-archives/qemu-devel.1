Received: from eggs.gnu.org ([208.118.235.92]:57449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gbH1F-0004nN-H4
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 22:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gbH1A-000147-WB
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 22:35:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gbH1A-0000zX-Na
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 22:35:00 -0500
Date: Mon, 24 Dec 2018 11:34:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181224033454.GB29835@xz-x1>
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<3645fb54-3651-f63b-c416-b22634e1f992@suse.com>
	<87zht1keso.fsf@dusky.pond.sub.org>
	<cc510f12-e94c-bd90-ce01-4ad5d143420f@suse.com>
	<1d626d01-e503-f554-3af8-0706830f245d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d626d01-e503-f554-3af8-0706830f245d@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Dec 21, 2018 at 05:36:57PM +0800, Fei Li wrote:
>=20
> On 12/19/2018 08:14 PM, Fei Li wrote:
> >=20
> > On 12/19/2018 06:10 PM, Markus Armbruster wrote:
> > > Fei Li <fli@suse.com> writes:
> > >=20
> > > > On 12/13/2018 03:26 PM, Markus Armbruster wrote:
> > > > > There's a question for David Gibson inline.=C2=A0 Please search=
 for /ppc/.
> > > > >=20
> > > > > Fei Li <fli@suse.com> writes:
> > > > >=20
> > > > > > Make qemu_thread_create() return a Boolean to indicate if it =
succeeds
> > > > > > rather than failing with an error. And add an Error parameter=
 to hold
> > > > > > the error message and let the callers handle it.
> > > > > The "rather than failing with an error" is misleading. Before t=
he
> > > > > patch, we report to stderr and abort().=C2=A0 What about:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-thread: Make qemu_thread_cr=
eate() handle errors properly
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create() abort()s on=
 error.=C2=A0 Not nice. Give it a
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return value and an Error ** arg=
ument, so it can
> > > > > return success /
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 failure.
> > > > A nice commit-amend! Thanks!
> > > > > Still missing from the commit message then: how you update
> > > > > the callers.
> > > > Yes, agree. I think the-how should also be noted here, like
> > > > - propagating the err to callers whose call trace already have th=
e
> > > > Error paramater;
> > > > - just add an &error_abort for qemu_thread_create() and make it a
> > > > "TODO: xxx";
> > > > > Let's see below.
> > > > >=20
> > > > > > Cc: Markus Armbruster <armbru@redhat.com>
> > > > > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > > > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > > Signed-off-by: Fei Li <fli@suse.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 cpus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45
> > > > > > ++++++++++++++++++++++++-------------
> > > > > > =C2=A0=C2=A0 dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 +++--
> > > > > > =C2=A0=C2=A0 hw/misc/edu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++--
> > > > > > =C2=A0=C2=A0 hw/ppc/spapr_hcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 +++++++--
> > > > > > =C2=A0=C2=A0 hw/rdma/rdma_backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 +++-
> > > > > > =C2=A0=C2=A0 hw/usb/ccid-card-emulated.c | 16 ++++++++++----
> > > > > > =C2=A0=C2=A0 include/qemu/thread.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ++--
> > > > > > =C2=A0=C2=A0 io/task.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
> > > > > > =C2=A0=C2=A0 iothread.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++=
+++++-----
> > > > > > =C2=A0=C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 54
> > > > > > +++++++++++++++++++++++++++++----------------
> > > > > > =C2=A0=C2=A0 migration/postcopy-ram.c=C2=A0=C2=A0=C2=A0 | 14 =
++++++++++--
> > > > > > =C2=A0=C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++++++++++----=
-----
> > > > > > =C2=A0=C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++---
> > > > > > =C2=A0=C2=A0 tests/atomic_add-bench.c=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 ++-
> > > > > > =C2=A0=C2=A0 tests/iothread.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > > > =C2=A0=C2=A0 tests/qht-bench.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > > > > > =C2=A0=C2=A0 tests/rcutorture.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > > > > > =C2=A0=C2=A0 tests/test-aio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > > > =C2=A0=C2=A0 tests/test-rcu-list.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 ++-
> > > > > > =C2=A0=C2=A0 ui/vnc-jobs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++-----
> > > > > > =C2=A0=C2=A0 ui/vnc-jobs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > > > =C2=A0=C2=A0 ui/vnc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 +++-
> > > > > > =C2=A0=C2=A0 util/compatfd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++--
> > > > > > =C2=A0=C2=A0 util/oslib-posix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 17 ++++++++++----
> > > > > > =C2=A0=C2=A0 util/qemu-thread-posix.c=C2=A0=C2=A0=C2=A0 | 24 =
+++++++++++++-------
> > > > > > =C2=A0=C2=A0 util/qemu-thread-win32.c=C2=A0=C2=A0=C2=A0 | 16 =
++++++++++----
> > > > > > =C2=A0=C2=A0 util/rcu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3=
 ++-
> > > > > > =C2=A0=C2=A0 util/thread-pool.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> > > > > > =C2=A0=C2=A0 28 files changed, 243 insertions(+), 101 deletio=
ns(-)
> > > > > >=20
> ...snip, and only leave the three uncertain small topics...
> > > >=20
> > > > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > > > index 658dfa88a3..6e0cccf066 100644
> > > > > > --- a/migration/ram.c
> > > > > > +++ b/migration/ram.c
> > > > > > @@ -473,6 +473,7 @@ static void compress_threads_save_cleanup=
(void)
> > > > > > =C2=A0=C2=A0 static int compress_threads_save_setup(void)
> > > > > > =C2=A0=C2=A0 {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, thread_count;
> > > > > > +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate=
_use_compression()) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return 0;
> > > > > > @@ -502,9 +503,12 @@ static int compress_threads_save_setup(v=
oid)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
comp_param[i].quit =3D false;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qemu_mutex_init(&comp_param[i].mutex);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qemu_cond_init(&comp_param[i].cond);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_creat=
e(compress_threads + i, "compress",
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 do_data_compress, comp_param + i,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 QEMU_THREAD_JOINABLE);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_thread_=
create(compress_threads + i, "compress",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_data_compress, com=
p_param + i,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_THREAD_JOINABLE,=
 &local_err)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_reportf_err(local_err, "failed to
> > > > > > create do_data_compress: ");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto exit;

[1]

> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > Reviewing the migration changes is getting tiresome...
> > > > Yes, indeed, the migration involves a lot! Thanks so much for hel=
ping
> > > > to review!
> > > > > =C2=A0=C2=A0 Is reporting the
> > > > > error appropriate here, and why?
> > > > I think the qemu monitor should display the obvious and exact fai=
ling
> > > > reason for administrators, esp considering that qemu_thread_creat=
e()
> > > > itself does not print any message thus we have no idea which dire=
ct
> > > > function fails if gdb is not enabled.
> > > > IOW, I think David's answer to that ppc's error_reportf_err() als=
o
> > > > apply here:
> > > >=20
> > > > "The error returns are for the guest, the reported errors are for=
 the
> > > > guest administrator or management layers."
> > > There could well be an issue with the "management layers" part. Sho=
uld
> > > this error be sent to the management layer via QMP somehow? Migrati=
on
> > > maintainers should be able to assist with this question.
> Kindly ping migration maintainers. :)

I think both the maintainers are on holiday so possibly there won't be
any reply from them this week... :)

Regarding to error reports of migration via QMP layer, please have a
look at d59ce6f344 ("migration: add reporting of errors for outgoing
migration", 2016-05-26).  Though I see that even
qemu_savevm_state_setup() is not capturing error for the management
layer so if you want to pass this thread creation error upward you'll
possibly need to work on that as well.

Though here note that when you "goto exit" at [1] you probably also
need to touch up the cleanup part since otherwise the join() could be
with an invalid thread ID, so you'll possibly need to check the thread
ID validity before do the join() of the compression thread.

Regards,

--=20
Peter Xu
