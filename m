Received: from eggs.gnu.org ([2001:4830:134:3::10]:43389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dugnl-0008SE-3J
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dugnf-0004rr-4d
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:20:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55734
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dugne-0004rU-Tc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:20:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KAsc05118523
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:56:21 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3phjsv9u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:56:20 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 11:56:19 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-4-pasic@linux.vnet.ibm.com>
	<20170920095818.17c52249.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 12:56:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170920095818.17c52249.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dca2591a-e1ee-2a70-e4ea-33923f69e7be@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/20/2017 09:58 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 20:27:43 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Replace direct access which implicitly assumes no IDA
>> or MIDA with the new ccw data stream interface which should
>> cope with these transparently in the future.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/virtio-ccw.c | 157 +++++++++++++++-----------------------------------
>>  1 file changed, 46 insertions(+), 111 deletions(-)
>>
> 
>> @@ -417,9 +382,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>                  /* Return zeroes if the guest supports more feature bits. */
>>                  features.features = 0;
>>              }
>> -            address_space_stl_le(&address_space_memory, ccw.cda,
>> -                                 features.features, MEMTXATTRS_UNSPECIFIED,
>> -                                 NULL);
>> +            ccw_dstream_rewind(&sch->cds);
>> +            cpu_to_le32s(&features.features);
>> +            ccw_dstream_write(&sch->cds, features.features);
>>              sch->curr_status.scsw.count = ccw.count - sizeof(features);
> 
> Hm, didn't you want to convert these as well? Or do you plan to do it
> as an add-on patch?
> 

I plan to do it as an add on patch.


>>              ret = 0;
>>          }
> 
