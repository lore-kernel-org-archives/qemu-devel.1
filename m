Received: from eggs.gnu.org ([2001:4830:134:3::10]:38140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbiA-0004J3-TA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbi6-0005OZ-Vt
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbi6-0005Nl-Mu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1A1B3B70C
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:48:25 +0000 (UTC)
Date: Fri, 19 May 2017 14:48:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170519064819.GA14679@pxdev.xzpeter.org>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] migration: enable return-path for
 precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Fri, May 19, 2017 at 02:43:26PM +0800, Peter Xu wrote:
> This idea derives from the bug reported:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1439147
> 
> It is not a extremely critical bug, since as long as the user uses
> libvirt to migrate, we won't have such an issue at all (we'll have
> identical command line parameters for QEMU). However it can be an
> severe one, since it caused data loss (source VM will quit assuming
> that destination VM is good, while it is not). So it would be good we
> fix it. Meanwhile, imho the return path may be used for other things
> as well in the future.
> 
> This series proposed a solution for the bug - let's enable return path
> even for precopy when possible, then source can know whether dest is
> good or not, then it can decide to do something better than quit.
> 
> The series is marked as RFC for two reasons:
> 
> One point for RFC is the idea in general that whether we would like to
> enable return path for precopy. I see it okay since after all it's
> optional (so it greatly reduces the chance that QEMU command line user
> will lose the data, and this feature will be automatically off when we
> are using e.g. "exec:" to migrate to a file).
> 
> The other one point is that I converted MigrationState into a QObject
> (actually a QDevice) to let migration codes benefits from some general
> framework advantages.
> 
> I got at least one positive feedback on each of the RFC elements
> mentioned above, so dare I post this to public. Though I guess some
> migration reviewers may be on PTO recently (I just know it :), I still
> decided to post this out for a broader rfc review.
> 
> Smoke test done, and of course I verified this series to fix the bug
> mentioned.
> 
> Please review. Thanks.
> 
> Peter Xu (6):
>   io: only allow return path for socket typed
>   migration: isolate return path on src
>   migration: fix leak of src file on dst
>   migration: shut src return path unconditionally
>   migration: let MigrationState be an QObject
>   migration: enable return path for precopy
> 
>  include/hw/compat.h           |   4 ++
>  include/io/channel.h          |   1 +
>  include/migration/migration.h |  27 ++++++++-
>  include/qemu/typedefs.h       |   1 -
>  io/channel-socket.c           |   1 +
>  migration/migration.c         | 133 +++++++++++++++++++++++++++++++-----------
>  migration/postcopy-ram.c      |   1 -
>  migration/qemu-file-channel.c |   9 +++
>  migration/trace-events        |   4 +-
>  9 files changed, 140 insertions(+), 41 deletions(-)
> 
> -- 
> 2.7.4
> 

CC Laurent as well. Sorry!

-- 
Peter Xu
