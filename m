Received: from eggs.gnu.org ([2001:4830:134:3::10]:50204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu7h-000563-9s
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu7c-0006Kj-IJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:11:41 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:46467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYu7c-0006JM-Ap
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:11:36 -0400
Received: by mail-wr0-x231.google.com with SMTP id t6-v6so8980861wrq.13
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:11:36 -0700 (PDT)
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-6-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180628164643.9668-6-f4bug@amsat.org>
Date: Fri, 29 Jun 2018 15:11:34 +0100
Message-ID: <874lhlvg15.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] docker: Restrict the 'travis' job
 to the Travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> We can still run any test in Travis.


I don't know about this one. The travis job isn't a fill in for real
travis, but a way to work through the matrix. I don't think it needs to
be restricted to any particular image.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 91d9665517..7d9d568eee 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -99,11 +99,17 @@ docker-image-tricore-cross: docker-image-debian9
>
>  # Expand all the pre-requistes for each docker image and test combination
>  $(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
> -	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
> +	$(foreach t,$(DOCKER_TESTS), \
>  		$(eval .PHONY: docker-$t@$i) \
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
> +		$(eval docker-test: docker-$t@$i) \
>  	) \
> -	$(foreach t,$(DOCKER_TESTS), \
> +)
> +# we only run Travis tests on the Travis image
> +$(foreach i,travis, \
> +	$(foreach t,$(DOCKER_TOOLS), \
> +		$(eval .PHONY: docker-$t@$i) \
> +		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
>  		$(eval docker-test: docker-$t@$i) \
>  	) \
>  )


--
Alex Benn=C3=A9e
