Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elRiQ-0003yW-SS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elRiN-0000Ew-Jw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:57:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1elRiN-0000E6-Ew
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:57:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D77598182D2D
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 03:56:55 +0000 (UTC)
Date: Tue, 13 Feb 2018 11:56:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180213035647.GE4472@xz-mi>
References: <20180212160340.15333-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212160340.15333-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] migration: Fix early failure crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Mon, Feb 12, 2018 at 04:03:38PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This fixes a crash for the case where a migration exits with an error
> very early, this is probably due to my recent error handling change.
> 
> I also add a test to make sure this doesn't fail again, the test does
> output one line of junk, suggestions for how to clean it up are welcome:
> 
> [dgilbert@dgilbert-t530 try]$ tests/migration-test 
> /x86_64/migration/deprecated: OK
> /x86_64/migration/bad_dest: qemu-system-x86_64: Failed to connect socket: Connection refused
> OK
> /x86_64/migration/postcopy/unix: OK

So we have more than one way to log things (error_report routes things
directly to stderr while we also have the qemu log stuff).

A stupid but fast way I can think of is just don't dump this in
migrate_fd_cleanup, since after all it's only for HMP and people
should also see that when query migration status.  But it'll be a bit
inconvenient for HMP users encountering failures.

Or maybe we can hack around fd 2 specifically in that test?  It's at
least ugly though...

Anyway, the patches look good to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
