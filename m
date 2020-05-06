Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B1FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2405620663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2405620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOBP-0006f1-5s
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWOAi-0006Eg-Dg
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:49:28 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:59234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWOAg-0002HC-Dt
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:49:28 -0400
Received: from player773.ha.ovh.net (unknown [10.110.115.3])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0D3F91D436A
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 19:49:14 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 5F350122E1ED0;
 Wed,  6 May 2020 17:49:13 +0000 (UTC)
Date: Wed, 6 May 2020 19:49:10 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Message-ID: <20200506194910.615e8126@bahia.lan>
In-Reply-To: <4216293.sUgoX00Q1d@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <4216293.sUgoX00Q1d@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17913630470085187904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.172.75; envelope-from=groug@kaod.org;
 helo=4.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 13:49:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 06 May 2020 15:05:23 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 30. April 2020 17:53:34 CEST Greg Kurz wrote:
> > Locking was introduced to address the deprecation of readdir_r(3)
> > in glibc 2.24. It turns out that the frontend code is the worst
> > place to handle a critical section with a pthread mutex: the code
> > runs in a coroutine on behalf of the QEMU mainloop and then yields
> > control, waiting for the fsdev backend to process the request in a
> > worker thread. If the client resends another readdir request for the
> > same fid before the previous one finally unlocked the mutex, we're
> > deadlocked. This never bit us because the linux client serializes
> > readdir requests for the same fid, but the small qtest in this patch
> > demonstrates how easy it would be for a guest to hang QEMU.
> > 
> > A solution could be to use CoMutex instead of QemuMutex, but it seems
> > better to narrow the critical section to the worker thread code and to
> > return a copy of the dirent to the frontend.
> 
> Ok, but why not both? Moving locks to worker thread and QemuMutex -> CoMutex?
> 

Using CoMutex would be mandatory if we leave the locking where it sits
today, so that the main thread can switch to other coroutines instead
of blocking. We don't have the same requirement with the worker thread:
it just needs to do the actual readdir() and then it goes back to the
thread pool, waiting to be summoned again for some other work. So I'd
rather use standard mutexes to keep things simple... why would you
want to use a CoMutex here ?

> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-synth.c           |   12 +++++++++++
> >  hw/9pfs/9p-synth.h           |    2 ++
> >  hw/9pfs/9p.c                 |   45
> > +++++++++++++----------------------------- hw/9pfs/codir.c              |  
> > 11 ++++++++--
> >  hw/9pfs/coth.h               |    3 ++-
> >  tests/qtest/virtio-9p-test.c |   33 +++++++++++++++++++++++++++++++
> >  6 files changed, 72 insertions(+), 34 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> > index 7eb210ffa89b..fb0741569bcd 100644
> > --- a/hw/9pfs/9p-synth.c
> > +++ b/hw/9pfs/9p-synth.c
> > @@ -256,6 +256,13 @@ static struct dirent *synth_readdir(FsContext *ctx,
> > V9fsFidOpenState *fs) if (entry) {
> >          synth_open->offset++;
> >      }
> > +
> > +    if (!strcmp(node->name, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR)) {
> > +        while (synth_open->offset !=
> > QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET) { +            sched_yield();
> > +        }
> > +    }
> > +
> >      return entry;
> >  }
> 
> The while loop condition would deserve a short comment here of what it's 
> about.
> 

Will do.

