Received: from eggs.gnu.org ([2001:4830:134:3::10]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fvJoP-0003RH-JT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fvJo9-0008Na-NH
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:04:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d3ea4f66-e8f3-35a2-1c3b-dcedb989827a@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
	<d3ea4f66-e8f3-35a2-1c3b-dcedb989827a@redhat.com>
Date: Thu, 30 Aug 2018 12:04:01 +0200
Message-ID: <w51bm9kmar2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/9] block: Allow changing 'discard' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 29 Aug 2018 01:39:10 PM CEST, Max Reitz wrote:
> On 2018-08-26 16:09, Alberto Garcia wrote:
>> 'discard' is one of the basic BlockdevOptions available for all
>> drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
>> the user cannot change it and doesn't get an error explaining that it
>> can't be changed.
>> 
>> This should update the discard setting, but does nothing:
>> 
>>    (qemu) qemu-io virtio0 "reopen -o discard=on"
>> 
>> Since there's no reason why we shouldn't allow changing it and the
>> implementation is simple let's just do it.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/block.c b/block.c
>> index 804d557608..21f1eb9cd1 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3178,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>>  
>>      update_flags_from_options(&reopen_state->flags, opts);
>>  
>> +    value = qemu_opt_get(opts, "discard");
>> +    if (value != NULL) {
>> +        if (bdrv_parse_discard_flags(value, &reopen_state->flags) != 0) {
>> +            error_setg(errp, "Invalid discard option");
>> +            ret = -EINVAL;
>> +            goto error;
>> +        }
>> +    }
>> +
>>      /* node-name and driver must be unchanged. Put them back into the QDict, so
>>       * that they are checked at the end of this function. */
>>      value = qemu_opt_get(opts, "node-name");
>
> Hm.  Why not just use the same "trick" here as in your last patch,
> i.e.  use qemu_opt_get_del() above and then qemu_opts_to_qdict() to
> return all unhandled options to the QDict?

Sure, I could do that and therefore forbid changing all of these
options. But as I said in the commit message, there's no reason why we
should not allow changing them.

Berto
