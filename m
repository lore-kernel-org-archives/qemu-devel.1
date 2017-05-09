Received: from eggs.gnu.org ([2001:4830:134:3::10]:42167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d846a-0003uT-98
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d846X-00038o-4h
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d846W-00038F-RW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:19:01 -0400
Date: Tue, 9 May 2017 20:18:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509121857.GB23466@lemon.lan>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-6-f4bug@amsat.org>
	<20170509040438.GB18973@lemon.lan> <87k25q8oc2.fsf@linaro.org>
	<20170509080543.GD18973@lemon.lan>
	<2f874a2e-bb34-7c1b-1b59-cc6b28366bf5@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2f874a2e-bb34-7c1b-1b59-cc6b28366bf5@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/21] docker: compact debian base
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

On Tue, 05/09 09:06, Philippe Mathieu-Daud=E9 wrote:
> On 05/09/2017 05:05 AM, Fam Zheng wrote:
> > On Tue, 05/09 08:46, Alex Benn=E9e wrote:
> > >=20
> > > Fam Zheng <famz@redhat.com> writes:
> > >=20
> > > > On Mon, 05/08 19:17, Philippe Mathieu-Daud=E9 wrote:
> > > > > - install common/basic tools at once
> > > > > - use eatmydata and remove apt cache to save space
> > > > > - add bison and flex and git
> > > > > - create deb-src entry and setup Emdebian in the same layer
> > > > >=20
> > > > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > > > ---
> > > > >  tests/docker/dockerfiles/debian.docker | 26 +++++++++++++-----=
--------
> > > > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > > >=20
> > > > > diff --git a/tests/docker/dockerfiles/debian.docker b/tests/doc=
ker/dockerfiles/debian.docker
> > > > > index d08def6a8d..dcded3ce84 100644
> > > > > --- a/tests/docker/dockerfiles/debian.docker
> > > > > +++ b/tests/docker/dockerfiles/debian.docker
> > > > > @@ -9,17 +9,17 @@
> > > > >  #
> > > > >  FROM debian:stable-slim
> > > > >=20
> > > > > -# Setup some basic tools we need
> > > > > -RUN apt update
> > > > > -RUN apt install -yy aptitude ca-certificates curl
> > > > > +# Install some basic tools and common build utilities
> > > > > +RUN apt-get update && \
> > > > > +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy \
> > > > > +        eatmydata && \
> > > > > +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata apt-get install=
 -y --no-install-recommends \
> > > > > +        aptitude ca-certificates curl \
> > > > > +        build-essential clang git \
> > > > > +        bison flex && \
> > > > > +    apt-get clean
> > > >=20
> > > > Any particular reason to make multiple "RUN" directives into one?
> > >=20
> > > It reduces the number of layers you generate during the building
> > > process. I'm not sure how much space that saves in the long run tho=
ugh
> > > (disk space is pretty cheap ;-).
> >=20
> > I don't think it matters much, but refreshing an image gets slower du=
e to
> > coarser cache, for example when you add a package in the big "apt-get=
 install"
> > command.
> >=20
> > I don't see a strong reason why this is better. It clutters the file =
and is
> > inconsistent.
>=20
> I'm living in a remote place where Internet is pretty bad so it does sa=
ve me
> some time to have reduced layer while using 'docker save | docker load'=
, but
> no worry :)

Shouldn't 'docker save' collapse the layers anyway and output final data?

On the contrary, Docker build cache saves me time too when I play with th=
e
package list, as 'apt-get update' result is cached in a previous RUN dire=
ctive,
and doesn't need to run again and again. (Yes, I live in a place where "a=
pt-get
update" is slow :)

Fam
