Received: from eggs.gnu.org ([2001:4830:134:3::10]:48819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk6th-000690-Ma
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk6tc-0007j7-SR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:59:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170822103126.3aeusdpvr55iwhym@postretch>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-4-el13635@mail.ntua.gr>
	<w51ziatm05h.fsf@maestria.local.igalia.com>
	<20170821153948.agdtsvy3m5u4jfip@postretch>
	<w51bmn7hqlz.fsf@maestria.local.igalia.com>
	<20170822103126.3aeusdpvr55iwhym@postretch>
Date: Tue, 22 Aug 2017 12:58:54 +0200
Message-ID: <w518tibhnrl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] block: require job-id when device
 is a node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 22 Aug 2017 12:31:26 PM CEST, Manos Pitsidianakis wrote:
> On Tue, Aug 22, 2017 at 11:57:28AM +0200, Alberto Garcia wrote:
>>On Mon 21 Aug 2017 05:39:48 PM CEST, Manos Pitsidianakis wrote:
>>>>> -    if (job_id == NULL && !(flags & BLOCK_JOB_INTERNAL)) {
>>>>> -        job_id = bdrv_get_device_name(bs);
>>>>> -        if (!*job_id) {
>>>>> -            error_setg(errp, "An explicit job ID is required for this node");
>>>>> -            return NULL;
>>>>> -        }
>>>>> -    }
>>>>> -
>>>>> -    if (job_id) {
>>>>> -        if (flags & BLOCK_JOB_INTERNAL) {
>>>>> +    if (flags & BLOCK_JOB_INTERNAL) {
>>>>> +        if (job_id) {
>>>>>              error_setg(errp, "Cannot specify job ID for internal block job");
>>>>>              return NULL;
>>>>>          }
>>>>
>>>>When BLOCK_JOB_INTERNAL is set, then job_id must be NULL...
>>>>
>>>>> -
>>>>> +    } else {
>>>>> +        /* Require job-id. */
>>>>> +        assert(job_id);
>>>>>          if (!id_wellformed(job_id)) {
>>>>>              error_setg(errp, "Invalid job ID '%s'", job_id);
>>>>>              return NULL;
>>>>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>>>>> index f13ad05c0d..ff906808a6 100644
>>>>> --- a/include/block/blockjob_int.h
>>>>> +++ b/include/block/blockjob_int.h
>>>>> @@ -112,8 +112,7 @@ struct BlockJobDriver {
>>>>>
>>>>>  /**
>>>>>   * block_job_create:
>>>>> - * @job_id: The id of the newly-created job, or %NULL to have one
>>>>> - * generated automatically.
>>>>> + * @job_id: The id of the newly-created job, must be non %NULL.
>>>>
>>>>...but here you say that it must not be NULL.
>>>>
>>>>And since job_id can be NULL in some cases I think I'd replace the
>>>>assert(job_id) that you added to block_job_create() with a normal
>>>>pointer check + error_setg().
>>>>
>>>>> @@ -93,9 +93,6 @@ static void test_job_ids(void)
>>>>>      blk[1] = create_blk("drive1");
>>>>>      blk[2] = create_blk("drive2");
>>>>>
>>>>> -    /* No job ID provided and the block backend has no name */
>>>>> -    job[0] = do_test_id(blk[0], NULL, false);
>>>>> -
>>>>
>>>>If you decide to handle NULL ids by returning and error instead of
>>>>asserting, we should keep a couple of tests for that scenario.
>>>>
>>>>Berto
>>>>
>>>
>>> Thanks, I will change that. What cases are you thinking of besides
>>> internal jobs though?
>>
>>Both cases (external job with a NULL id and internal job with non-NULL
>>id), checking that block_job_create() does return an error.
>
> I thought we handled the external job case by requiring job_id is set 
> before calling block_job_create(). I will check my patch again.

Yes, that appears to be checked correctly, I don't think you can call
block_job_create() directly with a NULL id for external block job.

But I also don't see how you can create an internal job with a non-NULL
id, so you could assert() there as well.

Either assert on both places or use error_setg() in both places. I think
I prefer the latter.

Berto
