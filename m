Received: from eggs.gnu.org ([209.51.188.92]:40564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH6fK-0005gp-TT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH6fJ-0000Y8-Nr
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:01:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH6fJ-0000V1-Cu
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:01:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3ID0tBq091958
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 09:01:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxq7272gk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 09:01:15 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 14:00:59 +0100
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
	<295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 15:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <806bf939-6560-1fae-f112-60094bd425e7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] s390x/cpumodel: remove CSSKE from
 base model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>



On 18.04.19 14:45, David Hildenbrand wrote:
> On 18.04.19 13:31, Christian Borntraeger wrote:
>> conditional sske is deprecated and a distant future machine (will be one
>> where the IBC will not allow to fully go back to z14) will remove this
>> feature. To prepare for this and allow for the z14 and older cpu model
>> to still run on systems without csske, remove csske from the base (and
> 
> will csske feature be a default feature for zNext? Or is it not
> available *at all*.
> 
> In case it is not available, baselining and cpu model comparison have to
> be thought about "ignoring csske".
> 
>> thus the default models for z10..z14). For compat machines we have to
>> add those back.
> 
> Base models are machine-independent. That means, changing base models is
> not supported.

Why is that? for the expansion?

> Once we introduce new models like here, we can set the
> new base models into stone.

the new model is easy (and yes I could only disable CSSKE in the base
model for gen15 but not for gen14. 

The problem is that without some kind of fixup for older base models like
z10-z14 expansion will fall back to z9 on anything that no longer has
csske. 

> 
>>
[....]
>>
> 
> Instead of doing that, can we rather start generating the next
> generation "fresh", listing all base model features it contains instead
> of doing it incrementally? Could end up "nicer"
> 
> 
> In target/s390x/cpu_models.c we have:
> 
> "... For now, base features of a following release are always a subset
> of base features of the previous release. Same is correct for the other
> feature sets."
> 
> This is especially relevant for "s390_find_cpu_def", and goes into the
> direction of baselining, as previously mentioned.
> 
> Luckily, we already have "ignored_base_feat", maybe we can simply add
> csske there and have it working.

Yes, maybe we could ignore csske. 
