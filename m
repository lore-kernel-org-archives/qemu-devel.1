Received: from eggs.gnu.org ([209.51.188.92]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h1R6v-0006ph-Bm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h1R6t-0006eV-LQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:37:05 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2424 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h1R6t-0006E8-9u
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 02:37:03 -0500
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Wed, 6 Mar 2019 07:36:44 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA394A7DF@dggeml529-mbx.china.huawei.com>
References: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
	<20190304213517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190304213517-mutt-send-email-mst@kernel.org>
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

Thanks a lot for your advice.

Maybe there are two methods to add this option:
1) Firstly, add a vhost-user protocol feature to tell Qemu if hide the disc=
onnects from the guest.  Here we just need the backend such as dpdk vhostus=
er to support this option and the feature.
2) Secondly, add a VM XML vhost-user nic configuration parameters for Qemu.=
  This method need more modification and other components such as Libvirt a=
nd Nova in openstack to configure it.

I'd like to choose the first method,  Do you think so?  =20

To monitor the status of connection, we can using the command " virsh qemu-=
monitor-command vm1 --hmp info chardev " to lookup that status. Another one=
 is to add new type event for Qemu to notify libvirt or other upper level c=
omponents.

Jerry

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, March 05, 2019 10:39 AM
> To: Lilijun (Jerry, Cloud Networking) <jerry.lilijun@huawei.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Liujinsong (Paul)
> <liu.jinsong@huawei.com>; lixiao (H) <lixiao91@huawei.com>; wangyunjian
> <wangyunjian@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: Re: Question about VM virtio device's link down delay when vhost=
-
> user reconnect
>=20
> On Mon, Mar 04, 2019 at 11:46:32AM +0000, Lilijun (Jerry, Cloud Networkin=
g)
> wrote:
> > Hi all,
> >
> >       I am running my VM using vhost-user NIC with OVS-DPDK.  The steps=
 of
> my question is shown as follows:
> >      1) In the VM, I add one route entry manually on the vNIC eth0 usin=
g
> "route add default gw 192.168.1.2".
> >      2) If openvswitch service was restarted, or the process ovs-vswitc=
hd was
> aborted, the new process may be started successfully after long seconds
> such as 40s for the initialization of DPDK huge page memory.
> >      3) And Qemu's vhost-user closed the connection and reconnected
> successfully after 40s.
> >      4) Here VM's vNIC will receive link down and up events, the interv=
al
> between the two events is about 40s.
> >      5) Then I found that route entry disappeared unexpectedly. This wi=
ll
> cause some network traffic problems.
> >
> >      I have an idea about this problem. We can add a parameter "
> link_down_delay" for all virtio devices that use vhost-user socket such a=
s
> virtio-net and virtio-blk.
> >
> >     If vhost-user socket get a connection closed event when the backend
> process was aborted or restarted, we don't notify VM virtio-net device li=
nk
> down right now.
> >    When the vhost-user backend recover this socket's connections before
> the time of "link_down_delay" ms passed, we need not do that link down
> notification to VM.
> >    Or else, if that's timeout, VM can be notified the link down event a=
s
> before.
> >
> >     Is there any other opinions about this solution?  Or some better id=
eas?
> Thanks.
> >
> > B.R.
> >
> > Jerry
> >
>=20
> Rather than hardcode a specific timeout policy, I would go further and st=
art
> with an option to just hide disconnects from guest completely.
> Instead add commands to monitor status of connection and events to report
> changes.  Management tools can then mirror connection status to link if t=
hey
> want to.
>=20
> --
> MST
