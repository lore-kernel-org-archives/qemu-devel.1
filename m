Received: from eggs.gnu.org ([209.51.188.92]:45652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h24i2-00038F-OK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h24i1-0000wd-BA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:54:02 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:34214 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h24hx-0000Vw-3U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:53:57 -0500
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Fri, 8 Mar 2019 01:53:28 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA394CCDA@dggeml529-mbx.china.huawei.com>
References: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
	<20190304213517-mutt-send-email-mst@kernel.org>
	<40280F65B1B0B44E8089ED31C01616EBA394A7DF@dggeml529-mbx.china.huawei.com>
	<20190306090412-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190306090412-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Question about VM virtio device's link down delay
 when vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>, wangyunjian <wangyunjian@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
>=20
> On Wed, Mar 06, 2019 at 07:36:44AM +0000, Lilijun (Jerry, Cloud Networkin=
g)
> wrote:
> > Thanks a lot for your advice.
> >
> > Maybe there are two methods to add this option:
> > 1) Firstly, add a vhost-user protocol feature to tell Qemu if hide the
> disconnects from the guest.  Here we just need the backend such as dpdk
> vhostuser to support this option and the feature.
> > 2) Secondly, add a VM XML vhost-user nic configuration parameters for
> Qemu.  This method need more modification and other components such as
> Libvirt and Nova in openstack to configure it.
> >
> > I'd like to choose the first method,  Do you think so?
>=20
> What we need to decide this is - when is it a good idea to down the link =
on
> disconnect.
> If it depends on vm configuration then it belongs with qemu.
> If it depends on hardware or other host configuration it might belong wit=
h
> the backend.
>=20

In my opinion, the vhost-user disconnects is related with the host backend =
process's restart or other socket close.

So, we can add a host configuration such as ovs/dpdk  vhostuser interface's=
 options(ovs-vsctl set interface) to tell Qemu hide the disconnects by vhos=
tuser protocol feature negotiation.

Thanks

>=20
>=20
> > To monitor the status of connection, we can using the command " virsh
> qemu-monitor-command vm1 --hmp info chardev " to lookup that status.
> Another one is to add new type event for Qemu to notify libvirt or other
> upper level components.
> >
> > Jerry
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Tuesday, March 05, 2019 10:39 AM
> > > To: Lilijun (Jerry, Cloud Networking) <jerry.lilijun@huawei.com>
> > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Liujinsong (Paul)
> > > <liu.jinsong@huawei.com>; lixiao (H) <lixiao91@huawei.com>;
> > > wangyunjian <wangyunjian@huawei.com>; wangxin (U)
> > > <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> > > <arei.gonglei@huawei.com>
> > > Subject: Re: Question about VM virtio device's link down delay when
> > > vhost- user reconnect
> > >
> > > On Mon, Mar 04, 2019 at 11:46:32AM +0000, Lilijun (Jerry, Cloud
> > > Networking)
> > > wrote:
> > > > Hi all,
> > > >
> > > >       I am running my VM using vhost-user NIC with OVS-DPDK.  The
> > > > steps of
> > > my question is shown as follows:
> > > >      1) In the VM, I add one route entry manually on the vNIC eth0
> > > > using
> > > "route add default gw 192.168.1.2".
> > > >      2) If openvswitch service was restarted, or the process
> > > > ovs-vswitchd was
> > > aborted, the new process may be started successfully after long
> > > seconds such as 40s for the initialization of DPDK huge page memory.
> > > >      3) And Qemu's vhost-user closed the connection and
> > > > reconnected
> > > successfully after 40s.
> > > >      4) Here VM's vNIC will receive link down and up events, the
> > > > interval
> > > between the two events is about 40s.
> > > >      5) Then I found that route entry disappeared unexpectedly.
> > > > This will
> > > cause some network traffic problems.
> > > >
> > > >      I have an idea about this problem. We can add a parameter "
> > > link_down_delay" for all virtio devices that use vhost-user socket
> > > such as virtio-net and virtio-blk.
> > > >
> > > >     If vhost-user socket get a connection closed event when the
> > > > backend
> > > process was aborted or restarted, we don't notify VM virtio-net
> > > device link down right now.
> > > >    When the vhost-user backend recover this socket's connections
> > > > before
> > > the time of "link_down_delay" ms passed, we need not do that link
> > > down notification to VM.
> > > >    Or else, if that's timeout, VM can be notified the link down
> > > > event as
> > > before.
> > > >
> > > >     Is there any other opinions about this solution?  Or some bette=
r ideas?
> > > Thanks.
> > > >
> > > > B.R.
> > > >
> > > > Jerry
> > > >
> > >
> > > Rather than hardcode a specific timeout policy, I would go further
> > > and start with an option to just hide disconnects from guest complete=
ly.
> > > Instead add commands to monitor status of connection and events to
> > > report changes.  Management tools can then mirror connection status
> > > to link if they want to.
> > >
> > > --
> > > MST
