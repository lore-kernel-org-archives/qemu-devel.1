Received: from eggs.gnu.org ([2001:4830:134:3::10]:51895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ej2aD-0003DH-RW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ej2aA-0005xS-P2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:42:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ej2aA-0005vZ-7x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:42:42 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Tue, 6 Feb 2018 12:42:36 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73942C099@shsmsx102.ccr.corp.intel.com>
References: <20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
	<20180201190712-mutt-send-email-mst@kernel.org>
	<5A7462DC.1020904@intel.com>
	<20180205162549.GH28241@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73942B586@shsmsx102.ccr.corp.intel.com>
	<20180206093158.GE4942@stefanha-x1.localdomain>
In-Reply-To: <20180206093158.GE4942@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, Maxime
	Coquelin <maxime.coquelin@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>

On Tuesday, February 6, 2018 5:32 PM, Stefan Hajnoczi wrote:
> On Tue, Feb 06, 2018 at 01:28:25AM +0000, Wang, Wei W wrote:
> > On Tuesday, February 6, 2018 12:26 AM, Stefan Hajnoczi wrote:
> > > On Fri, Feb 02, 2018 at 09:08:44PM +0800, Wei Wang wrote:
> > > > On 02/02/2018 01:08 AM, Michael S. Tsirkin wrote:
> > > > > On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> > > > > > Issues:
> > > > > > Suppose we have both the vhost and virtio-net set up, and=20
> > > > > > vhost pmd <-> virtio-net pmd communication works well. Now,=20
> > > > > > vhost pmd exits (virtio-net pmd is still there). Some time=20
> > > > > > later, we re-run vhost pmd, the vhost pmd doesn't know the=20
> > > > > > virtqueue addresses of the virtio-net pmd, unless the=20
> > > > > > virtio-net pmd reloads to start the 2nd phase of the=20
> > > > > > vhost-user protocol. So the second run of the vhost
> > > pmd won't work.
> > > > > >
> > > > > > Any thoughts?
> > > > > >
> > > > > > Best,
> > > > > > Wei
> > > > > So vhost in qemu must resend all configuration on reconnect.
> > > > > Does this address the issues?
> > > > >
> > > >
> > > > Yes, but the issues are
> > > > 1) there is no reconnecting when a pmd exits (the socket=20
> > > > connection seems still on at the device layer);
> > >
> > > This is how real hardware works too.  If the driver suddenly stops=20
> > > running then the device remains operational.  When the driver is=20
> > > started again it resets the device and initializes it.
> > >
> > > > 2) If we find a way to break the QEMU layer socket connection=20
> > > > when pmd exits and get it reconnect, virtio-net device still=20
> > > > won't send all the configure when reconnecting, because socket=20
> > > > connecting only triggers phase 1 of vhost-user negotiation (i.e.
> > > > vhost_user_init). Phase 2 is triggered after the driver loads=20
> > > > (i.e. vhost_net_start). If the virtio-net pmd doesn't reload,=20
> > > > there are no phase 2 messages (like virtqueue addresses which=20
> > > > are allocated by the pmd). I think we need to think more about=20
> > > > this before
> moving forward.
> > >
> > > Marc-Andr=E9: How does vhost-user reconnect work when the master=20
> > > goes away and a new master comes online?  Wei found that the QEMU=20
> > > slave implementation only does partial vhost-user initialization=20
> > > upon reconnect, so the new master doesn't get the virtqueue=20
> > > address and
> related information.
> > > Is this a QEMU bug?
> >
> > Actually we are discussing the slave (vhost is the slave, right?) going=
 away.
> When a slave exits and some moment later a new slave runs, the master
> (virtio-net) won't send the virtqueue addresses to the new vhost slave.
>=20
> Yes, apologies for the typo.  s/QEMU slave/QEMU master/
>=20
> Yesterday I asked Marc-Andr=E9 for help on IRC and we found the code=20
> path where the QEMU master performs phase 2 negotiation upon=20
> reconnect.  It's not obvious but the qmp_set_link() calls in net_vhost_us=
er_event() will do it.
>=20
> I'm going to try to reproduce the issue you're seeing now.  Will let=20
> you know what I find.
>=20

OK. Thanks. I observed no messages after re-run virtio-vhost-user pmd, and =
found there is no re-connection event happening in the device side.=20

I also tried to switch the role of client/server - virtio-net to run a serv=
er socket, and virtio-vhost-user to run the client, and it seems the curren=
t code fails to run that way. The reason is the virtio-net side vhost_user_=
get_features() doesn't return. On the vhost side, I don't see virtio_vhost_=
user_deliver_m2s being invoked to deliver the GET_FEATURES message. I'll co=
me back to continue later.

Best,
Wei
