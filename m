Received: from eggs.gnu.org ([2001:4830:134:3::10]:47748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGqNX-0002Yd-P5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGqNT-0005uf-Dq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:28:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dGqNT-0005uN-4P
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:28:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v52HOxqF029472
	for <qemu-devel@nongnu.org>; Fri, 2 Jun 2017 13:28:45 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2au8r11ne4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 13:28:44 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 2 Jun 2017 18:28:42 +0100
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-3-david@redhat.com>
	<e70d08bd-bf75-4997-df7b-e64710046fc3@linux.vnet.ibm.com>
	<f1a8957a-9d13-efce-c0c4-b010ae4b6cd8@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 2 Jun 2017 19:28:37 +0200
MIME-Version: 1.0
In-Reply-To: <f1a8957a-9d13-efce-c0c4-b010ae4b6cd8@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e7465d88-84b3-8287-1e42-c5b60b514ef6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, jjherne@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, thuth@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net



On 06/01/2017 07:42 PM, David Hildenbrand wrote:
> On 01.06.2017 19:06, Jason J. Herne wrote:
>> On 05/31/2017 03:34 PM, David Hildenbrand wrote:
>>> Currently, under z/VM on a 0x2827, QEMU will detect a 0x2828 if no
>>> IBC value is provided. QEMU will simply take the last model of that HW
>>> generation, which happens to be the BC version.
>>>
>>> Let's improve our search for that case by selecting the latest CPU
>>> definition that matches the CPU type. This might still detect e.g. a
>>> GA2 version on a GA1 system, but as we don't have further information at
>>> hand, there isn't too much we can do about it.
>>>
>>
>> Isn't it better to choose the earliest machine possible in this case? 
>> Systems
>> are backwards compatible far more often than they are forwards compatible.
>>
>> Said in a more verbose way, I'd rather pretend to be a GA1 on a GA2 
>> (ignoring
>> some new features) than pretend to be a GA2 on a GA1 and attempt to use
>> something that does not exist.
>>
>> I'm sure you've thought of all of this though, so what am I missing?
>>
> 
> Hi Jason,
> 
> excellent question. And of course I thought of it:
> 
> Fact 1: All GAX models share the same base feature set. A GAX++ might
> support "more features".
> 
> Fact 2: Without an IBC, the guest can't detect the GA version.
> 
> a) If we have no IBC (esp. unblocked_ibc == 0), the IBC we will present
> to the guest in read_SCP_info() will be 0. The guest will not know which
> GA version it has. The problem of missing IBC propagates.
> 
> b) If we don't have a feature of the GA++ version, also our guest won't
> have it. So in summary, the guest also has no idea of its GA version.
> 
> So this gives more "flexibility" and is backwards compatible.
> 
> Think about it like this: You're running on 0x2827 GA2.
> 
> Old QEMU version indicated "0x2828 GA1 == 0x2827 GA2". After you updated
> QEMU, you suddenly detect "0x2827 GA1". You're previous libvirt guest
> might suddenly refuse to run.
> 
> So it boils down to "it's just a QEMU representation that is more
> flexible, the guest can't see the difference".
> 
> Thanks!
>
Your change makes a lot of sense, but ain't easy to understand IMHO.

Maybe integrating some of the discussion from above into the commit
message would be helpful. Especially this assumption that the client code
is fine with getting a more recent GA version (and anything influenced by
it) if the ec_ga parameter is (basically) invalid, because ec_ga invalid
means no IBC, and that (somehow) ensures the guest will be unaware of the
picked GA (and everything affected by it)

I do understand that your patch is clearly superior to what we have now,
but I'm sill not sure why are we picking the last and not the firs one
with the matching type (and not necessarily matching ec_ga).  I guess the
solution is to be sought along 'more "flexibility".  That would mean the
GA does not matter for the guest, but matters for something else (QEMU,
libvirt, I do not know).

But if it matters, then for some to me unknown reasons newer GA must be
safe there too. Fact is (by picking the last one) the algorithm ain't
stable against appending a new GA to the list in a new qemu version
(that's why I assume it must be safe).

Let me add one meta comment too. IMHO what makes the function hard to
understand, is that we have a bunch of optional parameters, and that
although this seems to be some sort of approximation problem (find the
best good enough), the metric ain't obvious for somebody not to familiar
with the problem domain (like me). AFAIU you are fixing the following
problem domain (me). Seems that the metric implemented was sub-optimal:
if parameters present {type}, absent {ec_ga} maybe present {gen,
features}, then type is not honored appropriately.  One can probably
figure out what's intended by understanding all the usages (which makes
reviewing it demanding). For instance, you also refer to a particular
usage in your title/subject (that is "model->def =
s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
ibc_ec_ga(unblocked_ibc), NULL);" in target/s390x/kvm.c).

Since I agree it's an improvement:

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/cpu_models.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 9e23535..b6220c8 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -184,6 +184,7 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>>>                                      S390FeatBitmap features)
>>>  {
>>>      const S390CPUDef *last_compatible = NULL;
>>> +    const S390CPUDef *matching_cpu_type = NULL;
>>>      int i;
>>>
>>>      if (!gen) {
>>> @@ -218,8 +219,16 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>>>          if (def->type == type && def->ec_ga == ec_ga) {
>>>              return def;
>>>          }
>>> +        /* remember if we've at least seen one with the same cpu type */
>>> +        if (def->type == type) {
>>> +            matching_cpu_type = def;
>>> +        }
>>>          last_compatible = def;
>>>      }
>>> +    /* prefer the model with the same cpu type, esp. don't take the BC for EC */
>>> +    if (matching_cpu_type) {
>>> +        return matching_cpu_type;
>>> +    }
>>>      return last_compatible;
>>>  }
>>>
>>
> 
> 
