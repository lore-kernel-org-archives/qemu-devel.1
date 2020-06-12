Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF322081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaXPTsXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF322081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlNi-00076h-UG
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl38-0000WO-8D
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl35-0001aS-Tz
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UE9wdKZP6GU89BTo6VTTIYbzUF0RJkP16ivEbUjuuA=;
 b=AaXPTsXlNd1IzM8ahfawdObPbfgyCtFoXePUUAPxWFEg4YWo+Hin1vF22Jpy0pwAaTcRPz
 /kkM3ubS3dE4ldVt9FfZkiFCfJQhOkRclsl8YB8QUS0dclJVh+qiXsNPDzF+EMMCuOYNTQ
 /mXnQp+FKeyEebWzCZr2csypSBF6EhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-KWVTdW7nNQuChF4PgqDi8g-1; Fri, 12 Jun 2020 10:52:49 -0400
X-MC-Unique: KWVTdW7nNQuChF4PgqDi8g-1
Received: by mail-wm1-f69.google.com with SMTP id h6so2036195wmb.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2UE9wdKZP6GU89BTo6VTTIYbzUF0RJkP16ivEbUjuuA=;
 b=YagvGUylD/wNTzhp4qL413ZLj3zfHMtQ5MNWMhdycfs4LjVuDMFMAMLxGeoCZNANRY
 gKQc0jGehchAC+uRwJ7BwcPAHh3HaWth928IJjiNqzFcO9KqJL4b1i7iNX1UD/5bQZQI
 VwOdjF7e+X2/itdFopq7cXCXfSRvtzoqzmsY1MHr4BXsd5ZZUtZxYil9RUOWeGgj5FD6
 wreIFp4L2bsCcu1V9dwR5COoRo+VmMHHIh28HtikJNVpDXHbGrM5HTQIBzIwcNcTEc6h
 id1d2Mp8WwExMGwRZdXIEcz6RJiseeQqiTBEVVExByLdjfefGmEm6Fkhps0k6m4kkgFg
 iGMA==
X-Gm-Message-State: AOAM533AkGRCDCMscw3nW/YY+e0SIRXYw6NlGtWM1fzbRjTGdcmCSxJJ
 QtP72NIhMTtkbqa3pmed1JCQTH+8pK1hm7l3T3XZeekGjdAQSaURBTTptuuwIYavIUh/dh+ckfC
 WTVBrufNni8or/m0=
X-Received: by 2002:a5d:4204:: with SMTP id n4mr16273471wrq.247.1591973568206; 
 Fri, 12 Jun 2020 07:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZlkO4kO5MY1FZomgO4/NlH1Ek4W1n/n3KbFkeQy9NdcJqYFtZVERHzn89w/5ZN7DOejcnvw==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr16273441wrq.247.1591973567887; 
 Fri, 12 Jun 2020 07:52:47 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b18sm10084354wrn.88.2020.06.12.07.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:47 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 47/58] hw/pci: Fix crash when running QEMU with "-nic
 model=rocker"
Message-ID: <20200612141917.9446-48-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

QEMU currently aborts when being started with "-nic model=rocker" or with
"-net nic,model=rocker". This happens because the "rocker" device is not
a normal NIC but a switch, which has different properties. Thus we should
only consider real NIC devices for "-nic" and "-net". These devices can
be identified by the "netdev" property, so check for this property before
adding the device to the list.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 52310c3fa7dc854d ("net: allow using any PCI NICs in -net or -nic")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200527153152.9211-1-thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7bf2ae6d92..1b88a32cf7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1891,7 +1891,18 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
         if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
             dc->user_creatable) {
             const char *name = object_class_get_name(list->data);
-            g_ptr_array_add(pci_nic_models, (gpointer)name);
+            /*
+             * A network device might also be something else than a NIC, see
+             * e.g. the "rocker" device. Thus we have to look for the "netdev"
+             * property, too. Unfortunately, some devices like virtio-net only
+             * create this property during instance_init, so we have to create
+             * a temporary instance here to be able to check it.
+             */
+            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
+            if (object_property_find(obj, "netdev", NULL)) {
+                g_ptr_array_add(pci_nic_models, (gpointer)name);
+            }
+            object_unref(obj);
         }
         next = list->next;
         g_slist_free_1(list);
-- 
MST


