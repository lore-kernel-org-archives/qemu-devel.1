Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0AB20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsST0nOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0AB20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisfU-0004Hh-5L
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL8-0000Rd-G2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL7-0008Jc-Gm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvCRpjAXKNglq8ahDk7GnS4mPNv6Reg8kx+iDjbF7Mk=;
 b=CsST0nOtP5+odpqfQ5SIZ7qk4ARUgTuh3Xbapv7sqQ8uYotX+VRJ5fbB2Tq3WqVqOLarot
 0EMxgRdwhrUOT4MplTZ3w7cH4oGdKrbEzM01G6wFvDMrP+jQNHbst4my2MgLXO2JCMSQcy
 040Hqj4UMHKWqODLXClcID/jhGMb6TI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-LAF8q0iBN-2wzaO4oK3kgg-1; Wed, 10 Jun 2020 00:27:47 -0400
X-MC-Unique: LAF8q0iBN-2wzaO4oK3kgg-1
Received: by mail-wr1-f72.google.com with SMTP id w16so499359wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nvCRpjAXKNglq8ahDk7GnS4mPNv6Reg8kx+iDjbF7Mk=;
 b=A3TkPJmjFnsbZjJ0BJqsWLudh51KXGOrRYKLkCPPpZ+ofu35ii6PNfuTjSS6KUNlTK
 IT66RQtTFUoWXRXv6/1ZpboWcfLEVGroudWXBTVNmr58xut3SEtrL44bI7PmJ0rQXAm4
 pYLV6BBqOmmwDSyyLqlfVwbmsHyH2hWOQyFKb0aGarmvkfH5tTz43jE/ba8s9TTVEwtu
 M/TefDfEEWKD4ZykKPWOB0k+XsN/VFZ+61tufA14VUHettAFoUg+RH5pjqEu+2hLmGUX
 fobcuP5k1nnZSHVd7Jq9dNYZXIkkDHPtCx8FBrG0Zy40LyN0t3tjePiiPRyavbtr7nCF
 m9Mw==
X-Gm-Message-State: AOAM533RKoOj3qm3ay2Aofv2HoIKF89XXsim6De/7zt1KvuPOAj3TXgg
 /WIhxQIaa+Hz17tndLeE8bCxWl2F4WzY52057VzF3wuT0VscjCRF2SMNm/R7ToVzrPBDOKCWbT9
 ymGGwEcU1cuw/oHs=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr1435090wrv.58.1591763265615; 
 Tue, 09 Jun 2020 21:27:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnOOT/ar1qu/Xb9I1U+QX31bZm0gq2nN9JoCJxBM6PPnkQvULCtsM7Fy8InggzDOG1chmFKw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr1435072wrv.58.1591763265410; 
 Tue, 09 Jun 2020 21:27:45 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id s72sm4951248wme.35.2020.06.09.21.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:45 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/56] hw/pci/pci_bridge: Use the IEC binary prefix definitions
Message-ID: <20200610042613.1459309-33-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200601142930.29408-5-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci/pci_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 3ba3203f72..3789c17edc 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -423,14 +423,14 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     }
 
     if (res_reserve.mem_non_pref != (uint64_t)-1 &&
-        res_reserve.mem_non_pref >= (1ULL << 32)) {
+        res_reserve.mem_non_pref >= 4 * GiB) {
         error_setg(errp,
                    "PCI resource reserve cap: mem-reserve must be less than 4G");
         return -EINVAL;
     }
 
     if (res_reserve.mem_pref_32 != (uint64_t)-1 &&
-        res_reserve.mem_pref_32 >= (1ULL << 32)) {
+        res_reserve.mem_pref_32 >= 4 * GiB) {
         error_setg(errp,
                    "PCI resource reserve cap: pref32-reserve  must be less than 4G");
         return -EINVAL;
-- 
MST


