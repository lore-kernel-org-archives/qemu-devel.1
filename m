Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cQpuz-0002Pf-6O
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cQpux-0002KR-TK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:28:25 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1cQpux-0002K8-Ho
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 01:28:23 -0500
Received: by mail-lf0-x241.google.com with SMTP id k62so10990331lfg.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 22:28:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105101246.GC3292@redhat.com>
References: <CAMxP3BTmayVS5VHYm6iXgZFetiv8YAPnyd_1-6p_q33gDLTrEQ@mail.gmail.com>
	<20170105101246.GC3292@redhat.com>
From: Bob Chen <a175818323@gmail.com>
Date: Tue, 10 Jan 2017 14:28:19 +0800
Message-ID: <CAMxP3BRbr2huckaL_J+qEmAHHrwFKSsfYfp1ou1p=UVOqXgtvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Live migration + cpu/mem hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Answer my own question:

The corresponding cmd-line parameter for memory hot-add by QEMU monitor is,
-object memory-backend-ram,id=mem0,size=1024M -device
pc-dimm,id=dimm0,memdev=mem0

2017-01-05 18:12 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Thu, Jan 05, 2017 at 04:27:26PM +0800, Bob Chen wrote:
> > Hi,
> >
> > According to the docs, the destination Qemu must have the exactly same
> > parameters as the source one. So if the source has just finished cpu or
> > memory hotplug, what would the dest's parameters be like?
> >
> > Does DIMM device, or logically QOM object, have to be reflected on the
> new
> > command-line parameters?
>
> Yes, if you have hotplugged any type of device since the VM was started,
> the QEMU command line args on the target host must include all the original
> args from the source QEMU, and also any args reflect to reflect the
> hotplugged devices too.
>
> A further complication is that on the target, you must also make sure you
> fully specify *all* device address information (PCI slots, SCSI luns, etc
> etc), because the addresses QEMU assigns to a device after hotplug may
> not be the same as the addresses QEMU assigns to a device whne coldplug.
>
> eg if you boot a guest with 1 NIC + 1 disk, and then hotplug a 2nd NIC
> you might get
>
>    1st NIC  == PCI slot 2
>    1st disk == PCI slot 3
>    2nd NIC  == PCI slot 4
>
> if however, you started QEMU with 2 NICs and 1 disk straight away QEMU
> might assign addresses in the order
>
>    1st NIC  == PCI slot 2
>    2nd NIC  == PCI slot 3
>    1st disk == PCI slot 4
>
> this would totally kill a guest OS during live migration as the slots
> for devices its using would change.
>
> So as a general rule when launching QEMU on a target host for migrating,
> you must be explicit about all device addresses and not rely on QEMU to
> auto-assign addresses. This is quite alot of work to get right, but if
> you're using libvirt it'll do pretty much all this automatically for
> you.
>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/
> :|
> |: http://libvirt.org              -o-             http://virt-manager.org
> :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/
> :|
>
