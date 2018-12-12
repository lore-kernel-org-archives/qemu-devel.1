Received: from eggs.gnu.org ([2001:4830:134:3::10]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX5nh-0005Zj-Pp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX5nc-0007Kc-JS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:47:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gX5nc-0007K7-7g
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:47:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBCEiTWS004733
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:47:43 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pb178sahs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:47:42 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 12 Dec 2018 14:47:41 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<20181212153426.2ca5a481.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 12 Dec 2018 09:47:35 -0500
MIME-Version: 1.0
In-Reply-To: <20181212153426.2ca5a481.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b038a600-a6ac-a9f3-adce-7f2d8542facc@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 12/12/18 9:34 AM, Cornelia Huck wrote:
> On Wed, 12 Dec 2018 09:11:03 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
> Hm, I think you need to adjust your cc: list. I added some more folks
> (and removed Dong Jia, whose address is no longer valid AFAIK).
> 

Correct. I forgot to update my list before I sent.


>> NOTE: It has been a while, but I've finally chased down my infamous "reset bug".
>> On subsystem reset (I see this right after host ipl) we sometimes end up getting
>> an unexpected unit check status from a dasd device. This causes the first start
>> subchannel instruction to fail due to the pending unit check status. My solution
>> to this problem, as advised by the kernel folks, is to simply retry my ssch
>> instructions before declaring failure when unexpected unit checks happen. In the
>> event of a persistent error, after two retries we'll give up and print some
>> useful error info for the user.
> 
> So, is that a status we only see because the vfio-ccw driver keeps the
> subchannel enabled (as by the other recent thread)?
> 
> Is there any value in distinguishing different unit checks, or is retry
> the best strategy in any case?
> 

It is status only, yes. I'm not sure if there is value in treating different unit checks 
differently. I discussed the problem with some of the kernel i/o devs and the suggestion I 
got was to simply retry. In the event of a real I/O error I doubt there is much we'd be 
able to do to recover so I think showing the user all of the relevant info (see patch 
s390-bios: cio error handling) and exiting is the right thing to do.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
