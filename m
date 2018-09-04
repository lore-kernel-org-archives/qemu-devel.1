Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxGo5-0004id-G2
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxGo4-00019E-JJ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:16:09 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-6-jsnow@redhat.com>
	<b79cdffa-a0d4-824c-b9fd-b5aba38e61bd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <00da6ab1-d2ca-8d66-7e22-8fc848b9d861@redhat.com>
Date: Tue, 4 Sep 2018 15:15:42 -0400
MIME-Version: 1.0
In-Reply-To: <b79cdffa-a0d4-824c-b9fd-b5aba38e61bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/15] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>



On 09/03/2018 05:24 AM, Max Reitz wrote:
> On 2018-09-01 00:28, John Snow wrote:
>> In cases where we abort the block/mirror job, there's no point in
>> installing the new backing chain before we finish aborting.
>>
>> Move this to the "success" portion of mirror_exit.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index cba555b4ef..c164fee883 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -642,16 +642,6 @@ static void mirror_exit(Job *job)
>>       * required before it could become a backing file of target_bs. */
>>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
>>                              &error_abort);
>> -    if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>> -        BlockDriverState *backing = s->is_none_mode ? src : s->base;
>> -        if (backing_bs(target_bs) != backing) {
>> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
>> -            if (local_err) {
>> -                error_report_err(local_err);
>> -                ret = -EPERM;
>> -            }
>> -        }
>> -    }
>>  
>>      if (s->to_replace) {
>>          replace_aio_context = bdrv_get_aio_context(s->to_replace);
>> @@ -659,9 +649,18 @@ static void mirror_exit(Job *job)
>>      }
>>  
>>      if (s->should_complete && ret == 0) {
>> -        BlockDriverState *to_replace = src;
>> -        if (s->to_replace) {
>> -            to_replace = s->to_replace;
>> +        BlockDriverState *to_replace = s->to_replace ? s->to_replace : src;
>> +
>> +        if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>> +            BlockDriverState *backing = s->is_none_mode ? src : s->base;
>> +            if (backing_bs(target_bs) != backing) {
>> +                bdrv_set_backing_hd(target_bs, backing, &local_err);
>> +                if (local_err) {
>> +                    error_report_err(local_err);
>> +                    ret = -EPERM;
>> +                    goto clean;
>> +                }
>> +            }
>>          }
>>  
>>          if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
> 
> Testing shows that on post-READY cancel, s->should_complete is 0 (which
> makes sense, because all the rest in this path is about replacing
> to_replace by target_bs, which we don't want to do on cancel), so this
> would not be executed.
> 
> However, I think we do want to give the target the correct backing chain
> when the job is canceled this way (as I suppose there are ways to keep
> the target around even with drive-mirror).
> 
> So we should attach the backing chain whenever ret == 0, not just when
> s->should_complete is true.
> 
> Max
> 

Ah, thank you for saving me from myself. I got too excited to have
everything under that one conditional.

post-script: I really, really hate the "fake cancel" we've implemented
for mirror. It makes the job logic so much worse.

--js

>> @@ -678,6 +677,8 @@ static void mirror_exit(Job *job)
>>              ret = -EPERM;
>>          }
>>      }
>> +
>> + clean:
>>      if (s->to_replace) {
>>          bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
>>          error_free(s->replace_blocker);
>>
> 
> 
