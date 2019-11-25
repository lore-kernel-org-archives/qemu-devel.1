Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AECC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0362320740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtO/f631"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0362320740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHBt-0000pG-Ke
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZHAm-00007l-83
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZHAl-0005Ww-94
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:25:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZHAl-0005Wk-5Y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574699110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpWoAuNt4KGKQ+xl08kYRnys7W7k/TC2TB6w3sXsqbw=;
 b=GtO/f631gH1tB64m8a+al5+sddi3LRt2CdLwiROVE2mvGVhZOqI6fi2kg/IPf/DxSpS7Wb
 MF2CDOjiHPh9OXSGV8cyRvJxboGYXztCZ2aJIFJbMidEUkZzZur9OpjMm6FAWQ4NaY1CP+
 fi/Ddkca+Zu+hakn4ChmrG+5U/pU8Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-wpfFU-ZkN_iqxCvL7Q5oYA-1; Mon, 25 Nov 2019 11:25:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3D81856A8D;
 Mon, 25 Nov 2019 16:25:05 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 095631001B03;
 Mon, 25 Nov 2019 16:25:03 +0000 (UTC)
Subject: Re: [PATCH 2/2] test-keyval: Tighten test of trailing crap after size
To: Markus Armbruster <armbru@redhat.com>
References: <20191125133846.27790-1-armbru@redhat.com>
 <20191125133846.27790-3-armbru@redhat.com>
 <b06f7807-b201-5a52-5a62-b50f52cc4d44@redhat.com>
 <87fticdlbx.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <49d5c743-5ff4-2f5a-cb45-a6730d85f5f9@redhat.com>
Date: Mon, 25 Nov 2019 10:25:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87fticdlbx.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wpfFU-ZkN_iqxCvL7Q5oYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 9:31 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 11/25/19 7:38 AM, Markus Armbruster wrote:
>>> test_keyval_visit_size() should test for trailing crap after size with
>>> and without suffix.  It does test the latter: "sz2=16Gi" has size
>>> "16G" followed by crap "i".  It fails to test the former "sz1=16E" is
>>> a syntactically valid size that overflows uint64_t.  Replace by
>>> "sz1=0Z".
>>>

>>>          /* Trailing crap */
>>> -    qdict = keyval_parse("sz1=16E,sz2=16Gi", NULL, &error_abort);
>>> +    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, &error_abort);
>>
>> Does this actually test both failure cases, or does it abort the parse
>> after the first failure (sz1=0Z) without ever hitting the second half
>> of the parse (sz2=16Gi)?
> 
> Fair question!  Short answer: yes, we check both.

Aha - keyval_parse() just sets up the parser, while the check for double 
failures is in the test code below.

> Clear now?

Yes.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


