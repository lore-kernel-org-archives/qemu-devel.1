Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0FBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4672720657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvdbB+Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4672720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalHo-00010u-AM
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jalGM-0007sT-Nf
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:17:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jalGG-0005pn-Oa
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589829435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvoHOKex4kW5h2K26qcKL1T/cl7jVLgFUQ7GIePhcuQ=;
 b=IvdbB+GiK8JQh7PVpDHVZshpKkFKNwVzAlJmXBBEfi0WbZ4Ou34LG5CSJlwGfSzJJVNNLB
 lbCx1VsqpLDvqKCH0GpdYlGgnyWaT7s2g7wp6fOtRCL7ll6IfwEbCuHPzhYNtjpbZIfTgb
 ydxkvhwzpfUOaQS3eRkksW+dMSRXHzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-SfamcyrwPbO2VJX7MWQ61Q-1; Mon, 18 May 2020 15:17:11 -0400
X-MC-Unique: SfamcyrwPbO2VJX7MWQ61Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF31C835B8C;
 Mon, 18 May 2020 19:17:10 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DD095D9DC;
 Mon, 18 May 2020 19:17:10 +0000 (UTC)
Subject: Re: [PATCH v4 7/9] qcow2: Expose bitmaps' size during measure
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-8-eblake@redhat.com>
 <dcca62f0-3960-a9df-61d1-a6b9c2b1cf17@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a61b5d9f-ecdd-d37a-4df9-727a5c105b41@redhat.com>
Date: Mon, 18 May 2020 14:17:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dcca62f0-3960-a9df-61d1-a6b9c2b1cf17@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 8:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 04:16, Eric Blake wrote:
>> It's useful to know how much space can be occupied by qcow2 persistent
>> bitmaps, even though such metadata is unrelated to the guest-visible
>> data.  Report this value as an additional QMP field, present when
>> measuring an existing image and output format that both support
>> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
>> coverage in 190 demonstrating non-zero values made possible with the
>> recently-added qemu-img bitmap command.
>>

>> @@ -616,6 +616,7 @@ Command description:
>>
>>       required size: 524288
>>       fully allocated size: 1074069504
>> +    bitmaps: 0
>>
>>     The ``required size`` is the file size of the new image.  It may 
>> be smaller
>>     than the virtual disk size if the image format supports compact 
>> representation.
>> @@ -625,6 +626,13 @@ Command description:
>>     occupy with the exception of internal snapshots, dirty bitmaps, 
>> vmstate data,
>>     and other advanced image format features.
>>
>> +  The ``bitmaps size`` is the additional size required if the
> 
> you called it "bitmaps" in example output above. Should it be 
> consistent? Either "``bitmaps``" here, or "bitmaps size: 0" above?

"bitmaps size: 0" is better. Will fix the description above.

>> +++ b/qapi/block-core.json
>> @@ -633,18 +633,23 @@
>>   # efficiently so file size may be smaller than virtual disk size.
>>   #
>>   # The values are upper bounds that are guaranteed to fit the new 
>> image file.
>> -# Subsequent modification, such as internal snapshot or bitmap 
>> creation, may
>> -# require additional space and is not covered here.
>> +# Subsequent modification, such as internal snapshot or further bitmap
>> +# creation, may require additional space and is not covered here.
>>   #
>> -# @required: Size required for a new image file, in bytes.
>> +# @required: Size required for a new image file, in bytes, when 
>> copying just
>> +#            guest-visible contents.
>>   #
>>   # @fully-allocated: Image file size, in bytes, once data has been 
>> written
>> -#                   to all sectors.
>> +#                   to all sectors, when copying just guest-visible 
>> contents.
> 
> "copying just guest-visible" sounds like something less than "all 
> fully-allocated sectors"..
> But I don't have better suggestion.. Just, "not including bitmaps" 
> sounds weird too.

If we ever add support for copying internal snapshots, that would not be 
included either.  Maybe "copying just allocated guest-visible contents" 
for @required, and no change to the wording for @fully-allocated.


>> @@ -4796,13 +4797,38 @@ static BlockMeasureInfo 
>> *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,

