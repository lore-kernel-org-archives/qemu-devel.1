Received: from eggs.gnu.org ([2001:4830:134:3::10]:57029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpAdn-0001AR-DL
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fpAdk-0005c4-76
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:04:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fpAdk-0005be-0d
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:04:00 -0400
Date: Mon, 13 Aug 2018 12:03:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180813110346.GA14675@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
	<20180813090705.GH22904@redhat.com>
	<5ad932dc-6447-42b5-edf4-1b9cacbaac0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ad932dc-6447-42b5-edf4-1b9cacbaac0c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] tweaks for QEMU's C standard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mon, Aug 13, 2018 at 11:25:49AM +0200, Thomas Huth wrote:
> On 08/13/2018 11:07 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 10, 2018 at 06:10:58PM +0100, Alex Benn=C3=A9e wrote:
> >> Hi,
> >>
> >> While I was reviewing Richard's SVE series I found Travis choking on
> >> some perfectly valid c99. It turns out that Travis default image is
> >> old enough that gcc defaults to -std=3Dgnu89 hence the problem. Howe=
ver
> >> switching to c99 isn't enough as we use GNUisms and even gnu99 still
> >> trips up on qemu-secomp.
> >>
> >> Of course we could just jump to C11 already?
> >=20
> > We've always required GCC or a compatible compiler (CLang is only via=
ble
> > alternative option really). We use a number of GCC extensions to the =
C
> > standard and I don't see a compelling reason to stop using them.
> >=20
> > From that POV I think we do *NOT* need to care about official C stand=
ards
> > (c89, c99, c11, etc), only the GNU C standards (gnu89, gnu99, gnu11, =
etc).
> >=20
> >> This is an RFC because this could descend into a C standards
> >> bike-shedding exercise but I thought I'd at least put it out there o=
n
> >> a Friday afternoon ;-)
> >=20
> > I did some archeology to inform our plans...
> >=20
> > The default GCC C standards across various versions are:
> >=20
> >   8.2.1: gnu17
> >   7.3.1: gnu11
> >   6.4.1: gnu11
> >   5.3.1: gnu11
> >   4.9.1: gnu89
> >   4.4.7: gnu89
> >=20
> > Interesting to note that no version of GCC ever defaulted to gnu99. I=
t was
> > not fully implemented initially and by the time the standard was full=
y
> > implemented, gnu11 was already good enough to be the default. So GCC =
jumped
> > straight from gnu89 as default to gnu11 as default.
> >=20
> > Across the various distros we aim to support we have:
> >=20
> >       RHEL-7: 4.8.5
> >       Debian (Stretch): 6.3.0
> >       Debian (Jessie): 4.9.2
> >       OpenBSD (Ports): 4.9.4
> >       FreeBSD (Ports): 8.2.0
> >       OpenSUSE Leap 15: 7.3.1
> >       SLE12-SP2:
> >       Ubuntu (Xenial): 5.4.0
> >       macOS (Homebrew): 8.2.0
> >=20
> > IOW plenty of our plaforms are still on 4.x which defaults to gnu89.
>=20
> Thanks for the great summary!
>=20
> > In GCC 4.x, gnu99 is said to be incomplete (but usable) and gnu11
> > are said to be incomplete and experimental (ie don't use it).
> >=20
> > The lowest common denominator supported by all our platforms is thus
> > gnu89.
> >=20
> > If we don't mind that gnu99 is not fully complete in 4.x, we could us=
e
> > that standard.
> >=20
> > We definitely can't use gnu11 any time soon.
> >=20
> > Given that many modern platforms default to gnu11, I think we should
> > set an explicit -std=3Dgnu89, or -std=3Dgnu99, because otherwise we r=
isk
> > accidentally introducing code that relies on gnu11 features.
>=20
> Sounds good. What about trying -std=3Dgnu99 first, and if we run into
> problems, switch back to -std=3Dgnu89 later?

I don't have a strong opinion either way - both options would be better
than what we do today by relying on the variable gcc built-in defaults.

Using -std=3Dgnu99 gives slightly weaker protection in that we might stil=
l
accidentally use features which are not supported in the limitd gnu99
impl of gcc 4.x. I think that's unlikely, however, hence I don't really
mind either of gnu89 or gnu99

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
