Received: from eggs.gnu.org ([2001:4830:134:3::10]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fO040-000350-0J
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fO03s-0003Mh-Uy
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:18:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fO03s-0003MT-Ly
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51E0240201A0
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 12:18:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 May 2018 14:18:37 +0200
Message-Id: <1527682717-26391-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post about the new -nic
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

QEMU v2.12 features a new, useful parameter called "-nic". Let's
throw some light on this new parameter with a new blog post.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _posts/2018-05-30-nic-parameter.md         | 126 +++++++++++++++++++++++++++++
 screenshots/2018-05-30-qemu-cli-net.png    | Bin 0 -> 24020 bytes
 screenshots/2018-05-30-qemu-cli-netdev.png | Bin 0 -> 13553 bytes
 3 files changed, 126 insertions(+)
 create mode 100644 _posts/2018-05-30-nic-parameter.md
 create mode 100644 screenshots/2018-05-30-qemu-cli-net.png
 create mode 100644 screenshots/2018-05-30-qemu-cli-netdev.png

diff --git a/_posts/2018-05-30-nic-parameter.md b/_posts/2018-05-30-nic-parameter.md
new file mode 100644
index 0000000..787575f
--- /dev/null
+++ b/_posts/2018-05-30-nic-parameter.md
@@ -0,0 +1,126 @@
+---
+layout: post
+title:  "QEMU's new -nic command line parameter"
+date:   2018-05-30 14:00:00 +0200
+author: Thomas Huth
+categories: [features, parameters, 'qemu 2.12']
+---
+QEMU v2.12 has a new command line parameter, the `-nic` parameter, which can
+be used to configure a network connection for the guest quite easily, since
+it sets up both, the guest NIC and the host network backend in one go.
+If you've read the
+[ChangeLog of QEMU v2.12](https://wiki.qemu.org/ChangeLog/2.12) or the current
+[documentation of QEMU](https://qemu.weilnetz.de/doc/qemu-doc.html)
+you might already have spotted this new `-nic` parameter, and maybe you've
+thought "Why yet another parameter for configuring the network?". To answer
+that question, we've got to have look at the basics and other options first. 
+To configure a network interface for a guest, you've got to consider two
+sides:
+
+1. The emulated hardware that the guest sees, i.e. the so-called NIC (network
+interface controller). On systems that support PCI cards, these typically
+could be an e1000 network card, a rtl8139 network card or a virtio-net device.
+
+2. The network backend on the host side, i.e. the interface that QEMU uses
+to exchange network packets with the outside (like other QEMU instances
+or other real hosts in your intranet or in the internet). The common host
+backends are the "user" (a.k.a. SLIRP) backend which provides access to
+the host's network via NAT, the "tap" backend which allows the guest to
+directly access the host's network, or the "socket" backend which can be
+used to connect multiple QEMU instances to simulate a shared network for
+the their guests.
+
+The legacy -net option
+----------------------
+
+QEMU's initial way of configuring the network for the guest was the `-net`
+option. The emulated NIC hardware can be chosen with the
+`-net nic,model=xyz,...` parameter, and the host backend with the
+`-net <backend>,...` parameter (e.g. `-net user` for the SLIRP backend).
+The emulated NIC and the host backend are not directly connected here, but
+via an emulated hub (called "vlan" in QEMU), so if you start QEMU with
+`-net nic,model=e1000 -net user -net nic,model=virtio -net tap` for example,
+you get a setup where all the NICs and host backends are connected together
+via a hub:
+
+![Networking with -net](/screenshots/2018-05-30-qemu-cli-net.png)
+
+That means the e1000 NIC also gets the network traffic from the virtio-net
+NIC and both host backends... this is probably not what the user expected,
+who likely wanted to have two separate network connections instead. To achieve
+this with the `-net` parameter, you've got to use the "vlan" option instead,
+for example `-net nic,model=e1000,vlan=0 -net user,vlan=0
+-net nic,model=virtio,vlan=1 -net tap,vlan=1` moves the virtio-net NIC
+and the "tap" backend to another hub (with ID #1). Please note that the
+"vlan" option will be dropped in QEMU v3.0 since the term was rather
+[confusing](https://bugs.launchpad.net/qemu/+bug/658904) (it's not related
+to IEEE 802.1Q for example) and caused a lot of misconfigurations in the past.
+
+The modern -netdev option
+-------------------------
+
+Beside the confusing "vlan" option of the `-net` parameter, there is one
+more major drawback with that legacy option: Since you always get the
+emulated hub here inbetween to which multiple NICs and host backends could be
+attached, you can not use this concept for situations where the NIC frontend
+has to work very closely together with the host backend, e.g. when you want
+to use vhost acceleration for virtio-net.
+
+To configure a network connection where the emulated NIC is directly connected
+to a host network backend without a hub inbetween, you've got to use the
+`-netdev` option for the backend, together with `-device` for the guest NIC
+hardware. Assuming that you want to configure the same devices as in the
+`-net` example above, you could use `-netdev user,id=n1 -device e1000,netdev=n1
+-netdev tap,id=n2 -device virtio-net,netdev=n2` for example. This will give you
+straight 1:1 connections between the NICs and the host backends:
+
+![Networking with -netdev](/screenshots/2018-05-30-qemu-cli-netdev.png)
+
+Note that you can also still connect the devices to a hub with the special
+`-netdev hubport` backend, but in most of the normal use cases, the use
+of a hub is not required anymore.
+
+Now while `-netdev` together with `-device` provide a very flexible and
+extensive way to configure a network connection, there are still two
+drawbacks with this option pair which prevented us from deprecating the
+legacy `-net` parameter completely:
+
+1. The `-device` parameter can only be used for pluggable NICs. Boards
+(e.g. embedded boards) which feature an on-board NIC can not be configured
+with `-device` yet, so `-net nic` must be used here instead.
+
+2. In some cases, the `-net` parameter is easier to use (less to type).
+For example, assuming you want to set up a "tap" network connection and
+you've got the default scripts /etc/qemu-ifup and -down already in place,
+it's enough to type `-net nic -net tap` to start your guest. To do the
+same with `-netdev`, you always got to specify an ID here, too, for
+example like this: `-netdev tap,id=n1 -device e1000,netdev=n1`.
+
+The new -nic option
+-------------------
+
+Looking at the disadvantages listed above, it should be clear that there
+is a need for a convenience option that is
+
+ * easier to use (i.e. less to type) than `-netdev <backend>,id=<id>
+  -device <dev>,netdev=<id>`
+ * can be used to configure on-board / non-pluggable NICs, too
+ * does not use a hub between the NIC and the host backend.
+
+This is where the new `-nic` option kicks in: This option can be used
+to configure both, the guest's NIC hardware and the host backend in
+one go. For example, instead of `-netdev tap,id=n1 -device e1000,netdev=n1`
+you can simply type `-nic tap,model=e1000`. If you don't care about the
+exact NIC model type, you can even omit the `model=...` option and type
+`-nic tap`. This is even shorter and more convenient than the previous
+shortest way of typing `-net nic -net tap`. To get a list of NIC models
+that you can use with this option, you can simply run QEMU with
+`-nic model=help`.
+
+Beside being easier to use, the `-nic` option can be used to configure
+on-board NICs, too (just like the `-net` option). For machines that have
+on-board NICs, the first `-nic` parameter configures the first on-board NIC,
+the second `-nic` parameter configures the second on-board NIC, and so forth.
+You obviously have got to omit the `model=...` option from the `-nic`
+parameter in this case, though (or use the right model name of the on-board
+NIC).
diff --git a/screenshots/2018-05-30-qemu-cli-net.png b/screenshots/2018-05-30-qemu-cli-net.png
new file mode 100644
index 0000000000000000000000000000000000000000..32f05da022528c78ac6e11f59e7e4fae3b93200b
GIT binary patch
literal 24020
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

literal 0
HcmV?d00001

diff --git a/screenshots/2018-05-30-qemu-cli-netdev.png b/screenshots/2018-05-30-qemu-cli-netdev.png
new file mode 100644
index 0000000000000000000000000000000000000000..96589304b4e7afa3b9d29bfa4bc7f4392a1689fe
GIT binary patch
literal 13553
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

literal 0
HcmV?d00001

-- 
1.8.3.1
