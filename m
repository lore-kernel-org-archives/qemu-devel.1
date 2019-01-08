Received: from eggs.gnu.org ([209.51.188.92]:50090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ggvIp-0005wZ-2t
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ggvIn-0004Md-7Z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:36:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1ggvIj-0003qT-AS
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:36:31 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08HYF32008266
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 12:36:17 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pvyxu9arn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 12:36:17 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 Jan 2019 17:36:15 -0000
Date: Tue, 8 Jan 2019 18:36:09 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <f38c791b-3aad-46a8-79e7-9adb74ba4726@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<20181212153426.2ca5a481.cohuck@redhat.com>
	<f38c791b-3aad-46a8-79e7-9adb74ba4726@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190108183609.235a8eb8@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 00/15] s390: vfio-ccw dasd ipl
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

On Tue, 8 Jan 2019 11:37:56 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 12/12/18 9:34 AM, Cornelia Huck wrote:
> ...
> >>
> >> NOTE: It has been a while, but I've finally chased down my infamous "reset bug".
> >> On subsystem reset (I see this right after host ipl) we sometimes end up getting
> >> an unexpected unit check status from a dasd device. This causes the first start
> >> subchannel instruction to fail due to the pending unit check status. My solution
> >> to this problem, as advised by the kernel folks, is to simply retry my ssch
> >> instructions before declaring failure when unexpected unit checks happen. In the
> >> event of a persistent error, after two retries we'll give up and print some
> >> useful error info for the user.
> > 
> > So, is that a status we only see because the vfio-ccw driver keeps the
> > subchannel enabled (as by the other recent thread)?
> > 
> > Is there any value in distinguishing different unit checks, or is retry
> > the best strategy in any case?
> > 
> The status presents on device reset. So when the host kernel IPLs this status will be 
> present. The very first attempt to use the device (SSCH, other instructions perhaps?) will 
> cause this status to be presented. Sometimes the host kernel must "get there first" and 
> clear the status. And other times the guest (by way of Qemu bios) gets there first.
> 
> The kernel handles unexpected unit checks by simply retrying a low number of times before 
> giving up. Given that bios code is a constant frequency code path, and the kernel has 
> already set this precedent, I feel safe with this decision and don't see a ton of value in 
> doing much more. If we find a case that requires more handling we can take a look at it.
> 

I agree, doing elaborate CIO error handling here does not seem like a
particularly good idea.

Something remotely related -- let me play crazy for a moment: let's say
we pass-through two DASD's to a single guest, one as the IPL disk and
one just so. If I'm not mistaken, the guest is guaranteed to get this
special after reset unit check (let's say freshly constructed VM),
unless there is another OS messing with the same DASD maybe, at least
for the 'just son DASD'. I would even guess that the condition in
question is indicated even for the IPL-DASD (if we thing guest1).

But ccw-passthrough won't get perfect anyway. So I think we can ignore
this side effect of the reset, unless  a need arises not to.

Regards,
Halil
