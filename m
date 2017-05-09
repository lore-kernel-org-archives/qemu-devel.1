Received: from eggs.gnu.org ([2001:4830:134:3::10]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d809W-0007A8-3q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d809S-0006yb-Vb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d809S-0006yB-P5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:05:46 -0400
Date: Tue, 9 May 2017 16:05:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509080543.GD18973@lemon.lan>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-6-f4bug@amsat.org>
	<20170509040438.GB18973@lemon.lan> <87k25q8oc2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87k25q8oc2.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Tue, 05/09 08:46, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Mon, 05/08 19:17, Philippe Mathieu-Daud=E9 wrote:
> >> - install common/basic tools at once
> >> - use eatmydata and remove apt cache to save space
> >> - add bison and flex and git
> >> - create deb-src entry and setup Emdebian in the same layer
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  tests/docker/dockerfiles/debian.docker | 26 +++++++++++++----------=
---
> >>  1 file changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/d=
ockerfiles/debian.docker
> >> index d08def6a8d..dcded3ce84 100644
> >> --- a/tests/docker/dockerfiles/debian.docker
> >> +++ b/tests/docker/dockerfiles/debian.docker
> >> @@ -9,17 +9,17 @@
> >>  #
> >>  FROM debian:stable-slim
> >>
> >> -# Setup some basic tools we need
> >> -RUN apt update
> >> -RUN apt install -yy aptitude ca-certificates curl
> >> +# Install some basic tools and common build utilities
> >> +RUN apt-get update && \
> >> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy \
> >> +        eatmydata && \
> >> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata apt-get install -y -=
-no-install-recommends \
> >> +        aptitude ca-certificates curl \
> >> +        build-essential clang git \
> >> +        bison flex && \
> >> +    apt-get clean
> >
> > Any particular reason to make multiple "RUN" directives into one?
>=20
> It reduces the number of layers you generate during the building
> process. I'm not sure how much space that saves in the long run though
> (disk space is pretty cheap ;-).

I don't think it matters much, but refreshing an image gets slower due to
coarser cache, for example when you add a package in the big "apt-get ins=
tall"
command.

I don't see a strong reason why this is better. It clutters the file and =
is
inconsistent.
