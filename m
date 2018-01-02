Received: from eggs.gnu.org ([2001:4830:134:3::10]:60528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWTAi-0002ff-V5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWTAe-0003YJ-17
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:28:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWTAd-0003Xw-Rw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:28:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w02KLXva045927
	for <qemu-devel@nongnu.org>; Tue, 2 Jan 2018 15:28:23 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f8b7bwr22-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 15:28:22 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 2 Jan 2018 13:28:22 -0700
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
	<20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
	<d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 2 Jan 2018 18:28:15 -0200
MIME-Version: 1.0
In-Reply-To: <d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2e316196-0b13-1394-018f-c5324b0ade71@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com



On 01/02/2018 06:06 PM, Eric Blake wrote:
> On 01/02/2018 11:09 AM, Daniel Henrique Barboza wrote:
>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>> nutshell is:
>>
>> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_rea=
son
>> and notify the event
>> - in the main_loop, all vcpus are paused, a system reset is issued, al=
l
>> subscribers of wakeup_notifiers receives a notification, vcpus are the=
n
>> resumed and the wake up QAPI event is fired
>>
> ...
>> With this extra tool, management can avoid situations where a guest
>> that does not have proper suspend/wake capabilities ends up in
>> inconsistent state (e.g.
>> https://github.com/open-power-host-os/qemu/issues/31).
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
> Only an interface review:
>
>>   arch_init.c             | 1 +
>>   include/sysemu/sysemu.h | 1 +
>>   qapi-schema.json        | 3 ++-
>>   vl.c                    | 5 +++++
>>   4 files changed, 9 insertions(+), 1 deletion(-)
>>
>> +++ b/qapi-schema.json
>> @@ -2388,11 +2388,12 @@
>>   # Information describing the QEMU target.
>>   #
>>   # @arch: the target architecture (eg "x86_64", "i386", etc)
>> +# @wakeup-suspend-support: true if the target supports wake up from s=
uspend
> Missing a '(since 2.12)' notation.

TargetInfo is marked as "Since 1.2.0".=C2=A0 Should I add the 2.12.0 nota=
tion=20
to the
new parameter or change the 1.2.0 notation of TargetInfo?

>
>>   #
>>   # Since: 1.2.0
>>   ##
>>   { 'struct': 'TargetInfo',
>> -  'data': { 'arch': 'str' } }
>> +  'data': { 'arch': 'str', 'wakeup-suspend-support': 'bool' } }
> The struct is output-only, so adding the new field unconditionally is
> backwards-compatible.
>
I believe it's worth adding this info in the commit message.


Thanks,

Daniel
