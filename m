Received: from eggs.gnu.org ([2001:4830:134:3::10]:58407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0V5o-0003EW-N8
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0V5l-0001lB-Hj
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0V5l-0001kc-C1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:30:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 249142D9EB5
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 15:30:55 +0000 (UTC)
References: <20170418152424.GX30620@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ae9d913-2516-72dc-adaf-cdd0f082c486@redhat.com>
Date: Tue, 18 Apr 2017 17:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170418152424.GX30620@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio-scsi limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org



On 18/04/2017 17:24, Richard W.M. Jones wrote:
> In libvirt, <address ... bus="0"> refers to the virtio-scsi "channel".
> The current virtio-scsi driver in qemu has a hard limit of 1 channel,
> so you can only use bus="0" (or channel=0).
> 
> Open question: Will this limit ever be increased?

No, it's only there because spapr_vscsi supports channel>0.

> In libvirt, <address ... target="0"> refers to the virtio-scsi
> "scsi-id" (internally in the driver called just ".id").  You can use
> any target from 0 to 255 inclusive.
> 
> In libvirt, <address ... unit="0"> refers to the virtio-scsi "unit" ie
> the SCSI LUN.  You can use any LUN from 0 to 16383 inclusive.
> 
> Open question: What does the bus=scsi0.0 parameter mean?

The first bus in scsi0, where the 0 in scsi0 is the controller index.

> Not tested yet: Does hotplugging work on individual LUNs?

Yes.

> Currently libguestfs puts each disk on a separate target (target=i
> unit=0), and therefore has an effective limit of 255 disks (256 - 1
> because the appliance uses a disk).
> 
> When I changed libguestfs to use LUNs instead of targets (target=0
> unit=i), I got a peculiar bug.  It looks like there is some kind of
> race when enumerating the device, where /sys is populated before the
> device is actually available.

That's not _too_ surprising because devtmpfs processes creation/deletion
requests asynchronously.

Paolo

> See the below boot log, and compare it
> to the init code:
> 
> https://github.com/libguestfs/supermin/blob/master/init/init.c#L176
> 
> * fp = fopen ("/sys/block/sdab/dev", "r") succeeds at line 181
> 
> * we read major:minor from fp at line 230
> 
> * we mknod ("/dev/root",...) at line 245
> 
> * we mount ("/dev/root", "/root", "ext2"...) at line 262, which fails with
>   EINVAL
> 
> * shortly after that, kernel messages indicate that sdab has been
>   attached.
