Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7918C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 04:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C9C20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 04:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fxos3acU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C9C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyouy-0004v2-Qe
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 00:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyosq-0003WO-Dc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 00:00:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyosn-0005uO-6E
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 00:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595563227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1m+QtJyViz6KR5C6aFqYIQ6bSPPAo1REYSpCFB+UmP0=;
 b=Fxos3acUup5iJHx1nTHwWnBVYMayZyL16i6Q7TcW8jCzvlYY4Y+cBrU0kYrF+Xb9jlqG2F
 NHoCydhXSnb0cnTtUH9c+tnfHXYl4dFItIS0x2f5krE524GuppI9cn2WuM/CDIMOPOdgG/
 e4PMQJA2+mbefojBIcY+5uyGwmEjFVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-jGVmyWbsOpKncft2bXOhPQ-1; Fri, 24 Jul 2020 00:00:21 -0400
X-MC-Unique: jGVmyWbsOpKncft2bXOhPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFD118064DE;
 Fri, 24 Jul 2020 04:00:19 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B91C8BEF4;
 Fri, 24 Jul 2020 04:00:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
 <CAFEAcA-XHFXBeQ9qp91T_gzNqyxEEDz_caHanwMuYRjKjEocWQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67267c28-f706-700a-d1aa-6e5cd8ef0c8d@redhat.com>
Date: Fri, 24 Jul 2020 12:00:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XHFXBeQ9qp91T_gzNqyxEEDz_caHanwMuYRjKjEocWQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/23 下午6:36, Peter Maydell wrote:
> On Wed, 22 Jul 2020 at 10:00, Jason Wang <jasowang@redhat.com> wrote:
>> In loopback mode, e1000e RX can DMA into TX doorbell which requires
>> TX to be reentrant. This patch make e1000e's TX routine reentrant by
>> introducing a per device boolean for recording whether or not a TX
>> rountine is being called and return early.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
> This feels like a sticking-plaster fix that's not really in the
> right place... It stops us from calling back into
> e1000e_start_xmit(), but it doesn't prevent a DMA request
> from touching other device registers that update state in
> the E100ECore struct that the transmit code is not expecting
> to change.


Right, so we can track the mr owner and fail the memory access if 
there's another mr transaction in memory core: 
memory_region_dispatch_read() and memory_region_dispatch_write().

But what's more interesting is that some device uses bh for the doorbell 
which may require more thought...

Thanks


>
> thanks
> -- PMM
>


