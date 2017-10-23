Received: from eggs.gnu.org ([2001:4830:134:3::10]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YFM-0001yA-Vt
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6YFJ-0006fi-Ag
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6YFJ-0006f2-0s
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:38:05 -0400
Date: Mon, 23 Oct 2017 09:37:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023083752.GA16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171018073841.30062-1-famz@redhat.com>
	<150831409774.377.7665751901178175493@b58463cdfd5f>
	<20171018082836.GD9443@lemon> <20171018083549.GB9719@redhat.com>
	<20171020125107.GM21172@redhat.com> <20171023062237.GG29815@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023062237.GG29815@lemon>
Subject: Re: [Qemu-devel] [PATCH] docker: Fix PATH for ccache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org

On Mon, Oct 23, 2017 at 02:22:37PM +0800, Fam Zheng wrote:
> On Fri, 10/20 13:51, Daniel P. Berrange wrote:
> > On Wed, Oct 18, 2017 at 09:35:49AM +0100, Daniel P. Berrange wrote:
> > > On Wed, Oct 18, 2017 at 04:28:36PM +0800, Fam Zheng wrote:
> > > > On Wed, 10/18 01:08, no-reply@patchew.org wrote:
> > > > > Your branch is up-to-date with 'origin/test'.
> > > > > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > > > > Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> > > > > fatal: unable to connect to git.qemu-project.org:
> > > > > git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> > > > > 
> > > > > fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> > > > > Failed to clone 'dtc'. Retry scheduled
> > > > > Cloning into '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc'...
> > > > > fatal: unable to connect to git.qemu-project.org:
> > > > > git.qemu-project.org[0: 172.99.69.163]: errno=Connection timed out
> > > > > 
> > > > > fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-jhpnlaz0/src/docker-src.2017-10-18-04.03.32.32287/qemu.tar.vroot/dtc' failed
> > > > > Failed to clone 'dtc' a second time, aborting
> > > > > failed to init submodule dtc
> > > > 
> > > > So now patchew is less robust on network hiccups: a number of the same "git
> > > > submodule update --init" calls have succeeded above, so this is incidental. Any
> > > > idea how to improve that? Maybe if there is a checkout from $QEMU_SRC, clone/cp
> > > > from there instead of fetch from submodule remote?
> > > 
> > > If patchew has unreliable connectivity to git.qemu.org then the best thing
> > > is probably have a background job that mirrors the git.qemu.org repos on
> > > the patchew server. Then have the test job modify .gitmodules to point to
> > > your local mirror. That way, network access is used during the background
> > > job only, and actual builds just get a local clone from the cache.
> > 
> > I thought of a simpler way to address this.
> > 
> > Currently patchew runs 4 docker jobs, and each one triggers creation of
> > the $(DOCKER_SRC_COPY) rule. This runs archive-source.sh 4 times, because
> > $(DOCKER_SRC_COPY) contains the current timestamp and so is different
> > each time we run it.
> > 
> > If you override DOCKER_SRC_COPY with the current git change hash, then
> > you would end up using the same archive for all 4 jobs, and so only do
> > the checkouts once
> >  
> >   make docker-foo   DOCKER_SRC_COPY=docker-src.`git rev-parse HEAD`
> 
> I'm fine with that, just not sure about if this handles uncommitted changes
> correctly? It certainly isn't a concern on patchew, but may be a problem for
> developers.

Developers running locally wouldn't need to set this variable - they can
just run 'make docker-foo' and it'll do the right thing wrt git stash

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
