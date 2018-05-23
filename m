Received: from eggs.gnu.org ([2001:4830:134:3::10]:38768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLP3X-0000oM-1j
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLP3T-0000vd-T1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:23:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39691 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLP3T-0000vV-Oj
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32B0F40704B8
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:23:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180412061108.10875-1-peterx@redhat.com>
Date: Wed, 23 May 2018 10:23:22 +0200
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com> (Peter Xu's message of
	"Thu, 12 Apr 2018 14:11:08 +0800")
Message-ID: <87sh6iixvp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> In the future the monitor iothread may be accessing the cur_mon as
> well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> Out-Of-Band command,

Uh, inhowfar are the commands marked allow-oob: true now not real?
These are migrate-recover, migrate-pause, x-oob-test.

Aside: having x-oob-test in QEMU proper is awful.  Is there really no
way around it?

>                      let's convert the cur_mon variable to be a
> per-thread variable to make sure there won't be a race between threads.
>
> Note that thread variables are not initialized to a valid value when new
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
>
>   old_mon = cur_mon;
>   cur_mon = xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon = old_mon;
>
> It plays a role as stack variable, so no need to be initialized at all.
> We only need to make sure the variable won't be changed unexpectedly by
> other threads.

Do we plan to keep switching cur_mon forever?  Or do we intend to work
towards a 1:1 association between Monitor struct and monitor thread?

Even if we want the latter, I'm okay with this patch as an intermediate
step.

> Signed-off-by: Peter Xu <peterx@redhat.com>
