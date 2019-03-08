Received: from eggs.gnu.org ([209.51.188.92]:51530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h24nx-0007Zu-Bo
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h24nw-0000f4-33
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:00:09 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h24nu-0000ak-RE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:00:07 -0500
Received: by mail-qt1-f170.google.com with SMTP id z39so19624675qtz.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 18:00:05 -0800 (PST)
Date: Thu, 7 Mar 2019 21:00:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190307205429-mutt-send-email-mst@kernel.org>
References: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
	<20190304213517-mutt-send-email-mst@kernel.org>
	<40280F65B1B0B44E8089ED31C01616EBA394A7DF@dggeml529-mbx.china.huawei.com>
	<20190306090412-mutt-send-email-mst@kernel.org>
	<40280F65B1B0B44E8089ED31C01616EBA394CCDA@dggeml529-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40280F65B1B0B44E8089ED31C01616EBA394CCDA@dggeml529-mbx.china.huawei.com>
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
To: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>, wangyunjian <wangyunjian@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Fri, Mar 08, 2019 at 01:53:28AM +0000, Lilijun (Jerry, Cloud Networking) wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > 
> > On Wed, Mar 06, 2019 at 07:36:44AM +0000, Lilijun (Jerry, Cloud Networking)
> > wrote:
> > > Thanks a lot for your advice.
> > >
> > > Maybe there are two methods to add this option:
> > > 1) Firstly, add a vhost-user protocol feature to tell Qemu if hide the
> > disconnects from the guest.  Here we just need the backend such as dpdk
> > vhostuser to support this option and the feature.
> > > 2) Secondly, add a VM XML vhost-user nic configuration parameters for
> > Qemu.  This method need more modification and other components such as
> > Libvirt and Nova in openstack to configure it.
> > >
> > > I'd like to choose the first method,  Do you think so?
> > 
> > What we need to decide this is - when is it a good idea to down the link on
> > disconnect.
> > If it depends on vm configuration then it belongs with qemu.
> > If it depends on hardware or other host configuration it might belong with
> > the backend.
> > 
> 
> In my opinion, the vhost-user disconnects is related with the host backend process's restart or other socket close.

Right.

> So, we can add a host configuration such as ovs/dpdk  vhostuser interface's options(ovs-vsctl set interface) to tell Qemu hide the disconnects by vhostuser protocol feature negotiation.
> 
> Thanks

In that case it seems that what we want is actually a set of
commands for signalling link down events to qemu.
Then backend can signal link down before shutdown,
if it does not then if command is supported we can assume backend
is restarted. If command not supported - we assume legacy
backend and behave in a compatible way (i.e. do not drop link).


> > 
> > 
> > > To monitor the status of connection, we can using the command " virsh
> > qemu-monitor-command vm1 --hmp info chardev " to lookup that status.
> > Another one is to add new type event for Qemu to notify libvirt or other
> > upper level components.
> > >
> > > Jerry
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Tuesday, March 05, 2019 10:39 AM
> > > > To: Lilijun (Jerry, Cloud Networking) <jerry.lilijun@huawei.com>
> > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Liujinsong (Paul)
> > > > <liu.jinsong@huawei.com>; lixiao (H) <lixiao91@huawei.com>;
> > > > wangyunjian <wangyunjian@huawei.com>; wangxin (U)
> > > > <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> > > > <arei.gonglei@huawei.com>
> > > > Subject: Re: Question about VM virtio device's link down delay when
> > > > vhost- user reconnect
> > > >
> > > > On Mon, Mar 04, 2019 at 11:46:32AM +0000, Lilijun (Jerry, Cloud
> > > > Networking)
> > > > wrote:
> > > > > Hi all,
> > > > >
> > > > >       I am running my VM using vhost-user NIC with OVS-DPDK.  The
> > > > > steps of
> > > > my question is shown as follows:
> > > > >      1) In the VM, I add one route entry manually on the vNIC eth0
> > > > > using
> > > > "route add default gw 192.168.1.2".
> > > > >      2) If openvswitch service was restarted, or the process
> > > > > ovs-vswitchd was
> > > > aborted, the new process may be started successfully after long
> > > > seconds such as 40s for the initialization of DPDK huge page memory.
> > > > >      3) And Qemu's vhost-user closed the connection and
> > > > > reconnected
> > > > successfully after 40s.
> > > > >      4) Here VM's vNIC will receive link down and up events, the
> > > > > interval
> > > > between the two events is about 40s.
> > > > >      5) Then I found that route entry disappeared unexpectedly.
> > > > > This will
> > > > cause some network traffic problems.
> > > > >
> > > > >      I have an idea about this problem. We can add a parameter "
> > > > link_down_delay" for all virtio devices that use vhost-user socket
> > > > such as virtio-net and virtio-blk.
> > > > >
> > > > >     If vhost-user socket get a connection closed event when the
> > > > > backend
> > > > process was aborted or restarted, we don't notify VM virtio-net
> > > > device link down right now.
> > > > >    When the vhost-user backend recover this socket's connections
> > > > > before
> > > > the time of "link_down_delay" ms passed, we need not do that link
> > > > down notification to VM.
> > > > >    Or else, if that's timeout, VM can be notified the link down
> > > > > event as
> > > > before.
> > > > >
> > > > >     Is there any other opinions about this solution?  Or some better ideas?
> > > > Thanks.
> > > > >
> > > > > B.R.
> > > > >
> > > > > Jerry
> > > > >
> > > >
> > > > Rather than hardcode a specific timeout policy, I would go further
> > > > and start with an option to just hide disconnects from guest completely.
> > > > Instead add commands to monitor status of connection and events to
> > > > report changes.  Management tools can then mirror connection status
> > > > to link if they want to.
> > > >
> > > > --
> > > > MST
