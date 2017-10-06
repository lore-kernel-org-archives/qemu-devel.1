Received: from eggs.gnu.org ([2001:4830:134:3::10]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LZ3-0000jz-Pm
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LZ3-00060C-0c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:52:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171004015205.20724-1-jsnow@redhat.com>
	<20171004182732.GE9801@localhost.localdomain>
	<7fd66217-8eda-8de2-f34f-148f69f9df4d@redhat.com>
	<20171005113818.GA4416@localhost.localdomain>
Date: Fri, 06 Oct 2017 07:52:34 +0200
In-Reply-To: <20171005113818.GA4416@localhost.localdomain> (Kevin Wolf's
	message of "Thu, 5 Oct 2017 13:38:18 +0200")
Message-ID: <87o9pk961p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/4] blockjobs: add explicit job reaping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Quick drive-by comment:

Kevin Wolf <kwolf@redhat.com> writes:

[...]
> Let me try to just consolidate all of the above into a single state
> machine:
>
> 1.  CREATED --> RUNNING
>         driver callback: .start
> 2a. RUNNING --> READY | CANCELLED
>         via: auto transition (when bulk copy is finished) / block-job-cancel
>         event: BLOCK_JOB_READY
> 2b. READY --> READY (COMPLETING) | READY (CANCELLING)
>         via: block-job-complete / block-job-cancel
>         event: none
>         driver callback: .complete / none
> 3.  READY (CANCELLING | COMPLETING) --> DONE
>         via: auto transition
>              (CANCELLING: after draining in-flight mirror requests;
>               COMPLETING: when images are in sync)
>         event: BLOCK_JOB_DONE
> 4.  DONE --> PENDING
>         via: auto transition (all jobs in the transaction are DONE)
>         event: BLOCK_JOB_PENDING
> 5.  PENDING --> FINISHED
>         via: block-job-finalize
>         event: COMPLETED | CANCELLED
>         driver callback: .prepare_finalize / .commit / .abort
> 6.  FINISHED --> NULL
>         via: block-job-reap
>         event: none
>         driver callback: .clean
>
> I removed COMPLETED/CANCELLED states because they are never externally
> visible. You proposed an "auto transition" there, but the transition
> would be immediately after the previous one, so clients always see
> PENDING --> NULL | FINISHED.
>
> We would have two booleans to make explicit transition automatically:
>
>     auto-finalize for block-job-finalize (default: true)
>     auto-reap     for block-job-reap     (default: true)

Are we *sure* we need to quadruple the test matrix?

What exactly is the use case for either of these two flags?

> Both of them would be executed automatically as soon as the respective
> commands would be available.
>
> We could add more auto-* options for the remaining explicit transition

*groan*

> (block-job-complete/cancel in READY), but these are not important for
> the problems we're trying to solve here. They might become interesting
> if we do decide that we want a single copy block job instead of doing
> similar things in mirror, commit and backup.
> The naming needs some improvements (done -> pending -> finished looks
> really odd), but does this make sense otherwise?
>
> Kevin
