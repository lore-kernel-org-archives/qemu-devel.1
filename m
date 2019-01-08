Received: from eggs.gnu.org ([209.51.188.92]:59945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ggtPn-0002yr-R3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ggtPl-0000Sn-O9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:35:38 -0500
Date: Tue, 8 Jan 2019 15:35:32 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190108153532.GQ27120@redhat.com>
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<20190107184058.GN27120@redhat.com>
	<20190108121625.GA11492@linux.fritz.box>
	<b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
	<20190108151309.GE11492@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108151309.GE11492@linux.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, Jan 08, 2019 at 04:13:09PM +0100, Kevin Wolf wrote:
> Am 08.01.2019 um 15:51 hat Eric Blake geschrieben:
> > On 1/8/19 6:16 AM, Kevin Wolf wrote:
> > > Unconditionally setting optind = 1 looks fine. I would, however, quote a
> > > different part of the glibc man page (in addition or instead of the
> > > paragraph you already quoted):
> > > 
> > >     The  variable  optind is the index of the next element to be
> > >     processed in argv.  The system initializes this value to 1.  The
> > >     caller can reset it to 1 to restart scanning of the same argv, or
> > >     when scanning a new argument vector.
> > > 
> > > This makes it pretty clear that optind = 1 is fine for our case with
> > > glibc. The FreeBSD man page still suggests that we need optreset = 1, so
> > > I suppose we'd end up with something like:
> > > 
> > > ...
> > > optind = 1;
> > > #ifdef __FreeBSD__
> > > optreset = 1;
> > > #endif
> > 
> > If you really want to set optreset for BSD systems, I'd do a configure
> > probe for whether optreset exists, and if so set it for ALL platforms
> > that have optreset, not just for __FreeBSD__.  (That, and checkpatch.pl
> > will gripe if you don't do it that way).
> > 
> > But I'm leaning towards not bothering with optreset UNLESS someone
> > proves they have a case where it actually matters.
> 
> I don't mind either way as long as it works. Using optreset would be
> following the spec by the letter.
> 
> In fact, I had already applied this patch because it's correct even if
> possibly incomplete, depending on your interpretation, but I decided to
> reply instead because the commit message didn't really describe that
> optreset = 1 is correct for glibc, but that optreset = 0 is necessary in
> some other case (which is irrelevant here). So the commit message was my
> main point.

I have tested it[1] on:

Linux, glibc 2.28
FreeBSD 11.2-RELEASE
OpenBSD 6.4

Interestingly OpenBSD getopt works in this respect the same way as
Linux, so it doesn't need any fix.  It's only FreeBSD which needs the
fix.

Rich.

[1] "it" being v2 here:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00189.html

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
