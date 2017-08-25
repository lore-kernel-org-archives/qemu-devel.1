Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dl8ug-0006kj-Jl
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dl8ud-0004n3-G1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dl8ud-0004m8-8f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:20:15 -0400
Date: Fri, 25 Aug 2017 09:20:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170825092008.12484e6a.cohuck@redhat.com>
In-Reply-To: <97b35c4d-e897-c18a-525f-1fa1a7560776@de.ibm.com>
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
	<ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
	<CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
	<e24316e0-3b6f-ef1c-7c4b-66e7b302e5b4@linux.vnet.ibm.com>
	<97b35c4d-e897-c18a-525f-1fa1a7560776@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On Thu, 24 Aug 2017 20:14:06 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 08/24/2017 07:38 PM, Farhan Ali wrote:
> > 
> > 
> > On 08/24/2017 12:07 PM, Peter Maydell wrote:  
> >> On 24 August 2017 at 16:53, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:  
> >>>
> >>>
> >>> On 08/24/2017 11:50 AM, Thomas Huth wrote:  
> >>>> True, so that could still be an issue. Looking at the cio.h in the
> >>>> kernel, they define the struct like this:
> >>>>
> >>>> struct ccw1 {
> >>>>         __u8  cmd_code;
> >>>>         __u8  flags;
> >>>>         __u16 count;
> >>>>         __u32 cda;
> >>>> } __attribute__ ((packed,aligned(8)));
> >>>>
> >>>> So I guess adding the aligned(8) is the right way to go?  
> >>  
> >>> This was my initial fix and it works on my system. But for some reason this
> >>> fix does not work on my colleague's system. So I am hesitant about
> >>> submitting this fix  
> >>
> >> It seems like it ought to be the obvious fix, so I would double
> >> check that on your colleague's system the change really did
> >> get recompiled and it's actually using the new version (that
> >> sort of mistake can be easy to make and very confusing...)  
> 
> >>
> >> thanks
> >> -- PMM
> >>  
> > 
> > So after trying again with the fix, it seems to work on my colleague's system for most cases. It fails for LDL DASD boot case.... we are still investigating it.  
> 
> So chances are that this is an independent problem, I guess?
> 

OK, to recap:

- the current pre-built bios seems fine
- rebuilding the bios may yield a version that fails on some systems
  (different compiler?)
- adding aligned(8) looks like the right thing to do
- it seems to fix the problem, but on at least one system something
  still seems off (under investigation)
