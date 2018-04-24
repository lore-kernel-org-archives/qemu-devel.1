Received: from eggs.gnu.org ([2001:4830:134:3::10]:59413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAz58-0006CH-F3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAz52-00019C-C2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:38:10 -0400
Date: Tue, 24 Apr 2018 16:37:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180424163751.7a288803.cohuck@redhat.com>
In-Reply-To: <6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
	<d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
	<87f6ba73-2ded-06f2-c68f-d8ef4be50edf@redhat.com>
	<20180424160911.22a238bb.cohuck@redhat.com>
	<6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 24 Apr 2018 16:22:26 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 24.04.2018 16:09, Cornelia Huck wrote:
> > On Tue, 24 Apr 2018 16:02:59 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 24.04.2018 13:49, Christian Borntraeger wrote:  
> >>>
> >>>
> >>> On 04/24/2018 01:44 PM, Thomas Huth wrote:    
> >>>> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
> >>>> with "-device" and "-chardev" so far. Other machines use the convenience
> >>>> option "-serial" to configure the default consoles, too, even for virtual
> >>>> consoles like spapr-vty on the pseries machine. So let's support this
> >>>> option on s390x, too, so we can easily enable the serial console here
> >>>> again with "-nodefaults", for example. Also map the second -serial
> >>>> option to the "sclplmconsole", so that there is now an easy way to
> >>>> configure this second console on s390x, too.
> >>>> Additionally, the new code is also smaller than the old one and we have
> >>>> less s390x-specific code in vl.c :-)    
> [...]
> >>> I read that as "the current command lines continue to work". Correct?    
> >>
> >> Right. I was a little bit afraid that this might break migration, but I
> >> gave it a quick check and it still seems to work fine here.
> >> "info qom-tree" and "info qtree" at the HMP monitor show slightly
> >> different output, though ... not sure whether that's critical or not?  
> > 
> > What looks different? If we still send/expect the same kind of
> > information, it should not have any impact, I guess.  
> 
> $ diff -u sclp-qtree-before.txt sclp-qtree-after.txt
> --- sclp-qtree-before.txt	2018-04-24 16:17:14.527921927 +0200
> +++ sclp-qtree-after.txt	2018-04-24 16:17:35.582877042 +0200
> @@ -62,6 +62,6 @@
>      bus: s390-sclp-events-bus.0
>        type s390-sclp-events-bus
>        dev: sclpconsole, id ""
> -        chardev = "sclpcon0"
> +        chardev = "serial0"
>        dev: sclp-cpu-hotplug, id ""
>        dev: sclpquiesce, id ""
> 
> ... i.e. just the label of the chardev changed. I think that's ok, and
> migration likely does not care about that.

Nod.

> 
> $ diff -u sclp-qom-tree-before.txt sclp-qom-tree-after.txt
> --- sclp-qom-tree-before.txt	2018-04-24 16:17:48.462849585 +0200
> +++ sclp-qom-tree-after.txt	2018-04-24 16:18:02.222820256 +0200
> @@ -1,13 +1,14 @@
> -(qemu) info qom-tree
> +(qemu) info qom-tree
>  /machine (s390-ccw-virtio-2.12-machine)
>    /unattached (container)
> -    /system[0] (qemu:memory-region)
>      /sysbus (System)
> -    /device[1] (virtio-net-ccw)
> +    /device[0] (qemu-s390x-cpu)
> +    /s390.ram[0] (qemu:memory-region)
> +    /device[1] (sclpconsole)
> +    /device[2] (virtio-net-ccw)
>        /virtio-backend (virtio-net-device)
>        /virtio-bus (virtio-ccw-bus)
> -    /s390.ram[0] (qemu:memory-region)
> -    /device[0] (qemu-s390x-cpu)
> +    /system[0] (qemu:memory-region)
>      /io[0] (qemu:memory-region)
>    /sclp (sclp)
>      /s390-sclp-event-facility (s390-sclp-event-facility)
> @@ -17,7 +18,6 @@
>    /s390-flic-qemu (s390-flic-qemu)
>    /s390-skeys (s390-skeys-qemu)
>    /peripheral-anon (container)
> -    /device[0] (sclpconsole)
>    /peripheral (container)
>    /s390-ipl (s390-ipl)
>    /virtual-css-bridge (virtual-css-bridge)
> 
> ... the sclpconsole now shows up under /unattached instead of
> /peripheral-anon ... does that matter? (I don't have a clue)

That's because the device is no longer created through
qdev_device_add(), which attaches it to peripheral-anon. Not sure what
peripheral{,-anon} are used for?
