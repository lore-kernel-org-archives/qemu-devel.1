Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F99C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023C7204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN4/3jxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023C7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkqP-0005SV-T9
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kGkoO-0003DA-0a
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kGkoM-0005Q3-2M
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvuC/mGku++uXkqGQ3hR4fuAtXX7yZDSGRWTANMZNSM=;
 b=BN4/3jxUty/xeGhKDxhg4WCrscCVp2Ib7ufqIX2vPCSuHoMD5N8WgKaHO+sJPkTG40hOQO
 WfCYClNQatVvQSG3v3tdfsDUWI1fOENkHOEXgXRUxL67OAe7ks8gnFRDIpWqpiRBEni8op
 EgqAfJYYwtKi4AOsWEsP5iHfaT2An/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-_sJgtD44MiOvMF4NFg8UDA-1; Fri, 11 Sep 2020 11:17:55 -0400
X-MC-Unique: _sJgtD44MiOvMF4NFg8UDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FDD710A92C8;
 Fri, 11 Sep 2020 15:17:41 +0000 (UTC)
Received: from [10.3.113.1] (ovpn-113-1.phx2.redhat.com [10.3.113.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE45C5C1BD;
 Fri, 11 Sep 2020 15:17:40 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Support bitmap --merge into backing image
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200909123358.1244744-1-eblake@redhat.com>
 <32a96bcc-78de-a13e-c090-ad00c3b4c4ad@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b8bb3e55-2f23-798a-b0c7-843067e19dfd@redhat.com>
Date: Fri, 11 Sep 2020 10:17:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <32a96bcc-78de-a13e-c090-ad00c3b4c4ad@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:18:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Shenitzky <eshenitz@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 3:31 AM, Max Reitz wrote:
> On 09.09.20 14:33, Eric Blake wrote:
>> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
>> bitmap from top into base, qemu-img was failing with:
>>
>> qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed to get shared "write" lock
>> Is another process using the image [base.qcow2]?
>>
>> The easiest fix is to not open the entire backing chain of the source
>> image, so that we aren't worrying about competing BDS visiting the
>> backing image as both a read-only backing of the source and the
>> writeable destination.
>>
>> Fixes: http://bugzilla.redhat.com/1877209
>> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   qemu-img.c                 |  3 +-
>>   tests/qemu-iotests/291     | 12 ++++++++
>>   tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index eb2fc1f86243..b15098a2f9b3 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -4755,7 +4755,8 @@ static int img_bitmap(int argc, char **argv)
>>       }
>>       bs = blk_bs(blk);
>>       if (src_filename) {
>> -        src = img_open(false, src_filename, src_fmt, 0, false, false, false);
>> +        src = img_open(false, src_filename, src_fmt, BDRV_O_NO_BACKING,
>> +                       false, false, false);
> 
> Why not do the same for the destination BB?

Yeah, that should work, too.

> 
>>           if (!src) {
>>               goto out;
>>           }
>> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
>> index 1e0bb76959bb..4f837b205655 100755
>> --- a/tests/qemu-iotests/291
>> +++ b/tests/qemu-iotests/291
> 
> [...]
> 
>> @@ -107,6 +116,9 @@ $QEMU_IMG map --output=json --image-opts \
>>   nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
>>   $QEMU_IMG map --output=json --image-opts \
>>       "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
>> +nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"
> 
> Why not look into $TEST_IMG.base to see specifically whether the bitmap
> is there?

We did just that, several lines earlier, with the qemu-img info 
--backing-chain.

> 
> (I also am quite surprised that it’s even possible to export bitmaps
> from backing nodes, but, well.)

I actually ought to call that out in the commit message.  It used to be 
that we were inconsistent on what we could see from the backing chain (a 
filter would make it so we can't), but as soon as your filter patches 
land, then we _do_ want to always be able to find a bitmap from the 
backing chain (incremental backup depends on that: we create an overlay 
disk to run the block-copy job as a filter, and _want_ to expose that 
overlay image with the bitmap it inherits from the original image).  So 
being able to export bitmaps from a backing node is normally a feature; 
and it is only in 'qemu-img bitmap' where we don't want accidental 
inheritance to get in the way from what we are actually merging.

I'll send a v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


