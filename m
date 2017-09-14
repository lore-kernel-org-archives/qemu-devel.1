Received: from eggs.gnu.org ([2001:4830:134:3::10]:37038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsXLg-0000Jc-HM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsXLc-0007h5-93
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsXLb-0007fN-GK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:50:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EGoXwX064038
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:50:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyu309k4v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:50:37 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 17:50:33 +0100
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 18:50:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170914162603.1cdabd09.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
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



On 09/14/2017 04:26 PM, Cornelia Huck wrote:
> On Wed, 13 Sep 2017 15:27:51 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Add a fake device meant for testing the correctness of our css emulation.
>>
>> What we currently have is writing a Fibonacci sequence of uint32_t to the
>> device via ccw write. The write is going to fail if it ain't a Fibonacci
>> and indicate a device exception in scsw together with the proper residual
>> count.
>>
>> Of course lot's of invalid inputs (besides basic data processing) can be
>> tested with that as well.
>>
>> Usage:
>> 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
>>    on the command line
>> 2) exercise the device from the guest
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> Depends on the series 'add CCW indirect data access support'
>>
>> ---
>>  hw/s390x/Makefile.objs |   1 +
>>  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 180 insertions(+)
>>  create mode 100644 hw/s390x/ccw-tester.c
>>
> 
>> +static int  ccw_tester_write_fib(SubchDev *sch, CCW1 ccw)
>> +{
>> +    CcwTesterDevice *d = sch->driver_data;
>> +    bool is_fib = true;
>> +    uint32_t sum;
>> +    int ret = 0;
>> +
>> +    ccw_dstream_init(&sch->cds, &ccw, &sch->orb);
>> +    d->fib.next = 0;
>> +    while (ccw_dstream_avail(&sch->cds) > 0) {
>> +        ret = ccw_dstream_read(&sch->cds,
>> +                               d->fib.ring[abs_to_ring(d->fib.next)]);
>> +        if (ret) {
>> +            error(0, -ret, "fib");
>> +            break;
>> +        }
>> +        if (d->fib.next > 2) {
>> +            sum = (d->fib.ring[abs_to_ring(d->fib.next - 1)]
>> +                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
>> +            is_fib = sum ==  d->fib.ring[abs_to_ring(d->fib.next)];
> 
> This is not endian-safe (noticed while testing on my laptop). Trivial
> to fix:
> 
> diff --git a/hw/s390x/ccw-tester.c b/hw/s390x/ccw-tester.c
> index c8017818c4..a425daaa34 100644
> --- a/hw/s390x/ccw-tester.c
> +++ b/hw/s390x/ccw-tester.c
> @@ -58,9 +58,9 @@ static int  ccw_tester_write_fib(SubchDev *sch, CCW1 ccw)
>              break;
>          }
>          if (d->fib.next > 2) {
> -            sum = (d->fib.ring[abs_to_ring(d->fib.next - 1)]
> -                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
> -            is_fib = sum ==  d->fib.ring[abs_to_ring(d->fib.next)];
> +            sum = be32_to_cpu(d->fib.ring[abs_to_ring(d->fib.next - 1)])
> +                + be32_to_cpu(d->fib.ring[abs_to_ring(d->fib.next - 2)]);
> +            is_fib = sum == be32_to_cpu(d->fib.ring[abs_to_ring(d->fib.next)]);
>              if (!is_fib) {
>                  break;
>              }
> 

Nod. 

>> +            if (!is_fib) {
>> +                break;
>> +            }
>> +        }
>> +        ++(d->fib.next);
>> +    }
>> +    if (!is_fib) {
>> +        sch->curr_status.scsw.ctrl &= ~SCSW_ACTL_START_PEND;
>> +        sch->curr_status.scsw.ctrl |= SCSW_STCTL_PRIMARY |
>> +                                      SCSW_STCTL_SECONDARY |
>> +                                      SCSW_STCTL_ALERT |
>> +                                      SCSW_STCTL_STATUS_PEND;
>> +        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
>> +        sch->curr_status.scsw.cpa = sch->channel_prog + 8;
>> +        sch->curr_status.scsw.dstat =  SCSW_DSTAT_UNIT_EXCEP;
>> +        return -EIO;
>> +    }
>> +    return ret;
>> +}
>> +
> (...)
>> +static Property ccw_tester_properties[] = {
>> +    DEFINE_PROP_UINT16("cu_type", CcwTesterDevice, cu_type,
>> +                        0x3831),
> 
> 0x4711 would be nice :)

I don't understand the joke/pun/whatever if there is one,
but I'm fine with changing this too.

> 
> If we want to follow up on that testdev idea (and I think we should),
> it might make sense to have a proper type reserve to prevent accidental
> clashes.

I agree. Although I would still keep the cu_type configurable,
because it might make sense to test a particular 'real' driver
(and not a test driver like here). I haven't really thought
this through, but it was an idea I had while agonizing over
not having a proper type reserved.

I suppose you did something like that for virtio, or? I'm in dark
when it comes to the question what process do we/I have to go to
get a type,for example 0x4711, reserved.

> 
> (Or is there already something reserved for "hypervisor use" or
> whatever?)

Not that I know. I can't recall encountering a list of reserved
types. Honestly I've hoped to leverage your experience (again
because of virtio-ccw).

> 
>> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
>> +                       0x98),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
> 
> IIUC, pci-testdev provides some unit tests to testers (like kvm-tests)
> itself. This might be an idea to follow up on for ccw as well.
> 

I've just had a first look at pci-testdev, and it does appear to be a similar
concept. 

> There's quite some potential in this. We may want to make this a
> permanent addition.
> 

I'm happy to contribute! I'm not sure how shall we proceed though.
Maybe with making a todo list?
