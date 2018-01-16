Received: from eggs.gnu.org ([2001:4830:134:3::10]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ebTc6-0007Tb-02
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ebTc2-0008BL-UX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:57:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ebTc2-0008Ax-P5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:57:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFtAhg082843
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:57:22 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fhhh1sj04-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:57:20 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 15:57:17 -0000
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
	<20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 16:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com



On 01/15/2018 09:59 AM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-12 19:10:20 +0100]:
> 
>>
>>
>> On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
>>> What are still missing, thus need to be offered in the next version are:
>>> - I/O termination and FSM state handling if currently we have I/O on the status
>>>   switched path.
>>> - Vary on/off event is not sensible to a guest.
>>
>> I don't see a doc update. We do have documentation (in
>> Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
>> regions and their purpose/usage  is at least kind of explained. You are
>> changing this interface without updating the doc.
>>
>> I would like to see documentation on this because I'm under the
>> impression either the design is pretty convoluted or I did not
>> get it at all.
> Ah, I missed the documentation part. Thanks for pointing out. I will add
> it in the next cycle.
> 

I would have preferred having a doc update in this cycle. E.g. as
an answer to the cover letter.

As previously pointed out I don't really understand your design.
I wanted to avoid summarizing the design myself (that is my understanding
of it), to then question the design.

To give you a feeling of what I mean here some bullet points:
* Channel paths are css level resources (simplified).
* When a channel path malfunctions a CRW is generated and a machine
check channel report pending is generated. Same goes for
channel paths popping up (on HW level). Should not these get
propagated?
* Kind of instead of the CRW you introduce a per device interrupt
for channel path events on the qemu/kvm boundary. AFAIU for a chp
event you do an STSCH for each (affected?) subchannel and generate
an irq. Right? Why is this a good idea.
* SCHIB.PMCW provides path information relevant for a given device.
This information is retrieved using store subchannel. Is your series
sufficient for making store subchannel work properly (correct and
reasonably up to date)? Regarding PMCW it's supposed to get updated
when io functions are preformed by the css, AFAIR. Is that right?
If yes what are the implications? Are the manipulations you do
on some PMCW fields architecturally correct?
* The one thing I would very much appreciate as an user of vfio,
and should in my understanding be the user story of this series
(and the qemu counterpart of course) is the following. If my device
(that is IO operation) failed because no path could be found on
which the device is accessible, I would like to be able to identify
that. Preferably the same way I would do for an LPAR guest. Is this
series accomplishing that? 
* Why not just do proper STSCH for vfio-ccw?
* Shouldn't we virtualize CHPIDs? What if we have a clash? Lets
say my dasd is only accessible via chp  0.00 in the host. Currently
we have a problem there, or (as the only path would end up being
ignored)? Note: this is another unpleasant effect of not having
MCSSE in the guest. The original design was to have a separate
css for vfio, and then we would not have this kind of a problem.
(Virtualization of chps would still be good for migration.)

Regards,
Halil
