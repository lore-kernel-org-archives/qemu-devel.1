Received: from eggs.gnu.org ([2001:4830:134:3::10]:46595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRqXV-0002sk-KL
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRqXS-0002lZ-FI
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRqXS-0002kv-73
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 21:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1177040F0B
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 01:52:33 +0000 (UTC)
Date: Mon, 3 Jul 2017 09:52:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170703015231.GA30704@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
	<20170630030321.GA24859@pxdev.xzpeter.org>
	<20170630071123.GE24859@pxdev.xzpeter.org>
	<c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
	<42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
	<75c4314e-869f-38f3-3470-b1c8e94493b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75c4314e-869f-38f3-3470-b1c8e94493b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 30, 2017 at 03:57:23PM +0200, Max Reitz wrote:
> On 2017-06-30 15:05, Eric Blake wrote:
> > On 06/30/2017 07:33 AM, Max Reitz wrote:
> > 
> >>> The assertion is caused by migrate_add_blocker() called before
> >>> initialization of migration object. I'll fix it.
> >>
> >> Thanks!

Should be my thanks to you for reporting this. :)

> >>
> >>> But even with a fix (so I can pass 055 now), I still cannot pass some
> >>> of the other tests. Errors I got:
> >>>
> >>>   https://pastebin.com/ACqbXAYd
> >>>
> >>> I am not familiar with iotests. Is above usual? Looks like it still
> >>> includes 3 failures, and some output mismatch.
> >>
> >> Well, not usual. But 068 just is broken on master currently (Stefan has
> >> sent "virtio: use ioeventfd in TCG and qtest mode" to fix it, and it's
> >> part of his latest pull request). The failure in test 087 is because you
> >> don't have aio=native enabled in your build, as the message says. :-)
> > 
> > We could obviously patch 087 to gracefully skip instead of fail when the
> > build doesn't support running it.
> > 
> >>
> >> I'm not sure about 118. Maybe the os.chmod() doesn't work as intended on
> >> your machine...? Because it tries to open a read-only image as
> >> read/write and wants to see it fail (which it doesn't in your case).
> > 
> > Maybe a run-as-root issue, where root can write to the file in spite of
> > permissions?
> 
> That's what I had in mind, too.
> 
> >               Ideally, I'm reluctant to run testsuites as root without
> > good reason (or at least a good sandbox), for fear that a bug in the
> > testsuite will hose my system.
> 
> I never do. :-)

Good reason. I'll definitely switch to non-root even on my dev machine
next time, and also I think I'll also switch to use xfs for my rootfs
(I won't let you know that I'm using btrfs :).

> 
> There is one test which requires it, but well, that just never gets run
> on my machine (and I don't feel very sorry about it).

So looks like I didn't break the rest of the failed tests, good.

Then I'll send the fix soon. Thanks!

-- 
Peter Xu
