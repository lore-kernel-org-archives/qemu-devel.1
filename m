Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVzSR-0000oZ-I1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVzSN-0002FD-9e
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:12:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVzSN-0002Et-2q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:12:27 -0400
Date: Fri, 14 Jul 2017 20:12:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714121223.GH18687@lemon>
References: <20170713144352.2212-1-berrange@redhat.com>
	<20170714022930.GC18687@lemon> <20170714114106.GD28095@redhat.com>
	<20170714115002.GF18687@lemon> <20170714115200.GE28095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714115200.GE28095@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 07/14 12:52, Daniel P. Berrange wrote:
> > > > > @@ -132,7 +134,8 @@ docker-run: docker-qemu-src
> > > > >  		$(SRC_PATH)/tests/docker/docker.py run 			\
> > > > >  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> > > > >  			$(if $V,,--rm) 					\
> > > > > -			$(if $(DEBUG),-i,--net=none) 			\
> > > > > +			$(if $(DEBUG),-i,)				\
> > > > > +			$(if $(NETWORK),$(if $(subst $(NETWORK),,1)$(subst 1,,$(NETWORK)),--net=$(NETWORK),),--net=none) \
> > > > 
> > > > Isn't the first subst enough? We already know $(NETWORK) is non-empty. If it is
> > > > "1", $(subst 1,,1) is empty; otherwise, $(subst foo,,1) is non-empty:
> > > > 
> > > > 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),,--net=$(NETWORK)),--net=none) \
> > > 
> > > This looks inverted to me - NETWORK=1, will generate --net=1 and
> > > NETWORK=foo generates empty string.
> > 
> > You are right, I was confused (subst succeed is FALSE branch of if). I think
> > s/,,/,/ and it will work?
> 
> Yep

OK, so dropping the second "$(subst ...)" and the comma we have:

			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \

With that, queued for 2.10:

    https://github.com/famz/qemu/tree/staging

Fam
