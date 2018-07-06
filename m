Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRz1-000362-Ho
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRyy-0004AU-Ai
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:45:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49450
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fbRyy-0004AE-4l
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:45:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66Ehl34132243
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 10:45:11 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k296qk9yt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:45:11 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 6 Jul 2018 08:45:10 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
	<20180706120841.11cbdfa8.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 6 Jul 2018 10:45:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180706120841.11cbdfa8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d92a4a2a-ff8c-c55e-7af3-14bd6bcbb70b@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC 15/15] s390-bios: Use sense ccw to ensure
 consistent device state at boot time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 07/06/2018 06:08 AM, Cornelia Huck wrote:
> On Thu,  5 Jul 2018 13:25:43 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> If a vfio-ccw device is left in an error state (example: pending unit
>> check) then it is possible for that state to persist for a vfio-ccw device even
>> after the enable subchannel that we do to bring the device online. If this state
>> is allowed to persist then even simple I/O operations will needlessly fail. A
>> basic sense ccw is used to clear this error state for the boot device.
> 
> Another thing: What about unsolicited interrupts? I.e., you enable the
> subchannel, and then it becomes pending with unsolicited status. Do you
> have any handling for that (or plan to add it)?
> 
> We could ignore that for virtio devices, but probably not for dasds.
...
> Hmm. Could an error condition reassert itself after it was cleared?
> Probably not worth spending too much time on, though.
> 
>> +
>>       switch (cu_type(blk_schid)) {
>>       case 0x3990:  /* Real DASD device */
>>           dasd_ipl(blk_schid); /* no return */

I believe both of these issues to be the same as we are currently 
discussion in our replies to patch #10. My opinion posted there applies 
to this scenario. If my information is incorrect or you disagree with my 
assessment please yell at me! :-D


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
