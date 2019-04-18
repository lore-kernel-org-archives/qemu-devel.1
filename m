Received: from eggs.gnu.org ([209.51.188.92]:43330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6tQ-0001gQ-40
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6tP-0008Fo-3o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:15:56 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
	<295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
	<806bf939-6560-1fae-f112-60094bd425e7@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <27a9145b-676d-3f65-0584-8805108ed351@redhat.com>
Date: Thu, 18 Apr 2019 15:15:50 +0200
MIME-Version: 1.0
In-Reply-To: <806bf939-6560-1fae-f112-60094bd425e7@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 18.04.19 15:00, Christian Borntraeger wrote:
> 
> 
> On 18.04.19 14:45, David Hildenbrand wrote:
>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>> conditional sske is deprecated and a distant future machine (will be one
>>> where the IBC will not allow to fully go back to z14) will remove this
>>> feature. To prepare for this and allow for the z14 and older cpu model
>>> to still run on systems without csske, remove csske from the base (and
>>
>> will csske feature be a default feature for zNext? Or is it not
>> available *at all*.
>>
>> In case it is not available, baselining and cpu model comparison have to
>> be thought about "ignoring csske".
>>
>>> thus the default models for z10..z14). For compat machines we have to
>>> add those back.
>>
>> Base models are machine-independent. That means, changing base models is
>> not supported.
> 
> Why is that? for the expansion?

Yes, and baselining. It's what the QAPI interface promises.

> 
>> Once we introduce new models like here, we can set the
>> new base models into stone.
> 
> the new model is easy (and yes I could only disable CSSKE in the base
> model for gen15 but not for gen14. 
> 
> The problem is that without some kind of fixup for older base models like
> z10-z14 expansion will fall back to z9 on anything that no longer has
> csske. 

I'd prefer to do generate the "right" base models right away and not fix
them up at runtime. They should never change, so fixing them up at
runtime feels wrong.

>> Luckily, we already have "ignored_base_feat", maybe we can simply add
>> csske there and have it working.
> 
> Yes, maybe we could ignore csske. 
> 

Yes, that should at least avoid falling back to a z9.

-- 

Thanks,

David / dhildenb
