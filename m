Received: from eggs.gnu.org ([2001:4830:134:3::10]:47370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fI6k8-0006dK-TE
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fI6k1-0003ie-C9
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:13:54 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fI6k1-0003hf-26
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:13:49 -0400
Received: by mail-it0-x235.google.com with SMTP id n64-v6so8754841itb.3
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 23:13:48 -0700 (PDT)
References: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a9e4b70d-8f5e-c486-9c55-2d619490070b@ozlabs.ru>
Date: Mon, 14 May 2018 16:13:41 +1000
MIME-Version: 1.0
In-Reply-To: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ping latency issue on passthrough guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhu Yijun <lovemrd@gmail.com>, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 11/5/18 5:20 pm, Zhu Yijun wrote:
> Hi all,
> 
>   I booted two sr-iov guests using KVM-VFIO and pinged each other with
> no-load one night. I found that most of the latency was little than 0.1ms,
> but several icmp_seq greater than 10ms, even up to 1000ms;
> 
[...]
> 
>    VF used by these two guest from same port(eth0) of intel X710 Ethernet
> controller. By contrast, I selected another two VFs and set them to
> separate network namespace, this issue did not exits, all the latency
> litter than 0.2ms.
> 
>    Advised by other guys, I disabled the BIOS C-State, set cpu power to
> "performance", add kernel parameter "idle=poll, pcie_aspm=off", but it
> makes no sense.
> 
>    I think it may be not the hardware issue, but may relate to KVM
> hypervisor or guest kernel. As a result, I reported here, any advice and
> suggestions will be greatly appreciated.


I'd suggest trying the exact same VFs on the host and make sure:

1) trafic is actually going through the physical device and not routed by
the host kernel (because the ip addresses on VFs are on the same network,
etc, ifconfig's statistic should tell). I use a script like this to do the
setup:

===
# !/bin/bash

function cfg_run() {
        echo cfg and run: $*
        IP0=$1
        IP1=$2
        ETH0=$3
        ETH1=$4
        BASENUM=$5
        ip addr add $IP0/24 dev $ETH0
        ip addr add $IP1/24 dev $ETH1
        ip link set $ETH0 up
        ip link set $ETH1 up
        ip link set $ETH0 mtu 9000
        ip link set $ETH1 mtu 9000
        ip rule add priority $(expr $BASENUM + 10 ) from all to $IP0 lookup
$(expr $BASENUM + 10 )
        ip rule add priority $(expr $BASENUM + 20 ) from all to $IP1 lookup
$(expr $BASENUM + 20 )
        ip route add table $(expr $BASENUM + 10 ) default dev $ETH0 scope link
        ip route add table $(expr $BASENUM + 20 ) default dev $ETH1 scope link
        ip rule add priority $BASENUM from all iif $ETH0 lookup local
        ip rule add priority $BASENUM from all iif $ETH1 lookup local
        ip rule add priority $(expr 20000 + $BASENUM ) from all lookup local
        ip rule del priority 0 from all lookup local
        ip addr
}
cfg_run 172.12.0.1 172.12.1.1 enp1s0f0 enp1s0f1 100
===

2) distro for the host host and the guest.

Also you can kill the irqbalance daemon (I doubt it will make such a
difference though).

Is the ethernet cable needed for the test? How do you know if the outer
network is not the problem?

What is your guest doing other than pinging? Any chance it might start
swapping sometime? 4GB of RAM is not extraordinary huge amount for a
gui-enabled linux system.



-- 
Alexey
