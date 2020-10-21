Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB7C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C3D221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tevouu2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C3D221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV5cR-0006OO-Nf
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV5ba-0005n8-38
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV5bW-0000zE-Di
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603254000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6M48ZEmEZg9biLJa9lbXZqwlpORFWxvRtY9CVR/UjQ=;
 b=Tevouu2PsIpdBSOlRTl/3tap5s2fslFGRBAJPwq2zHuTofkHwRCrIAtO5Q7ga3QpLbNJ10
 nxFeq/UK0pJalV71NmGlocp/kCERL5udLRT/ex/RWiCA/iIFTspqdX9P9o3W4VonrgJrfW
 L79yHXycD2NlnLhNpp9eSOd76zKmYiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-BONMoX1sP5SROCeMUoP0bQ-1; Wed, 21 Oct 2020 00:19:58 -0400
X-MC-Unique: BONMoX1sP5SROCeMUoP0bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC8A1006C97;
 Wed, 21 Oct 2020 04:19:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A6A05D9EF;
 Wed, 21 Oct 2020 04:19:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B165E1132A08; Wed, 21 Oct 2020 06:19:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple
 bitmaps
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-5-eblake@redhat.com>
 <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
 <56b413b5-2213-1b4e-5cac-865d8f0e0689@redhat.com>
 <87lfg1gu06.fsf@dusky.pond.sub.org>
 <4d7d4c9b-3b32-0c13-9ec1-b326e49ca7ae@redhat.com>
Date: Wed, 21 Oct 2020 06:19:51 +0200
In-Reply-To: <4d7d4c9b-3b32-0c13-9ec1-b326e49ca7ae@redhat.com> (Eric Blake's
 message of "Tue, 20 Oct 2020 13:26:19 -0500")
Message-ID: <87v9f48b2w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, rjones@redhat.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/20/20 3:51 AM, Markus Armbruster wrote:
>
>>> #define QAPI_LIST_ADD(list, element) do { \
>>>     typeof(list) _tmp = g_new(typeof(*(list)), 1); \
>>>     _tmp->value = (element); \
>>>     _tmp->next = (list); \
>>>     (list) = _tmp; \
>>> } while (0)
>>>
>>>
>>> Markus, thoughts on if we should publish this macro,
>> 
>> If it's widely useful.
>> 
>> "git-grep -- '->value ='" matches ~200 times.  A patch converting these
>> to the macro where possible would make a strong case for having the
>> macro.
>> 
>>>                                                      and if so, which
>>> header would be best?
>> 
>> The macro is generic: @list's type may be any of the struct TYPEList we
>> generate for the QAPI type ['TYPE'].
>> 
>> We don't want to generate this macro next to each of these struct
>> definitions.  A non-generic macro would go there, but let's not generate
>> almost a hundred non-generic macros where a single generic one can do
>> the job.
>
> Agreed.
>
>> 
>> The closest we have to a common base is GenericList.  It's in in
>> visitor.h because it's only used by visitors so far.  Adding the macro
>> next it is not so smart, because we don't want non-visitor code to
>> include visitor.h just for this macro.
>
> Also agreed.
>
>> 
>> Perhaps the macro should go into qapi/util.h, and perhaps GenericList
>> and GenericAlternate should move there, too.
>
> GenericList is easy, but GenericAlternate is harder: it would introduce
> a cyclic declaration dependency (generated qapi-builtin-types.h includes
> qapi/util.h for the definition of QEnumLookup, but qapi/util.h declaring
> GenericAlternate would depend on including qapi-builtin-types.h for the
> definition of QType).

You're right.

QType is a built-in QAPI type.  The typedef is generated into
qapi-builtin-types.h.

It needs to be a QAPI type because it's the type of alternates'
(implicit) member @type.

I figure the easiest way to move GenericAlternate (if we want to), is
creating a new header, or rather splitting qapi/util.h into the part
needed by qapi-builtin-types.h and the part that needs
qapi-builtin-types.h.

Doesn't seem to be worth our while now.  We can simply put the macro
into qapi/util.h and call it a day.


