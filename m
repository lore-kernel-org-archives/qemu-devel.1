Received: from eggs.gnu.org ([209.51.188.92]:42827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h0m3q-0003ZI-1K
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h0m3o-0006rE-EU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:47:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2423 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h0m3o-0006kU-2d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 06:47:08 -0500
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Mon, 4 Mar 2019 11:46:32 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Question about VM virtio device's link down delay when
 vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>, wangyunjian <wangyunjian@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi all,

      I am running my VM using vhost-user NIC with OVS-DPDK.  The steps of =
my question is shown as follows:
     1) In the VM, I add one route entry manually on the vNIC eth0 using "r=
oute add default gw 192.168.1.2".=20
     2) If openvswitch service was restarted, or the process ovs-vswitchd w=
as aborted, the new process may be started successfully after long seconds =
such as 40s for the initialization of DPDK huge page memory.
     3) And Qemu's vhost-user closed the connection and reconnected success=
fully after 40s. =20
     4) Here VM's vNIC will receive link down and up events, the interval b=
etween the two events is about 40s.
     5) Then I found that route entry disappeared unexpectedly. This will c=
ause some network traffic problems.

     I have an idea about this problem. We can add a parameter " link_down_=
delay" for all virtio devices that use vhost-user socket such as virtio-net=
 and virtio-blk.=20

    If vhost-user socket get a connection closed event when the backend pro=
cess was aborted or restarted, we don't notify VM virtio-net device link do=
wn right now.
   When the vhost-user backend recover this socket's connections before the=
 time of "link_down_delay" ms passed, we need not do that link down notific=
ation to VM.
   Or else, if that's timeout, VM can be notified the link down event as be=
fore.

    Is there any other opinions about this solution?  Or some better ideas?=
 Thanks.

B.R.

Jerry
