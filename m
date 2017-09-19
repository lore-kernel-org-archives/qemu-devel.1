Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duGaW-0007lM-3S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duGaQ-0001HE-AR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duGaQ-0001GY-22
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:21:06 -0400
Date: Tue, 19 Sep 2017 12:20:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919112055.GI9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
	<20170919100839.GH9536@redhat.com>
	<1505818700.12708.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505818700.12708.3.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Sep 19, 2017 at 12:58:20PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > So I did the keymaps build with a recursive make call too, which
> > > doesn't look that pretty ...
> > 
> > I don't think that's too ugly, but I wonder if there's some way to
> > avoid
> > the recursive make call.
> > 
> > It feels like this is a similar scenario to 'config-host.mak' being
> > outdated. I don't entirely understand the logic yet, but we manage to
> > automatically re-run configure and rebuild config-host.make, when
> > configure changes, and that in turn affects which dependancies need
> > rebuild.
> 
> Can't spot anything special in the Makefile.  Maybe make is clever
> enough to figure that a rule updates a include file and starts over
> then.
> 
> > I wonder if we can somehow integrate into that process, so
> > that configure is responsible for checking out the git submodules,
> > then make the re-running of configure trigger when .gitmodules
> > changes content.
> 
> .gitmodules only has the repo links, not the checkout hashes.  So it
> wouldn't be touched on updates.
> 
> I can't see an easy way for make to figure a submodule has changed,
> other than running "git submodule update".

So I think I figured out the trick libvirt/gnulib uses for this. It
runs an external script to check the submodule status. This runs
'git submodule' to get a list of expected hashes, and compares this
to a file .git-submodule-status that it previously created (might be
missing on fresh checkout). If the expected & stores hashes don't
match this script runs an error.

The Makefile checks the output of this script, and if it indicates
that an submodule update is required, it uses an ifeq() to add a
dependancy between "Makefile" and a phony target that re-runs
configure (which in turns updates the submodules). If no update was
required, then no dependancy from Makefile gets added, so build runs
normally.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
