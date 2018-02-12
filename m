Received: from eggs.gnu.org ([2001:4830:134:3::10]:36534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elGqJ-0006Kj-Qw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elGqF-0006CP-Sj
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:20:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elGqF-0006AY-Iy
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:20:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CGJkMU118462
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:20:28 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3c5spktu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:20:27 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 16:20:25 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212165228.2021b4d4.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 17:20:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180212165228.2021b4d4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <f1fa0d61-bda9-e6e2-0b71-aa851a87f855@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On 12.02.2018 16:52, Cornelia Huck wrote:
> On Mon, 12 Feb 2018 13:14:30 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> Presently s390x is the only architecture not exposing specific
>> CPU information via QMP query-cpus. Upstream discussion has shown
>> that it could make sense to report the architecture specific CPU
>> state, e.g. to detect that a CPU has been stopped.
>>
>> With this change the output of query-cpus will look like this on
>> s390:
>>
>>    [
>>      {"arch": "s390", "current": true,
>>       "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>>       "qom_path": "/machine/unattached/device[0]",
>>       "halted": false, "thread_id": 63115},
>>      {"arch": "s390", "current": false,
>>       "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>>       "qom_path": "/machine/unattached/device[1]",
>>       "halted": true, "thread_id": 63116}
>>    ]
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> Acked-by: Eric Blake <eblake@redhat.com>
>> ---
>>  cpus.c                     |  6 ++++++
>>  hmp.c                      |  4 ++++
>>  hw/intc/s390_flic.c        |  4 ++--
>>  hw/s390x/s390-virtio-ccw.c |  2 +-
>>  qapi-schema.json           | 28 +++++++++++++++++++++++++++-
>>  target/s390x/cpu.c         | 24 ++++++++++++------------
>>  target/s390x/cpu.h         |  7 ++-----
>>  target/s390x/kvm.c         |  8 ++++----
>>  target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>>  9 files changed, 77 insertions(+), 44 deletions(-)
> 
> Patch looks good to me. I presume this should go through the s390 tree?
> Or do we want someone to pick up the whole series?
> 
The main reason for adding this patch to the series is to ensure
everything is applied in proper order. This patch can stand for itself,
but it must be applied before 3/3.
Valid orders would be 1 - 2 - 3 or 2 - 1 - 3.
As long as this is observed, I'm fine with either way.

-- 
Regards,
 Viktor Mihajlovski
