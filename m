Received: from eggs.gnu.org ([2001:4830:134:3::10]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYuIK-0006PN-Gg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYuIG-0006Zo-IR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fYuIG-0006Xo-By
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:36 -0400
Date: Fri, 29 Jun 2018 22:22:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180629142232.GG3862@lemon.usersys.redhat.com>
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180628164643.9668-6-f4bug@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Thu, 06/28 13:46, Philippe Mathieu-Daud=E9 wrote:
> We can still run any test in Travis.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 91d9665517..7d9d568eee 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -99,11 +99,17 @@ docker-image-tricore-cross: docker-image-debian9
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
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
> --=20
> 2.18.0
>=20

Apart from Alex's concern (which I don't have), I suppose a 'requires tra=
vis'
and 'ENV features travis' pair is the correct way to do it. See test-ming=
w for
example.

Fam
