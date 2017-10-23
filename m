Received: from eggs.gnu.org ([2001:4830:134:3::10]:56991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YHD-0002Xo-FI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YH9-0007Nq-Mk
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6YH9-0007Ne-ED
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:39:59 -0400
Date: Mon, 23 Oct 2017 09:39:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023083951.GB16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171018073841.30062-1-famz@redhat.com>
	<150831409774.377.7665751901178175493@b58463cdfd5f>
	<20171018082836.GD9443@lemon> <20171018083549.GB9719@redhat.com>
	<CAKmqyKMYMPCQo+7Ces23qKqp9CQR2P+HFMq5DuJOuB0RByhe0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKmqyKMYMPCQo+7Ces23qKqp9CQR2P+HFMq5DuJOuB0RByhe0Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] docker: Fix PATH for ccache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Mon, Oct 23, 2017 at 10:02:20AM +0200, Alistair Francis wrote:
> On Wed, Oct 18, 2017 at 10:35 AM, Daniel P. Berrange
> <berrange@redhat.com> wrote:
> > On Wed, Oct 18, 2017 at 04:28:36PM +0800, Fam Zheng wrote:
> >> On Wed, 10/18 01:08, no-reply@patchew.org wrote:
> >> > Your branch is up-to-date with 'origin/test'.
> >> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> >> > Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> >> > fatal: unable to connect to git.qemu-project.org:
> >> > git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> >> >
> >> > fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> >> > Failed to clone 'dtc'. Retry scheduled
> >> > Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> >> > fatal: unable to connect to git.qemu-project.org:
> >> > git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> >> >
> >> > fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> >> > Failed to clone 'dtc' a second time, aborting
> >> > failed to init submodule dtc
> >>
> >> So now patchew is less robust on network hiccups: a number of the same "git
> >> submodule update --init" calls have succeeded above, so this is incidental. Any
> >> idea how to improve that? Maybe if there is a checkout from $QEMU_SRC, clone/cp
> >> from there instead of fetch from submodule remote?
> >
> > If patchew has unreliable connectivity to git.qemu.org then the best thing
> > is probably have a background job that mirrors the git.qemu.org repos on
> > the patchew server. Then have the test job modify .gitmodules to point to
> > your local mirror. That way, network access is used during the background
> > job only, and actual builds just get a local clone from the cache.
> 
> It looks like git://git.qemu-project.org/dtc.git is completely down
> now, so I'm not sure it's only a patchew issue.
> 
> I think having a fall back to the locally checked out submodule would
> be a good idea, QEMU submodules don't update that often.
> 
> Whatever the solution ends up being can we have something in tree that
> others can use? We run the Docker tests internally and I would like to
> have the same setup (plus it saves me having to maintain something :)
> ).

What is already in tree works just fine for developers in general. You
can just run 'make docker-BLAH' and it'll right the right thing. If devs
hit a transient problem with git they can just re-run it. The problem
here is just about ensuring that patchew has as close to 100% reliable
checkout as possible, by minimizing the impact of transient network
failures for it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
