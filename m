Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cde4t-0007kZ-0d
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cde4p-00082d-3L
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cde4o-000828-TH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:27:31 -0500
Date: Tue, 14 Feb 2017 22:27:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214142727.GB20715@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
	<20170214140049.GB12294@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170214140049.GB12294@lemon.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] new: debian docker targets for
 cross-compiling
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

On Tue, 02/14 22:00, Fam Zheng wrote:
> On Tue, 02/14 10:07, Alex Benn=E9e wrote:
> > This provides a basic Debian install with access to the emdebian cros=
s
> > compilers. The debian-armhf-cross and debian-arm64-cross targets buil=
d
> > on the basic Debian image to allow cross compiling to those targets.
> >=20
> > To build against the cross compiler a cross-compile prefix needs to b=
e
> > set in the configure options, for example:
> >=20
> >   make docker-test-build@debian-arm64-cross \
> >     EXTRA_CONFIGURE_OPTS=3D"--cross-prefix=3Daarch64-linux-gnu-" \
> >     TARGET_LIST=3D"aarch64-softmmu,aarch64-linux-user"
>=20
> If cross-compile is the only meaningful way to use this image, we proba=
bly
> should bake the configure option into the dockerfile and pick it up
> automatically in common.rc.  What do you think?

The example change is like this:

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 21657e87c6..6865689bb5 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -29,7 +29,7 @@ build_qemu()
     config_opts=3D"--enable-werror \
                  ${TARGET_LIST:+--target-list=3D${TARGET_LIST}} \
                  --prefix=3D$PWD/install \
-                 $EXTRA_CONFIGURE_OPTS \
+                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $@"
     echo "Configure options:"
     echo $config_opts
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/d=
ocker/dockerfiles/debian-arm64-cross.docker
index 04212629f7..fc1c135e74 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -10,3 +10,4 @@ RUN dpkg --add-architecture arm64
 RUN apt update
 RUN apt install -yy crossbuild-essential-arm64
 RUN apt-get build-dep -yy -a arm64 qemu
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Daarch64-linux-gnu-
