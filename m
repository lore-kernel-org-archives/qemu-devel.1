Received: from eggs.gnu.org ([2001:4830:134:3::10]:52736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvUE-0005wO-Uj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvU6-0006gk-UO
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:45:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMvU1-0006Ym-8M
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:45:31 -0500
Date: Wed, 14 Nov 2018 13:45:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114134503.GO19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>=20
> This series goal is to allow building libslirp as an independent librar=
y.

At least half of the patches in this series are deleting unused or
unreachable code. I'd suggest you send all of those as a non-RFC
series, as they are things we could merge straight away regardless
of whether/when slirp becomes a separate library.

> While looking at making SLIRP a seperate running process, I thought
> that having an independent library from QEMU would be a first step.
>=20
> There has been some attempts to make slirp a seperate project in the pa=
st.
> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> Unfortunately, they forked from QEMU and didn't provide enough
> compatibility for QEMU to make use of it (in particular, vmstate
> handling was removed, they lost git history etc). Furthermore, they
> are not maintained as far as I can see.

More recently there is this fun project which just pulled in the
QEMU code and chopped out everything todo with slirp:

  https://github.com/rootless-containers/slirp4netns

If the libslirp you propose can satisfy their integration needs
it would be a positive validation of the need for & benefit of
a standalone libslirp.

> I would propose to make slirp a seperate project, that can initially
> be used by QEMU as a submodule, keeping Makefile.objs until a proper
> shared library with stability guarantees etc is ready..

A sub-module sounds ok in short term, but from a distro packaging
POV, I think there'd be strong pressure to unbundle it as quickly
as possible, even immediately. A lack of stable ABI would not be
ideal, but it is not a show stopper either - it would just mean
relatively frequent rebuilds for soname changes which is something
that happens quite a bit already for other deps we have in Fedora:

$ grep soname qemu.spec=20
- Rebuild for libiscsi changed soname again
- Rebuild for changed Xen sonames
- Rebuild to pick up changed libxen* sonames
- Rebuild for libiscsi soname bump
- Rebuild for changed xen soname

> The subproject could created by preserving git tags, and cleaning up th=
e code style, this way:
>=20
> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clang-=
format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-empt=
y --tag-name-filter cat -- --all
> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8a2=
404678ac73)

FWIW, when I split the libvirt python binding out of the main
libvirt repo, I needed a few more commands to fully clean the
git repo, otherwise the git repo size was still enourmous
despite having very few files left. At the time I ran this:

  $ git clone libvirt libvirt-python
  $ cd libvirt-python
  $ git filter-branch --subdirectory-filter python --tag-name-filter cat =
-- --all=20
  $ git for-each-ref --format=3D"%(refname)" refs/original/ | xargs -n 1 =
git update-ref -d
  $ git reflog expire --expire=3Dnow --all
  $ git gc --prune=3Dnow

  https://www.redhat.com/archives/libvir-list/2013-September/msg00413.htm=
l

> What do you think?

I think it sounds worthwhile given the number of times this has
come up before and the fact that people are forking QEMU already
to get access to slirp code.

A standalone project could potentially draw in more contributors
who are otherwise put off by it being part of the bigger QEMU
project, and/or unable to even use it as part of QEMU. This could
ultimately improve slirp's quality.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
