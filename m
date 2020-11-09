Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CA0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90797206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cH7+Xmb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90797206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc926-0006wj-Kv
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc90E-0005gt-VT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc90B-0002cy-Kk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tV6PIKFhEYVGQg9BDbubXRZaiVsQHQ6eisvtlzzfOGM=;
 b=cH7+Xmb+kxFhSj6UzbyaCotaLuxBGtAktImLkjk3AmnL7lWcBLQ9lKueNXpA7ahRqqXT4K
 ElJ4W3wfkE5KVWFEfqfab6UyE+GLuw4sEOGO5G5XSptpFE/NtTKIfKvTvpEeajQQguAaRi
 +9DEJqjG+DCX3lI73YmnAKvX6uIAGdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-m9TGyap5MGy5nYklBrSMZA-1; Mon, 09 Nov 2020 10:22:32 -0500
X-MC-Unique: m9TGyap5MGy5nYklBrSMZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FDA801FDB;
 Mon,  9 Nov 2020 15:22:31 +0000 (UTC)
Received: from [10.3.112.154] (ovpn-112-154.phx2.redhat.com [10.3.112.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52DAF6EF5B;
 Mon,  9 Nov 2020 15:22:31 +0000 (UTC)
Subject: Re: nbd: bitmap_to_extents() calls nbd_extent_array_add() without
 checking return value: coverity false positive?
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
 <9ff386a7-c334-30ed-da79-341d75ed39b2@redhat.com>
 <CAFEAcA8Po-V6+b-AVxSdwrEJ7Zy2Pm7xf8Ss4fsUtWDMG=ziQw@mail.gmail.com>
 <2c778baa-8829-4dcd-ebc2-8d6b35ca87ae@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1f402e27-7044-dcda-064c-c23d4c90362a@redhat.com>
Date: Mon, 9 Nov 2020 09:22:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2c778baa-8829-4dcd-ebc2-8d6b35ca87ae@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 1:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.11.2020 01:53, Peter Maydell wrote:
>> On Fri, 6 Nov 2020 at 20:36, Eric Blake <eblake@redhat.com> wrote:
>>>
>>> On 11/6/20 11:22 AM, Peter Maydell wrote:
>>>> Hi; Coverity's "you usually check the return value of this function
>>>> but you didn't do that here" heuristic has fired on the code in
>>>> nbd/server.c:bitmap_to_extents() -- the function nbd_extent_array_add()
>>>> is called five times in server.c, and the return value is checked
>>>> in four of those, but not in the final call at the end of
>>>> bitmap_to_extents(). (CID 1436125.)
>>>>
>>>> Is this a false positive, or should the caller be handling an
>>>> error here ?
>>>
>>> False positive, but I don't mind tweaking the code to silence Coverity.
>>> This should do it; let me know if I should turn it into a formal patch.
>>>
>>> diff --git i/nbd/server.c w/nbd/server.c
>>> index d145e1a69083..377698a2ce85 100644
>>> --- i/nbd/server.c
>>> +++ w/nbd/server.c
>>> @@ -2128,9 +2128,8 @@ static void bitmap_to_extents(BdrvDirtyBitmap
>>> *bitmap,
>>>           }
>>>       }
>>>
>>> -    if (!full) {
>>> -        /* last non dirty extent */
>>> -        nbd_extent_array_add(es, end - start, 0);
>>> +    if (!full && nbd_extent_array_add(es, end - start, 0) < 0) {
>>> +        /* last non dirty extent, not a problem if array is now full */
>>>       }
>>>
>>>       bdrv_dirty_bitmap_unlock(bitmap);
>>
>> Hmm; that looks a little odd but I guess it's a bit more
>> documentative of the intent. Up to you whether you want
>> to submit it as a patch or not I guess :-)
>>
>> thanks
>> -- PMM
>>
> 
> 
> update_refcount() in block/qcow2-refcount.c is defined as
> 
>  static int QEMU_WARN_UNUSED_RESULT update_refcount(..);
> 
> May be, use such specifier for nbd_extent_array_add()?

Adding that attribute would _force_ us to modify the code, rather than
the current situation where we are mulling the modification merely to
pacify Coverity's 4-out-of-5 analysis.  We don't strictly need to always
use the return value (hence my declaration that this was a Coverity
false positive), but declaring that we always want to use it, and fixing
the code fallout, would indeed silence Coverity.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


