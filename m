Received: from eggs.gnu.org ([2001:4830:134:3::10]:56643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evSy5-0006D8-J9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evSy1-0004hA-Is
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:18:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evSy1-0004gm-Es
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71B70D1446
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 19:18:36 +0000 (UTC)
Date: Mon, 12 Mar 2018 19:18:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312191824.GA15677@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
	<20180312124939.20562-4-berrange@redhat.com>
	<20180312174621.GA14096@redhat.com>
	<8ed40a69-95a9-c259-d21e-eb239b950754@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ed40a69-95a9-c259-d21e-eb239b950754@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/9] sockets: pull code for testing IP
 availability out of specific test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Mar 12, 2018 at 01:08:44PM -0500, Eric Blake wrote:
> On 03/12/2018 12:46 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Mar 12, 2018 at 12:49:33PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > From: "Daniel P. Berrange" <berrange@redhat.com>
> > >=20
> > > The test-io-channel-socket.c file has some useful helper functions =
for
> > > checking if a specific IP protocol is available. Other tests need t=
o
> > > perform similar kinds of checks to avoid running tests that will fa=
il
> > > due to missing IP protocols.
> > >=20
> > > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
>=20
> > > +    if (socket_can_bind("::1") < 0) {
> > > +        if (errno !=3D EADDRNOTAVAIL) {
> > > +            return -1;
> > > +        }
> > > +    } else {
> > > +        *has_ipv6 =3D true;
> > > +    }
> > > +
> >=20
> > Sigh, I should have kept the new code identical to the old code,
> > rather than trying to improve it, as this is in fact broken. The
> > socket_can_bind() is mistakenly returning '0' when EADDRNOTAVAIL
> > is set, so we always set the has_ipv4|6 vars to true.
> >=20
> > It needs this squashed in:
>=20
> The squash makes sense; with that, you can keep the R-b I added on the
> series (I guess that shows I only read the code, not tried to run the
> testsuite with the code applied, or I might have found this too).

Even if you had run the testsuite (like I did), you would not have seen
the bug unless your host has IPv6 disabled *entirely*. Fortunately
Travis hits that scenario which is how I noticed when I sent my branch
through Travis prior to generating a pull request :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
