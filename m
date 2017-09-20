Received: from eggs.gnu.org ([2001:4830:134:3::10]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duh8t-0001PH-IY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duh8o-000341-D8
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:42:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1duh8n-00031i-W1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:42:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KBImoC128231
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:23:34 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3p3gwjxe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:23:33 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 20 Sep 2017 12:23:31 +0100
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<20170920111431.1435dacd.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 20 Sep 2017 13:23:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170920111431.1435dacd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <65ae4646-0396-37fb-6d88-3157c9bf2c24@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>



On 09/20/2017 11:14 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 09:43:14 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>>
>> This patch is the s390 implementation of guest crash information, similar
>> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") and
>> the related commits. We will detect several crash reasons, with the
>> "disabled wait" being the most important one, since this is used by all
>> s390 guests as a "panic like" notification.
>>
>> Demonstrate the these ways with examples as follows.
> 
> s/the these/these/
> 
>>
>>   1. crash-information QOM property;
>>
>>   Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
>>   to execute "qom-get" command, and might get the result like,
>>
>>   (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
>>   {"return": {"psw-addr": 1105350, "psw-mask": 562956395872256, "reason":
>>    "disabled wait", "type": "s390"}}
>>
>>   2. GUEST_PANICKED event reporting;
>>
>>   Run qemu with a socket option, and telnet or nc to that,
>>   -chardev socket,id=qmp,port=4444,host=localhost,server \
>>   -mon chardev=qmp,mode=control,pretty=on \
>>   Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
>>   information will be reported on a guest crash event like,
>>
>>   {
>>       "timestamp": {
>>           "seconds": 1499931739,
>>           "microseconds": 961296
>>       },
>>       "event": "GUEST_PANICKED",
>>       "data": {
>>           "action": "pause",
>>           "info": {
>>               "psw-addr": 1105350,
>>               "reason": "disabled wait",
>>               "psw-mask": 562956395872256,
>>               "type": "s390"
>>           }
>>       }
>>   }
> 
> Out of scope for this patch, but is there a way to print the values as
> hex in the monitor?

This is qmp, so I guess not?
> 
>>
>>   3. log;
>>
>>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>>   specify the logfile and log item. The results might be,
>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  
>>   Guest crashed
>>   S390 crash parameters: (0x2000180000000 0x10ddc6)
> 
> Would it make sense to pad with zeroes, for readability?

Yes, makes sense. 
> 
>>   S390 crash reason: disabled wait
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  
>>
>> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [minor fixes due to upstream feedback]
>> ---
>> V1->V2:
>> 	- rename kvm-s390 to s390 in all places
>> 	- add "loop" to the crash reasons where appropriate
>> 	- use "-" instead of "_" for qapi
>>
>>  qapi/run-state.json | 19 ++++++++++++++++--
>>  target/s390x/cpu.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.h  |  6 ++++++
>>  target/s390x/kvm.c  | 29 +++++++++++++++++++++------
>>  vl.c                |  6 ++++++
>>  5 files changed, 109 insertions(+), 8 deletions(-)
> 
> No further comments over what others have already said.
> 
