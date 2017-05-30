Received: from eggs.gnu.org ([2001:4830:134:3::10]:49489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfrs-0003DT-SK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfrp-0000xl-QG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFfrp-0000xh-KL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:03:17 -0400
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-4-aurelien@aurel32.net>
	<b2da0fdb-f964-8d2f-e364-b91a0595d4e0@redhat.com>
	<20170530111836.24e2doi3qg763uah@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9dd0bb71-71e7-1cf1-e9aa-ddd103d8cb77@redhat.com>
Date: Tue, 30 May 2017 14:03:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170530111836.24e2doi3qg763uah@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/29] target/s390x: implement
 local-TLB-clearing in IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 30.05.2017 13:18, Aurelien Jarno wrote:
> On 2017-05-30 11:01, Thomas Huth wrote:
>> On 29.05.2017 21:24, Aurelien Jarno wrote:
>>> And at the same time make IPTE SMP aware.
>>>
>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>> ---
>>>  target/s390x/helper.h     |  2 +-
>>>  target/s390x/mem_helper.c | 19 ++++++++++++-------
>>>  target/s390x/translate.c  |  6 +++++-
>>>  3 files changed, 18 insertions(+), 9 deletions(-)
>> [...]
>>> @@ -1092,13 +1091,19 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr)
>>>  
>>>      /* XXX we exploit the fact that Linux passes the exact virtual
>>>         address here - it's not obliged to! */
>>> -    tlb_flush_page(cs, page);
>>> +    /* XXX: the LC bit should be considered as 0 if the local-TLB-clearing
>>> +       facility is not installed.  */
>>
>> That should be easy, I think:
>>
>>     if (!s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
>>         m4 = 0;
>>     }
> 
> I agree, it should be easy to implement. The reason I haven't implemented
> it is that we currently don't have a good model for the TCG CPU, so we
> don't have a way to easily enable it or not (though that is changing a
> bit with your later patches). In practice we expose supported features
> through STFL/SFTLE, but we don't do any check to see if the features or
> instructions are enable or not.

OK, fair, ... and your patch clearly marks this spot with an XXX, so we
can revise this later. So:

Reviewed-by: Thomas Huth <thuth@redhat.com>
