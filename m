Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxOZ3-0001Dz-Hy
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxOZ0-0003Dj-4g
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxOYz-0003BY-Lt
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:33:05 -0400
Date: Wed, 5 Sep 2018 11:32:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180905033255.GA16809@xz-x1>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180720092717.GB16910@xz-mi>
	<4c3e07f4-ba82-9b88-6d32-4407b10a9926@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c3e07f4-ba82-9b88-6d32-4407b10a9926@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/17] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 04:00:31PM +0300, Denis Plotnikov wrote:
> Hi Peter

Hi, Denis,

> 
> I moved the code to the repository
> https://github.com/denis-plotnikov/qemu/tree/background-snapshot-kvm.
> the current version includes fixes with respect to your comments for version
> 1.
> I moved KVM related patches to the end of the branch (formerly patch
> series).
> Since, the KVM patches and the other parts to modify (vhost an others) are
> needless in favor of upcoming userfaltfd,
> I would ask you to review the general framework which is able to work with
> tcg.
> 
> Thanks in advance!

Thank you for pushing the tree.

I might have made a mistake before that I thought this work is at
least working for TCG, but I think I was wrong.  The problem is (I'm
trying to repeat Dave's question that you seems haven't yet answered):
even for TCG there could be use cases where the process might access
guest memory from the kernel space (e.g., vhost, or any system calls
that with a guest memory buffer passed in).  I'm afraid mprotect() and
the whole signal-based mechanism cannot be able to address these page
faults, then we'll encounter adhoc errors and we'll need to fix all
these places up.  Userfaultfd-wp should not have this problem.

I think the general idea of the work is good, but I'm not sure whether
we can merge the work if we don't settle these issues.

Regards,

-- 
Peter Xu
