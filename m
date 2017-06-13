Received: from eggs.gnu.org ([2001:4830:134:3::10]:60368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKidr-0001hW-6d
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKidm-0006UI-Mm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:01:43 -0400
Date: Tue, 13 Jun 2017 12:01:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170613100125.GD4383@noname.redhat.com>
References: <20170611011427.6713-1-el13635@mail.ntua.gr>
	<20170611011427.6713-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170611011427.6713-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/2] block: move ThrottleGroup
 membership to ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Am 11.06.2017 um 03:14 hat Manos Pitsidianakis geschrieben:
> This commit gathers ThrottleGroup membership details from BlockBackendPublic
> into ThrottleGroupMember and refactors existing code to use the structure.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/block-backend.c           |  75 ++++++----
>  block/qapi.c                    |   8 +-
>  block/throttle-groups.c         | 305 +++++++++++++++++-----------------------
>  blockdev.c                      |   4 +-
>  include/block/throttle-groups.h |  15 +-
>  include/qemu/throttle.h         |  64 +++++++++
>  include/sysemu/block-backend.h  |  22 +--
>  tests/test-throttle.c           |  53 +++----
>  util/throttle.c                 |   5 +
>  9 files changed, 293 insertions(+), 258 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index f3a60081a7..1d6b35c34d 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -209,6 +209,7 @@ static const BdrvChildRole child_root = {
>  BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
>  {
>      BlockBackend *blk;
> +    BlockBackendPublic *blkp;
>  
>      blk = g_new0(BlockBackend, 1);
>      blk->refcnt = 1;
> @@ -216,8 +217,9 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
>      blk->shared_perm = shared_perm;
>      blk_set_enable_write_cache(blk, true);
>  
> -    qemu_co_queue_init(&blk->public.throttled_reqs[0]);
> -    qemu_co_queue_init(&blk->public.throttled_reqs[1]);
> +    blkp = blk_get_public(blk);
> +    qemu_co_queue_init(&blkp->throttle_group_member.throttled_reqs[0]);
> +    qemu_co_queue_init(&blkp->throttle_group_member.throttled_reqs[1]);
>  
>      notifier_list_init(&blk->remove_bs_notifiers);
>      notifier_list_init(&blk->insert_bs_notifiers);
> @@ -284,7 +286,7 @@ static void blk_delete(BlockBackend *blk)
>      assert(!blk->refcnt);
>      assert(!blk->name);
>      assert(!blk->dev);
> -    if (blk->public.throttle_state) {
> +    if (blk_get_public(blk)->throttle_group_member.throttle_state) {
>          blk_io_limits_disable(blk);
>      }
>      if (blk->root) {

Is there a reason why you need to go from blk->public to
blk_get_public()? We're inside block-backend.c here, so I don't really
see the point of using a wrapper function. Other places use the function
because the struct definition of BlockBackend isn't visible to them.

Anyway, even if his did improve the code, we really try to have strictly
one change per patch. So factoring things out of BlockBackendPublic into
ThrottleGroupMember would be one patch, and using blk_get_public() would
be another one. Reasons for this include that it's much easier to review
when a patch does only one change, and that if something breaks,
bisecting directly leads to the problematic change.

> @@ -596,8 +598,10 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
>  void blk_remove_bs(BlockBackend *blk)
>  {
>      notifier_list_notify(&blk->remove_bs_notifiers, blk);
> -    if (blk->public.throttle_state) {
> -        throttle_timers_detach_aio_context(&blk->public.throttle_timers);
> +    BlockBackendPublic *blkp = blk_get_public(blk);

Please make sure that declarations are always at the top of the block
(though again I'm not sure why we're using blk_get_public()).

> +    if (blkp->throttle_group_member.throttle_state) {
> +        ThrottleTimers *tt = &blkp->throttle_group_member.throttle_timers;
> +        throttle_timers_detach_aio_context(tt);
>      }
>  
>      blk_update_root_state(blk);

>  /* should be called before blk_set_io_limits if a limit is set */
>  void blk_io_limits_enable(BlockBackend *blk, const char *group)
>  {
> -    assert(!blk->public.throttle_state);
> -    throttle_group_register_blk(blk, group);
> +    BlockBackendPublic *blkp = blk_get_public(blk);
> +
> +    assert(!blkp->throttle_group_member.throttle_state);
> +
> +    blkp->throttle_group_member.aio_context = blk_get_aio_context(blk);
> +    throttle_group_register_tgm(&blkp->throttle_group_member, group);
>  }

The aio_context assignment here is new and doesn't seem to be related to
the refactoring work that the commit message advertises. Refactoring
patches should be as mechanical as possible.

If this is needed, it should be in a separate patch where the commit
message explains why the change is made.

>  void blk_io_limits_update_group(BlockBackend *blk, const char *group)
>  {
> +    BlockBackendPublic *blkp = blk_get_public(blk);
>      /* this BB is not part of any group */
> -    if (!blk->public.throttle_state) {
> +    if (!blkp->throttle_group_member.throttle_state) {
>          return;
>      }
>  
>      /* this BB is a part of the same group than the one we want */
> -    if (!g_strcmp0(throttle_group_get_name(blk), group)) {
> +    if (!g_strcmp0(throttle_group_get_name(&blkp->throttle_group_member),
> +                group)) {

This looks like refactoring, but not related to extracting fields from
BlockBackendPublic into ThrottleGroupMember.

Changing the argument of throttle_group_get_name() and similar functions
from BlockBackend to ThrottleGroupMember isn't strictly required for the
creation of ThrottleGroupMember, so it should be a separate patch.

>          return;
>      }
>  

> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -29,43 +29,6 @@
>  #include "qemu/thread.h"
>  #include "sysemu/qtest.h"
>  
> -/* The ThrottleGroup structure (with its ThrottleState) is shared
> - * among different BlockBackends and it's independent from
> - * AioContext, so in order to use it from different threads it needs
> - * its own locking.
> - *
> - * This locking is however handled internally in this file, so it's
> - * transparent to outside users.
> - *
> - * The whole ThrottleGroup structure is private and invisible to
> - * outside users, that only use it through its ThrottleState.
> - *
> - * In addition to the ThrottleGroup structure, BlockBackendPublic has
> - * fields that need to be accessed by other members of the group and
> - * therefore also need to be protected by this lock. Once a
> - * BlockBackend is registered in a group those fields can be accessed
> - * by other threads any time.
> - *
> - * Again, all this is handled internally and is mostly transparent to
> - * the outside. The 'throttle_timers' field however has an additional
> - * constraint because it may be temporarily invalid (see for example
> - * bdrv_set_aio_context()). Therefore in this file a thread will
> - * access some other BlockBackend's timers only after verifying that
> - * that BlockBackend has throttled requests in the queue.
> - */
> -typedef struct ThrottleGroup {
> -    char *name; /* This is constant during the lifetime of the group */
> -
> -    QemuMutex lock; /* This lock protects the following four fields */
> -    ThrottleState ts;
> -    QLIST_HEAD(, BlockBackendPublic) head;
> -    BlockBackend *tokens[2];
> -    bool any_timer_armed[2];
> -
> -    /* These two are protected by the global throttle_groups_lock */
> -    unsigned refcount;
> -    QTAILQ_ENTRY(ThrottleGroup) list;
> -} ThrottleGroup;

What Berto said. The comment explicitly says that this struct is
private, so preferably it shouldn't be moved to a header file, or if we
have to, the comment needs to be changed.

I see that you access it only in one place in block/throttle.c. Wouldn't
it be possible to just export helper functions in throttle-groups.c so
that the struct can stay private?

> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -185,6 +185,9 @@ static bool throttle_compute_timer(ThrottleState *ts,
>  void throttle_timers_attach_aio_context(ThrottleTimers *tt,
>                                          AioContext *new_context)
>  {
> +    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
> +    tgm->aio_context = new_context;
> +
>      tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
>                                    tt->read_timer_cb, tt->timer_opaque);
>      tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> @@ -241,6 +244,8 @@ static void throttle_timer_destroy(QEMUTimer **timer)
>  /* Remove timers from event loop */
>  void throttle_timers_detach_aio_context(ThrottleTimers *tt)
>  {
> +    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
> +    tgm->aio_context = NULL;
>      int i;

This part looks unrelated again.

Kevin