>>
>> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
>> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
>> +                const char *name = bdrv_dirty_bitmap_name(bm);
>> +                uint32_t granularity = 
>> bdrv_dirty_bitmap_granularity(bm);
>> +                uint64_t bmbits = 
>> DIV_ROUND_UP(bdrv_dirty_bitmap_size(bm),
>> +                                               granularity);
>> +                uint64_t bmclusters = DIV_ROUND_UP(DIV_ROUND_UP(bmbits,
>> +                                                                
>> CHAR_BIT),
>> +                                                   cluster_size);
>> +
>> +                /* Assume the entire bitmap is allocated */
>> +                bitmaps_size += bmclusters * cluster_size;
>> +                /* Also reserve space for the bitmap table entries */
>> +                bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
>> +                                         cluster_size);
>> +                /* And space for contribution to bitmap directory 
>> size */
>> +                bitmap_dir_size += ROUND_UP(strlen(name) + 24,
>> +                                            sizeof(uint64_t));
> 
> Could we instead reuse code from qcow2_co_can_store_new_dirty_bitmap(), 
> which calls calc_dir_entry_size() for this thing?
> Possibly, make a function qcow2_measure_bitmaps in block/qcow2-bitmaps.c 
> with this FOR_EACH? All details about qcow2 bitmap structures sounds 
> better in block/qcow2-bitmaps.c

Could do.  Sounds like I'm better off submitting a v5 for this patch, 
although I'll go ahead and stage 1-6 for pull request today to minimize 
future rebase churn.


>> +    info->has_bitmaps = version >= 3 && in_bs &&
>> +        bdrv_supports_persistent_dirty_bitmap(in_bs);
>> +    info->bitmaps = bitmaps_size;
> 
> AFAIK, in QAPI, if has_<something> field is false, than <something> must 
> be zero. Maybe, it's only about nested structured fields, not about 
> simple numbers, but I think it's better keep bitmaps 0 in case when 
> has_bitmaps is false.

During creation (including when parsing QMP from the user over the 
monitor), everything is indeed guaranteed to be zero-initialized.  But 
we don't have any requirement that things remain zero-initialized even 
when has_FOO is false; at the same time, it's easy enough to make this 
code conditional.

> 
> Also, it seems a bit better to check version earlier, and don't do all 
> the calculations, if we are not going to use them.. But it's a rare 
> backward-compatibility case, I don't care.

I'll see how easy or hard it is for my v5 patch.


>> @@ -5275,9 +5285,24 @@ static int img_measure(int argc, char **argv)
>>           goto out;
>>       }
>>
>> +    if (bitmaps) {
>> +        if (!info->has_bitmaps) {
>> +            error_report("no bitmaps measured, either source or 
>> destination "
>> +                         "format lacks bitmap support");
>> +            goto out;
>> +        } else {
>> +            info->required += info->bitmaps;
>> +            info->fully_allocated += info->bitmaps;
>> +            info->has_bitmaps = false;
> 
> And here, I think better to zero info->bitmaps as well.

Here, the object is going to be subsequently freed; I'm less worried 
about wasting time doing local cleanups than I am about the earlier case 
about letting an object escape immediate scope in a different state than 
the usual preconditions.


>> +$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
>> +$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
>> +
>> +# No bitmap without a source
>> +$QEMU_IMG measure --bitmaps -O qcow2 --size 10M
> 
> should this be ored to  'echo "unexpected success"' as following failures?
> 

Can't hurt.


>> +# Compute expected output:
>> +echo
>> +val2T=$((2*1024*1024*1024*1024))
>> +cluster=$((64*1024))
>> +b1clusters=$(( (val2T/512/8 + cluster - 1) / cluster ))
>> +b2clusters=$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
> 
> comment on the following calculations won't hurt, at least something like
>   "bitmap clusters + bitmap tables + bitmaps directory"

Sure.

> 
>> +echo expected bitmap $((b1clusters * cluster +
>> +            (b1clusters * 8 + cluster - 1) / cluster * cluster +
>> +            b2clusters * cluster +
>> +            (b2clusters * 8 + cluster - 1) / cluster * cluster +
>> +            cluster))
>> +$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
>> +$QEMU_IMG measure --bitmaps -O qcow2 -o cluster_size=64k -f qcow2 
>> "$TEST_IMG"
>> +

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


