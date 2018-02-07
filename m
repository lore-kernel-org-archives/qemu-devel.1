Received: from eggs.gnu.org ([2001:4830:134:3::10]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejPn5-0006mt-7x
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejPn0-0000Y8-G5
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:29:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejPn0-0000Xe-8m
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:29:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17DTDvZ100562
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 08:29:28 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyxt0axnb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 08:29:28 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 13:29:25 -0000
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<db339d3b-2425-8055-0c1a-890a6f0d4039@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 14:29:21 +0100
MIME-Version: 1.0
In-Reply-To: <db339d3b-2425-8055-0c1a-890a6f0d4039@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1216cef6-00fd-683d-2bf2-1673ee272c0d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 02/07/2018 02:21 PM, David Hildenbrand wrote:
> On 07.02.2018 13:38, Christian Borntraeger wrote:
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
>>   (QEMU) (QEMU) qom-get path=/machine/unattached/device[0] \
>>       property=crash-information
>>   {"return": {"core": 0, "reason": "disabledwait", "psw-mask": 562956395872256, \
>>       "type": "s390", "psw-addr": 1102832}}
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
>>     "timestamp": {
>>         "seconds": 1518004739,
>>         "microseconds": 552563
>>     },
>>     "event": "GUEST_PANICKED",
>>     "data": {
>>         "action": "pause",
>>         "info": {
>>             "core": 0,
>>             "psw-addr": 1102832,
>>             "reason": "disabledwait",
>>             "psw-mask": 562956395872256,
>>             "type": "s390"
>>         }
>>     }
>>   }
>>
>>   3. log;
>>
>>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>>   specify the logfile and log item. The results might be,
>>
>>   Guest crashed on cpu 0: disabledwait
>>   PSW: 0x0002000180000000 0x000000000010d3f0
>>
>> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> V5->V6: - use qapi enum
>> 	- add core id to the crash parameters
>> 	- indent fixes
>> 	- rework debug log message to reuse the enum string
>> 	- update patch description
>>
>>  qapi/run-state.json   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++--
>>  target/s390x/cpu.c    | 41 ++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.h    |  2 ++
>>  target/s390x/helper.c |  5 ++++-
>>  target/s390x/kvm.c    | 15 +++++++-------
>>  vl.c                  | 12 ++++++++++--
>>  6 files changed, 116 insertions(+), 13 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index bca46a8785..328c86b4bb 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -320,22 +320,29 @@
>>  #
>>  # An enumeration of the guest panic information types
>>  #
>> +# @hyper-v: hyper-v guest panic information type
>> +#
>> +# @s390: s390 guest panic information type (Since: 2.12)
>> +#
>>  # Since: 2.9
>>  ##
>>  { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v'] }
>> +  'data': [ 'hyper-v', 's390' ] }
>>  
>>  ##
>>  # @GuestPanicInformation:
>>  #
>>  # Information about a guest panic
>>  #
>> +# @type: Crash type that defines the hypervisor specific information
>> +#
>>  # Since: 2.9
>>  ##
>>  {'union': 'GuestPanicInformation',
>>   'base': {'type': 'GuestPanicInformationType'},
>>   'discriminator': 'type',
>> - 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
>> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
>> +           's390': 'GuestPanicInformationS390' } }
>>  
>>  ##
>>  # @GuestPanicInformationHyperV:
>> @@ -350,3 +357,46 @@
>>             'arg3': 'uint64',
>>             'arg4': 'uint64',
>>             'arg5': 'uint64' } }
>> +
>> +##
>> +# @S390CrashReason:
>> +#
>> +# Reason why the CPU is in a crashed state.
>> +#
>> +# @unknown: no crash reason was set
>> +#
>> +# @disabledwait: the CPU has entered a disabled wait state
>> +#
>> +# @extintloop: timer interrupt with new PSW enabled for timer
> 
> Is this CPU timer or CKC? Or both?

both. The kernel will give this to QEMU if one timer is going to be
delivered but the new PSW is enabled for external interrupts.