> > @@ -596,6 +603,11 @@ static int synth_init(FsContext *ctx, Error **errp)
> >                  assert(!ret);
> >                  g_free(name);
> >              }
> > +
> > +            ret = qemu_v9fs_synth_mkdir(
> > +                NULL, 0700, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR, &dir
> > +            );
> > +            assert(!ret);
> >          }
> >      }
> > 
> > diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
> > index 036d7e4a5b1c..c9a65b61ed45 100644
> > --- a/hw/9pfs/9p-synth.h
> > +++ b/hw/9pfs/9p-synth.h
> > @@ -59,6 +59,8 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int
> > mode, #define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
> >  #define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
> >  #define QTEST_V9FS_SYNTH_READDIR_NFILES 100
> > +#define QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR "ReadDirDeadLock"
> > +#define QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET 3
> > 
> >  /* Any write to the "FLUSH" file is handled one byte at a time by the
> >   * backend. If the byte is zero, the backend returns success (ie, 1),
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 9e046f7acb51..ac84ae804496 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> >      struct stat stbuf;
> >      off_t saved_dir_pos;
> > -    struct dirent *dent;
> > +    struct dirent dent;
> > 
> >      /* save the directory position */
> >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > @@ -2181,13 +2181,11 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, while (1) {
> >          v9fs_path_init(&path);
> > 
> > -        v9fs_readdir_lock(&fidp->fs.dir);
> > -
> 
> That's the deadlock fix, but ...
> 
> >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > -        if (err || !dent) {
> > +        if (err <= 0) {
> >              break;
> >          }
> 
> ... even though this code simplification might make sense, I don't think it 
> should be mixed with the deadlock fix together in one patch. They are not

I could possibly split this in two patches, one for returning a copy
and one for moving the locking around, but...

> related with each other, nor is the code simplification you are aiming trivial 

... this assertion is somewhat wrong: moving the locking to v9fs_co_readdir()
really requires it returns a copy.

> enough to justify squashing. The deadlock fix should make it through the 
> stable branches, while the code simplification should not. So that's better 
> off as a separate cleanup patch.
> 

The issue has been there for such a long time without causing any
trouble. Not worth adding churn in stable for a bug that is impossible
to hit with a regular linux guest.

> Plus the commit log does not even mention these cleanup changes.
> 

What you call cleanup changes is simply "change the function to
return a copy of the dirent by reference instead of an unsafe
pointer"... and it is _briefly_ mentioned at the end of the changelog.

I'll give a try at two patches and see if it's clearer.

> > -        err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
> > +        err = v9fs_co_name_to_path(pdu, &fidp->path, dent.d_name, &path);
> >          if (err < 0) {
> >              break;
> >          }
> > @@ -2195,13 +2193,11 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, if (err < 0) {
> >              break;
> >          }
> > -        err = stat_to_v9stat(pdu, &path, dent->d_name, &stbuf, &v9stat);
> > +        err = stat_to_v9stat(pdu, &path, dent.d_name, &stbuf, &v9stat);
> >          if (err < 0) {
> >              break;
> >          }
> >          if ((count + v9stat.size + 2) > max_count) {
> > -            v9fs_readdir_unlock(&fidp->fs.dir);
> > -
> >              /* Ran out of buffer. Set dir back to old position and return
> > */ v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> >              v9fs_stat_free(&v9stat);
> > @@ -2212,8 +2208,6 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, /* 11 = 7 + 4 (7 = start offset, 4
> > = space for storing count) */ len = pdu_marshal(pdu, 11 + count, "S",
> > &v9stat);
> > 
> > -        v9fs_readdir_unlock(&fidp->fs.dir);
> > -
> >          if (len < 0) {
> >              v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> >              v9fs_stat_free(&v9stat);
> > @@ -2223,11 +2217,9 @@ static int coroutine_fn
> > v9fs_do_readdir_with_stat(V9fsPDU *pdu, count += len;
> >          v9fs_stat_free(&v9stat);
> >          v9fs_path_free(&path);
> > -        saved_dir_pos = dent->d_off;
> > +        saved_dir_pos = dent.d_off;
> >      }
> > 
> > -    v9fs_readdir_unlock(&fidp->fs.dir);
> > -
> >      v9fs_path_free(&path);
> >      if (err < 0) {
> >          return err;
> > @@ -2340,7 +2332,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, int len, err = 0;
> >      int32_t count = 0;
> >      off_t saved_dir_pos;
> > -    struct dirent *dent;
> > +    struct dirent dent;
> > 
> >      /* save the directory position */
> >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > @@ -2349,17 +2341,13 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> > *pdu, V9fsFidState *fidp, }
> > 
> >      while (1) {
> > -        v9fs_readdir_lock(&fidp->fs.dir);
> > -
> >          err = v9fs_co_readdir(pdu, fidp, &dent);
> > -        if (err || !dent) {
> > +        if (err <= 0) {
> >              break;
> >          }
> >          v9fs_string_init(&name);
> > -        v9fs_string_sprintf(&name, "%s", dent->d_name);
> > +        v9fs_string_sprintf(&name, "%s", dent.d_name);
> >          if ((count + v9fs_readdir_data_size(&name)) > max_count) {
> > -            v9fs_readdir_unlock(&fidp->fs.dir);
> > -
> >              /* Ran out of buffer. Set dir back to old position and return
> > */ v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> >              v9fs_string_free(&name);
> > @@ -2374,9 +2362,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, * different entries; we cannot make any assumption to
> > avoid * that here.
> >               */
> > -            err = dirent_to_qid(pdu, fidp, dent, &qid);
> > +            err = dirent_to_qid(pdu, fidp, &dent, &qid);
> >              if (err < 0) {
> > -                v9fs_readdir_unlock(&fidp->fs.dir);
> >                  v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> >                  v9fs_string_free(&name);
> >                  return err;
> > @@ -2392,8 +2379,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, * user would get that error anyway when accessing those
> > * files/dirs through other ways.
> >               */
> > -            size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> > -            memcpy(&qid.path, &dent->d_ino, size);
> > +            size = MIN(sizeof(dent.d_ino), sizeof(qid.path));
> > +            memcpy(&qid.path, &dent.d_ino, size);
> >              /* Fill the other fields with dummy values */
> >              qid.type = 0;
> >              qid.version = 0;
> > @@ -2401,10 +2388,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp,
> > 
> >          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
> >          len = pdu_marshal(pdu, 11 + count, "Qqbs",
> > -                          &qid, dent->d_off,
> > -                          dent->d_type, &name);
> > -
> > -        v9fs_readdir_unlock(&fidp->fs.dir);
> > +                          &qid, dent.d_off,
> > +                          dent.d_type, &name);
> > 
> >          if (len < 0) {
> >              v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> > @@ -2413,11 +2398,9 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, }
> >          count += len;
> >          v9fs_string_free(&name);
> > -        saved_dir_pos = dent->d_off;
> > +        saved_dir_pos = dent.d_off;
> >      }
> > 
> > -    v9fs_readdir_unlock(&fidp->fs.dir);
> > -
> >      if (err < 0) {
> >          return err;
> >      }
> > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > index 73f9a751e178..90356dc60140 100644
> > --- a/hw/9pfs/codir.c
> > +++ b/hw/9pfs/codir.c
> > @@ -19,7 +19,7 @@
> >  #include "coth.h"
> > 
> >  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
> > -                                 struct dirent **dent)
> > +                                 struct dirent *dent)
> >  {
> >      int err;
> >      V9fsState *s = pdu->s;
> > @@ -32,13 +32,20 @@ int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu,
> > V9fsFidState *fidp, struct dirent *entry;
> > 
> >              errno = 0;
> > +
> > +            v9fs_readdir_lock(&fidp->fs.dir);
> > +
> >              entry = s->ops->readdir(&s->ctx, &fidp->fs);
> >              if (!entry && errno) {
> >                  err = -errno;
> > +            } else if (entry) {
> > +                memcpy(dent, entry, sizeof(*dent));
> > +                err = 1;
> 
> I find using sizeof(*dent) a bit dangerous considering potential type changes 
> in future. I would rather use sizeof(struct dirent). It is also more human 
> friendly to read IMO.
> 

Hmm... I believe it's the opposite actually: with sizeof(*dent), memcpy
will always copy the number of bytes that are expected to fit in *dent,
no matter the type.

But yes, since memcpy() doesn't do any type checking for us, I think
I'll just turn this into:

                *dent = *entry;


> >              } else {
> > -                *dent = entry;
> >                  err = 0;
> >              }
> > +
> > +            v9fs_readdir_unlock(&fidp->fs.dir);
> >          });
> >      return err;
> >  }
> > diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> > index c2cdc7a9eaac..696c90111261 100644
> > --- a/hw/9pfs/coth.h
> > +++ b/hw/9pfs/coth.h
> > @@ -48,7 +48,8 @@
> > 
> >  void co_run_in_worker_bh(void *);
> >  int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
> > -int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent
> > **); +/* Returns < 0 on error, 1 on success and 0 on end of directory */
> > +int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent
> > *); off_t coroutine_fn v9fs_co_telldir(V9fsPDU *, V9fsFidState *);
> >  void coroutine_fn v9fs_co_seekdir(V9fsPDU *, V9fsFidState *, off_t);
> >  void coroutine_fn v9fs_co_rewinddir(V9fsPDU *, V9fsFidState *);
> 
> That API comment should better go into the .c file as a multi-line comment 
> instead of squeezing it as single-line comment into the header file here.
> 
> It would also make sense either defining macros, or enums as those 2 possible 
> succesful return types of that function instead of simply using hard coded 
> values (0 and 1).
> 

