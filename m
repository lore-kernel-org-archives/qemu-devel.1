Received: from eggs.gnu.org ([2001:4830:134:3::10]:43120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJecB-0005AR-Vy
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJebz-0005F2-NE
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:08:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJebz-0005Cd-FC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:08:11 -0500
Date: Mon, 5 Nov 2018 14:08:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105130808.qwrb6gm2l3jqiu2z@sirius.home.kraxel.org>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
	<1541420337.16655.496.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541420337.16655.496.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

On Mon, Nov 05, 2018 at 01:18:57PM +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD=
 wrote:
> On Mon, 2018-11-05 at 07:52 +0100, Gerd Hoffmann wrote:
> > > 2. Have a single function as follows:
> > >=20
> > > void spice_qxl_set_device_info(QXLInstance *instance,
> > >                                const char *device_address,
> > >                                uint32_t device_display_id_start,
> > >                                uint32_t device_display_id_count);
> >=20
> > How about:
> >=20
> > void spice_qxl_set_device_info(QXLInstance *instance,
> >                                const char *device_address,
> >                                uint32_t device_display_id);
> >=20
> > I don't think we need start+count:
> >=20
> >  * For single-head devices device_display_id will be zero.
> >  * For one-channel-per-head multihead devices (i.e. virtio-gpu)
> >    device_display_id will enumerate the heads (so everybody can figur=
e
> >    which channel is which head).
> >  * For one-channel-per-device multihead devices (i.e. qxl/linux)
> >    device_display_id will be zero too.  Number of heads is set via
> >    spice_qxl_set_max_monitors().
>=20
> That requires nontrivial and unexpected logic for the one-channel-per-
> device multihead devices case. The API should be doing what it says and
>  the dumber the better, this seems too smart to me...

Well, the device_display_id_count argument is redundant with
spice_qxl_set_max_monitors().  That isn't a great API either.

I can see that it simplifies the logic in spice-server if we have a
single function call instead of two.  So we could deprecate
spice_qxl_set_max_monitors() in favour of your
spice_qxl_set_device_info() variant.

spice_qxl_set_max_monitors() would then basically do this:

    spice_qxl_set_max_monitors(qxl, max)
    {
        spice_qxl_set_device_info(qxl, NULL, 0, max);
    }

cheers,
  Gerd
