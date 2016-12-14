Received: from eggs.gnu.org ([2001:4830:134:3::10]:37891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHDEd-0008PL-BX
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHDEY-0004Tr-9e
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHDEY-0004TX-4I
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:20:50 -0500
References: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
	<ef1f3b2a-d206-7082-3227-423e0d9d9619@redhat.com>
	<20161214170058.GJ3808@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abea10db-9da8-d6eb-c6eb-67817b1fadda@redhat.com>
Date: Wed, 14 Dec 2016 18:20:46 +0100
MIME-Version: 1.0
In-Reply-To: <20161214170058.GJ3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org, rth@twiddle.net



On 14/12/2016 18:00, Eduardo Habkost wrote:
> On Wed, Dec 14, 2016 at 05:55:07PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 14/12/2016 17:19, Vlad Lungu wrote:
>>> get_opt_value() truncates the value at the first comma.
>>> Use memcpy() instead.
>>
>> Looks good since get_opt_value is already used by the caller.  Have you
>> tested this with multiple initrd modules too?
> 
> get_opt_value() is used by the caller, but with NULL buf
> argument. This means the caller doesn't handle ",," escaping.
> (See my reply to the previous submission of this patch)

Hmm, wait.  When NULL is passed, ",," escaping is handled correctly in
that next_initrd points to the next lone comma.  The lone comma is
replaced with a '\0' by the caller.

So you need to use get_opt_value again in mb_add_cmdline to do the
unescaping, because mb_add_cmdline only receives double commas.

This was actually my first reaction to the patch, and it was correct.
Then I overthought it. :)

So the patch is wrong.

Paolo

> However this only means the caller is buggy, not
> mb_add_cmdline(). So the change still looks good to me.
> 
>>
>> Paolo
>>
>>> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
>>> ---
>>>  hw/i386/multiboot.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>>> index 387caa6..b4495ad 100644
>>> --- a/hw/i386/multiboot.c
>>> +++ b/hw/i386/multiboot.c
>>> @@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
>>>      hwaddr p = s->offset_cmdlines;
>>>      char *b = (char *)s->mb_buf + p;
>>>  
>>> -    get_opt_value(b, strlen(cmdline) + 1, cmdline);
>>> +    memcpy(b, cmdline, strlen(cmdline) + 1);
>>>      s->offset_cmdlines += strlen(b) + 1;
>>>      return s->mb_buf_phys + p;
>>>  }
>>>
> 
