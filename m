Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993EEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650252071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8+7mCAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650252071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEoB-00058b-LV
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAEnc-0004bJ-ER
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:54:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAEnY-0008Is-FN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598284454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLknTB3Qn2kc2glRNxKC3NuFsNrtGph/lOmrDD9l2l4=;
 b=M8+7mCAL9GLhVfXnUpgILORig6+d8bELK4bSlaxO8XGcR7SAVjFZ8pfU5+FzfuPWBUYbG9
 Qu1lKQyiG6RgoHVwqEc/UjDbyWzLAMy5t12WO2hqucnVcLPqI72LgEWKM77BsooQ+nPJba
 kIOzhYRkSKUdfqKfiUadAUUOpM8rDpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-EsaAfy5jOZiV0vdcyhFeEA-1; Mon, 24 Aug 2020 11:54:13 -0400
X-MC-Unique: EsaAfy5jOZiV0vdcyhFeEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D861074663;
 Mon, 24 Aug 2020 15:54:11 +0000 (UTC)
Received: from [10.10.112.89] (ovpn-112-89.rdu2.redhat.com [10.10.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A895D9E2;
 Mon, 24 Aug 2020 15:54:10 +0000 (UTC)
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6bec9117-a7fc-a4e1-2c95-b84b86234668@redhat.com>
Date: Mon, 24 Aug 2020 11:54:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 9:03 AM, Max Reitz wrote:
> On 18.02.20 11:07, Fabian Grünbichler wrote:
> 
> [Sorry :/]
> 
>> picking up on John's in-progress patch series from last summer, this is
>> a stab at rebasing and adding test cases for the low-hanging fruits:
>>
>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>> - incremental mirror mode as sugar for bitmap + on-success
>>
>> Fabian Grünbichler (4):
>>    mirror: add check for bitmap-mode without bitmap
>>    mirror: switch to bdrv_dirty_bitmap_merge_internal
>>    iotests: add test for bitmap mirror
>>    mirror: move some checks to QMP
>>
>> John Snow (2):
>>    drive-mirror: add support for sync=bitmap mode=never
>>    drive-mirror: add support for conditional and always bitmap sync modes
> 
> Looks reasonable to me.  I would indeed merge patches 2 through 4 into a
> single one, and perhaps switch patches 5 and 6.
> 
> Also, we still need an S-o-b from John on patch 2.
> 

Whoops! Will do.

> I have one question: When the mirror job completes successfully (or is
> cancelled “successfully”), the bitmap is always fully cleared when the
> job completes, right?  (Unless in “never” mode.)
> 

I don't remember personally, it's been a minute ...

> Not that I think we should change the current implementation of “clear
> sync_bitmap; merge dirty_bitmap into sync_bitmap;”.  Just a question for
> understanding.
> 
> 
> Soo...  What’s the plan?
> 
> Max
> 


