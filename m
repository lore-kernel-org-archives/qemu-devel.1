Received: from eggs.gnu.org ([208.118.235.92]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eS68c-0000I8-Vk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eS68Z-0004RW-LC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:04:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eS68Z-0004Qe-FN
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:04:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBLJ43Xc048084
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:04:06 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f0jawh97u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:04:04 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 21 Dec 2017 12:03:49 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
	<20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
	<d3550f4f-adc1-ff8e-5aa7-7b1c815f2c90@redhat.com>
	<7379da29-1f3e-fe61-6216-67c8839bb8a4@linux.vnet.ibm.com>
Date: Thu, 21 Dec 2017 17:03:43 -0200
MIME-Version: 1.0
In-Reply-To: <7379da29-1f3e-fe61-6216-67c8839bb8a4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0b41344b-c35a-92a8-67e9-348e37ccfa44@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: introduce
 query-wakeup-from-suspend-support command
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

Hi,

On 12/06/2017 01:50 PM, Daniel Henrique Barboza wrote:
>
>
> On 12/06/2017 12:26 PM, Eric Blake wrote:
>> On 12/06/2017 06:02 AM, Daniel Henrique Barboza wrote:
>>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>>> nutshell is:
>>>
>>> This patch implements a new QMP command called
>>> 'query-wakeup-from-suspend-support' that allows the caller to query
>>> if the guest supports wake up from suspend via system_wakeup. It
>>> goes over the subscribers of the wake up event and, if it's empty,
>>> it assumes that the guest does not support wake up from suspend
>>> (and thus, pm-suspend itself).
>>>
>>> This is the expected output of the command when running a x86 guest:
>>>
>>> {"execute" : "query-wakeup-from-suspend-support"}
>>> {"return": {"enabled": true}}
>> Do we really need a new command, or can we add it as an additional field
>> to an existing command (for example, in MachineInfo under
>> query-machines, or TargetInfo under query-target)?
>
> A new QMP command was the first idea that crossed my mind but yeah, 
> adding
> the info to an existing command is also valid IMO.

After investigating, I think that it's simpler to hook the wakeup 
support info into TargetInfo
than MachineInfo, given that the detection I'm using for this new 
property is based
on the current runtime state. Hooking into MachineInfo would require to 
change the
MachineClass to add a new property, then setting it up for the machines 
that have
the wakeup support (only x86 so far). Definitely doable, but if we don't 
have any
favorites between MachineInfo and TargetInfo I'd rather pick the simpler 
route.

So, if no one objects, I'll rework this series by putting the logic 
inside query-target
instead of a new API.


Daniel


>
>
> Daniel
>
>>
>
>
