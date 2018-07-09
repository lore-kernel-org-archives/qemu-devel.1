Received: from eggs.gnu.org ([2001:4830:134:3::10]:42764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fcQjA-0003l8-3t
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fcQj7-0007hZ-1U
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fcQj6-0007hM-S9
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D1FA4E90E
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 07:36:51 +0000 (UTC)
Date: Mon, 9 Jul 2018 08:36:47 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180709073647.GF16293@redhat.com>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<20180705165348-mutt-send-email-mst@kernel.org>
	<20180705141132.GM1455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705141132.GM1455@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lersek@redhat.com, qemu-devel@nongnu.org, jferlan@redhat.com, mxie@redhat.com

On Thu, Jul 05, 2018 at 03:11:32PM +0100, Richard W.M. Jones wrote:
> VMware represents these internally as two signed 64 bit integers, eg:
> 
>   vm.genid = "-570734802784577186"
>   vm.genidx = "-5042519231342505152"
> 
> I am still trying to get verification, but I believe the first is the
> low 64 bit word and the second is the high 64 bit word.

I have now been able to verify how this works using a real VMware
hypervisor (thanks to help from Ming Xie).  For the record, here is
how it maps, since I could not find any documentation about this.

VMX file contains:

  vm.genid = "7344585841658099715"
  vm.genidX = "-8483171368186442967"

Those numbers are signed 64 bit integers written in hex as:

  vm.genid = 65 ED 35 E8 E2 64 F8 03
  vm.genidX = 8A 45 B8 96 1E 7B 8B 29

In the guest the VMGENID.EXE program prints (with my spaces added for
clarity):

  VmCounterValue: 65 ED 35 E8 E2 64 F8 03 : 8A 45 B8 96 1E 7B 8B 29

So this confirms my original guess.  Note that VMware is not doing any
endianness adjustment, but then VMware only works on LE hardware.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
