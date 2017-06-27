Received: from eggs.gnu.org ([2001:4830:134:3::10]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPxqD-0004Ni-AH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPxq8-0002wl-BZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:16:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57302 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dPxq8-0002wD-0w
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:16:04 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <589b8e71-b025-a0ad-0621-d6827e31c90d@suse.de>
Date: Tue, 27 Jun 2017 23:15:56 +0200
MIME-Version: 1.0
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>



On 27.06.17 13:48, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image (based on a Linux installation), but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
> 
> This patch series now introduces network booting via DHCP and TFTP
> directly into the s390-ccw firmware by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.
> 
> Once the patches have been applied, you can download an .INS file
> via TFTP which contains the information about the further files
> that have to be loaded - kernel, initrd, etc. For example, you can
> use the built-in TFTP and DHCP server of QEMU for this by starting
> QEMU with:
> 
>   qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
>         -netdev user,id=n1,tftp=/path/to/tftp,bootfile=generic.ins
> 
> The .INS file has to use the same syntax as the .INS files that can
> already be found on s390x Linux distribution installation CD-ROMs.
> 
> The patches are still in a rough shape, but before I continue here,
> I though I'd get some feedback first. Specifically:
> 
> - This adds a lot of additional code to the s390-ccw firmware (and
>    the binary is afterwards three times as big as before, 75k instead
>    of 25k) ... is that still acceptable?

I think 75k is still perfectly reasonable, yes.

> 
> - Is it OK to require loading an .INS file first? Or does anybody
>    have a better idea how to load multiple files (kernel, initrd,
>    etc. ...)?
> 
> - The code from SLOF uses a different coding style (TABs instead
>    of space) ... is it OK to keep that coding style here so we
>    can share patches between SLOF and s390-ccw more easily?
> 
> - The code only supports TFTP (via UDP) ... I think that is OK for
>    most use-cases, but if we ever want to support network booting
>    via HTTP or something else that is based on TCP, we would need to
>    use something else instead... Should we maybe rather head towards
>    grub2, petitboot or something different instead?

IMHO the only viable next step would be to support UEFI and build on top 
of that - either by porting edk2 or U-Boot to s390x.

The problem with solutions like petitboot or home grown grub2 targets is 
that it becomes a documentation and knowledge sharing nightmare down the 
road. The less we're different from everyone else, the easier it becomes 
to maintain s390x.


Alex
