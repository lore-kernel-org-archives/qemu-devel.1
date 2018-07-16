Received: from eggs.gnu.org ([2001:4830:134:3::10]:54619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesWq-0008Ci-Eg
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesWn-0001DK-2f
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:42:20 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:44597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesWm-0001Cj-UK
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:42:17 -0400
Received: by mail-vk0-x242.google.com with SMTP id 125-v6so20860415vke.11
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 18:42:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <27bc62f7-919b-7d81-55b0-15cf4f9517e4@amsat.org>
Date: Sun, 15 Jul 2018 22:42:08 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 11/16] docker: add expansion for
 docker-test-FOO to Makefile.include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com
Cc: cota@braap.org, famz@redhat.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

Hi Alex,

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> This allows us to run a particular test on all docker images. For
> example:
> 
>   make docker-test-unit
> 
> Will run the unit tests on every supported image. At the same time
> rename docker-test to docker-all-tests to be clearer.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - docker-test -> docker-all-tests
> ---
>  tests/docker/Makefile.include | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index fe63aacf69..e32c35be0d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -151,7 +151,8 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPR
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>  	) \
>  	$(foreach t,$(DOCKER_TESTS), \
> -		$(eval docker-test: docker-$t@$i) \
> +		$(eval docker-all-tests: docker-$t@$i) \
> +		$(eval docker-$t: docker-$t@$i) \

Is this supposed to work this way?

$ make docker-test-quick@debian-alpha-cross
make: *** No rule to make target 'docker-test-quick@debian-alpha-cross'.
 Stop.

>  	) \
>  )
>  
> @@ -161,7 +162,8 @@ docker:
>  	@echo 'Available targets:'
>  	@echo
>  	@echo '    docker:              Print this help.'
> -	@echo '    docker-test:         Run all image/test combinations.'
> +	@echo '    docker-all-tests:    Run all image/test combinations.'
> +	@echo '    docker-TEST:         Run TEST on all image combinations.'
>  	@echo '    docker-clean:        Kill and remove residual docker testing containers.'
>  	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
>  	@echo '                         Note: "TEST" is one of the listed test name,'
> 
