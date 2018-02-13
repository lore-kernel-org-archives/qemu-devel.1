Received: from eggs.gnu.org ([2001:4830:134:3::10]:47404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elZZx-0003El-1g
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elZZu-0002TO-Ar
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:20:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41608
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elZZu-0002Se-54
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:20:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DCKMZI064837
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:20:53 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3ysj0d61-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:20:52 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 12:20:50 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212130301.1714d393@redhat.com>
	<5b46d287-cc8a-4d84-cbb4-d6d45e60135b@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 13:20:44 +0100
MIME-Version: 1.0
In-Reply-To: <5b46d287-cc8a-4d84-cbb4-d6d45e60135b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <e635d74e-cf95-20f2-07e4-3ccec08086b0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] qmp: expose s390-specific
 CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: agraf@suse.de, berrange@redhat.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, rth@twiddle.net

On 13.02.2018 12:16, David Hildenbrand wrote:
> On 12.02.2018 19:03, Luiz Capitulino wrote:
>> On Mon, 12 Feb 2018 13:14:30 +0100
>> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
>>
>>> Presently s390x is the only architecture not exposing specific
>>> CPU information via QMP query-cpus. Upstream discussion has shown
>>> that it could make sense to report the architecture specific CPU
>>> state, e.g. to detect that a CPU has been stopped.
>>>
>>> With this change the output of query-cpus will look like this on
>>> s390:
>>>
>>>    [
>>>      {"arch": "s390", "current": true,
>>>       "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>>>       "qom_path": "/machine/unattached/device[0]",
>>>       "halted": false, "thread_id": 63115},
>>>      {"arch": "s390", "current": false,
>>>       "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>>>       "qom_path": "/machine/unattached/device[1]",
>>>       "halted": true, "thread_id": 63116}
>>>    ]
>>
>> We're adding the same information to query-cpus-fast. Why do we
>> need to duplicate this into query-cpus? Do you plan to keep using
>> query-cpus? If yes, why?
> 
> Wonder if we could simply pass a flag to query-cpus "fast=true", that
> makes it behave differently. (either not indicate the critical values or
> simply provide dummy values - e.g. simply halted=false)
> 
That was one of the ideas in the earlier stages of this discussion (and
I was inclined to go that way initially). The major drawback of this
approach that the slow call is hard to deprecate (OK, one could change
the default to fast=true over time). It's easier to deprecate the entire
query-cpus function. The other issue, maybe not as bad, is that one has
to deal with fields that are suddenly optional or obsolete in way not
confusing every one.
Bottom line is that I'm convinced it's better to have both APIs and to
deprecate the slow one over time. But I have to confess I'm not familiar
with QAPI deprecation rules, maybe Eric can shed some light on this...
>>
>> Libvirt for one, should move away from it. We don't want to run
>> into the risk of having the same issue we had with x86 in other
>> archs.
>>
>>>
> 
> 


-- 
Regards,
 Viktor Mihajlovski
