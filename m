Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7962081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmMkOHka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7962081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorpJ-0003yL-Ri
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorjv-0006Y3-7k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorjt-0004cj-RH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorjt-0004c6-O0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+1AiFYA4jwJXgwLDoVnwKQ62HQ9au7D6spvhTUBGU8=;
 b=fmMkOHkaSK0wl/Pn15EFL6dCIT/86BPzow2YlVajkQ0CGeEsxAzRK5i1Tn3tRPQbs83PAy
 O2VoJ8tiF6xxh6hnZmYTIY5ehYBKfvPiZBMUMv1vcQtx0IGz0ZqXmTW3LTCPzZiKoq9gyD
 FLWn6fysayVNB2KTviI5oJsD2m4vztE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-jF4ZBLVaPjqj0fc5k-b1cg-1; Tue, 07 Jan 2020 11:29:49 -0500
Received: by mail-qv1-f70.google.com with SMTP id e10so226902qvq.18
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1upHWGgN+kA2iqb9NZ9XxvQ8bHfo9CqfdVL2Jr4HnRY=;
 b=mHjhYzR55opKLECBbQjqt9gA9SK8PrZZ4ZW2cLexEIQg7XiGZ+adowClXpqihSsCMx
 L1eEuZAtHjIP4tsx2FTOcD3/KknL+lWuiUTsCvWq0qCMN0ohaBPHFz1KJMpV2FK4OzV0
 Qwhu8RFSxJrV0BXUmJx/fvaa9S+oA4IS2lN4Bpwey/jH67K3f/uJXyb3iaq1lpD4MMa6
 M8c3ahkn737KYR5hyK6U271muLmO7nqk/P4ftBzAEvHHgjvjlRrRtfSqBPzk2hnzG86c
 r/SCxWf6GXOwslVl6k/BAWtjqbiKQ3MuA3WMq8AED7CzMSWbDAoI8Ni7srZP+B0TmCsF
 HFoA==
X-Gm-Message-State: APjAAAVelDRpNoDirxNLh1Xn90RIGnxPRFMVmlwKu2SZPfGauXZwbjuP
 mdUyncOokSjUW50R3gPE+jf95H3Tfds/3nFHJAPpMYsxH/zzbyzinq7XlxKE64MAr4o29gZC7qX
 KdXNzFCvpdrlHzpU=
X-Received: by 2002:a37:a02:: with SMTP id 2mr106849qkk.111.1578414588600;
 Tue, 07 Jan 2020 08:29:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqvQTo5HQ1VRAX3+nhHtgXoybUt2XZ5MfPBYpojY7FXmRoLOeiAbshDGQ4NeYsAg5b47pq+w==
X-Received: by 2002:a37:a02:: with SMTP id 2mr106832qkk.111.1578414588397;
 Tue, 07 Jan 2020 08:29:48 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id u55sm114881qtc.28.2020.01.07.08.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:29:47 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/32] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Message-ID: <20200107162850.411448-4-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: jF4ZBLVaPjqj0fc5k-b1cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivq/dvq/svq/free_page_vq is forgot to cleanup in
virtio_balloon_device_unrealize, the memory leak stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
    #0 0x7f99fd9d8560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f99fcb20015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x557d90638437 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x557d9064401d in virtio_balloon_device_realize hw/virtio/virtio-bal=
loon.c:793
    #4 0x557d906356f7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x557d9073f081 in device_set_realized hw/core/qdev.c:876
    #6 0x557d908b1f4d in property_set_bool qom/object.c:2080
    #7 0x557d908b655e in object_property_set_qobject qom/qom-qobject.c:26

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <1575444716-17632-2-git-send-email-pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40b04f5180..57f3b9f22d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -831,6 +831,13 @@ static void virtio_balloon_device_unrealize(DeviceStat=
e *dev, Error **errp)
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
+
+    virtio_delete_queue(s->ivq);
+    virtio_delete_queue(s->dvq);
+    virtio_delete_queue(s->svq);
+    if (s->free_page_vq) {
+        virtio_delete_queue(s->free_page_vq);
+    }
     virtio_cleanup(vdev);
 }
=20
--=20
MST


