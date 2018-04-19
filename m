Received: from eggs.gnu.org ([2001:4830:134:3::10]:38315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f94yc-0005fc-Rk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f94yb-0004FU-TD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:31:34 -0400
References: <20180413181401.46318-1-vsementsov@virtuozzo.com>
	<20180413181401.46318-3-vsementsov@virtuozzo.com>
	<dc98f4cc-e863-2c1a-9729-a049229a40e6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1641dac5-5322-4c72-6123-631e6f0f64ac@virtuozzo.com>
Date: Thu, 19 Apr 2018 11:31:21 +0300
MIME-Version: 1.0
In-Reply-To: <dc98f4cc-e863-2c1a-9729-a049229a40e6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com, armbru@redhat.com, jsnow@redhat.com

18.04.2018 17:05, Eric Blake wrote:
> On 04/13/2018 01:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>> "qemu:dirty-bitmap:<export bitmap name>".
>>
>> With new metadata context negotiated, BLOCK_STATUS query will reply
>> with dirty-bitmap data, converted to extents. New public function
>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>> may be exported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h |   6 ++
>>   nbd/server.c        | 234 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>   2 files changed, 224 insertions(+), 16 deletions(-)
>>
>>   
>> +/* nbd_meta_bitmap_query
>> + *
>> + * Handle query to 'qemu-dirty-bitmap' namespace.
> Stale comment
>
>> + * 'len' is the amount of text remaining to be read from the current name, after
>> + * the 'qemu-dirty-bitmap:' portion has been stripped.
> and again
>
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_meta_bitmap_query(NBDClient *client, NBDExportMetaContexts *meta,
>> +                                 uint32_t len, Error **errp)
>> +{
>> +    if (!client->exp->export_bitmap) {
>> +        return nbd_opt_skip(client, len, errp);
>> +    }
>> +
>> +    return nbd_meta_single_query(
>> +            client, client->exp->export_bitmap_context + strlen("qemu:"), len,
>> +            &meta->dirty_bitmap, errp);
> Wait, so client->exp->export_bitmap_context is stored WITH the "qemu:"
> prefix as part of the name?
>
> During _LIST, you are allowing a query of "qemu:" to list all
> qemu-specific contexts (namely, qemu:dirty-bitmap:<export-name>); but
> should we also make it work that if you do "qemu:dirty-bitmap:", you get
> a list of just dirty-bitmap contexts even if "qemu:" has added other
> contexts in the meantime?

reasonable.

>
>> @@ -1800,6 +1851,94 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>>       return nbd_co_send_extents(client, handle, &extent, 1, context_id, errp);
>>   }
>>   
>> +/* Set several extents, describing region of given @length with given @flags.
>> + * Do not set more than @nb_extents, return number of set extents.
>> + */
>> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
>> +                            uint64_t length, uint32_t flags)
>> +{
>> +    unsigned i = 0;
>> +    uint32_t max_extent = QEMU_ALIGN_DOWN(INT32_MAX, 512);
>> +    /* TODO: should be somehow in agreement with blocksize of OPT_GO,
>> +     * and this should be documented in NBD proto. */
> nbd.git commit 218c446 documented that descriptor lengths MUST be an
> integer multiple of minimum block size; as for maximum, I see no reason
> why BLOCK_STATUS can't report larger extents than what NBD_CMD_READ can
> do.  Do we need further doc tweaks to nbd.git?
>

ok, missed it.

-- 
Best regards,
Vladimir
