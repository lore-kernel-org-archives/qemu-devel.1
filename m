Received: from eggs.gnu.org ([2001:4830:134:3::10]:54181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eh4b4-0001LU-E7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eh4b1-0005yh-82
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:27:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eh4b1-0005yB-2D
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:27:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 626DB4ACAC
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 02:27:26 +0000 (UTC)
Date: Thu, 1 Feb 2018 10:27:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180201022722.GE31397@xz-mi>
References: <20180129121754.13033-1-quintela@redhat.com>
	<20180129121754.13033-3-quintela@redhat.com>
	<20180131120339.GC31397@xz-mi> <87lgge9pey.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgge9pey.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] migration: Set the migration tcp
 port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Jan 31, 2018 at 01:35:33PM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jan 29, 2018 at 01:17:51PM +0100, Juan Quintela wrote:
> >> We can set the port parameter as zero.  This patch lets us know what
> >> port the system was choosen for us.  Now we can migrate to this place.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> --
> >> 
> >> This was migrate_set_uri(), but as we only need the tcp_port, change
> >> to that one.
> >> ---
> >>  migration/migration.c | 10 ++++++++++
> >>  migration/migration.h |  2 ++
> >>  migration/socket.c    | 35 ++++++++++++++++++++++++++++++-----
> >>  3 files changed, 42 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index eb6958dcda..53818a87af 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -245,6 +245,16 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> >>      }
> >>  }
> >>  
> >> +void migrate_set_port(const uint16_t port, Error **errp)
> >> +{
> >> +    MigrateSetParameters p = {
> >> +        .has_x_tcp_port = true,
> >> +        .x_tcp_port = port,
> >> +    };
> >> +
> >> +    qmp_migrate_set_parameters(&p, errp);
> >
> > If we are calling qmp_migrate_set_parameters() here, does it mean that
> > user can also set this parameter via QMP?
> 
> Yeap.  We do that, or we invent yet another mechanism to update the
> tcp_port parameter :-(
> 
> You can't have both.
> 
> if the user modifies it, it just shots itself it its feet, no?

How about set this directly? :)  Like:

  migrate_get_current()->parameters.x_tcp_port = xxx;

Maybe also add a comment showing that this is a special case.  I just
feel strange that if user can set it, but I'll follow your decision
even if you really want to keep the qmp_*() call since after all this
is for debugging, and QEMU itself won't use this value now.

Thanks,

-- 
Peter Xu
