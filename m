Received: from eggs.gnu.org ([2001:4830:134:3::10]:60872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6FLO-0004pf-Ce
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6FLL-0005JE-99
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:59:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6FLL-0005J4-4l
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:59:19 -0400
Date: Wed, 11 Apr 2018 20:59:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180411125908.GD2785@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-2-alex.bennee@linaro.org>
	<20180411085054.GC2785@lemon.usersys.redhat.com>
	<87y3hu3t73.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y3hu3t73.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/24] configure: add test for docker
 availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org

On Wed, 04/11 11:58, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Tue, 04/10 20:38, Alex Benn=E9e wrote:
> >> This tests for a working docker installation without sudo and sets u=
p
> >> config-host.mak accordingly. This will be useful from cross compilin=
g
> >> things in the future.
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> ---
> >>  configure | 23 +++++++++++++++++++++++
> >>  1 file changed, 23 insertions(+)
> >>
> >> diff --git a/configure b/configure
> >> index 4d0e92c96c..b402befe94 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -451,6 +451,7 @@ jemalloc=3D"no"
> >>  replication=3D"yes"
> >>  vxhs=3D""
> >>  libxml2=3D""
> >> +docker=3D"no"
> >>
> >>  supported_cpu=3D"no"
> >>  supported_os=3D"no"
> >> @@ -5396,6 +5397,23 @@ EOF
> >>    fi
> >>  fi
> >>
> >> +##########################################
> >> +# Docker and cross-compiler support
> >> +#
> >> +# This is specifically for building test
> >> +# cases for foreign architectures, not
> >> +# cross-compiling QEMU itself.
> >> +
> >> +if has "docker"; then
> >> +    if docker images  >/dev/null 2>&1 ; then
> >> +        docker=3D"yes"
> >> +    else
> >> +        # docker may be available but using sudo
> >> +        # so we won't use it for cross-building
> >> +        docker=3D"maybe"
> >
> > What is the problem with using sudo for cross-building?
>=20
> Nothing in particular but we need someway of testing if the sudo is
> passwordless otherwise you might find the build stuck waiting for user
> interaction. This is fine for "make docker-foo" but for an eventual
> unattended "make check" this may cause problems.
>=20
> Is there a way we can test for this? Maybe we can push the docker probe
> into docker.py and just return to configure if it can run docker
> unattended?

We can try 'sudo -n -k docker' to test if passwordless docker works. Acco=
rding
to the manpage, -k ignores the credential cache, and -n ensures non-inter=
action.

Fam
