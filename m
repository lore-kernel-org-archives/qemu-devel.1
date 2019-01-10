Received: from eggs.gnu.org ([209.51.188.92]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghcwz-0006uD-Rm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghcwy-0007wD-NM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1ghcwy-0007vk-Bx
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0AG9GEu072207
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 11:12:54 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2px5w634ea-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 11:12:54 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 10 Jan 2019 16:12:53 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-13-git-send-email-jjherne@linux.ibm.com>
	<20181214140428.6c677a48.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 10 Jan 2019 11:12:47 -0500
MIME-Version: 1.0
In-Reply-To: <20181214140428.6c677a48.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <39e59802-2ba9-e621-c339-6f870cd58754@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 12/15] s390-bios: Refactor virtio to run
 channel programs via cio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On 12/14/18 8:04 AM, Cornelia Huck wrote:
> On Wed, 12 Dec 2018 09:11:15 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Now that we have a Channel I/O library let's modify virtio boot code to
>> make use of it for running channel programs.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/virtio.c | 21 ++-------------------
>>   1 file changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index aa9da72..5fb49e2 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -92,30 +92,13 @@ int drain_irqs(SubChannelId schid)
>>   static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
>>   {
>>       Ccw1 ccw = {};
>> -    CmdOrb orb = {};
>> -    int r;
>> -
>> -    enable_subchannel(vdev->schid);
>> -
>> -    /* start subchannel command */
>> -    orb.fmt = 1;
>> -    orb.cpa = (u32)(long)&ccw;
>> -    orb.lpm = 0x80;
>>   
>>       ccw.cmd_code = cmd;
>>       ccw.cda = (long)ptr;
>>       ccw.count = len;
>>   
>> -    r = ssch(vdev->schid, &orb);
>> -    /*
>> -     * XXX Wait until device is done processing the CCW. For now we can
>> -     *     assume that a simple tsch will have finished the CCW processing,
>> -     *     but the architecture allows for asynchronous operation
>> -     */
>> -    if (!r) {
>> -        r = drain_irqs(vdev->schid);
>> -    }
>> -    return r;
>> +    enable_subchannel(vdev->schid);
> 
> Preexisting, but I'm wondering why we enable the subchannel here and
> not just once?
> 
>> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
>>   }
>>   
>>   static void vring_init(VRing *vr, VqInfo *info)
> 
> 

Good question. It seems to be needed for the net-boot path. Here is the chain:

netmain.c : main()
netmain,c : net_init()
virtio-net.c : virtio_net_init()
virtio.c : virtio_setup_ccw()
virtio.c : run_ccw()

In this case the subchannel would not already be enabled. I suppose I *could* change it, 
but at this point I'm trying to limit how much more code I'm touching :). This patch set 
already touches a bit more code than I anticipated. Let me know what your thoughts are.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
