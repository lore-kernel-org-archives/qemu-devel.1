Received: from eggs.gnu.org ([2001:4830:134:3::10]:40178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gRdPp-0007Rk-As
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gRd9J-0002jL-8o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:11:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59494
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gRd9H-0002i9-EP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:11:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wARD9XDs140413
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 08:11:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p15fsu6bt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 08:11:29 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 27 Nov 2018 13:11:28 -0000
References: <20181127114102.4319-1-david@redhat.com>
	<f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
	<55d945eb-a9ba-9183-9c47-3a1e505d2d35@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Nov 2018 14:11:23 +0100
MIME-Version: 1.0
In-Reply-To: <55d945eb-a9ba-9183-9c47-3a1e505d2d35@redhat.com>
Content-Language: en-US
Message-Id: <c15332b4-9369-dec2-dce3-e630e3345a88@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>



On 27.11.2018 14:06, Thomas Huth wrote:
> On 2018-11-27 13:43, Christian Borntraeger wrote:
>> On 27.11.2018 12:41, David Hildenbrand wrote:
>>> Just like on other architectures, we should stop the clock while the guest
>>> is not running. This is already properly done for TCG. Right now, doing an
>>> offline migration (stop, migrate, cont) can easily trigger stalls in the
>>> guest.
>>>
>>> Even doing a
>>>     (hmp) stop
>>>     ... wait 2 minutes ...
>>>     (hmp) cont
>>> will already trigger stalls.
>>>
>>> So whenever the guest stops, backup the KVM TOD. When continuning to run
>>> the guest, restore the KVM TOD.
>>
>> We do a similar thing for managedsave so it probably makes sense to solve
>> the stall warnings. Now: At the same time, we actually want to have the guest
>> see the real time and maybe even share the TOD clock with the host in some
>> way, while at the same time avoid the stall warnings.
> 
> Hmm, by the way, do we also have to consider the "-rtc clock=host|rt|vm"
> option from the commandl line, or is this an orthogonal concept?

I think this option does not work at all in how time works on s390.
