Received: from eggs.gnu.org ([209.51.188.92]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqk7D-0007eS-MR
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqjyL-0006Ey-Vq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:32:04 -0500
References: <20190202011048.12343-1-jsnow@redhat.com>
	<6d3a1905-db14-cbbc-bdad-2f6da9dfaec5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <993f7476-a9f3-c587-01b1-7486a72904b8@redhat.com>
Date: Mon, 4 Feb 2019 14:26:36 -0500
MIME-Version: 1.0
In-Reply-To: <6d3a1905-db14-cbbc-bdad-2f6da9dfaec5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>



On 2/4/19 10:00 AM, Eric Blake wrote:
> On 2/1/19 7:10 PM, John Snow wrote:
>> The meaning of the states has changed subtly over time,
>> this should bring the understanding more in-line with the
>> current, actual usages.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> ---
>> V2: Amended some wordings, though this is a little chatty now.
>>     Hopefully it's clearer, though.
>> ---
> 
>>  /**
>> - * A BdrvDirtyBitmap can be in three possible states:
>> - * (1) successor is NULL and disabled is false: full r/w mode
>> - * (2) successor is NULL and disabled is true: read only mode ("disabled")
>> - * (3) successor is set: frozen mode.
>> - *     A frozen bitmap cannot be renamed, deleted, anonymized, cleared, set,
>> - *     or enabled. A frozen bitmap can only abdicate() or reclaim().
>> + * A BdrvDirtyBitmap can be in four possible user-visible states:
>> + * (1) Active:   successor is NULL, and disabled is false: full r/w mode
>> + * (2) Disabled: successor is NULL, and disabled is true: qualified r/w mode,
>> + *               guest writes are dropped, but monitor writes are possible,
>> + *               through commands like merge and clear.
>> + * (3) Frozen:   successor is not NULL.
>> + *               A frozen bitmap cannot be renamed, deleted, cleared, set,
>> + *               enabled, merged to, etc. A frozen bitmap can only abdicate()
>> + *               or reclaim().
>> + *               In this state, the anonymous successor bitmap may be either
>> + *               Active and recording writes from the guest (e.g. backup jobs),
>> + *               but it can be Disabled and not recording writes.
> 
> s/but/or/
> 

I'll touch that up.

>> + * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
>> + *               in any way from the monitor.
> 
> Worth a parenthetical comment mentioning NBD export as a possible reason
> for Locked to be visible?
> 

Since this is effectively developer documentation, yes. How about:

"Whether Active or Disabled, the user cannot modify this bitmap in any
way from the monitor. This mode is used to achieve a successor-less
locking of a bitmap for operations like point-in-time NBD export or for
incoming migration data."

> With the one word fix,
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

If Vladimir agrees with these phrasings I'll stage it.

--js
