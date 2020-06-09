Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D004C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D96206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWKIHbPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D96206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiUF-0003yx-4A
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jiiRo-0000SP-7z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:54:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jiiRm-0007sM-Gm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591725241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PoNgeO0d0gLsKSqyPx0Y/dLjHWvuRlXFhk0lSXdhmS4=;
 b=AWKIHbPsFLky5EVJkgqvs2G2BSqt5hPuTatAyhiiQiHDIIKxGcjLbrBXOm33pWzJa6f7MQ
 h2e5jWYnmSnKOBSoKrZST1iXEUPzHmZ/BA1619nUgiLnCfCaQ7OKeHlH1RMsjopYYu7vYq
 /uZYyihMEUjFF95FDIootf0sOXQgm5o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Np2GM32MOemB2ZfYQ6w8LQ-1; Tue, 09 Jun 2020 13:53:59 -0400
X-MC-Unique: Np2GM32MOemB2ZfYQ6w8LQ-1
Received: by mail-qv1-f69.google.com with SMTP id d5so15845272qvo.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PoNgeO0d0gLsKSqyPx0Y/dLjHWvuRlXFhk0lSXdhmS4=;
 b=hOrdCYJxdDVe66x3cUZQhv+w3RU0aA4ZLnNXO8VlCPXsFqWNvHMCjyt0kGYlKz1Krq
 WyBL5JZ0pYrSjD2rnh4Dm21q495h0sWHTHrfT6iAtQALKVlqdpPTqsmv6Iwqm1wlGBYB
 4rhqdwhA5hq6F3Mu2WPYIVYK91Q2xoj5Ggv+0jsPPM6nYrvAHb5ONlEiYlsqz4VFyUWe
 71usHRLm9zaHFctROsKYRNYPbI3UT0Kne0yoirwgLNbZCk3Jn8TbVkfjBG/pIPcUSMwv
 EaZ2tPtTptOOUeMKk7uJcDK2RtBV3Fwxz3JJK232+6LebkmhoUTvrmazO6iBejdBj70O
 AEoA==
X-Gm-Message-State: AOAM530bLJD0e4idoALhhUbOZh8g2S6aeqGmB0d+gF16LYJ5hyItcFDD
 /tSLnjjixCsbVU+XxUa+tXNSE10Y7Apm8iTGdkdrvTCF3j0QyP6T6vOMdr339kULTBAwOmy6Da9
 uQ7dQ+ZgmcEBPkzc=
X-Received: by 2002:a37:7645:: with SMTP id r66mr28132459qkc.397.1591725238359; 
 Tue, 09 Jun 2020 10:53:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxic9wQxGf8nFWvuzA9+B0wb2CxBLiT/G9nlCv+MAUCMtNZnGMJl2/sq+Giz/GUWW2ONMbiRw==
X-Received: by 2002:a37:7645:: with SMTP id r66mr28132435qkc.397.1591725238114; 
 Tue, 09 Jun 2020 10:53:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v14sm11849974qtj.31.2020.06.09.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:53:57 -0700 (PDT)
Date: Tue, 9 Jun 2020 13:53:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200609175355.GD3061@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
 <6beb4b5d-91c6-2536-64ab-18217be71134@redhat.com>
 <20200317201153.GB233068@xz-x1>
 <2847e5da-4cc3-8273-f51f-86b0995943de@redhat.com>
 <20200609114913-mutt-send-email-mst@kernel.org>
 <20200609161328.GB3061@xz-x1>
 <f4faa7cf-1bb3-6381-05e0-64f01eb377cc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f4faa7cf-1bb3-6381-05e0-64f01eb377cc@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 06:18:15PM +0200, Philippe Mathieu-Daudé wrote:
> No problem!

Thanks!

-- 
Peter Xu


