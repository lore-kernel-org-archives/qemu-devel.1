Received: from eggs.gnu.org ([2001:4830:134:3::10]:37125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmfG3-0006No-T1
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmfFy-0007Gc-9g
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmfFy-0007GK-18
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:04:34 -0400
Date: Tue, 29 Aug 2017 14:04:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829140429.08a1731c.cohuck@redhat.com>
In-Reply-To: <3421f46f-fa82-ac23-b0ac-5a2acce26d41@linux.vnet.ibm.com>
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
	<c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
	<b5a9ab05-4e3c-66bc-33ce-d953d7f911e2@linux.vnet.ibm.com>
	<20170828160554.45855dfa.cohuck@redhat.com>
	<e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
	<9b9880e4-71fd-4bc5-961b-ab0e2b298f03@linux.vnet.ibm.com>
	<3421f46f-fa82-ac23-b0ac-5a2acce26d41@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com

On Mon, 28 Aug 2017 10:28:53 -0400
Farhan Ali <alifm@linux.vnet.ibm.com> wrote:

> On 08/28/2017 10:19 AM, Halil Pasic wrote:
> >
> >
> > On 08/28/2017 04:15 PM, Farhan Ali wrote:  
> >>
> >>
> >> On 08/28/2017 10:05 AM, Cornelia Huck wrote:  
> >>>>>> It's the alignment of the CCW which causes the problem.
> >>>>>>
> >>>>>> The exact error message when starting the guest was:
> >>>>>>
> >>>>>> ! No virtio device found !
> >>>>>>
> >>>>>> Since it worked for SCSI and CDL, and failed for LDL disks on that particular system, we are not really sure what caused the failure.
> >>>>>> Debugging it further showed the CCW for LDL disks were not aligned at double word boundary.  
> >>> This is really, really odd, as the low-level ccw code is the same for
> >>> any disk type...
> >>>  
> >> Exactly!
> >>  
> >>>>>> Trying the test on a different system with LDL disks worked fine, with the aligned(8) fix.  
> >>>>> Do you happen to have an old s390-ccw.img laying around in the test folder? QEMU might pick up
> >>>>> this one (e.g. when calling it without libvirt from the command line).
> >>>>>  
> >>>> I explicitly mention the bios to use with '-bios' option and pick up the
> >>>> latest bios. Without the aligned fix I see the error and with the fix it
> >>>> works fine.  
> >>> Wait, so the fix fixes it? Or am I confused now?
> >>>  
> >>
> >> It fixes in my system and one other system we tried on. But fails on a system where this issue was first noticed.  
> >
> > This is very confusing. So you have tried -bios on the system
> > where the issue was first noticed and the issue still persists
> > despite of the fixed bios is specified?
> >  
> Yes.
> 
> The system where the issue was first noticed, applying the fix for the 
> bios, fixes for:
> 
> 1) CDL disks
> 2) SCSI disks
> 
> But fails for LDL disk.
> 
> On my system and one other system, the fix works for all the disk types, 
> CDL, SCSI and LDL and fixes the issue.

Are you using different toolchains on the failing and the working
systems? Does it work when you copy the bios from a working system?

(Clutching at straws here...)
