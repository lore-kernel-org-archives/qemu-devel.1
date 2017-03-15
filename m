Received: from eggs.gnu.org ([2001:4830:134:3::10]:58418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co45J-0000Uw-W8
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co45G-00032s-0I
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:15:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1co45F-00032e-Qt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:15:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE226C04BD3A
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 08:15:01 +0000 (UTC)
References: <20170314113941.15362-1-pbonzini@redhat.com>
	<87mvcnnfbp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8ffc658-88a5-4e4d-0b2e-159ee1609ef2@redhat.com>
Date: Wed, 15 Mar 2017 09:14:59 +0100
MIME-Version: 1.0
In-Reply-To: <87mvcnnfbp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org



On 15/03/2017 08:56, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> When more complexity was added to facilitate inlining, Coverity
>> lost the ability to use the address_space_rw model for
>> address_space_read/write.
> 
> Got the commit hash of the change?
> 
>> This causes false positive defects when Coverity sees
>> a length-8 write in address_space_read and a length-4
>> (e.g. int*) buffer to read into.  As long as the size of
>> the buffer is okay, this is a false positive.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/coverity-model.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
>> index ee5bf9d..2e30150 100644
>> --- a/scripts/coverity-model.c
>> +++ b/scripts/coverity-model.c
>> @@ -79,6 +79,25 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
>>      return result;
>>  }
>>  
>> +MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>> +                               MemTxAttrs attrs,
>> +                               uint8_t *buf, int len)
>> +{
>> +    MemTxResult result;
>> +    __bufwrite(buf, len);
>> +    return result;
>> +}
>> +
>> +MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
>> +                                MemTxAttrs attrs,
>> +                                const uint8_t *buf, int len)
>> +{
>> +    MemTxResult result;
>> +    __bufread(buf, len);
>> +    return result;
>> +}
>> +
>> +
>>  /* Tainting */
>>  
>>  typedef struct {} name2keysym_t;
> 
> Preferably with the commit hash of the change that necessitates this
> update mentioned in the commit message:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> I can stick this in a miscellaneous pull request due later today.

Commit eb7eeb8 ("memory: split address_space_read and
address_space_write", 2015-12-17).  On the other hand, the model for
address_space_rw is not needed anymore, so I'll send v2.

Paolo
