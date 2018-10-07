Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g95jh-0003Jf-HF
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g95jf-0007HB-99
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:52:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:41825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1g95jd-00076j-TV
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:52:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id x31-v6so376960edd.8
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 02:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPgXcHEVrW7a5WqcoPn6X8=-j07K3yvXo4sjYJKNonYd2asQw@mail.gmail.com>
	<20181004132026.39c002ab@redhat.com>
In-Reply-To: <20181004132026.39c002ab@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 7 Oct 2018 12:52:11 +0300
Message-ID: <CAKPgXcF575pf+dizFKjV1PrQo6tfbdwd+AA72a=kbcxdTcKCmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is the command line. All of the devices are wired to pci.0, there is
no pci bridge.

According to this,  Integrated Endpoints are not hot-pluggable. However I
can still use device_del to delete a device and device_add to add e1000
with no issues.
https://github.com/qemu/qemu/blob/master/docs/pcie.txt#L37

qemu-system-x86_64 \
-device
e1000,netdev=hostnet0,mac=56:cc:c1:01:cc:21,id=cc1_71,primary=cc1_72 \
-netdev
tap,vhost=on,id=hostnet1,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_72,queues=4
\
-device
virtio-net,host_mtu=1500,netdev=hostnet1,mac=56:cc:c1:04:2c:21,id=cc1_72,vectors=10,mq=on,standby=cc1_71
\
-netdev
tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_71
\
-enable-kvm \
-name netkvm \
-m 1000M \
-snapshot \
-smp 4 \
-drive file=windows_10_enterprise_x64_netkvm_dev.qcow2,if=ide,id=drivex \
-global PIIX4_PM.disable_s3=0 \
-global PIIX4_PM.disable_s4=0 \
-usbdevice tablet \
-vga qxl \
-spice port=6110,disable-ticketing \
-device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x7
\
-chardev spicevmc,name=vdagent,id=vdagent \
-device
virtserialport,nr=1,bus=virtio-serial0.0,chardev=vdagent,name=com.redhat.spice.0
\
-chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
-device virtio-serial \
-device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
-monitor stdio


On Thu, Oct 4, 2018 at 2:20 PM Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 3 Oct 2018 19:50:58 +0300
> Sameeh Jubran <sameeh@daynix.com> wrote:
>
> > Hi all,
> >
> > I am trying to get the hotplug handler of a pci device in Qemu using
> > "qdev_get_hotplug_handler" function. This function simply tries to get
> > the hotplug handler from the parent bus. For some reason it's always
> > null. Why it is not initialized?
> >
> > Thanks!
> >
>
> what's used qemu command line?
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
