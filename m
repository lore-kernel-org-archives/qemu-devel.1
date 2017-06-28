Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dQ7d3-0008W5-BX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dQ7d0-0000Uo-5E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:43:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39498
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dQ7cz-0000Tv-UU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:43:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5S7cp14011357
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:43:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bc45q8ufs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:43:07 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 28 Jun 2017 01:43:06 -0600
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Jun 2017 09:43:00 +0200
MIME-Version: 1.0
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
Message-Id: <235dac52-673a-6b00-bacf-175dcff82933@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Interesting work, thanks for giving it a ry.

On 06/27/2017 01:48 PM, Thomas Huth wrote:
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

What is the licensing situation with SLOF?
> 
> Once the patches have been applied, you can download an .INS file
> via TFTP which contains the information about the further files
> that have to be loaded - kernel, initrd, etc. For example, you can
> use the built-in TFTP and DHCP server of QEMU for this by starting
> QEMU with:
> 
>  qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
>        -netdev user,id=n1,tftp=/path/to/tftp,bootfile=generic.ins
> 
> The .INS file has to use the same syntax as the .INS files that can
> already be found on s390x Linux distribution installation CD-ROMs.
> 
> The patches are still in a rough shape, but before I continue here,
> I though I'd get some feedback first. Specifically:
> 
> - This adds a lot of additional code to the s390-ccw firmware (and
>   the binary is afterwards three times as big as before, 75k instead
>   of 25k) ... is that still acceptable?

Yes, sure. I think up to 1M everything is fine as long as the startup time
stays low (e.g. if we want to do something like clear containers. Right
now I can start a small Linux guest from qemu start to command line in <100ms
without any optimization)

> 
> - Is it OK to require loading an .INS file first? Or does anybody
>   have a better idea how to load multiple files (kernel, initrd,
>   etc. ...)?

I agree with Viktor that supporting a pxelinux config file is probably the
better way, since this is what all exisiting servers admins understand. For
the time being Linux will be the most relevant guest and requiring changes in
management infrastructure will certainly make things very hard.


> - The code from SLOF uses a different coding style (TABs instead
>   of space) ... is it OK to keep that coding style here so we
>   can share patches between SLOF and s390-ccw more easily?

Is it possible to enhance SLOF and then link to the existing SLOF code?
> 
> - The code only supports TFTP (via UDP) ... I think that is OK for
>   most use-cases, but if we ever want to support network booting
>   via HTTP or something else that is based on TCP, we would need to
>   use something else instead... Should we maybe rather head towards
>   grub2, petitboot or something different instead?
