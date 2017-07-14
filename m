Received: from eggs.gnu.org ([2001:4830:134:3::10]:36330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVyyC-0003tG-QP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVyyB-000119-Mg
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVyyB-000104-DP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:41:15 -0400
Date: Fri, 14 Jul 2017 12:41:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170714114106.GD28095@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170713144352.2212-1-berrange@redhat.com>
	<20170714022930.GC18687@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714022930.GC18687@lemon>
Subject: Re: [Qemu-devel] [PATCH v2] docker: Don't enable networking as a
 side-effect of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Jul 14, 2017 at 10:29:30AM +0800, Fam Zheng wrote:
> On Thu, 07/13 15:43, Daniel P. Berrange wrote:
> > When trying to debug problems with tests it is natural to set
> > DEBUG=1 when starting the docker environment. Unfortunately
> > this has a side-effect of enabling an eth0 network interface
> > in the container, which changes the operating environment of
> > the test suite. IOW tests with fail may suddenly start
> > working again if DEBUG=1 is set, due to changed network setup.
> > 
> > Add a separate NETWORK variable to allow enablement of
> > networking separately from DEBUG=1. This can be used in two
> > ways. To enable the default docker network backend
> > 
> >   make docker-test-build@fedora NETWORK=1
> > 
> > while to enable a specific network backend, eg join the network
> > associated with the container 'wibble':
> > 
> >   make docker-test-build@fedora NETWORK=container:wibble
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > 
> > Changed in v2:
> > 
> >  - Remove reference to eth0
> >  - Allow arbitrary docker network backend to be given
> > 
> >  tests/docker/Makefile.include | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> > index 037cb9e9e7..ec8e8d935d 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -106,6 +106,8 @@ docker:
> >  	@echo '                         (default is 1)'
> >  	@echo '    DEBUG=1              Stop and drop to shell in the created container'
> >  	@echo '                         before running the command.'
> > +	@echo '    NETWORK=1            Enable virtual network interface with default backend.'
> > +	@echo '    NETWORK=$BACKEND     Enable virtual network interface with $BACKEND.'
> >  	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
> >  	@echo '    NOCACHE=1            Ignore cache when build images.'
> >  	@echo '    EXECUTABLE=<path>    Include executable in image.'
> > @@ -132,7 +134,8 @@ docker-run: docker-qemu-src
> >  		$(SRC_PATH)/tests/docker/docker.py run 			\
> >  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> >  			$(if $V,,--rm) 					\
> > -			$(if $(DEBUG),-i,--net=none) 			\
> > +			$(if $(DEBUG),-i,)				\
> > +			$(if $(NETWORK),$(if $(subst $(NETWORK),,1)$(subst 1,,$(NETWORK)),--net=$(NETWORK),),--net=none) \
> 
> Isn't the first subst enough? We already know $(NETWORK) is non-empty. If it is
> "1", $(subst 1,,1) is empty; otherwise, $(subst foo,,1) is non-empty:
> 
> 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),,--net=$(NETWORK)),--net=none) \

This looks inverted to me - NETWORK=1, will generate --net=1 and
NETWORK=foo generates empty string.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
