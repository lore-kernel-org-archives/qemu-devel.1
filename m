Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082C62075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxQIX8x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082C62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp1J-0006Ri-6X
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIozZ-000512-NP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIozX-0007fv-Ll
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600330206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjQUdj5KNJ+AWWSxf1ydrOwvYgdAwq04fNZLK0PU42k=;
 b=OxQIX8x6LFeGR3OJOKQ2bo+4PxhkxqBQNiaqIT3mF++yL93aF7bT+x9nH5UyR7cC8tyAHc
 iGNMO7XAIxy1QZG19xtmi7tOh/6V1RMFeLp/JcDnJlZeJoeksH/nsK+PCIalDJ/D0yK+9F
 ZW4m6YAUU7nrkq9+g9CfpejpG6t9yAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-CQ4IphE4P8CWuY8ccEWXaQ-1; Thu, 17 Sep 2020 04:10:04 -0400
X-MC-Unique: CQ4IphE4P8CWuY8ccEWXaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B628518C89C4;
 Thu, 17 Sep 2020 08:10:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1942919646;
 Thu, 17 Sep 2020 08:09:58 +0000 (UTC)
Subject: Re: [PATCH v2] migration: Silence compiler warning in
 global_state_store_running()
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20200917074344.168785-1-thuth@redhat.com>
 <da9ed157-dd81-c486-e4ac-d98ca3ac0ee3@redhat.com>
 <46f47558-7881-6856-f68b-b4963f39949d@redhat.com>
Message-ID: <c39e7db3-2a43-5ad4-a14f-4f9f0f07cf5d@redhat.com>
Date: Thu, 17 Sep 2020 10:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <46f47558-7881-6856-f68b-b4963f39949d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 10.02, Thomas Huth wrote:
> On 17/09/2020 09.47, Philippe Mathieu-Daudé wrote:
>> On 9/17/20 9:43 AM, Thomas Huth wrote:
>>> GCC 9.3.0 on Ubuntu complains:
>>>
>>> In file included from /usr/include/string.h:495,
>>>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
>>>                  from ../migration/global_state.c:13:
>>> In function ‘strncpy’,
>>>     inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
>>> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
>>>  ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> ... but we apparently really want to do a strncpy here - the size is already
>>> checked with the assert() statement right in front of it. To silence the
>>> warning, simply replace it with our strpadcpy() function.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  v2: Use strpadcpy instead of QEMU_NONSTRING (and yes, this time it seems
>>>      to really silence the compiler warning :-))
>>>
>>>  migration/global_state.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/global_state.c b/migration/global_state.c
>>> index 25311479a4..a33947ca32 100644
>>> --- a/migration/global_state.c
>>> +++ b/migration/global_state.c
>>> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>>>  {
>>>      const char *state = RunState_str(RUN_STATE_RUNNING);
>>>      assert(strlen(state) < sizeof(global_state.runstate));
>>> -    strncpy((char *)global_state.runstate,
>>> -           state, sizeof(global_state.runstate));
>>> +    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>>> +              state, '\0');
>>
>> https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
>> ;)
> 
> Oh, well :-) ... but why did you never pushed to get that merged?

Hmm, commit 0a5526a18b0245dfa20a9fe453b2a9af3125d175 was supposed to fix
it already ... but apparently, that does not work with GCC 9.3 ?

 Thomas


