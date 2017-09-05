Received: from eggs.gnu.org ([2001:4830:134:3::10]:43114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpCkU-0000vt-If
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dpCkN-0006gN-SC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:14:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42058
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dpCkN-0006fs-L9
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:14:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85CDbUu088488
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 08:14:26 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2csrt0hpt8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:14:26 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 5 Sep 2017 13:14:24 +0100
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-18-david@redhat.com>
	<f162eece-8dd0-a8e9-f339-356465ab6587@de.ibm.com>
	<cdc6b4d0-117a-be80-cd3e-d2a4592f061d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Sep 2017 14:14:21 +0200
MIME-Version: 1.0
In-Reply-To: <cdc6b4d0-117a-be80-cd3e-d2a4592f061d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <41bbb466-4b9d-1c7e-f622-38a867b1db65@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/19] s390x: CPU hot unplug via
 device_del cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>



On 09/05/2017 02:01 PM, David Hildenbrand wrote:
> On 05.09.2017 11:14, Christian Borntraeger wrote:
>> On 09/04/2017 05:43 PM, David Hildenbrand wrote:
>>> device_del on a CPU will currently do nothing. Let's emmit an error
>>> telling that this is will never work (there is no architecture support
>>> on s390x). Error message copied from ppc.
>>>
>>> (qemu) device_del cpu1
>>> device_del cpu1
>>> CPU hot unplug not supported on this machine
>>
>> Given the fact that I get the question about unplug _every_ time when I give a presentation
>> about KVM on z, I will try to get some architecture folks look at this. Maybe we can define
>> something very simple like "if the CPU is in the stopped state we can remove this and just
>> piggy back on the existing sclp EVENT_QUAL_CPU_CHANGE notification".
>>
>> So maybe add  "currently"
> 
> Unfortunately it might not be that easy.
> 
> We would have to find a way that existing OS's don't break. If a guest
> OS is not prepared for CPUs to get removed, we might run into
> inconsistencies when simply deleting CPUs that are in the STOPPED state.

Yes, this needs to be validated across all things.
> 
> Especially, these CPUs would still show up in the guest as "offline".
> Wonder what would then happen trying to "online" these.

The main use case seems to be, that the admin does not want to allow a guest
to online back a guest CPU if it was taken away from the configuration. 
So maybe we could simply fail a SIGP START for those.

Or we might go one level below and only allow an unplug if the CPU is in
the deconfigured state and we would then have to forbid the configuration
step. Right now SCLP_CMDW_(DE)CONFIGURE_CPU seems to be unimplemented in
QEMU.

Anyway, we need some architecture agreement here first (something that is
also ok with LPAR and z/VM).


> But yes, I can add "currently".
> 
