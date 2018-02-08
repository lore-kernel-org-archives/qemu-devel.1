Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejjD3-0002aW-8m
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejjCx-00033z-8i
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:13:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35902
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejjCx-00033v-2N
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:13:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18ABVuP140083
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 05:13:34 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0mdughum-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:13:33 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 10:13:32 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
	<5cb72a0b-5ff0-42ab-d992-ccdd2a565cfa@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 11:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <5cb72a0b-5ff0-42ab-d992-ccdd2a565cfa@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <cad670ad-e20c-dc6e-7d1c-65f2c9f6fd5d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, ehabkost@redhat.com

On 08.02.2018 08:41, Viktor Mihajlovski wrote:
> On 07.02.2018 18:50, Luiz Capitulino wrote:
>> The query-cpus command has an extremely serious side effect:
>> it always interrupt all running vCPUs so that they can run
>> ioctl calls. This can cause a huge performance degradation for
>> some workloads. And most of the information retrieved by the
>> ioctl calls are not even used by query-cpus.
>>
>> This commit introduces a replacement for query-cpus called
>> query-cpus-fast, which has the following features:
>>
>>  o Never interrupt vCPUs threads. query-cpus-fast only returns
>>    vCPU information maintained by QEMU itself, which should be
>>    sufficient for most management software needs
>>
>>  o Make "halted" field optional: we only return it if the
>>    halted state is maintained by QEMU. But this also gives
>>    the option of dropping the field in the future (see below)
>>
>>  o Drop irrelevant fields such as "current", "pc" and "arch"
> I disagree that arch is irrelevant and would strongly suggest to keep
> arch and arch-specific fields. At least in the case of s390 there's a
> cpu_state field that can be obtained cheaply.
I've posted a patch [1] to add s390-specific state info to the
query-cpus output. This state *can* be obtained without kicking the CPU
out of VM execution. With this info in the query-cpus-fast return data
we can eventually get rid of halted and its ramifications.
[...]

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02032.html
-- 
Regards,
 Viktor Mihajlovski
