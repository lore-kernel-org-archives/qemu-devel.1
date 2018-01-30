Received: from eggs.gnu.org ([2001:4830:134:3::10]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1egOgK-0003Kq-OP
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1egOgJ-0007jO-9p
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:42:08 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1egOgI-0007if-VG
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:42:07 -0500
Received: by mail-wr0-x230.google.com with SMTP id a43so2131711wrc.4
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 21:42:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 30 Jan 2018 05:42:04 +0000
Message-ID: <CAK3tnvLTwPASC7eypwnc25GvMdJ==k9JZpJbg8piZxs6CNDj0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V4 00/16] COLO: integrate colo frame with
 block replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi~ All~

No news for a long time, this is the last part to make COLO running in
upstream.
Any comments for this series?

Thanks
Zhang Chen


On Fri, Jan 19, 2018 at 1:44 PM, Zhang Chen <zhangckid@gmail.com> wrote:

> From: Zhang Chen <chen.zhang@intel.com>
>
> Hi~
>
> COLO Frame, block replication and COLO proxy(colo-compare,filter-mirror,
> filter-redirector,filter-rewriter) have been exist in qemu
> for long time, it's time to integrate these three parts to make COLO
> really works.
>
> In this series, we have some optimizations for COLO frame, including
> separating the
> process of saving ram and device state, using an COLO_EXIT event to notify
> users that
> VM exits COLO, for these parts, most of them have been reviewed long time
> ago in old version,
> but since this series have just rebased on upstream which had merged a new
> series of migration,
> parts of pathes in this series deserve review again.
>
> We use notifier/callback method for COLO compare to notify COLO frame about
> net packets inconsistent event, and add a handle_event method for
> NetFilterClass to
> help COLO frame to notify filters and colo-compare about
> checkpoint/failover event,
> it is flexible.
>
> For the neweset version, please refer to:
> https://github.com/zhangckid/qemu/tree/qemu-colo-18jan19
>
> Please review, thanks.
>
> V4:
>  - Address Eric's comments in patch 10/16.
>  - Rebase on upstream codes.
>  - Fix mingw compile error in patch 02/16.
>  - Fix some comments.
>  - Fix conflect with the patch "migration: remove "enable_colo" var" in
> patch 06/16.
>
> V3:
>  - Address community comments from V2.
>  - Rebase on upstream codes.
>  - Fix several bugs.
>  - Splite shared disk part to indepentent patch set.
>  - Optimize codes.
>
>
> Zhang Chen (8):
>   filter-rewriter: fix memory leak for connection in
>     connection_track_table
>   colo-compare: implement the process of checkpoint
>   colo-compare: use notifier to notify packets comparing result
>   COLO: integrate colo compare with colo frame
>   COLO: Add block replication into colo process
>   ram/COLO: Record the dirty pages that SVM received
>   filter: Add handle_event method for NetFilterClass
>   filter-rewriter: handle checkpoint and failover event
>
> zhanghailiang (8):
>   COLO: Remove colo_state migration struct
>   COLO: Load dirty pages into SVM's RAM cache firstly
>   COLO: Flush memory data from ram cache
>   qmp event: Add COLO_EXIT event to notify users while exited COLO
>   savevm: split the process of different stages for loadvm/savevm
>   COLO: flush host dirty ram from cache
>   COLO: notify net filters about checkpoint/failover event
>   COLO: quick failover process by kick COLO thread
>
>  include/exec/ram_addr.h  |   1 +
>  include/migration/colo.h |  11 ++-
>  include/net/filter.h     |   5 ++
>  migration/Makefile.objs  |   2 +-
>  migration/colo-comm.c    |  76 -------------------
>  migration/colo.c         | 188 ++++++++++++++++++++++++++++++
> ++++++++++++++---
>  migration/migration.c    |  38 +++++++++-
>  migration/ram.c          | 181 ++++++++++++++++++++++++++++++
> ++++++++++++++-
>  migration/ram.h          |   4 +
>  migration/savevm.c       |  54 ++++++++++++--
>  migration/savevm.h       |   5 ++
>  migration/trace-events   |   3 +
>  net/colo-compare.c       | 108 +++++++++++++++++++++++++--
>  net/colo-compare.h       |  24 ++++++
>  net/colo.h               |   4 +
>  net/filter-rewriter.c    | 109 +++++++++++++++++++++++++--
>  net/filter.c             |  17 +++++
>  net/net.c                |  28 +++++++
>  qapi/migration.json      |  35 +++++++++
>  vl.c                     |   2 -
>  20 files changed, 777 insertions(+), 118 deletions(-)
>  delete mode 100644 migration/colo-comm.c
>  create mode 100644 net/colo-compare.h
>
> --
> 2.7.4
>
>
