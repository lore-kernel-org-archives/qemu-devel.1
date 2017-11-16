Received: from eggs.gnu.org ([2001:4830:134:3::10]:34486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFErS-0003cF-5X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFErO-0006QP-OR
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:45:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57304
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eFErO-0006PN-J8
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:45:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAG7i78w147051
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 02:45:15 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e96ey88am-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 02:45:14 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Nov 2017 07:45:13 -0000
References: <20171115154223.109991-1-borntraeger@de.ibm.com>
	<20171115181034.5f0b624e.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Nov 2017 08:45:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171115181034.5f0b624e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <07ba2257-d6b4-2a57-1151-21f3a69b89d0@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390/kvm_virtio/linux-headers: remove
 traces of old virtio transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 11/15/2017 06:10 PM, Cornelia Huck wrote:
> On Wed, 15 Nov 2017 16:42:23 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> We no longer support the old s390 transport, neither does the newest
>> Linux kernel. Remove it from the linux header script as well as the
>> s390x virtio code.  We still should handle the VIRTIO_NOTIFY hypercall,
>> to tolerate early printk on older guest kernels without an sclp console.
> 
> Are there any such guests still around? Wouldn't they be unable to run
> because of the missing old transport anyway?

As far as I can see even an 4.13 will do

static int __init s390_virtio_console_init(void)
{
        if (sclp.has_vt220 || sclp.has_linemode)
                return -ENODEV;
        return virtio_cons_early_init(early_put_chars);
}
console_initcall(s390_virtio_console_init);

No matter if there is the old transport or not available.

So as soon as somebody chooses virtio-console you should see the diag500 from the early
printk.


> 
>> We continue to ignore these events.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-hcall.h                   |  6 ++-
>>  include/standard-headers/asm-s390/kvm_virtio.h | 64 --------------------------
>>  scripts/update-linux-headers.sh                |  1 -
>>  3 files changed, 4 insertions(+), 67 deletions(-)
>>  delete mode 100644 include/standard-headers/asm-s390/kvm_virtio.h
> 
