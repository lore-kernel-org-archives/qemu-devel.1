Received: from eggs.gnu.org ([2001:4830:134:3::10]:39655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQq5Z-0002bo-0D
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQq5V-0007qW-RR
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQq5V-0007q4-LL
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A56E08553D
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 07:11:32 +0000 (UTC)
Date: Fri, 30 Jun 2017 15:11:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170630071123.GE24859@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
	<20170630030321.GA24859@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170630030321.GA24859@pxdev.xzpeter.org>
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jun 30, 2017 at 11:03:21AM +0800, Peter Xu wrote:
> On Fri, Jun 30, 2017 at 04:18:56AM +0200, Max Reitz wrote:
> > On 2017-06-27 06:10, Peter Xu wrote:
> > > Let the old man "MigrationState" join the object family. Direct benefit
> > > is that we can start to use all the property features derived from
> > > current QDev, like: HW_COMPAT_* bits, command line setup for migration
> > > parameters (so will never need to set them up each time using HMP/QMP,
> > > this is really, really attractive for test writters), etc.
> > > 
> > > I see no reason to disallow this happen yet. So let's start from this
> > > one, to see whether it would be anything good.
> > > 
> > > Now we init the MigrationState struct statically in main() to make sure
> > > it's initialized after global properties are applied, since we'll use
> > > them during creation of the object.
> > > 
> > > No functional change at all.
> > 
> > Evidently not quite right because this breaks iotest 055.
> > 
> > Condensed test case:
> > 
> > $ ./qemu-img create -f vmdk -o subformat=streamOptimized foo.vmdk 64M
> > Formatting 'foo.vmdk', fmt=vmdk size=67108864 compat6=off
> > hwversion=undefined subformat=streamOptimized
> > $ x86_64-softmmu/qemu-system-x86_64 -drive if=none,file=foo.vmdk
> > qemu-system-x86_64: ./migration/migration.c:114: migrate_get_current:
> > Assertion `current_migration' failed.
> > [1]    15453 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64
> > -drive if=none,file=foo.vmdk
> > 
> > (It just worked before this patch.)
> 
> Sorry. Will have a look.

Hello, Max,

The assertion is caused by migrate_add_blocker() called before
initialization of migration object. I'll fix it.

But even with a fix (so I can pass 055 now), I still cannot pass some
of the other tests. Errors I got:

  https://pastebin.com/ACqbXAYd

I am not familiar with iotests. Is above usual? Looks like it still
includes 3 failures, and some output mismatch.

-- 
Peter Xu
