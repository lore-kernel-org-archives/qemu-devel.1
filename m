Received: from eggs.gnu.org ([2001:4830:134:3::10]:41494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqc95-0008LN-Sc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqc90-00023S-VR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:38:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqc90-00023B-Q0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:38:14 -0400
References: <20180817051853.23792-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9419c47a-4cc9-8f52-3d63-fda767029633@redhat.com>
Date: Fri, 17 Aug 2018 12:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] synchronization profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

On 17/08/2018 07:18, Emilio G. Cota wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02186.html
> 
> Changes since v1:
> 
> - Rebase on current master.
> - Update copyright to 2018.
> - Add -m option to the HMP info command to sort by average wait time,
>   as suggested by Paolo.
> - Add -n option to the HMP info command to NOT merge call sites.
>   The default does merge call sites, as suggested by Paolo (thanks
>   to Peter for the clarification).
> - Switch to camel case in qsp.c
> - Update the commit logs of the two HMP patches to clearly state
>   that this is only for developers, so it is HMP-only.
> - Rename the HMP command from "sync" to "sync-profile", as suggested
>   by Markus.
> - Use int for line info consistently (was using unsigned sometimes)
> - Drop qsp_init from qsp_cond_wait, as suggested by Fam.
> - #undef QSP_GEN_{VOID,RET1} once they're no longer used.
> - Add qsp_reset()
>   This uses a snapshot to avoid deleting items, which would require
>   adding rcu_read_lock/unlock to the fast path.
> - Convert to run-time option, as suggested by Fam
>   - Add -enable-sync-profile to qemu-options
>   - Add sync-profile HMP command: "sync-profile on|off|reset"
> - allocate QSPEntry with g_new0
> 
> I added most new bits as separate patches to ease review.
> 
> The first patch has some perf numbers; the last patch shows
> sample output from the monitor.
> 
> Checkpatch gives some errors, but they're false positives.
> 
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/sync-profiler-v2
> 
> Diffstat below.
> 
> Thanks,
> 
> 		Emilio
> ---
>  cpus.c                      |  10 +-
>  hmp-commands-info.hx        |  22 ++
>  hmp-commands.hx             |  15 +
>  hmp.c                       |  24 ++
>  hmp.h                       |   1 +
>  include/qemu/main-loop.h    |   4 +-
>  include/qemu/qht.h          |   1 +
>  include/qemu/qsp.h          |  29 ++
>  include/qemu/thread-posix.h |   4 +-
>  include/qemu/thread-win32.h |   5 +-
>  include/qemu/thread.h       |  66 +++-
>  monitor.c                   |  11 +
>  qemu-options.hx             |  10 +
>  stubs/iothread-lock.c       |   2 +-
>  tests/atomic_add-bench.c    |   6 +-
>  util/Makefile.objs          |   1 +
>  util/qemu-thread-win32.c    |   4 +-
>  util/qht.c                  |  47 ++-
>  util/qsp.c                  | 779 +++++++++++++++++++++++++++++++++++++++
>  vl.c                        |   3 +
>  20 files changed, 1016 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/qsp.h
>  create mode 100644 util/qsp.c
> 
> 

Queued, I'll wait for more comments before sending a pull request.

Paolo
