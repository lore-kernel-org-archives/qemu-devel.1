Received: from eggs.gnu.org ([2001:4830:134:3::10]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxZts-0003Xs-AJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxZtr-0002pn-EH
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:39:24 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-6-jsnow@redhat.com>
	<ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9cda4756-3bcf-01a9-5fbc-755a4e722581@redhat.com>
Date: Wed, 5 Sep 2018 11:39:14 -0400
MIME-Version: 1.0
In-Reply-To: <ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/15] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>



On 09/05/2018 06:40 AM, Max Reitz wrote:
> On 2018-09-04 19:09, John Snow wrote:
>> In cases where we abort the block/mirror job, there's no point in
>> installing the new backing chain before we finish aborting.
>>
>> Move this to the "success" portion of mirror_exit.
> 
> Sounds a bit weird now that you don't do any moving.
> 

I ought to proofread my commit messages when I make changes...

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index cba555b4ef..3365bcfdfb 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -642,7 +642,7 @@ static void mirror_exit(Job *job)
>>       * required before it could become a backing file of target_bs. */
>>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>>                              &error_abort);
>> -    if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>> +    if (ret == 0 && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>>          BlockDriverState *backing = s->is_none_mode ? src : s->base;
>>          if (backing_bs(target_bs) != backing) {
>>              bdrv_set_backing_hd(target_bs, backing, &local_err);
>> @@ -659,10 +659,7 @@ static void mirror_exit(Job *job)
>>      }
>>  
>>      if (s->should_complete && ret == 0) {
>> -        BlockDriverState *to_replace = src;
>> -        if (s->to_replace) {
>> -            to_replace = s->to_replace;
>> -        }
>> +        BlockDriverState *to_replace = s->to_replace ? s->to_replace : src;
>>  
>>          if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
>>              bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);
> 
> And this hunk now looks out of place.  Sure, it makes sense, but why is
> it in this patch now? :-)
> 
> (Moving it into the next patch would make more sense, I think.)
> 
> I'd like to give an R-b anyway, but I know that I shouldn't, so I won't.
> 
> Max
> 

I have to admit that my appetite for patch purity is just... low. I know
it's something we care a lot in the QEMU project, but after a number of
years I'm just not overwhelmed to care about it in any significant capacity.

I suppose the main argument for this practice is ease of backporting, yes?

--js
