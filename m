Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKhVz-0003ky-G6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKhVw-0000BW-Bz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:49:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170611011427.6713-2-el13635@mail.ntua.gr>
References: <20170611011427.6713-1-el13635@mail.ntua.gr>
	<20170611011427.6713-2-el13635@mail.ntua.gr>
Date: Tue, 13 Jun 2017 10:48:50 +0200
Message-ID: <w5160g01de5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Sun 11 Jun 2017 03:14:26 AM CEST, Manos Pitsidianakis wrote:
> This commit gathers ThrottleGroup membership details from BlockBackendPublic
> into ThrottleGroupMember and refactors existing code to use the structure.
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

Wait a minute, why do you need to move this structure to a header file?

The idea is that ThrottleGroup, its members and locking rules are
handled internally in throttle-groups.c. In particular we don't want to
have to expose this QemuMutex and its locking rules to the outside.

Berto
