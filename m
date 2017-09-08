Received: from eggs.gnu.org ([2001:4830:134:3::10]:51765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dqAin-0005WA-DH
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dqAii-00027E-OW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dqAii-00026q-IW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:16:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97EC05D68C
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 04:16:43 +0000 (UTC)
Date: Fri, 8 Sep 2017 12:16:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170908041641.GG23040@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-2-quintela@redhat.com>
	<20170811034725.GD26015@pxdev.xzpeter.org>
	<878thsccfw.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878thsccfw.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v6 01/19] migration: Create
 migration_ioc_process_incoming()
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

On Wed, Sep 06, 2017 at 01:07:47PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, Aug 08, 2017 at 06:26:11PM +0200, Juan Quintela wrote:
> >
> > [...]
> >
> >>  void migration_fd_process_incoming(QEMUFile *f)
> >>  {
> >> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
> >> -
> >> +    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
> >> +    MigrationIncomingState *mis = migration_incoming_get_current();
> >> +    
> >> +    if (!mis->from_src_file) {
> >> +        mis->from_src_file = f;
> >
> > [1]
> >
> >> +    }
> >>      qemu_file_set_blocking(f, false);
> >>      qemu_coroutine_enter(co);
> >>  }
> >>  
> >> +void migration_ioc_process_incoming(QIOChannel *ioc)
> >> +{
> >> +    MigrationIncomingState *mis = migration_incoming_get_current();
> >> +
> >> +    if (!mis->from_src_file) {
> >> +        QEMUFile *f = qemu_fopen_channel_input(ioc);
> >> +        mis->from_src_file = f;
> >
> > Remove this line? Since migration_fd_process_incoming() will set it up
> > as well below at [1].
> >
> > Then we can make sure there will be only one place to setup
> > from_src_file.
> 
> This can be end being called from rdma code.
> 
> Yes, I know it is a mess.

But isn't RDMA code calling migration_fd_process_incoming()?  Btw, I
meant removing the one in migration_ioc_process_incoming(), and keep
the one in migration_fd_process_incoming().

(did I miss anything?)

-- 
Peter Xu
