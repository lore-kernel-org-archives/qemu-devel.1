Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF42C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90A82085B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/t8cUa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90A82085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwMK-0007cb-S1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUwLC-0006RF-FY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUwL9-00082i-SH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603218389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LF73k65ov8x4+X5zOZr74OODwusf/PEsFSrUJbZcy+I=;
 b=g/t8cUa3sjB/1MmwPjMJYeie/tA6Os7z9S4baz+ACN52xIFUEVL1eKNa9y30IIbAowATIp
 x6XcrNCagzbgeaXSAhsoUr21hBmsBc8Jcv5iynH44DWAA1H0OQtJ0lL8KByJcMmU8BhUa6
 JmOO5A58lD0CRX4dYl5Uv+nygPaMOi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-ECmK8S0xNNuF9_bspyQ4aA-1; Tue, 20 Oct 2020 14:26:24 -0400
X-MC-Unique: ECmK8S0xNNuF9_bspyQ4aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 860CE805723;
 Tue, 20 Oct 2020 18:26:23 +0000 (UTC)
Received: from [10.3.113.90] (ovpn-113-90.phx2.redhat.com [10.3.113.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCEE460C0F;
 Tue, 20 Oct 2020 18:26:19 +0000 (UTC)
Subject: Re: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple
 bitmaps
To: Markus Armbruster <armbru@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-5-eblake@redhat.com>
 <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
 <56b413b5-2213-1b4e-5cac-865d8f0e0689@redhat.com>
 <87lfg1gu06.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4d7d4c9b-3b32-0c13-9ec1-b326e49ca7ae@redhat.com>
Date: Tue, 20 Oct 2020 13:26:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87lfg1gu06.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, rjones@redhat.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 3:51 AM, Markus Armbruster wrote:

>> #define QAPI_LIST_ADD(list, element) do { \
>>     typeof(list) _tmp = g_new(typeof(*(list)), 1); \
>>     _tmp->value = (element); \
>>     _tmp->next = (list); \
>>     (list) = _tmp; \
>> } while (0)
>>
>>
>> Markus, thoughts on if we should publish this macro,
> 
> If it's widely useful.
> 
> "git-grep -- '->value ='" matches ~200 times.  A patch converting these
> to the macro where possible would make a strong case for having the
> macro.
> 
>>                                                      and if so, which
>> header would be best?
> 
> The macro is generic: @list's type may be any of the struct TYPEList we
> generate for the QAPI type ['TYPE'].
> 
> We don't want to generate this macro next to each of these struct
> definitions.  A non-generic macro would go there, but let's not generate
> almost a hundred non-generic macros where a single generic one can do
> the job.

Agreed.

> 
> The closest we have to a common base is GenericList.  It's in in
> visitor.h because it's only used by visitors so far.  Adding the macro
> next it is not so smart, because we don't want non-visitor code to
> include visitor.h just for this macro.

Also agreed.

> 
> Perhaps the macro should go into qapi/util.h, and perhaps GenericList
> and GenericAlternate should move there, too.

GenericList is easy, but GenericAlternate is harder: it would introduce
a cyclic declaration dependency (generated qapi-builtin-types.h includes
qapi/util.h for the definition of QEnumLookup, but qapi/util.h declaring
GenericAlternate would depend on including qapi-builtin-types.h for the
definition of QType).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


