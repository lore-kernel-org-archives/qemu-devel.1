Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4GW-0002mA-Ke
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4GS-00057d-PA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fG4GS-00056n-Hu
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:52 -0400
Date: Tue, 8 May 2018 16:10:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508151026.GA5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504210001.GB30250@redhat.com>
	<CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 0/3] Document intent for
 supported build platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Dunlap <dunlapg@umich.edu>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>, Anthony Perard <anthony.perard@citrix.com>

On Tue, May 08, 2018 at 03:50:49PM +0100, George Dunlap wrote:
> On Fri, May 4, 2018 at 10:00 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > CC'ing xen-devel in case Xen maintainers have a need for something th=
at
> > will that conflict with this proposal wrt supported build platforms.
>=20
> Thanks for the heads-up.  CC'ing some more people who usually have
> opinions on this sort of thing.
>=20
> >
> > On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> >> This short series is a followup the discussions around min glib vers=
ion
> >> when Olaf found we had accidentally increased the min glib by using =
a
> >> newer function:
> >>
> >>   https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02699.htm=
l
> >>
> >> Some key points from that thread
> >>
> >>   - Although we have a docker job that tries to test the min glib
> >>     version is adhered to, that's only run post-build, not by Peter'=
s
> >>     merge tests, nor by patchew.
> >>
> >>   - The docker min glib test failed to detect the problem anyway
> >>     because RHEL had backported the symbol in question.
> >>
> >>   - The docker min glib test only builds with certain configure
> >>     options so isn't foolproof.
> >>
> >>   - The modern distros we implicitly care about have way newer glib
> >>     than 2.22
> >>
> >>   - Peter's OS-X build host previously had 2.22, but after switching
> >>     from fink to homebrew now has 2.56
> >>
> >>   - I suggested following libvirt's lead in writing a policy for how
> >>     we pick supported OS targets to inform maintainers when min vers=
ions
> >>     can be increased.
> >>
> >> This series writes such a document largely based on one I wrote for
> >> libvirt with a few changes, largely around OS-X and *BSD. Note it
> >> is not meant to be an exhaustive list of distros we'll build on, rat=
her
> >> a representative selection, so that we can identify the range of 3rd
> >> party library versions we need to care about. So if your favourite
> >> distro is missing, dont be alarmed, as it probably ships similar
> >> vintage software to one of those listed - if not feel free to sugges=
t
> >> additions.
> >>
> >> Based on that doc and https://repology.org/metapackage/glib/versions=
,
> >> I identified that we could feasibly set min glib to 2.42. Note that
> >> this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
> >> 2010 so that's reasonable to drop IMHO). It would still cover 2 majo=
r
> >> Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not=
*
> >> 14.04). This min glib lets us remove almost all our compat code.
> >>
> >> Most interestingly, thanks tothe new min version being greater than
> >> 2.32, we can now use GLIB_VERSION_MAX_ALLOWED to validate the correc=
t
> >> API usage according to our min version:
> >>
> >>   https://developer.gnome.org/glib/stable/glib-Version-Information.h=
tml#GLIB-VERSION-MAX-ALLOWED:CAPS
> >>
> >> This means that *all* our CI jobs & developer builds will be enforci=
ng
> >> the min version, so means very many more conditionally built feature=
s
> >> will get their build validated against min glib version. This would
> >> do a much better job of catching mistakes than our min-glib docker
> >> job, making that obsolete.
> >>
> >> Daniel P. Berrang=C3=A9 (3):
> >>   qemu-doc: provide details of supported build platforms
> >>   glib: bump min required glib library version to 2.42
> >>   glib: enforce the minimum required version and warn about old APIs
>=20
> Two responses from me.
>=20
> With my Xen maintainer hat on: I wouldn't feel justified, personally,
> in asking another project to continue supporting older versions.  If
> we didn't want to bump our own glib version, we would have to disable
> "upstream" QEMU (as opposed to Xen's old qemu fork) for older versions
> of glib.

Or could you say that people need to use a stable version of QEMU ?
eg users wanting Xen on RHEL-6, can use "upstream" QEMU, but they'll
need to stick with the 2.12 stable branch version - not use git master
or future releases. I guess it depends whether you can expect 2.12
QEMU to carry on working correctly with ongoing Xen changes.

>=20
> That said, when we've had similar discussions for our own project,
> we've generally aimed at supporting all major currently-supported
> distros, which would include RHEL 6 / CentOS 6.
>=20
> Tailing into that, with my CentOS package maintainer hat on: You said
> that the code in question compiled on RHEL 6 because RH had backported
> the function in question.  Will QEMU continue to actually compile on
> RHEL 6 / CentOS 6?  I.e., will configure be checking for that
> function, or only checking for the version number?

No, the function discussed was just one example of the extra work we
have in trying to maintain compat with old distros, and how even with
testing we sometimes mess up.

This patch is explicitly requiring a much newer glib2 version by doing
a min version check with pkg-config. So with this change applied,
RHEL-6/CentOS-6 would be explicitly *unsupported* as a build host.

If someone needed to continue using 6, they would have to either
backout the min version change and then own the problem of providing
backcompat fixups, or they would have to build a parallel installed
version of glib2 to satisfy EQMU's deps.

> If the former, then the CentOS 6 Xen packages won't be affected.  If
> the latter, then at some point I'll have to stop updating the Xen
> version for CentOS 6 -- but as the CentOS 6 EOL is coming up in 2020,
> it shouldn't be too much of a hardship.

The policy I've proposed for QEMU was in turn inspired by what we
recently did for libvirt[1].  Previously libvirt tried to support
the 2 most recent versions of major RHEL at all times, while QEMU
had no rule about supported versions at all - it has been bumped
on a fairly adhoc basis.

With the new formal rule, libvirt, and now QEMU with this patch
series, cuts the support to the most recent major release, plus
the previous major release for an overlap period of 2 years.

IOW, since RHEL-7.0 came out in June 2014, with this new rule,
RHEL-6.x can be considered dropped as a build target from June 2016.

Regards,
Daniel

[1] https://libvirt.org/platforms.html
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
