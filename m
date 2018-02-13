Received: from eggs.gnu.org ([2001:4830:134:3::10]:49033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elZiy-0002O3-3v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elZiv-00088D-02
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:30:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elZiu-00087h-OM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:30:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DCS14O123685
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:30:11 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3wsedxhw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:30:11 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 12:30:08 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212131504.1243e696@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 13:30:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180212131504.1243e696@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <9757bd46-06f2-1ce2-9cbd-9118c4a6cb9c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On 12.02.2018 19:15, Luiz Capitulino wrote:
> On Mon, 12 Feb 2018 13:14:32 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> -{ 'struct': 'CpuInfoFast',
>> -  'data': {'cpu-index': 'int', 'qom-path': 'str',
>> -           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
>> +{ 'union': 'CpuInfoFast',
>> +  'base': {'cpu-index': 'int', 'qom-path': 'str',
>> +           'thread-id': 'int', '*props': 'CpuInstanceProperties',
>> +           'arch': 'CpuInfoArch' },
>> +  'discriminator': 'arch',
>> +  'data': { 'x86': 'CpuInfoOther',
>> +            'sparc': 'CpuInfoOther',
>> +            'ppc': 'CpuInfoOther',
>> +            'mips': 'CpuInfoOther',
>> +            'tricore': 'CpuInfoOther',
>> +            's390': 'CpuInfoS390Fast',
>> +            'other': 'CpuInfoOther' } }
> 
> Consider this a minor comment (and QMP maintainers can give a much
> better advice than me), but I think this arch list has problems. For
> one thing, it's incomplete. And the second problem is the 'other'
> field. What happens when QEMU starts supporting a new arch? 'other'
> becomes the new arch. Is this compatible? I don't know.
This seems to be the customary approach, see
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01986.html
> 
> I don't know if this would work with the QAPI, but you could have
> a '*arch-data' field in the CpuInfoFast definition, like:
> 
> 'data': { ..., '*arch-data': 'CpuInfoFastArchData' }
> 
> where 'CpuInfoFastArchData' is defined by each arch that supports
> the field. An arch supporting the field could also export a
> query_cpus_fast_arch() function, which is called by qmp_query_cpus_fast().
> 
I had it like this in my first reply to your initial patch. However,
that adds an additional hierarchy level in the return data. This
prevents clients like libvirt to reuse the data extraction code when
they switch over to using query-cpus-fast.

-- 
Regards,
 Viktor Mihajlovski
