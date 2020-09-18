Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61372C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC9821D24
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG363yWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC9821D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJDR-000231-0m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7i-0005FQ-SS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7g-0005lI-7M
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQLHX1DoJKJj5W3DVopK1pVavkbFhdLI78v3G2Q4YW4=;
 b=AG363yWk6/nA7gHEOKwnxL6COvMa2KcucqDfpgVp2QBiq2WLMzyJsf1qKsqT42Qi+fNFS8
 BIW2NATISeNWupryZGiuUIL0yeUHT82dPBIY/KBEvE2UsddvF5XReoLSYBWMZ7Dw+8kbfm
 Sd/PQOial2+f7hCAihfCKGRv8Z/IEUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-MbAGSbzGPzG7EKCEP4E0gA-1; Fri, 18 Sep 2020 12:20:26 -0400
X-MC-Unique: MbAGSbzGPzG7EKCEP4E0gA-1
Received: by mail-wr1-f72.google.com with SMTP id h4so2331205wrb.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cQLHX1DoJKJj5W3DVopK1pVavkbFhdLI78v3G2Q4YW4=;
 b=FJpS7GPBHpzgxXHAK93b6HJs3bHhGSiZQ5N7xKfOadO4XL5zpfKrZT2RGqpb+hlnwD
 4II/oSCKxcKgoQqt8fcq0W76cmmAJGTfozV0YnsFe5GwWI391E5L6rELZMeo3rH7O3zV
 EnyF+ynjKE3fLk5Ed5d98vqkTfdWox4qVbmXoHhUnuyXivOGTzymH0qgppWgudmpWotf
 zSNSH006sdsgAtdUHAJFJUmOSxSGn41NaJxdJ2cY/pAj4CQath7v6rjaH+3HoKGi6Rdh
 6v0EldVjF+/DgK5n1vO3FhKPoP7npMapKhOYt4/gY9GpuWDcpaRkiPq8F/0F/A4VeNdu
 znHw==
X-Gm-Message-State: AOAM532AH9Y5aDb5v8yE5ouVyMdvOabR5hxe3Eg8vcsUAbcP4jOH2hPE
 WcVdDB9zPtbm6OaPRnIJUZ+2e1RYWlZtpcH72Qx2iARpseOOAgZTQ482uT7ZBrzJj+0myj3DvhY
 wFN8XSeWqyG5D5wg=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr39531344wrr.269.1600446025041; 
 Fri, 18 Sep 2020 09:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbkL3nYp1jsxgLayp4DGAN/gpY7D4KM3CDnNmJ+cr4f+xKKfaogLgWL2DJp3EZFfDPdt+htA==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr39531317wrr.269.1600446024822; 
 Fri, 18 Sep 2020 09:20:24 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id f6sm6142752wro.5.2020.09.18.09.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:24 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/15] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200918161836.318893-10-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add support for the vhost-user-blk-pci device. This node can be used by
the vhost-user-blk tests. Tests for the vhost-user-blk device are added
in the following patches.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
index 5da02591bc..c0fd9d24e3 100644
--- a/tests/qtest/libqos/virtio-blk.c
+++ b/tests/qtest/libqos/virtio-blk.c
@@ -30,7 +30,8 @@
 static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
                                     const char *interface)
 {
-    if (!g_strcmp0(interface, "virtio-blk")) {
+    if (!g_strcmp0(interface, "virtio-blk") ||
+            !g_strcmp0(interface, "vhost-user-blk")) {
         return v_blk;
     }
     if (!g_strcmp0(interface, "virtio")) {
@@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
     qos_node_produces("virtio-blk-pci", "virtio-blk");
 
     g_free(arg);
+
+    /* vhost-user-blk-pci */
+    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
+                                PCI_SLOT, PCI_FN);
+    opts.extra_device_opts = arg;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
+    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
+    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
+
+    g_free(arg);
 }
 
 libqos_init(virtio_blk_register_nodes);
-- 
MST


