Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fQ9xa-0004n7-9p
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fQ9xV-0003Zj-9c
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:17:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39164
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fQ9xU-0003VY-Uj
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:17:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w55BF6LR062428
	for <qemu-devel@nongnu.org>; Tue, 5 Jun 2018 07:16:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jdsfng2dc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:16:56 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 5 Jun 2018 12:16:55 +0100
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
	<20180605121437.4c360af3.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 5 Jun 2018 13:16:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180605121437.4c360af3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <066ee37c-9afe-33fb-1981-5fb627a2a1c3@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 06/05/2018 12:14 PM, Cornelia Huck wrote:
> On Thu, 24 May 2018 19:58:27 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> There is at least one guest (OS) such that although it does not rely on
>> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
>> P bit) not being set, it fails to tell this to the machine.
>>
>> Usually this ain't a big deal, as the original purpose of the P bit is to
>> allow for performance optimizations. vfio-ccw however can not provide the
>> guarantees required if the bit is not set.
>>
>> It is not possible to implement support for the P bit not set without
>> transitioning to lower level protocols for vfio-ccw.  So let's give the
>> user the opportunity to force setting the P bit, if the user knows this
>> is safe.  For self modifying channel programs forcing the P bit is not
>> safe.  If the P bit is forced for a self modifying channel program things
>> are expected to break in strange ways.
>>
>> Let's also avoid warning multiple about P bit not set in the ORB in case
>> P bit is not told to be forced, and designate the affected vfio-ccw
>> device.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
>> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>
>> @Jason:
>> I have kept the tags this time without consulting you because
>> all that changed is the logging. Scream if that's not OK with you.
>>
>> v2->v3:
>> * tweak commit message (Connie)
>> * designate subsystem (vfio-ccw) and devno in the log messages (Connie)
>> * turn WARN_ONCE macro into inline function
>>
>> ---
>>   hw/s390x/css.c |  3 +--
>>   hw/vfio/ccw.c  | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+), 2 deletions(-)
> 
> How shall we proceed with this? I currently don't have much
> (understatement of the year...) queued, so we could wait until we
> hashed out where to go with _once logging (although the discussion
> seems to have died down a bit). If I merge a respin of David's tcg
> patches, however, I'd be inclined to merge this in the current form as
> well and transition to a common _once handling later.
> 

I'd prefer going ahead with this as is, and eventually transitioning
to common infrastructure when it's there.

Regards,
Halil
