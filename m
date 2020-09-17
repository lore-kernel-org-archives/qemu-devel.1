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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E695C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310E92072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0pK7qoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoOI-00044I-9d
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIoMT-0002pe-9j
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:29:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIoMR-0002Rj-Mh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600327783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ol/DHTMaWWwAY+5j6Qx9hSpAczBFlYGFx/1+2pb0ezE=;
 b=b0pK7qoSjv0d+baEY/aIC9hNvxaKSJcKQoPP8/fnOB2giSjL/KsScsh8Sx6qUHAO9Q5Xk0
 aQEG0ZwNbPB5h0sa58/JGByuFFohq9Xpi2sg5ftYF/LLfDYnLFzkPl8x8X8bNMPCJisnlS
 x5QjfDHL9FB2S8ng2SOlcsEIVmoAo38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-Con4K7cCNPyppGsMf6a2sA-1; Thu, 17 Sep 2020 03:29:39 -0400
X-MC-Unique: Con4K7cCNPyppGsMf6a2sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4A71891E80;
 Thu, 17 Sep 2020 07:29:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 839C719D7C;
 Thu, 17 Sep 2020 07:29:33 +0000 (UTC)
Subject: Re: [PATCH] migration: Silence compiler warning in
 global_state_store_running()
To: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20200916171913.148681-1-thuth@redhat.com>
 <93744d31-0f33-5bb1-fb76-42ca3a5fa401@redhat.com>
 <e44e5105-baba-3d0d-6477-37f24531d39f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2ea865f-db34-8f9d-525b-8050d2d8aa65@redhat.com>
Date: Thu, 17 Sep 2020 09:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e44e5105-baba-3d0d-6477-37f24531d39f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:23:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 09.18, Paolo Bonzini wrote:
> On 17/09/20 08:30, Thomas Huth wrote:
>> On 16/09/2020 19.19, Thomas Huth wrote:
>>> GCC 9.3.0 on Ubuntu complains:
>>>
>>> In file included from /usr/include/string.h:495,
>>>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
>>>                  from ../migration/global_state.c:13:
>>> In function ‘strncpy’,
>>>     inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
>>> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> ... but we apparently really want to do the strncpy here. Silence the
>>> warning with QEMU_NONSTRING.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  migration/global_state.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/global_state.c b/migration/global_state.c
>>> index 25311479a4..f1355d7d97 100644
>>> --- a/migration/global_state.c
>>> +++ b/migration/global_state.c
>>> @@ -43,9 +43,9 @@ int global_state_store(void)
>>>  void global_state_store_running(void)
>>>  {
>>>      const char *state = RunState_str(RUN_STATE_RUNNING);
>>> +    QEMU_NONSTRING char *dest = (char *)global_state.runstate;
>>>      assert(strlen(state) < sizeof(global_state.runstate));
>>> -    strncpy((char *)global_state.runstate,
>>> -           state, sizeof(global_state.runstate));
>>> +    strncpy(dest, state, sizeof(global_state.runstate));
>>>  }
>>
>> Darn, I was sending too fast here, sorry, but seems like this does *not*
>> fix the issue with GCC 9.3:
>>
>>  https://travis-ci.com/github/huth/qemu/jobs/385871010#L2930
>>
>> ... so maybe we should simply switch to strpadcpy() instead?
> 
> Yes, and probably do so everywhere that strncpy is used.

I think the trick with QEMU_NONSTRING should work fine in all cases
where we have a real array, see e.g. buf[] in find_vdi_name() in
block/sheepdog.c. It just does not seem to work in case you have a char*
pointer instead of an array...

 Thomas


