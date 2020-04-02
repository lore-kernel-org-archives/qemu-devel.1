Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8248C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8149E20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eqd6vTRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8149E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3hm-00040U-Jt
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crobinso@redhat.com>) id 1jK3g9-0002pj-VI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crobinso@redhat.com>) id 1jK3g8-0006qP-0s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1jK3g7-0006pq-Rg
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585848654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr96PduOKnvohulXwwfqnxejdhMYtOulNHwzCMe7H94=;
 b=Eqd6vTRZSms5JZy0jKE3dD5aQlMvhOiJnmjo8JfB4TRLWDnKV/KS+pZwkj60e1xGyjeETG
 m/4MqTM2qHXxgFbTbQ4+AEUQAwicVkIpPTFmVXs7nTHxdGu2ACXmFIhLbbPzK86D4NrUFA
 s4ok+MJ19neZudhmL3dYeDAW8zxSI6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-HuBm-PnTOqiAG3XMTVYZ4g-1; Thu, 02 Apr 2020 13:30:53 -0400
X-MC-Unique: HuBm-PnTOqiAG3XMTVYZ4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 242F418AB2C3;
 Thu,  2 Apr 2020 17:30:51 +0000 (UTC)
Received: from [10.10.114.210] (ovpn-114-210.rdu2.redhat.com [10.10.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F9725E000;
 Thu,  2 Apr 2020 17:30:41 +0000 (UTC)
Subject: Re: [PATCH for-5.0] aio-posix: fix test-aio /aio/event/wait with
 fdmon-io_uring
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200402145434.99349-1-stefanha@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <f5ae45d8-19de-2053-7320-86b24a64cd52@redhat.com>
Date: Thu, 2 Apr 2020 13:30:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200402145434.99349-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 10:54 AM, Stefan Hajnoczi wrote:
> When a file descriptor becomes ready we must re-arm POLL_ADD.  This is
> done by adding an sqe to the io_uring sq ring.  The ->need_wait()
> function wasn't taking pending sqes into account and therefore
> io_uring_submit_and_wait() was not being called.  Polling for cqes
> failed to detect fd readiness since we hadn't submitted the sqe to
> io_uring.
> 
> This patch fixes the following tests/test-aio -p /aio/event/wait
> failure:
> 
>   ok 11 /aio/event/wait
>   **
>   ERROR:tests/test-aio.c:374:test_flush_event_notifier: assertion failed: (aio_poll(ctx, false))
> 
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Fixes: 73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf
>        ("aio-posix: add io_uring fd monitoring implementation")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Fixes the crash for me, thanks!

Tested-by: Cole Robinson <crobinso@redhat.com>

- Cole


