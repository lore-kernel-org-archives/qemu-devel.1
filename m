Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B13C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA9A205CA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpIiq8E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9A205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2Do-0005r1-Fy
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX2Cb-0004WG-HA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX2CZ-0003EC-4a
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603717577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OTfWbqjLzW/vn2DRWdq8fgN/6ZpNDgAsTGWUU3b7GLM=;
 b=WpIiq8E1ekZHrkyhOGnIEjoLgcebydxhk18v0VawOHk9uXKFBQqUehdC72MwvGif8Xa8qH
 j85EEpSYWi7hSjKIU10EfA5mW84czX6XWCd4y1xpmgpCP6SBI4e09vqgbTgCDSh8rof88D
 a/WOSb2s/JrOa6xPT655EGj+x/ZNJYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-tAZcKCE5N2SR0W_KXm4RHQ-1; Mon, 26 Oct 2020 09:06:13 -0400
X-MC-Unique: tAZcKCE5N2SR0W_KXm4RHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CF62A0C01;
 Mon, 26 Oct 2020 13:06:12 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E19419728;
 Mon, 26 Oct 2020 13:06:05 +0000 (UTC)
To: Peter Krempa <pkrempa@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-7-eblake@redhat.com>
 <20201026105039.GC727443@angien.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH v5 06/12] nbd: Update qapi to support exporting multiple
 bitmaps
Message-ID: <8f898aa0-11f3-019b-5da7-5ffdce2972bb@redhat.com>
Date: Mon, 26 Oct 2020 08:06:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026105039.GC727443@angien.pipo.sk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 5:50 AM, Peter Krempa wrote:
> On Fri, Oct 23, 2020 at 13:36:46 -0500, Eric Blake wrote:
>> Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
>> 5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
>> nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
>> changes to permit passing multiple bitmaps as distinct metadata
>> contexts that the NBD client may request, but the actual support for
>> more than one will require a further patch to the server.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---

>> +++ b/qapi/block-export.json
>> @@ -74,10 +74,10 @@
>>  # @description: Free-form description of the export, up to 4096 bytes.
>>  #               (Since 5.0)
>>  #
>> -# @bitmap: Also export the dirty bitmap reachable from @device, so the
>> -#          NBD client can use NBD_OPT_SET_META_CONTEXT with the
>> -#          metadata context name "qemu:dirty-bitmap:NAME" to inspect the
>> -#          bitmap. (since 4.0)
>> +# @bitmaps: Also export each of the named dirty bitmaps reachable from
>> +#           @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
>> +#           the metadata context name "qemu:dirty-bitmap:BITMAP" to inspect
>> +#           each bitmap. (since 5.2)
> 
> Given unsynchronised release cycles between qemu and management apps
> it's not cool to deprecate an interface without having at least one
> release where the replacement interface is already stable.
> 

That's why I'm trying as hard as possible to get the block-export-add
interface perfect in its 5.2 release; if we agree that allowing qemu to
expose more than one bitmap is beneficial (and I argue that it is), then
the new interface MUST support that from the get-go, and not something
where we release it with 5.2 having 'bitmap' and 6.0 adding 'bitmaps'.

> This means that any project wanting to stay up to date will either have
> to use deprecated interfaces for at least one release and develop the
> replacement only when there's a stable interface or hope that they don't
> have to change the interfaces too often.
> 
> This specifically impacts libvirt as we have validators which notify us
> that a deprecated interface is used and we want to stay in sync, so that
> there's one less group of users to worry about at the point qemu will
> want to delete the interface.

The deprecated interface is nbd-server-add; for _that_ interface, the
'bitmap' parameter will continue to work until nbd-server-add is removed
in 6.1 (so you have all of 5.2 and 6.0 to switch from nbd-server-add to
block-export-add).

What this patch does, then, is alter the deprecation from merely
changing the command from nbd-server-add to block-export-add with all
parameter names remaining the same, to instead changing both the command
name and the 'bitmap'=>'bitmaps' parameter.  But I agree that libvirt
wants to do an all-or-none conversion: there is no reason for libvirt to
use block-export-add until 5.2 is actually released, at which point we
have locked in the new interface; and this patch is a demonstration that
we are still debating about a tweak to that interface before it becomes
locked in.

> 
>>  # @allocation-depth: Also export the allocation depth map for @device, so
>>  #                    the NBD client can use NBD_OPT_SET_META_CONTEXT with
>> @@ -88,7 +88,7 @@
>>  ##
>>  { 'struct': 'BlockExportOptionsNbd',
>>    'data': { '*name': 'str', '*description': 'str',
>> -            '*bitmap': 'str', '*allocation-depth': 'bool' } }
>> +            '*bitmaps': ['str'], '*allocation-depth': 'bool' } }
> 
> This adds 'bitmaps' also to nbd-server-add, which should not happen. You
> probably want to stop using 'base' for 'NbdServerAddOptions' and just
> duplicate everything else.

I can respin this to NOT add 'bitmaps' to the legacy 'nbd-server-add',
if you think that would be better.  It is more complex in the QAPI code,
but not too much more difficulty in the glue code; and the glue code all
goes away in 6.1 when the deprecation cycle ends.

> 
>>  # @NbdServerAddOptions:
>> @@ -100,12 +100,18 @@
>>  # @writable: Whether clients should be able to write to the device via the
>>  #            NBD connection (default false).
>>  #
>> +# @bitmap: Also export a single dirty bitmap reachable from @device, so the
>> +#          NBD client can use NBD_OPT_SET_META_CONTEXT with the metadata
>> +#          context name "qemu:dirty-bitmap:BITMAP" to inspect the bitmap
>> +#          (since 4.0).  Mutually exclusive with @bitmaps, and newer
>> +#          clients should use that instead.
> 
> This doesn't make sense, nbd-server-add never had @bitmaps. Also adding
> features to a deprecated interface doesn't IMO make sense if you want to
> motivate users switch to thne new one.

Fair enough. v6 coming up later today.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


