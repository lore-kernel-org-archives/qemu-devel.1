Received: from eggs.gnu.org ([2001:4830:134:3::10]:47823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwpyp-0003a0-5v
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwpyl-0004up-V2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42257
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwpyl-0004uX-Oc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QDTbAm052061
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:32:48 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d7p99fqw8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:32:47 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 14:32:45 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-4-borntraeger@de.ibm.com>
	<a19a2b4f-af68-12d1-ee34-fbd174785c6f@redhat.com>
	<fc891aa4-d6f1-7348-3de7-cfa06ffa20c8@de.ibm.com>
	<49e66ee4-2df2-c310-93a7-e4ec91217c32@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 15:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <49e66ee4-2df2-c310-93a7-e4ec91217c32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cb323145-86e9-04b9-cb61-90bfabcf2c3a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 3/3] s390x/ais: disable ais for compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 09/26/2017 03:00 PM, David Hildenbrand wrote:

> 
> Wonder when we can finally let go of these hacks. The host cpu model is
> not migration safe, therefore such things are expected to not work. Just
> think about trying to migrate from a kernel without AIS support to a
> kernel with AIS support. It is broken.
> 
> AIS is just one feature that actually tells you that you are currently
> doing something evil. Other CPU features you lose on the way simply
> don't result in an error, but still migration could break silently
> afterwards, when the guest assumes it has certain CPU features.
> 
> 
> The main problem is that we have machines <= 2.7 that had no CPU model
> support. For these machines, migration should work just fine, as
> 	s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)
> will always return false.
> However, the guest will be presented the AIS bit, as soon as the
> capability is enabled (as we then don't manually set the stfle bitmap
> from QEMU), which is bad.
> 
> So my point would be: don't turn on these new facilities if the cpu
> model is not allowed (<=2.7), but don't add ais_allowed() compat
> handling for any newer machines. If they use the host model, they have
> to assume that migration can break.
> 
> I think using cpu_model_allowed() would be just fine to be used instead
> of ais_allowed().

Let me thing about that. I will send 2 (with fs->ais_supported gone) and 3
and we can then decide if we only want to apply 2 or both.

Now: regarding your -cpu host comment:

I checked all the migration stuff now with -cpu z13 and it seems that
migration is now broken for qemu 2.10->qemu 2.11 when using the s390-ccw-virtio-2.9
machine due to the PCI fencing from Conny.

qemu-system-s390x: Unknown savevm section or instance 'PCIBUS' 0
qemu-system-s390x: load of migration failed: Invalid argument
