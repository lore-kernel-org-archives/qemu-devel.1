Received: from eggs.gnu.org ([2001:4830:134:3::10]:48146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gAuTc-0000nB-MT
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gAuTZ-0000qA-Fq
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gAuTZ-0000oA-7t
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:15:21 -0400
Date: Fri, 12 Oct 2018 06:15:18 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <2078529305.33241973.1539339318932.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
	<1539263541.16655.110.camel@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
	<1539272266.16655.154.camel@redhat.com>
	<20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> On Thu, Oct 11, 2018 at 05:37:46PM +0200, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=
=BD wrote:
> > On Thu, 2018-10-11 at 17:09 +0200, Gerd Hoffmann wrote:
> > > > > Ok.  We probably should fix interface_client_monitors_config() to=
 use
> > > > > the channel_id instead of qemu_console_get_head() then.
> > > >=20
> > > > It's not that simple. This would break the QXL with multiple monito=
rs
> > > > per channel case.
> > >=20
> > > It is that simple.
> > >=20
> > > qxl doesn't use that code path and has its own version of the callbac=
k
> > > (in qxl.c).  Fixing it there is a bit more tricky.
> >=20
> > Ok.. and what's actually the problem using qemu_console_get_head()? It
> > just doesn't feel right to me using channel_id as an index into this
> > array. It is not the right index strictly speaking.
>=20
> Assume you have one qxl and one virtio-gpu device (one head each), for
> example:
>=20
>    00:02.0   qxl          channel 0
>    00:03.0   virtio-gpu   channel 1
>=20
> So the client will assign display 0 to qxl and display 1 to virtio-gpu.
> In interface_client_monitors_config() we have to pick the correct array
> entry.
>=20
> When using the channel_id it works correctly.
>=20
> When using qemu_console_get_head() it doesn't work correctly, it would
> use the qxl card's data.  It would work if spice-server would filter the
> list to only include the entries for the given display channel before
> calling the ->client_monitors_config() callback.  But it doesn't, we get
> the complete set.
>=20

That's why I said is a bug, IMHO it should.

> > > > I think we should fix spice server to actually do the filtering and
> > > > only send monitors_config that belongs to the device to the QXL
> > > > interface. As Frediano mentioned, it looks more like a bug.
> > >=20
> > > Only problem is changing the callback semantics changes the library a=
pi.
> > > We could add a second version of the callback which gets called with =
a
> > > filtered list (if present).  Not sure this is worth the effort though=
.
> >=20
> > That's right. But if we don't actually break any currently supported
> > use cases, it might be fine? The only thing we would be breaking is
> > the virtio-gpu, I think?  Is that already something we don't want to
> > break?
>=20
> It would break any multihead configuration which uses multiple display
> channels.  Yes, virtio-gpu is one case.  Breaking that would not be very
> nice, but maybe acceptable.  The other case is multiple qxl devices
> (i.e.  windows guest style multihead).  Breaking that is out of
> question.
>=20

Windows is not a problem as it ignores the data passed to client_monitors_c=
onfig.

> cheers,
>   Gerd
>=20

Frediano
