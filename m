Received: from eggs.gnu.org ([2001:4830:134:3::10]:37243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVqMI-0007sI-Gy
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVqMH-0006VV-LD
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVqMH-0006UG-Bn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:29:33 -0400
Date: Fri, 14 Jul 2017 10:29:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714022930.GC18687@lemon>
References: <20170713144352.2212-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713144352.2212-1-berrange@redhat.com>
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
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 07/13 15:43, Daniel P. Berrange wrote:
> When trying to debug problems with tests it is natural to set
> DEBUG=1 when starting the docker environment. Unfortunately
> this has a side-effect of enabling an eth0 network interface
> in the container, which changes the operating environment of
> the test suite. IOW tests with fail may suddenly start
> working again if DEBUG=1 is set, due to changed network setup.
> 
> Add a separate NETWORK variable to allow enablement of
> networking separately from DEBUG=1. This can be used in two
> ways. To enable the default docker network backend
> 
>   make docker-test-build@fedora NETWORK=1
> 
> while to enable a specific network backend, eg join the network
> associated with the container 'wibble':
> 
>   make docker-test-build@fedora NETWORK=container:wibble
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> Changed in v2:
> 
>  - Remove reference to eth0
>  - Allow arbitrary docker network backend to be given
> 
>  tests/docker/Makefile.include | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 037cb9e9e7..ec8e8d935d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -106,6 +106,8 @@ docker:
>  	@echo '                         (default is 1)'
>  	@echo '    DEBUG=1              Stop and drop to shell in the created container'
>  	@echo '                         before running the command.'
> +	@echo '    NETWORK=1            Enable virtual network interface with default backend.'
> +	@echo '    NETWORK=$BACKEND     Enable virtual network interface with $BACKEND.'
>  	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
>  	@echo '    NOCACHE=1            Ignore cache when build images.'
>  	@echo '    EXECUTABLE=<path>    Include executable in image.'
> @@ -132,7 +134,8 @@ docker-run: docker-qemu-src
>  		$(SRC_PATH)/tests/docker/docker.py run 			\
>  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
>  			$(if $V,,--rm) 					\
> -			$(if $(DEBUG),-i,--net=none) 			\
> +			$(if $(DEBUG),-i,)				\
> +			$(if $(NETWORK),$(if $(subst $(NETWORK),,1)$(subst 1,,$(NETWORK)),--net=$(NETWORK),),--net=none) \

Isn't the first subst enough? We already know $(NETWORK) is non-empty. If it is
"1", $(subst 1,,1) is empty; otherwise, $(subst foo,,1) is non-empty:

			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),,--net=$(NETWORK)),--net=none) \

The second subst is only a necessary condition.

Another way to write it is:

			$(if $(NETWORK),$(if $(findstring $(NETWORK),1),,--net=$(NETWORK)),--net=none) \

Fam

>  			-e TARGET_LIST=$(TARGET_LIST) 			\
>  			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
>  			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
> -- 
> 2.13.0
> 
