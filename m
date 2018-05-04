Received: from eggs.gnu.org ([2001:4830:134:3::10]:54243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEhoM-0006Pv-Op
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEhoJ-0000y2-47
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:00:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEhoI-0000xg-V8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:00:11 -0400
Date: Fri, 4 May 2018 22:00:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180504210001.GB30250@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Document intent for supported build
 platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

CC'ing xen-devel in case Xen maintainers have a need for something that
will that conflict with this proposal wrt supported build platforms.

On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=C3=A9 wrote:
> This short series is a followup the discussions around min glib version
> when Olaf found we had accidentally increased the min glib by using a
> newer function:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02699.html
>=20
> Some key points from that thread
>=20
>   - Although we have a docker job that tries to test the min glib
>     version is adhered to, that's only run post-build, not by Peter's
>     merge tests, nor by patchew.
>=20
>   - The docker min glib test failed to detect the problem anyway
>     because RHEL had backported the symbol in question.
>=20
>   - The docker min glib test only builds with certain configure
>     options so isn't foolproof.
>=20
>   - The modern distros we implicitly care about have way newer glib
>     than 2.22
>=20
>   - Peter's OS-X build host previously had 2.22, but after switching
>     from fink to homebrew now has 2.56
>=20
>   - I suggested following libvirt's lead in writing a policy for how
>     we pick supported OS targets to inform maintainers when min version=
s
>     can be increased.
>=20
> This series writes such a document largely based on one I wrote for
> libvirt with a few changes, largely around OS-X and *BSD. Note it
> is not meant to be an exhaustive list of distros we'll build on, rather
> a representative selection, so that we can identify the range of 3rd
> party library versions we need to care about. So if your favourite
> distro is missing, dont be alarmed, as it probably ships similar
> vintage software to one of those listed - if not feel free to suggest
> additions.
>=20
> Based on that doc and https://repology.org/metapackage/glib/versions,
> I identified that we could feasibly set min glib to 2.42. Note that
> this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
> 2010 so that's reasonable to drop IMHO). It would still cover 2 major
> Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
> 14.04). This min glib lets us remove almost all our compat code.
>=20
> Most interestingly, thanks tothe new min version being greater than
> 2.32, we can now use GLIB_VERSION_MAX_ALLOWED to validate the correct
> API usage according to our min version:
>=20
>   https://developer.gnome.org/glib/stable/glib-Version-Information.html=
#GLIB-VERSION-MAX-ALLOWED:CAPS
>=20
> This means that *all* our CI jobs & developer builds will be enforcing
> the min version, so means very many more conditionally built features
> will get their build validated against min glib version. This would
> do a much better job of catching mistakes than our min-glib docker
> job, making that obsolete.
>=20
> Daniel P. Berrang=C3=A9 (3):
>   qemu-doc: provide details of supported build platforms
>   glib: bump min required glib library version to 2.42
>   glib: enforce the minimum required version and warn about old APIs
>=20
>  configure               |   6 +-
>  include/glib-compat.h   | 362 ++++++----------------------------------=
--------
>  qemu-doc.texi           |  68 +++++++++
>  tests/test-qmp-event.c  |   2 +-
>  tests/tpm-emu.h         |   4 +-
>  tests/vhost-user-test.c |   4 +-
>  trace/simple.c          |   6 +-
>  7 files changed, 123 insertions(+), 329 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
