Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboxO-00039w-IM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboxL-00020u-BU
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:44:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49368
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eboxL-0001zs-6t
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:44:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HEiESO035863
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:44:46 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fj7hq390f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:44:45 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 14:44:44 -0000
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<bd0d62c3-9243-931b-a539-b32b3fc19cf9@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 15:44:39 +0100
MIME-Version: 1.0
In-Reply-To: <bd0d62c3-9243-931b-a539-b32b3fc19cf9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2017497a-8b3c-2e06-b89b-e2b30c71d0d8@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 01/17/2018 03:30 PM, David Hildenbrand wrote:
> On 17.01.2018 15:18, Christian Borntraeger wrote:
>> We need to handle the bpb control on reset and migration. Normally
>> stfle.82 is transparent (and the normal guest part works without
>> hypervisor activity). To prevent any issues we require full
>> host kernel support for this feature.
> 
> Actually it is not transparent because we need hypervisor support to get
> VSIE running... or what am I missing? (or were you talking about bit 81?)

When you pass along the bit as a transparent bit (just enable it if the host
has it) it will work in nested guests. Its only that after reset or vsie you
have a short period of time where you work in a stale state.
Anyway we are aware that bit82 should have been a non-transparent bit, consider
it a quirk in the architecture. Thats why I handle this feature not in patch 3.
