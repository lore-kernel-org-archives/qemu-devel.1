Received: from eggs.gnu.org ([2001:4830:134:3::10]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Fgf-0008SS-Tt
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 14:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f1Fge-0006Lp-Mm
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 14:20:41 -0400
Date: Wed, 28 Mar 2018 14:20:27 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180328182027.GA30186@localhost.localdomain>
References: <cover.1522245129.git.jcody@redhat.com>
	<8172e5c57529e2275e5d8f1cbe06bd9bc88a8dd4.1522245129.git.jcody@redhat.com>
	<CAMxuvawv2Q13Ge=Pim3Uy9JG65rQaCU2CCHZav6jsPirUdqmAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvawv2Q13Ge=Pim3Uy9JG65rQaCU2CCHZav6jsPirUdqmAg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, jsnow@redhat.com, mreitz@redhat.com, "Wolf, Kevin" <kwolf@redhat.com>

On Wed, Mar 28, 2018 at 04:28:05PM +0200, Marc-Andr=E9 Lureau wrote:
> On Wed, Mar 28, 2018 at 4:09 PM, Jeff Cody <jcody@redhat.com> wrote:
> > From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > This fixes leaks found by ASAN such as:
> >   GTESTER tests/test-blockjob
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D31442=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 24 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f88483cba38 in __interceptor_calloc (/lib64/libasan.so.4+0x=
dea38)
> >     #1 0x7f8845e1bd77 in g_malloc0 ../glib/gmem.c:129
> >     #2 0x7f8845e1c04b in g_malloc0_n ../glib/gmem.c:360
> >     #3 0x5584d2732498 in block_job_txn_new /home/elmarco/src/qemu/blo=
ckjob.c:172
> >     #4 0x5584d2739b28 in block_job_create /home/elmarco/src/qemu/bloc=
kjob.c:973
> >     #5 0x5584d270ae31 in mk_job /home/elmarco/src/qemu/tests/test-blo=
ckjob.c:34
> >     #6 0x5584d270b1c1 in do_test_id /home/elmarco/src/qemu/tests/test=
-blockjob.c:57
> >     #7 0x5584d270b65c in test_job_ids /home/elmarco/src/qemu/tests/te=
st-blockjob.c:118
> >     #8 0x7f8845e40b69 in test_case_run ../glib/gtestutils.c:2255
> >     #9 0x7f8845e40f29 in g_test_run_suite_internal ../glib/gtestutils=
.c:2339
> >     #10 0x7f8845e40fd2 in g_test_run_suite_internal ../glib/gtestutil=
s.c:2351
> >     #11 0x7f8845e411e9 in g_test_run_suite ../glib/gtestutils.c:2426
> >     #12 0x7f8845e3fe72 in g_test_run ../glib/gtestutils.c:1692
> >     #13 0x5584d270d6e2 in main /home/elmarco/src/qemu/tests/test-bloc=
kjob.c:377
> >     #14 0x7f8843641f29 in __libc_start_main (/lib64/libc.so.6+0x20f29=
)
> >
> > Add an assert to make sure that the job doesn't have associated txn b=
efore free().
> >
> > [Jeff Cody: N.B., used updated patch provided by John Snow]
>=20
> Looks good to me, so :)
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> thanks

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff

>=20
> >
> > ---
> >  blockjob.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/blockjob.c b/blockjob.c
> > index ef3ed69ff1..c510a9fde5 100644
> > --- a/blockjob.c
> > +++ b/blockjob.c
> > @@ -204,6 +204,15 @@ void block_job_txn_add_job(BlockJobTxn *txn, Blo=
ckJob *job)
> >      block_job_txn_ref(txn);
> >  }
> >
> > +static void block_job_txn_del_job(BlockJob *job)
> > +{
> > +    if (job->txn) {
> > +        QLIST_REMOVE(job, txn_list);
> > +        block_job_txn_unref(job->txn);
> > +        job->txn =3D NULL;
> > +    }
> > +}
> > +
> >  static void block_job_pause(BlockJob *job)
> >  {
> >      job->pause_count++;
> > @@ -232,6 +241,7 @@ void block_job_unref(BlockJob *job)
> >  {
> >      if (--job->refcnt =3D=3D 0) {
> >          assert(job->status =3D=3D BLOCK_JOB_STATUS_NULL);
> > +        assert(!job->txn);
> >          BlockDriverState *bs =3D blk_bs(job->blk);
> >          QLIST_REMOVE(job, job_list);
> >          bs->job =3D NULL;
> > @@ -392,6 +402,7 @@ static void block_job_decommission(BlockJob *job)
> >      job->busy =3D false;
> >      job->paused =3D false;
> >      job->deferred_to_main_loop =3D true;
> > +    block_job_txn_del_job(job);
> >      block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
> >      block_job_unref(job);
> >  }
> > @@ -481,8 +492,7 @@ static int block_job_finalize_single(BlockJob *jo=
b)
> >          }
> >      }
> >
> > -    QLIST_REMOVE(job, txn_list);
> > -    block_job_txn_unref(job->txn);
> > +    block_job_txn_del_job(job);
> >      block_job_conclude(job);
> >      return 0;
> >  }
> > --
> > 2.13.6
> >
