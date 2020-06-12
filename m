Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5222AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B10120691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDHpqySq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B10120691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlDh-0002DT-77
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2K-0006nU-4C
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2I-0001Sn-EF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faqMeqxMHWHCdUO54aiSA0UglN7d7KGvOFdxDmBlKuk=;
 b=hDHpqySq23pumRAtu1JeoaBuR1IvS7+heuA9Dao8jkLd3a0/YBc5R+HvJGnRwSAOyLQhSp
 z/+uY5jg8IaakS/v8GyMh7QFnNVj+Wqk4VvrCMrzOETVnEbyeLbZF/rbZvPpwhxGKV8Nbj
 nnYbSXoVipmrt33bEfVZV2qz0GQbAj4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-exIWrETwNnC-0V7fNdvkYw-1; Fri, 12 Jun 2020 10:51:59 -0400
X-MC-Unique: exIWrETwNnC-0V7fNdvkYw-1
Received: by mail-wr1-f69.google.com with SMTP id d6so3993255wrn.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=faqMeqxMHWHCdUO54aiSA0UglN7d7KGvOFdxDmBlKuk=;
 b=hFQnbCB7R+sYQLwhInoH70E2z9FJZMTdpJe7QmjRKI5yMuWy7hWXhG5drH8MA4SKqV
 U4EUosO3TD+hVswLvHFC3Wddy8rAGtBIE6TJD0EX12B42dXUxqWVbgOCIcO4VEgRh+K3
 /xleadA2mik3GybNT7Z0+E/Oky6GKfgfeVooppndIZt3ZeQKL8GpyXFTEi7uP+tSTEAq
 Mq/WMcHpEUZmfgY0H5ZJ1gPBR7cSOTpRs1TlsmXrEl3DkL4Wi+KVOS3D9KNyRR77+NfJ
 zcUUTHjE83UjtoDTPSwWC39nfPTBymdANEMCI9d69RWMEXYMhUGYH2HEfXaGEyou1UeG
 yJtw==
X-Gm-Message-State: AOAM5326eRN9VKrECqFSce+ROmEWmg8SENMcEjzwxVScJmU7cZVdyrG6
 +6qNixuu0RaxnP/c0fqzTKus7Y9ANg0+9FlBSnO8Vggx2Ufr8kIpncEtrNrPnjoOFiB0VPczdGB
 MbixANyfkZN7LhAA=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13603880wmc.10.1591973518220; 
 Fri, 12 Jun 2020 07:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVFLJwVUoeZ8XIOe/8WuvCGQdcjHtYQxXhDGXB3x2E5rST23tp6VZWFukTGjlT81RLU+B/7w==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13603862wmc.10.1591973518023; 
 Fri, 12 Jun 2020 07:51:58 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id a81sm9680533wmd.25.2020.06.12.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:57 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 24/58] virtio-balloon: unref the iothread when unrealizing
Message-ID: <20200612141917.9446-25-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We took a reference when realizing, so let's drop that reference when
unrealizing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 32e9fe3f64..cff8eab6a1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
+        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
     }
-- 
MST


