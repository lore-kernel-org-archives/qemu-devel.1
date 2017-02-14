Received: from eggs.gnu.org ([2001:4830:134:3::10]:42861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddzg-0003O6-3B
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddzb-0004Qg-Iu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:22:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cddzb-0004PP-Ck
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:22:07 -0500
Date: Tue, 14 Feb 2017 22:22:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214142204.GA20715@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170214100733.22280-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] tests/docker: add basic user
 mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 02/14 10:07, Alex Benn=E9e wrote:
> Currently all docker builds are done by exporting a tarball to the
> docker container and running the build as the containers root user.
> Other use cases are possible however and it is possible to map a part
> of users file-system to the container. This is useful for example for
> doing cross-builds of arbitrary source trees. For this to work
> smoothly the container needs to have a user created that maps cleanly
> to the host system.
>=20
> This adds a -u option to the docker script so that:
>=20
>   DEB_ARCH=3Darmhf DEB_TYPE=3Dstable ./tests/docker/docker.py build \
>     -u --include-executable=3Darm-linux-user/qemu-arm \
>     debian:armhf ./tests/docker/dockerfiles/debian-bootstrap.docker
>=20
> Will build a container that can then be run like:
>=20
>   docker run --rm -it -v /home/alex/lsrc/qemu/risu.git/:/src \
>     --user=3Dalex:alex -w /src/ debian:armhf \
>     sh -c "make clean && ./configure -s && make"
>=20
> Alternatively specifying USER will add the appropriate stanza when
> building via the Makefile:
>=20
>   make docker-image-debian-armhf-cross USER=3D1
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Fam Zheng <famz@redhat.com>
>=20
> ---
> v2
>   - write the useradd directly
>   - change long option to --add-current-user
> v3
>   - images -> image's
>   - add r-b
>   - add USER to Makefile
> ---
>  tests/docker/Makefile.include |  2 ++
>  tests/docker/docker.py        | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 3f15d5aea8..8db55e43aa 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -50,6 +50,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  	$(call quiet-command,\
>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
> +		$(if $(USER),--add-current-user,) \
>  		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
>  		"BUILD","$*")
> =20
> @@ -99,6 +100,7 @@ docker:
>  	@echo '                         (default is 1)'
>  	@echo '    DEBUG=3D1              Stop and drop to shell in the creat=
ed container'
>  	@echo '                         before running the command.'
> +	@echo '    USER=3D1		Add current user to docker image.'

This is a bad choice of name, $USER is "$(id -un)", maybe ADD_CUR_USER?

Fam


>  	@echo '    NOCACHE=3D1            Ignore cache when build images.'
>  	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
> =20
