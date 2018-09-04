Received: from eggs.gnu.org ([2001:4830:134:3::10]:34893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxE1T-0003VO-3k
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxE1S-0007W0-CP
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 12:17:47 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-7-jsnow@redhat.com>
	<97a9bb99-2894-3185-da39-b214f5f8e92f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f8702376-7948-e5a0-928b-096659fbdee6@redhat.com>
Date: Tue, 4 Sep 2018 12:17:39 -0400
MIME-Version: 1.0
In-Reply-To: <97a9bb99-2894-3185-da39-b214f5f8e92f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/15] block/mirror: conservative
 mirror_exit refactor
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



On 09/03/2018 05:32 AM, Max Reitz wrote:
> On 2018-09-01 00:28, John Snow wrote:
>> For purposes of minimum code movement, refactor the mirror_exit
>> callback to use the post-finalization callbacks in a trivial way.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 31 +++++++++++++++++++++++++------
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index c164fee883..5067f1764d 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
> 
> [...]
> 
>> @@ -617,7 +618,13 @@ static void mirror_exit(Job *job)
>>      BlockDriverState *target_bs = blk_bs(s->target);
>>      BlockDriverState *mirror_top_bs = s->mirror_top_bs;
>>      Error *local_err = NULL;
>> -    int ret = job->ret;
>> +    bool abort = !!job->ret;
> 
> I think "job->ret < 0" could be read more easily.

Hm, OK. We shouldn't be using > 0 retcodes anyway.

> 
>> +    int ret = 0;
>> +
>> +    if (s->prepared) {
>> +        return 0;
>> +    }
>> +    s->prepared = true;
>>  
>>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
>>  
> 
> [...]
> 
>> @@ -712,7 +719,17 @@ static void mirror_exit(Job *job)
>>      bdrv_unref(mirror_top_bs);
>>      bdrv_unref(src);
>>  
>> -    job->ret = ret;
>> +    return ret;
>> +}
>> +
>> +static int mirror_prepare(Job *job)
>> +{
>> +    return mirror_exit_common(job);
>> +}
>> +
>> +static void mirror_abort(Job *job)
>> +{
>> +    assert(mirror_exit_common(job) == 0);
> 
> You shouldn't execute vital code in assert(), as NDEBUG would make that
> code disappear.  As far as I know, we have decided (at some point) not
> to ever enable NDEBUG in qemu, but, you know.  Doing it right only costs
> one more line, and it would get you a
> 

d'oh.

> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>>  }
>>  
>>  static void mirror_throttle(MirrorBlockJob *s)
> 
