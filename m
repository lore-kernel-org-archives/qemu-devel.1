Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej2qN-0007AC-2M
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej2qI-0004EL-6F
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:59:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54794
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ej2qI-0004DE-09
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:59:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16CxC5F125489
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 07:59:20 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fya28yhe3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 07:59:16 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Feb 2018 12:59:04 -0000
References: <20180206074622.157812-1-borntraeger@de.ibm.com>
	<20180206134934.1b1bb2b3.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Feb 2018 13:59:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180206134934.1b1bb2b3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <340ffc3a-2b4c-ec70-a780-23c3c3d72008@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 1/1] s390x/cpu: expose the
 guest crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Eric Blake <eblake@redhat.com>



On 02/06/2018 01:49 PM, Cornelia Huck wrote:
> On Tue,  6 Feb 2018 07:46:22 +0000
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> This patch is the s390 implementation of guest crash information,
>> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
>> property") and the related commits. We will detect several crash
>> reasons, with the "disabled wait" being the most important one, since
>> this is used by all s390 guests as a "panic like" notification.
>>
>> Demonstrate these ways with examples as follows.
>>
>>   1. crash-information QOM property;
>>
>>   Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
>>   to execute "qom-get" command, and might get the result like,
>>
>>   (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
>>   {"return": {"psw-addr": 1105350, "psw-mask": 562956395872256, "reason":
>>    "disabled wait", "type": "s390"}}
> 
> Hm, for me cpu0 shows up under /machine/unattached/device[0].

The patch description is a bit older. Feel free to update the path.
> 
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
>>
>>   3. log;
>>
>>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>>   specify the logfile and log item. The results might be,
>>
>>   Guest crashed
>>   S390 crash parameters: (0x0000100000000000 0x0000000000000006)
>>   S390 crash reason: operation exception loop
>>
>> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  qapi/run-state.json   | 27 ++++++++++++++++++++++--
>>  target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.h    | 11 ++++++++++
>>  target/s390x/helper.c |  5 ++++-
>>  target/s390x/kvm.c    | 15 +++++++-------
>>  vl.c                  |  6 ++++++
>>  6 files changed, 110 insertions(+), 11 deletions(-)
> 
> Looks good to me. Will apply, but waiting for an ack/review.
> 
