Received: from eggs.gnu.org ([2001:4830:134:3::10]:48870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d9GXL-0002pG-Nn
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d9GXK-0003G8-HP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:47:39 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
Date: Fri, 12 May 2017 15:47:29 -0400
MIME-Version: 1.0
In-Reply-To: <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org



On 05/12/2017 03:46 PM, Eric Blake wrote:
> On 05/12/2017 01:07 PM, Max Reitz wrote:
>> On 2017-05-11 20:27, John Snow wrote:
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1213786
>>>
>>> Or, rather, force the open of a backing image if one was specified
>>> for creation. Using a similar -unsafe option as rebase, allow qemu-img
>>> to ignore the backing file validation if possible.
>>>
> 
>>> +++ b/block.c
>>> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>>      // The size for the image must always be specified, with one exception:
>>>      // If we are using a backing file, we can obtain the size from there
>>>      size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>>> -    if (size == -1) {
>>
>> "Hang on, why should this be -1 when the defval is 0? Where does the -1
>> come from?"
>> "..."
>> "Oh, the option exists and is set to -1? Why is that?"
>> "..."
>> "Oh, because this function always sets it itself, and because @img_size
>> is set to (uint64_t)-1."
> 
> I had pretty much the same conversation on my v1 review.
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01097.html
> 
>>
>> First, I won't start with how signed integer overflow is
>> implementation-defined in C because I hope you have thrashed that out
>> with Eric (I hope that "to thrash out" is a good translation for
>> "auskaspern" (lit. "to buffoon out").).
> 
> Sounds like a reasonable choice of words, even if I don't speak the
> counterpart language to validate your translation.
> 
> (uint64_t)-1 is well-defined in C (so I think we're just fine here). But
> (int64_t)UINT64_MAX is where signed integer overflow does indeed throw
> wrinkles at you.
> 
> I seem to recall that qemu has chosen to use compiler flags and/or
> assumptions that we are using 2s-complement arithmetic with sane
> behavior (that is, tighter behavior than the bare minimum that C
> requires), because it was easier than auditing our code for strict C
> compliance on border cases of conversions from unsigned to signed that
> trigger undefined behavior.  But again, I don't think it affects this
> patch (where our conversion is only from signed to unsigned, and that is
> well-defined behavior).
> 
> 
>>
>> Second, well, at least we should put -1 as the default value here, then.
> 
> Indeed, now that two reviewers have tripped on it,
> qemu_opt_get_size(,,-1) would be nicer.
> 
>>
>> Not strictly your fault or something that you need to fix, but it is
>> just a single line in the vicinity...
>>
>> Let me know if you want to address this, for now I'll leave a
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> here if you don't want to.
> 
> I'm okay whether you want to squash that fix into this patch, or whether
> you do it as a separate followup patch.
> 

I had considered the issue separate; but you're welcome to either write
a patch or squish it into this one, I'm not going to be picky.

--js
