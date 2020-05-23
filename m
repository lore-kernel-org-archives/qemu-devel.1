Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9FBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A5A20727
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLov8+8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A5A20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcarK-0004oH-64
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcaql-0004OR-7S
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:34:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcaqk-0004p9-Bm
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590266069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ii96JHZeWU7/nhs9XbEalD4DaA2KuKVPxyUYhuiCcEg=;
 b=SLov8+8O0kmYoPdq+DioS/JkKkHUWfIENrERztknRsxeOYsKEO1wwQq0vUmrxtXPoAR9+J
 7VibDadyqaacH6rX7aB+tURMPOdaXF0TDiusvLe6H4eECLXYrdv4Y9rcMg4WEo+Un/PmOD
 xtwi9g2AQpcm5RWGa32YFAYFYKFxtP8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-zy-_1RLPNLy2NbqzaQLxFQ-1; Sat, 23 May 2020 16:34:27 -0400
X-MC-Unique: zy-_1RLPNLy2NbqzaQLxFQ-1
Received: by mail-qv1-f69.google.com with SMTP id l1so11891431qvy.20
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ii96JHZeWU7/nhs9XbEalD4DaA2KuKVPxyUYhuiCcEg=;
 b=qwvaeNMTIAb6KRiyqj5OufI1UW21pVmhS8xrinijn4Bwb4O/nHjZK6B9QTwgecbjTr
 pVSb2X8pckS3fQa7A2PtzFuRcHtvxbJUPYv+XIzYvudDa9b8+cyUMupa2QVSk70q6/oU
 6uuAqMS1XOUlXPo1IO06bWfpnD+FLhlz+816LW5iqxqHCgTXGyvRCIwN5UMchhVQhUMc
 uYd9zZkzIg09fndcb6s2htUnC9kwQYnHT5qS+5Bzsib55/H5t6ONB4R3jbsDvbs0PVV/
 K+LUnn6Ony16hswKVaf2gPiqC4HqNsQ/qeFpAMBZ5hW8q25AIXmBKaSIBoCvZz5qxbSq
 1evA==
X-Gm-Message-State: AOAM531TMklM8rOhr/9s2gU6nUS+Z8J2wqQsVXdvmeoj2npY3rAWaEkN
 ZXu/4PKVAhtxBOVLGvUaTyzZT+PYbbrZ5eDnFZg+FFgdLk3GGZP/LwF8ja1Ei71dfEEFN6RpEiN
 IDKTIxp0pU/bFtys=
X-Received: by 2002:ac8:7106:: with SMTP id z6mr11416028qto.310.1590266066816; 
 Sat, 23 May 2020 13:34:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDHOm1/1N3jRgxfTARJYP7YvJ992flHmKRpbS4S7TVVzFcNWhnouf8BnwodpQ8WJPCBEC+4g==
X-Received: by 2002:ac8:7106:: with SMTP id z6mr11416014qto.310.1590266066613; 
 Sat, 23 May 2020 13:34:26 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u41sm12138514qte.28.2020.05.23.13.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:34:25 -0700 (PDT)
Date: Sat, 23 May 2020 16:34:24 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200523203424.GK766834@xz-x1>
References: <20200317195908.283800-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317195908.283800-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 16:34:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 03:59:08PM -0400, Peter Xu wrote:
> Sometimes it would be good to be able to read the pin number along
> with the IRQ number allocated.  Since we'll dump the IRQ number, no
> reason to not dump the pin information.  For example, the vfio-pci
> device will overwrite the pin with the hardware pin number.  It would
> be nice to know the pin number of one assigned device from QMP/HMP.
> 
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Julia Suvorova <jusual@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Ping?

-- 
Peter Xu


