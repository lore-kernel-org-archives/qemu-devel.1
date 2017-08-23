Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkRKl-00087X-I5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkRKi-0003Eu-Fc
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42760
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkRKi-0003Ek-97
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7N8i0Ju036653
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 04:48:15 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ch4ke6n3j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 04:48:15 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 23 Aug 2017 09:48:12 +0100
References: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
	<CAATJJ0+OztkKpfD9RzK_FpGZKeUm_QbmEDr4CdajNYaiU9VnfQ@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 23 Aug 2017 10:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAATJJ0+OztkKpfD9RzK_FpGZKeUm_QbmEDr4CdajNYaiU9VnfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7372935f-750b-6f4d-a526-e542a98138b1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Dan Horak <dhorak@redhat.com>



On 08/23/2017 09:28 AM, Christian Ehrhardt wrote:
> 
> 
> On Wed, Aug 23, 2017 at 8:53 AM, Christian Borntraeger <borntraeger@de.ibm.com <mailto:borntraeger@de.ibm.com>> wrote:
> 
>     KVM guests on s390 need a different page table layout than normal
>     processes (2kb page table + 2kb page status extensions vs 2kb page table
>     only). As of today this has to be enabled via the vm.allocate_pgste
>     sysctl.
> 
>     Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
>     and enable the pgste page table extensions in that case. This makes the
>     vm.allocate_pgste sysctl unnecessary. We enable this program header for
>     the s390 system emulation (qemu-system-s390x) if we build on s390
>     - for s390 system emulation
>     - the linker supports --s390-pgste (binutils >= 2.29)
>     - KVM is enabled
> 
>     This will allow distributions to disable the global vm.allocate_pgste
>     sysctl, which will improve the page table allocation for non KVM
>     processes as only 2kb chunks are necessary.
> 
> 
> Hi Christian,
> it is great to see context pgste come to life.
> Currently vm.allocate_pgste defaults to 0 in the kernel but as you stated mostly enabled for KVM support in Distros.
> So when someone wants to disable it he has to drop the enabling (e.g. /etc/sysctl.d/10-arch-specific.conf for us).
> 
> I want to be sure on the proper phasing of this - we can drop the "enabling" of global pgste once for a release we:
> - do not expect/support a kernel <4.12 to run there
> - will have only qemu versions >= the one carrying this change (and have it properly enabled)
> - binutils >= 2.29 to get the linking right

Yes. So I guess that for the Ubuntu case you could remove the sysctl thing for 18.04 assuming that
this will hit qemu 2.11 and 18.04 will use 2.11.


> 
> But furthermore if we have a qemu with this enabled, there is no drawback and we could still run it in:
> - former releases with older kernels

Yes.

> - former releases with older build environments

Yes.

> That program header would just be ignored and we just would have to keep the sysctl enabled there right?

Yes.

> 
> Also for the time we want to check on the proper header, you surely have a one liner you can share that you run against the binary to check if it was generated correctly?
> Maybe even one that you can run against a pid if the status is correct?

readelf -l on the binary
$ readelf -l REPOS/qemu/build/s390x-softmmu/qemu-system-s390x 

Elf file type is EXEC (Executable file)
Entry point 0x101f758
There are 11 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000001000040 0x0000000001000040
                 0x0000000000000268 0x0000000000000268  R E    0x8
  INTERP         0x00000000000002a8 0x00000000010002a8 0x00000000010002a8
                 0x000000000000000f 0x000000000000000f  R      0x1
      [Requesting program interpreter: /lib/ld64.so.1]
  LOAD           0x0000000000000000 0x0000000001000000 0x0000000001000000
                 0x00000000004852f0 0x00000000004852f0  R E    0x1000
  LOAD           0x0000000000485450 0x0000000001486450 0x0000000001486450
                 0x000000000003dcc8 0x0000000000485840  RW     0x1000
  DYNAMIC        0x0000000000485b80 0x0000000001486b80 0x0000000001486b80
                 0x0000000000000480 0x0000000000000480  RW     0x8
  NOTE           0x00000000000002b8 0x00000000010002b8 0x00000000010002b8
                 0x0000000000000044 0x0000000000000044  R      0x4
  TLS            0x0000000000485450 0x0000000001486450 0x0000000001486450
                 0x0000000000000000 0x0000000000000230  R      0x8
  GNU_EH_FRAME   0x00000000003dc638 0x00000000013dc638 0x00000000013dc638
                 0x0000000000017a74 0x0000000000017a74  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x0000000000485450 0x0000000001486450 0x0000000001486450
                 0x0000000000000bb0 0x0000000000000bb0  R      0x1
  S390_PGSTE     0x0000000000000000 0x0000000000000000 0x0000000000000000   <----
                 0x0000000000000000 0x0000000000000000         0x8	    <----

[...]

Older binutils will report something like

  LOPROC+0       0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         8

instead of S390_PGSTE.
