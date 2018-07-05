Received: from eggs.gnu.org ([2001:4830:134:3::10]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb4iD-0001CO-3L
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb4iA-0003uG-19
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:54:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fb4i9-0003sQ-Ra
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:54:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4191B401EF13
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:54:17 +0000 (UTC)
Date: Thu, 5 Jul 2018 16:54:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180705165348-mutt-send-email-mst@kernel.org>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705125231.GD16293@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, berrange@redhat.com, jferlan@redhat.com

On Thu, Jul 05, 2018 at 01:52:31PM +0100, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 01:39:29PM +0100, Richard W.M. Jones wrote:
> > I was doing a bit of investigation around how different hypervisors
> > handle the VM Generation ID feature.  QEMU's behaviour seems quite
> > strange, I wonder if this is a bug or expected?
> > 
> > (1) I booted a Windows 2016 VM with:
> > 
> >   qemu-system-x86_64 -M pc,accel=kvm -m 2G -hda w2k16-mincore.img \
> >       -device vmgenid,guid=01020304-0506-0708-090a-0b0c0d0e0f00,id=vmgenid0
> > 
> > (2) Inside the guest I used the VMGENID.EXE program from:
> > 
> >   https://bugzilla.redhat.com/show_bug.cgi?id=1598350#c3
> >   https://docs.microsoft.com/en-gb/windows/desktop/HyperV_v2/virtual-machine-generation-identifier
> > 
> > Note this is self-compiled using mingw64-g++ (not using Visual Studio
> > which I don't have available), but I don't believe that could have
> > caused the problem.
> > 
> > (3) The program prints:
> > 
> >   VmCounterValue: 708050601020304:f0e0d0c0b0a09
> > 
> > To make it easier to see, this is the same number but zero-extended:
> > 
> >   VmCounterValue: 07 08 05 06 01 02 03 04 : 00 0f 0e 0d 0c 0b 0a 09
> >                   \________ LOW ________/   \_______ HIGH _______/
> >                             WORD                     WORD
> > 
> > As you can see it looks like there is no clear relationship between
> > the order of the bytes in the guid= parameter and the order that they
> > are seen by Windows.
> 
> OK after examining util/uuid.c and the qemu_uuid_bswap function,
> I sort of see what's going on here.
> 
> FWIW other hypervisors seem to store these as two 64 bit integers.
> 
> Rich.

What do others do, and what is, in your opinion, the correct behaviour here?


> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> Fedora Windows cross-compiler. Compile Windows programs, test, and
> build Windows installers. Over 100 libraries supported.
> http://fedoraproject.org/wiki/MinGW
