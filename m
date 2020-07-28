Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C151C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 04:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249A320759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 04:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaSe47S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249A320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0GoM-0006zp-Bu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 00:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0GnA-0006Wx-5B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 00:00:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Gn8-0000iw-Kp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 00:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595908837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hknvEOICRQY0q1eoXLR0kORhRPhVlLEyukskQ3N7UK0=;
 b=XaSe47S0XymvyXAQmtQ/cAEFVLXAChWoW6/62tm1I3t0tRAclJIoiDhX1JTS/iQ1GoJFmX
 0aEdxxpFvE2bNoc/bms9vJhoWFeLtbpwVCednZevw357/R241HrGKvaxofHb1OR5kJ23uL
 fz5KG2PYFeGImgfcO5v98phuFZnUnp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-_Rw0QYY8OhaOdALhGIKHPg-1; Tue, 28 Jul 2020 00:00:35 -0400
X-MC-Unique: _Rw0QYY8OhaOdALhGIKHPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C7F1DE6;
 Tue, 28 Jul 2020 04:00:33 +0000 (UTC)
Received: from [10.72.13.242] (ovpn-13-242.pek2.redhat.com [10.72.13.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2A93712F8;
 Tue, 28 Jul 2020 04:00:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] net: forbid the reentrant RX
To: qemu-devel@nongnu.org
References: <20200722085747.6514-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fd8eb52-6410-1bbd-2462-598c6fcebeb9@redhat.com>
Date: Tue, 28 Jul 2020 12:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722085747.6514-1-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:56:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: dmitry.fleytman@gmail.com, mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com,
 alxndr@bu.edu, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/22 下午4:57, Jason Wang wrote:
> The memory API allows DMA into NIC's MMIO area. This means the NIC's
> RX routine must be reentrant. Instead of auditing all the NIC, we can
> simply detect the reentrancy and return early. The queue->delivering
> is set and cleared by qemu_net_queue_deliver() for other queue helpers
> to know whether the delivering in on going (NIC's receive is being
> called). We can check it and return early in qemu_net_queue_flush() to
> forbid reentrant RX.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   net/queue.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/queue.c b/net/queue.c
> index 0164727e39..19e32c80fd 100644
> --- a/net/queue.c
> +++ b/net/queue.c
> @@ -250,6 +250,9 @@ void qemu_net_queue_purge(NetQueue *queue, NetClientState *from)
>   
>   bool qemu_net_queue_flush(NetQueue *queue)
>   {
> +    if (queue->delivering)
> +        return false;
> +
>       while (!QTAILQ_EMPTY(&queue->packets)) {
>           NetPacket *packet;
>           int ret;


Queued for rc2.

Thanks


