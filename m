Received: from eggs.gnu.org ([2001:4830:134:3::10]:55031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eidWl-0006aY-TG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eidWi-0000lx-Np
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:57:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:23980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eidWi-0000kf-Es
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:57:28 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 5 Feb 2018 09:57:23 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73942A470@shsmsx102.ccr.corp.intel.com>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
	<20180202152538.GA16064@stefanha-x1.localdomain>
In-Reply-To: <20180202152538.GA16064@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>

On Friday, February 2, 2018 11:26 PM, Stefan Hajnoczi wrote:
> On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> > Background:
> > The vhost-user negotiation is split into 2 phases currently. The 1st
> > phase happens when the connection is established, and we can find
> > what's done in the 1st phase in vhost_user_init(). The 2nd phase
> > happens when the master driver is loaded (e.g. run of virtio-net pmd)
> > and set status to the device, and we can find what's done in the 2nd
> > phase in vhost_dev_start(), which includes sending the memory info and
> > virtqueue info. The socket is connected, till one of the QEMU devices
> > exits, so pmd exiting won't end the QEMU side socket connection.
> >
> > Issues:
> > Suppose we have both the vhost and virtio-net set up, and vhost pmd
> > <-> virtio-net pmd communication works well. Now, vhost pmd exits
> > (virtio-net pmd is still there). Some time later, we re-run vhost pmd,
> > the vhost pmd doesn't know the virtqueue addresses of the virtio-net
> > pmd, unless the virtio-net pmd reloads to start the 2nd phase of the
> > vhost-user protocol. So the second run of the vhost pmd won't work.
>=20
> This isn't a problem for virtio-vhost-user since the vhost-pmd resets the
> virtio-vhost-user device when it restarts.  The vhost-user AF_UNIX socket
> reconnects and negotiation restarts.

I'm not sure if you've agreed that vhost-user negotiation is split into two=
 phases as described above. If not, it's also not difficult to check, thank=
s to the RTE_LOG put at the vhost_user_msg_handler:
RTE_LOG(INFO, VHOST_CONFIG, "read message %s\n",
                        vhost_message_str[msg.request.master]);
It tells us what messages are received and when they are received.=20

Before trying the virtio-vhost-user setup, please make sure the virtio-net =
side VM doesn't have the virtio-net kernel driver loaded (blacklist the mod=
ule or disable it in .config).
VM1: the VM with virtio-vhost-user
VM2: the VM with virtio-net

1) After we boot VM1 and the virtio-vhost-user pmd, we boot VM2, and we wil=
l see the following log in VM1:
VHOST_CONFIG: new device, handle is 0
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_GET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_GET_QUEUE_NUM
VHOST_CONFIG: read message VHOST_USER_SET_OWNER
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:0 file:-1
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:1 file:-1

Those messages are what I called phase1 negotiation. They are negotiated wh=
en the AF_UNIX socket connects.

2) Then in VM2 we load the virtio-net pmd, we will see phase2 messages show=
ing up in VM1, like:
VHOST_CONFIG: read message VHOST_USER_SET_VRING_NUM
VHOST_CONFIG: read message VHOST_USER_SET_VRING_BASE
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ADDR
...
Those messages are sent to virtio-vhost-user only when the VM2's virtio-net=
 pmd loads.

AF_UNIX socket reconnection only triggers phase1 negotiation. If virtio-net=
 pmd in VM2 doesn't reload, virtio-vhost-user pmd won't get the above phase=
2 messages. Do you agree with the issue?

Best,
Wei=20
