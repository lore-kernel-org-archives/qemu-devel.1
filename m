Received: from eggs.gnu.org ([2001:4830:134:3::10]:41944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPbs-0001Xp-RL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPbo-0001hQ-VQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:55:52 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPbo-0001hB-Px
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:55:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so3857661qta.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:55:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712162550.8061-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <292ec5a0-8722-4c66-d3d6-377b9863e092@amsat.org>
Date: Wed, 12 Jul 2017 18:55:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170712162550.8061-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Don't enable networking as a side-effect
 of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Daniel,

On 07/12/2017 01:25 PM, Daniel P. Berrange wrote:
> When trying to debug problems with tests it is natural to set
> DEBUG=1 when starting the docker environment. Unfortunately
> this has a side-effect of enabling an eth0 network interface
> in the container, which changes the operating environment of
> the test suite. IOW tests with fail may suddenly start
> working again if DEBUG=1 is set, due to changed network setup.
> 
> Add a separate NETWORK=1 option to allow enablement of
> networking separately from DEBUG=1, since common debugging
> tasks probably don't require networking anyway.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   tests/docker/Makefile.include | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 037cb9e..a8c4b82 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -106,6 +106,7 @@ docker:
>   	@echo '                         (default is 1)'
>   	@echo '    DEBUG=1              Stop and drop to shell in the created container'
>   	@echo '                         before running the command.'
> +	@echo '    NETWORK=1            Enable eth0 virtual network interface.'

"eth0" is not always true...

This patch could be more generic, maybe documented as:

   NETWORK=host     Use full host network stack (default no network).'

>   	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
>   	@echo '    NOCACHE=1            Ignore cache when build images.'
>   	@echo '    EXECUTABLE=<path>    Include executable in image.'
> @@ -132,7 +133,8 @@ docker-run: docker-qemu-src
>   		$(SRC_PATH)/tests/docker/docker.py run 			\
>   			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
>   			$(if $V,,--rm) 					\
> -			$(if $(DEBUG),-i,--net=none) 			\
> +			$(if $(DEBUG),-i,)				\
> +			$(if $(NETWORK),,--net=none)			\

and here use directly:  --net=${NETWORK:-none}

so an experimented docker user could even run tests as:

   make docker-test-quick@centos6 NETWORK=container:qemu

(or NETWORK=bridge)

>   			-e TARGET_LIST=$(TARGET_LIST) 			\
>   			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
>   			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
> 

Regards,

Phil.
