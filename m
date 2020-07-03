Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB09C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981DD20836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="equi0d0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981DD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHlB-00012f-Px
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHco-0000S1-RA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcn-0004W0-2a
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+cCdkPsrD4TM/VrIcZdX3Ig4P6coUYr9PkA+fapcI0=;
 b=equi0d0sQYedatw5+x6vxQouzcufhHWuXtUYA7dyod7YD7sPIlVS/sl63vzYTMD8hUZtD9
 0+/T/BA0UYYzyG3EeO4P1LTsc5XxsMTncw0Cmy5MUn4cvGahnz0/ahmAd04U7ImRaFyD26
 odKKvMC3+VzPyXf8+UrAE41sxFQ9bbk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-KfvdTBizMKOBYV-MwNEpuQ-1; Fri, 03 Jul 2020 05:04:46 -0400
X-MC-Unique: KfvdTBizMKOBYV-MwNEpuQ-1
Received: by mail-wr1-f69.google.com with SMTP id z1so1301377wrn.18
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b+cCdkPsrD4TM/VrIcZdX3Ig4P6coUYr9PkA+fapcI0=;
 b=FyPls+KiFQP9eC0sGpEOm+2g+vOB42Ekx28PXrj/n/RnvZThyYS09xIJ9ycSz7q1vY
 TE3JKLZy7mzYRehs4hMxUwp9cxqVRHLbsl87gsNRlGcTo1H1PMv8G3yn3vAVEO7EL84p
 dhfeFxGnlRaqB2b4N9sIM2/dSpMsKQl/G2JKKli6Q0CSB4XQyiq3TQaVxzXvz0aWE87W
 AeDW0aNX4Fv1ir4ztI8IMAg1/wyXhgf6piCloQ48uZMZKVIF1G/4Di97fWIXsxWKL4H4
 IwiTuSH1U6v3aqP/HWbwZwiebNzK2yoCbA5IAElpopeGMTnZO/OwnpHFWYxkudnZNeEe
 NMrw==
X-Gm-Message-State: AOAM532D2+/1N0TYSwwX56ySimKAx3hzt5agXRGpwav4G7WdW9tcvEh2
 QPF9lXL3ThpfbDnMS8MyS0JpFeXKJc+0Z+lM2ZtEGaSc1nL25XMXoy5Y3xpw1+xjdEUjG4kIANv
 1nxS6li7jtKjGcuU=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr5374228wmb.93.1593767085282;
 Fri, 03 Jul 2020 02:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8k11ax1hga9RvwoEl3X4POoGOckBMufTY3rTD6NLb52ZpW3akWdluSOLrWXWu2FgDdUxrOg==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr5374204wmb.93.1593767085097;
 Fri, 03 Jul 2020 02:04:45 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 s15sm12972235wmj.41.2020.07.03.02.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:44 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] MAINTAINERS: add VT-d entry
Message-ID: <20200703090252.368694-28-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Add this entry as suggested by Jason and Michael.

CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200701124418.63060-1-peterx@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f02160436..49a0d837d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2624,6 +2624,15 @@ F: tests/uefi-test-tools/
 F: .gitlab-ci.d/edk2.yml
 F: .gitlab-ci.d/edk2/
 
+VT-d Emulation
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Peter Xu <peterx@redhat.com>
+R: Jason Wang <jasowang@redhat.com>
+S: Supported
+F: hw/i386/intel_iommu.c
+F: hw/i386/intel_iommu_internal.h
+F: include/hw/i386/intel_iommu.h
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
-- 
MST


