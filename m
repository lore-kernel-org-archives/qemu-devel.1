Received: from eggs.gnu.org ([209.51.188.92]:60320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0zzE-0005Dd-JW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h0zzD-0002ak-Pa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:39:20 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h0zzD-0002ZY-Kw
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:39:19 -0500
Received: by mail-qt1-f170.google.com with SMTP id d2so7483602qti.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 18:39:18 -0800 (PST)
Date: Mon, 4 Mar 2019 21:39:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190304213517-mutt-send-email-mst@kernel.org>
References: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40280F65B1B0B44E8089ED31C01616EBA3947E6A@dggeml529-mbx.china.huawei.com>
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

On Mon, Mar 04, 2019 at 11:46:32AM +0000, Lilijun (Jerry, Cloud Networking) wrote:
> Hi all,
> 
>       I am running my VM using vhost-user NIC with OVS-DPDK.  The steps of my question is shown as follows:
>      1) In the VM, I add one route entry manually on the vNIC eth0 using "route add default gw 192.168.1.2". 
>      2) If openvswitch service was restarted, or the process ovs-vswitchd was aborted, the new process may be started successfully after long seconds such as 40s for the initialization of DPDK huge page memory.
>      3) And Qemu's vhost-user closed the connection and reconnected successfully after 40s.  
>      4) Here VM's vNIC will receive link down and up events, the interval between the two events is about 40s.
>      5) Then I found that route entry disappeared unexpectedly. This will cause some network traffic problems.
> 
>      I have an idea about this problem. We can add a parameter " link_down_delay" for all virtio devices that use vhost-user socket such as virtio-net and virtio-blk. 
> 
>     If vhost-user socket get a connection closed event when the backend process was aborted or restarted, we don't notify VM virtio-net device link down right now.
>    When the vhost-user backend recover this socket's connections before the time of "link_down_delay" ms passed, we need not do that link down notification to VM.
>    Or else, if that's timeout, VM can be notified the link down event as before.
> 
>     Is there any other opinions about this solution?  Or some better ideas? Thanks.
> 
> B.R.
> 
> Jerry
> 

Rather than hardcode a specific timeout policy, I would go further and
start with an option to just hide disconnects from guest completely.
Instead add commands to monitor status of connection and events to
report changes.  Management tools can then mirror connection status to
link if they want to.

-- 
MST
