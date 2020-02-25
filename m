Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B431C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6662064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUg924mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6662064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c4x-0003HU-0A
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bud-000118-OF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buc-0001VR-NN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6buc-0001V4-IV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qy9/687s6ZY1i4Ce3m2ls24YlJZNFW8NDWw91xMGiXM=;
 b=bUg924mriWRfDpDIArhGvnrrdpdasfeh92Xl3sctP5ntrWJY+wtlHQQjs+t3xAZsy94Vgr
 v2JoU+6L41DGhoWX+DsHYvpcT+zpuvhSLc5gn0k4KnIBU8IPQ44cjF5aDo8CppgHdg4843
 vntpNmjlklOMfOGQ4kYd4sv38GbiSfY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-z0uNVI0yOU6og1WqMMozIA-1; Tue, 25 Feb 2020 10:14:15 -0500
X-MC-Unique: z0uNVI0yOU6og1WqMMozIA-1
Received: by mail-qt1-f197.google.com with SMTP id r30so15155140qtb.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=66uA6nm0t2SlG2qj7xxlmLCKVkLyYwtKAF+OGhXadUo=;
 b=ga3v+KiubbLo/8AxRakDLVMxwongBJN6Xw8FqPVO6e9d+OPTuCl67hKaPzG4YEAPxe
 ZKqa2dcLvCWj6B+QzXV1FyOduexWhvQD2vokaUP236lgMV9+nBMgKIvo+S0okVQV4zj6
 fTJyDuDDZvNOFjtgsUHjY0bDxsglHVmwf2FjnOIMzfdzYat5qvBmWapbucRhZye6Rl4Q
 CCLENPPu+MSfvJYU62LZ8Z4xE6eRTVl6azYZ22OQ+M9mLbAJgi8r4htLEbQZBJ4b1XMt
 gDfCjP2tyEXonlV4tmJ0//ne1uk8jF//3iD7aaIuEk5DR8yWtUoYnvZ5id3ZTR7FySUk
 CFKg==
X-Gm-Message-State: APjAAAWK/h4J06UHdIKTq5n+Ed7XbOWl/CAvz+Wr0DFnrpjStE8GAhQt
 prVV4mDSDMGIFuGIFzlaLU0KTgO1KIl8YZ6i7uzsa32SNILil89n4Bv7MBECubgnUJFem8BHMCR
 uvru32Snf5OtJFoA=
X-Received: by 2002:a37:4e53:: with SMTP id c80mr32516856qkb.58.1582643654872; 
 Tue, 25 Feb 2020 07:14:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsvjMDSkILq0d6UvyzqEaN+plnS158t3MC6k4FkTYWDxGkTSxi2lHdn7LQMJs6l9mObvoO7g==
X-Received: by 2002:a37:4e53:: with SMTP id c80mr32516822qkb.58.1582643654626; 
 Tue, 25 Feb 2020 07:14:14 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 j17sm1710279qth.27.2020.02.25.07.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:13 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] MAINTAINERS: add virtio-iommu related files
Message-ID: <20200225151210.647797-22-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Add a new "virtio-iommu" section with the new files
related to this device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200214132745.23392-11-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 195dd58cac..ff06934bb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1631,6 +1631,12 @@ F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
=20
+virtio-iommu
+M: Eric Auger <eric.auger@redhat.com>
+S: Maintained
+F: hw/virtio/virtio-iommu*.c
+F: include/hw/virtio/virtio-iommu.h
+
 virtio-serial
 M: Laurent Vivier <lvivier@redhat.com>
 R: Amit Shah <amit@kernel.org>
--=20
MST


