Received: from eggs.gnu.org ([2001:4830:134:3::10]:54897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9QuL-0000AQ-Ew
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9QuI-0003tl-7o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 04:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g9QuH-0003sw-W0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 04:28:50 -0400
Date: Mon, 8 Oct 2018 10:28:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181008102846.3ce9c912@redhat.com>
In-Reply-To: <CAKPgXcF575pf+dizFKjV1PrQo6tfbdwd+AA72a=kbcxdTcKCmA@mail.gmail.com>
References: <CAKPgXcHEVrW7a5WqcoPn6X8=-j07K3yvXo4sjYJKNonYd2asQw@mail.gmail.com>
	<20181004132026.39c002ab@redhat.com>
	<CAKPgXcF575pf+dizFKjV1PrQo6tfbdwd+AA72a=kbcxdTcKCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 7 Oct 2018 12:52:11 +0300
Sameeh Jubran <sameeh@daynix.com> wrote:

> This is the command line. All of the devices are wired to pci.0, there is
> no pci bridge.
> 
> According to this,  Integrated Endpoints are not hot-pluggable. However I
> can still use device_del to delete a device and device_add to add e1000
> with no issues.
> https://github.com/qemu/qemu/blob/master/docs/pcie.txt#L37
Your CLI is using default 'pc' machine so it's conventional PCI (not PCI-E),
with that CLI for a device plugged into pci.0 bus you should get piix4_pm as
hotplug handler (ACPI is used on pci.0 as default).
To troubleshoot your issue, you might look at code that's
using following symbols:

  use_acpi_pci_hotplug
  piix4_update_bus_hotplug
  piix4_device_plug_cb
  piix4_device_unplug_request_cb

> 
> qemu-system-x86_64 \
> -device
> e1000,netdev=hostnet0,mac=56:cc:c1:01:cc:21,id=cc1_71,primary=cc1_72 \
> -netdev
> tap,vhost=on,id=hostnet1,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_72,queues=4
> \
> -device
> virtio-net,host_mtu=1500,netdev=hostnet1,mac=56:cc:c1:04:2c:21,id=cc1_72,vectors=10,mq=on,standby=cc1_71
> \
> -netdev
> tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=cc1_71
> \
> -enable-kvm \
> -name netkvm \
> -m 1000M \
> -snapshot \
> -smp 4 \
> -drive file=windows_10_enterprise_x64_netkvm_dev.qcow2,if=ide,id=drivex \
> -global PIIX4_PM.disable_s3=0 \
> -global PIIX4_PM.disable_s4=0 \
> -usbdevice tablet \
> -vga qxl \
> -spice port=6110,disable-ticketing \
> -device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x7
> \
> -chardev spicevmc,name=vdagent,id=vdagent \
> -device
> virtserialport,nr=1,bus=virtio-serial0.0,chardev=vdagent,name=com.redhat.spice.0
> \
> -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
> -device virtio-serial \
> -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
> -monitor stdio
> 
> 
> On Thu, Oct 4, 2018 at 2:20 PM Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 3 Oct 2018 19:50:58 +0300
> > Sameeh Jubran <sameeh@daynix.com> wrote:
> >  
> > > Hi all,
> > >
> > > I am trying to get the hotplug handler of a pci device in Qemu using
> > > "qdev_get_hotplug_handler" function. This function simply tries to get
> > > the hotplug handler from the parent bus. For some reason it's always
> > > null. Why it is not initialized?
> > >
> > > Thanks!
> > >  
> >
> > what's used qemu command line?
> >  
> 
> 
