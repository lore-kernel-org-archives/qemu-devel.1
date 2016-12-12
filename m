Received: from eggs.gnu.org ([2001:4830:134:3::10]:52474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGTmV-0000W9-SE
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGTmR-0001iC-DC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGTmR-0001hz-6o
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:48:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20161209203954.GW4027@thinpad.lan.raisama.net>
Date: Mon, 12 Dec 2016 17:48:43 +0100
In-Reply-To: <20161209203954.GW4027@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Fri, 9 Dec 2016 18:39:54 -0200")
Message-ID: <8760mp14b8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Using latest qemu.git master:
>
>   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
>   QEMU 2.7.93 monitor - type 'help' for more information
>   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
>   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
>   Segmentation fault (core dumped)

Bisected to

commit 3f1e1478db2d67098d98f2c3acf5a4946b7fb643
Author: Cao jin <caoj.fnst@cn.fujitsu.com>
Date:   Wed Oct 28 14:20:31 2015 +0800

    enable multi-function hot-add
    
    Enable PCIe device multi-function hot-add, just ensure function 0 is added
    last, then driver will get the notification to scan the slot.
    
    Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

It's in v2.5.0, probably no need to hold the release for a fix.