Yeah, I'll drop the comment and go for an enum I guess.

> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index 2167322985ec..f46ad888daa6 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -793,6 +793,38 @@ static void fs_flush_ignored(void *obj, void *data,
> > QGuestAllocator *t_alloc) g_free(wnames[0]);
> >  }
> > 
> > +static void fs_readdir_deadlock(void *obj, void *data, QGuestAllocator
> > *t_alloc) +{
> > +    QVirtio9P *v9p = obj;
> > +    alloc = t_alloc;
> > +    char *const wnames[] = {
> > g_strdup(QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR) }; +    P9Req *req, *req2;
> > +
> > +    fs_attach(v9p, NULL, t_alloc);
> > +    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rwalk(req, NULL, NULL);
> > +
> > +    req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_rlopen(req, NULL, NULL);
> > +
> > +    /*
> > +     * The first request will remain pending in the backend until
> > +     * a request with the magic offset is received. This deadlocks
> > +     * the mainloop of an older QEMU that still handles the critical
> > +     * section around readdir() in the frontend code.
> > +     */
> > +    req = v9fs_treaddir(v9p, 1, 0, 128, 0);
> > +    req2 = v9fs_treaddir(v9p, 1, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET,
> > 128, +                         1);
> > +    v9fs_req_wait_for_reply(req, NULL);
> > +    v9fs_req_free(req);
> > +    v9fs_req_free(req2);
> > +
> > +    g_free(wnames[0]);
> > +}
> > +
> >  static void register_virtio_9p_test(void)
> >  {
> >      qos_add_test("config", "virtio-9p", pci_config, NULL);
> > @@ -810,6 +842,7 @@ static void register_virtio_9p_test(void)
> >      qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
> >                   NULL);
> >      qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
> > +    qos_add_test("fs/readdir/deadlock", "virtio-9p", fs_readdir_deadlock,
> > NULL); }
> > 
> >  libqos_init(register_virtio_9p_test);
> 
> Best regards,
> Christian Schoenebeck
> 
> 

Thanks for the review !

Cheers,

--
Greg

