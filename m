Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095F6207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz2trLeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095F6207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bOS-00026B-87
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7b3W-0006iF-2F
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 05:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7b3U-0006bF-75
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 05:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597655027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X35wZYIYnvgTdM0PIU+9mMGzSR72ducVZms1cOn7WOU=;
 b=Cz2trLeQV54xU9/5OrDropOedHmlWl3b26MjczJxIAzi0zeO4b2gXjhMlc8il0fn4WzlB9
 0swn+RqAGnhy6S09AYTIN8Lx7apqUCWlLJ6ueLm+3pXA9XM4cPGrlq+rUE28Re5dgGdX5l
 bq3Z8H+A35lLiDhNST7oAHbi02f8YLA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-QccHJaNLOsCnPgJjpbYsNQ-1; Mon, 17 Aug 2020 05:03:45 -0400
X-MC-Unique: QccHJaNLOsCnPgJjpbYsNQ-1
Received: by mail-wm1-f70.google.com with SMTP id c124so4579227wme.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 02:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=10W6+w8S8KVTvPPTYuD7O76lRKEN8eCw/p+UvSihqdQ=;
 b=cwt4L+9Fz0aiRj131ezsLDUnm0soB5+qEf3LiKT/yv4sc3ghtTBT6g6alNOGIHq7mO
 b2qo7pQ6ODMBTnadxfvpt8d9O7fRfK2bVkC2KXcCcdDndgjcIbgLlD3fpRI9d36gL/85
 D8+eJF18VjA3Q+sO3IE9iZIutKbmCjAoDC7BgfyppjAoZ+d/8DvxImgq4RldgxENGY8n
 XeVA8FxR7QqA+GguU9v6UKZVA5bBOWk9aACeGBFKgqOizyF1wT1oaLq7GtUJUo6v+bkd
 gsA388KSmfLh/Nw3+JEzVzDWA+67L04s6r6Gfy/zFX+3qqezmeejSSQMxowijtkJrpAy
 2Nmw==
X-Gm-Message-State: AOAM531yEr2Zrd/QH1UPw2GDgw0j1tc8Mscm+sIIxkk9WoByDD1uUqUU
 Gm9nBzgmD9HNTOEJqZZvichdQru8Klin75SESErr8rxQs76eY68q2jjpT1ouf86VxyYfkBlQfYx
 /ECVcNk8Z3FKDMOw=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr14115126wrs.273.1597655024700; 
 Mon, 17 Aug 2020 02:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrhB8FU/5JHe6zeIVlYGOii6t7WWTqkQihhTXB5P//FXUmgnZAwGzZCJgtV/aUZasbmTFlUg==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr14115085wrs.273.1597655024370; 
 Mon, 17 Aug 2020 02:03:44 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id e5sm32177018wrc.37.2020.08.17.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 02:03:43 -0700 (PDT)
Date: Mon, 17 Aug 2020 11:03:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/7] block: Use definitions instead of magic values
Message-ID: <20200817090335.kgjvqnyjk2qujjia@steredhat>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 10:28:34AM +0200, Philippe Mathieu-Daudé wrote:
> Trivial block patches:
> - Fix a typo
> - Replace '1 << 30' by '1 * GiB' in null-co
> - Replace 512 by BDRV_SECTOR_SIZE when appropriate.
> 
> Philippe Mathieu-Daudé (7):
>   block/null: Make more explicit the driver default size is 1GiB
>   hw/ide/core: Trivial typo fix
>   hw/ide/core: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/ide/atapi: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/scsi/scsi-disk: Replace magic '512' value by BDRV_SECTOR_SIZE
> 
>  block/null.c        |  4 +++-
>  hw/ide/ahci.c       |  5 +++--
>  hw/ide/atapi.c      |  8 ++++----
>  hw/ide/core.c       | 25 +++++++++++++------------
>  hw/ide/pci.c        |  2 +-
>  hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
>  6 files changed, 47 insertions(+), 41 deletions(-)

Series:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Thanks for the cleaning that makes the code more readable!
Stefano


