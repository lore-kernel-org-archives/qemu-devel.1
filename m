Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F97C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E7622282
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYqCSFd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E7622282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbAH-0007Kw-1I
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 22:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kXb9H-0006mL-BT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 22:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kXb9D-0002qa-UW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 22:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603851909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aoic+wXbINFBD2qMcqBk9a+pdn+FHQKT7qahKwb+wQ=;
 b=dYqCSFd0E4oLK/Ye+jDWmHjqu5gHg05sd2bYjhEW7Ug4T9G0oGDgsZ+aBKcmEifjB9sY/e
 qy1Rc/7Rcn9XcDy6yne2RLDYvVt6612aK5ZOXELu5PaKN634agB3sTwD4+HFC9iGsu9a8m
 5mYTiRvAYqjhNYVLTOMZhAL/ZDMya6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-HYMUYYCTPVunwk0R6ul6PA-1; Tue, 27 Oct 2020 22:25:08 -0400
X-MC-Unique: HYMUYYCTPVunwk0R6ul6PA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1CA7804B6C;
 Wed, 28 Oct 2020 02:25:06 +0000 (UTC)
Received: from [10.72.13.38] (ovpn-13-38.pek2.redhat.com [10.72.13.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B31265B4BC;
 Wed, 28 Oct 2020 02:25:04 +0000 (UTC)
Subject: Re: [PATCH v3] net: remove an assert call in eth_get_gso_type
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
References: <20201021060550.1652896-1-ppandit@redhat.com>
 <38575304-e5ff-c93e-c1e8-997d4148e579@redhat.com>
 <nycvar.YSQ.7.78.906.2010211440290.1506567@xnncv>
 <CAFEAcA-sSk+4v5XDUTapV8qKu-Lv2v87q7+_NUqtxoM50PQnAg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a57e243-fabb-0993-7cc6-ee4cdc261c86@redhat.com>
Date: Wed, 28 Oct 2020 10:25:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sSk+4v5XDUTapV8qKu-Lv2v87q7+_NUqtxoM50PQnAg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 22:00:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Gaoning Pan <pgn@zju.edu.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/26 下午5:59, Peter Maydell wrote:
> On Wed, 21 Oct 2020 at 10:23, P J P <ppandit@redhat.com> wrote:
>> +-- On Wed, 21 Oct 2020, Jason Wang wrote --+
>> | It should not be a guest error, since guest is allowed to send a packet
>> | other than IPV4(6).
>>
>> * Ah...sigh! :(
>>
>> * I very hesitantly used guest_error mask, since it was g_assert-ing before.
>>    To me both guest_error and log_unimp seem mismatching. Because no GSO is
>>    also valid IIUC. That's why in patch v2 I used plain qemu_log(). But plain
>>    qemu_log is also not good it seems.
> Well, as I said last time round, the right function depends on what
> is going on here. If this is "the fallback code path is fine, it
> might just be a bit inefficient", then either no logging or use
> a tracepoint. If this is "the guest is allowed to send this packet
> but we're going to mishandle it" then use LOG_UNIMP.


Ok, rethink about this. I think at least 802.1Q is a valid option for GSO.

So I decide to apply the path with LOG_UNIMP.

Thanks


>
> thanks
> -- PMM
>


