Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duFSY-00007U-4Z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duFSR-0005Qg-Sq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duFSR-0005QQ-KI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:08:47 -0400
Date: Tue, 19 Sep 2017 11:08:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919100839.GH9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505747575.4959.1.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 18, 2017 at 05:12:55PM +0200, Gerd Hoffmann wrote:
> On Thu, 2017-09-14 at 13:40 +0100, Daniel P. Berrange wrote:
> > On Thu, Sep 14, 2017 at 12:58:26PM +0100, Peter Maydell wrote:
> > > On 14 September 2017 at 12:55, Gerd Hoffmann <kraxel@redhat.com>
> > > wrote:
> > > > =C2=A0 Hi,
> > > >=20
> > > > > I think a better approach is to have something in rules.mak
> > > > > that ensures the submodule is checked out correctly (only
> > > > > when building from GIT, not dist), and then have the rules
> > > > > which generate the keymap files depend on this.
> > > >=20
> > > > Care sending a patch doing that for dtc?
> > >=20
> > > It sounds awfully fiddly. Maybe it is the best we can do
> > > given the mess that is git submodules, but is it really
> > > the common approach?
> >=20
> > I'll do a prototype so we can see something concrete working and
> > evaluate how pleasant (or not) it is
>=20
> Tried to brew something:
>=20
> https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/submodule
>=20
> dtc was pretty simple due to the recursive make call.
>=20
> Hooking the submodule update into a non-recursive make looks
> complicated, especially because the submodule update might change the
> timestamps and therefore the target set which needs a rebuild ...
>=20
> So I did the keymaps build with a recursive make call too, which
> doesn't look that pretty ...

I don't think that's too ugly, but I wonder if there's some way to avoid
the recursive make call.

It feels like this is a similar scenario to 'config-host.mak' being
outdated. I don't entirely understand the logic yet, but we manage to
automatically re-run configure and rebuild config-host.make, when
configure changes, and that in turn affects which dependancies need
rebuild. I wonder if we can somehow integrate into that process, so
that configure is responsible for checking out the git submodules,
then make the re-running of configure trigger when .gitmodules
changes content.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
