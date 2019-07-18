Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24920C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CC921019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CC921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnvMn-0002sG-KC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 21:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnvMe-0002RI-0P
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnvMd-0000ib-3b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:37:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnvMc-0000i4-Tb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:37:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so5826508pgc.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 18:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LCz2zphFe9dqR/iXCW3kppHJXzn2GAgw7Y1K4WMtLXU=;
 b=GEJZDMiZet9IqPmmmkCRastj35Of/SuMrOjhBdqMYONMxgitXdUiYxv2P0bjzGMiii
 AORH+aY/F7h2pf0S5omIP0t3WRy3B4vbswnlY8YqXCUkoYS0Pr7chJy79/bQR0ZXBtTF
 2dP+BkL8LnPOpwFZgWZT6PDPy+jTsp1YHcteq1f/z5uIptuasaNYsX/7HvuthQnDb8XU
 o0wQ3uYiPHcr8/bVmwOheWYTxq8SLnWQD/AKq8vUnpenQfCa8WcFosvAZuZJaakoR7rb
 WrFR5B9hl5SapjlXhmTK5LBZQj+K2V7zaRSDIsRFLKg9yklIK5kS0Wj7rxj5OPUD8qj6
 pvBA==
X-Gm-Message-State: APjAAAXQ59IbiCCBGGBkjOvHbaijzTG6Q7FqqdvyxkBY2LWr748MuQmo
 BN0Fbt53gvJSJ1jNG6ILt3KRGw==
X-Google-Smtp-Source: APXvYqzdD5YbcX44m4pegnZ8IHbzgX2l8F45VRLCNYT4qD9VmG45SGJxQCDXTiJLVNHp1L1wHg705w==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr4573394pgr.156.1563413861777; 
 Wed, 17 Jul 2019 18:37:41 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o13sm24418261pje.28.2019.07.17.18.37.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 18:37:40 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Thu, 18 Jul 2019 09:37:31 +0800
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190718013731.GJ30980@xz-x1>
References: <20190718012547.16373-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190718012547.16373-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH] migration: just pass RAMBlock is enough
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
Cc: pbonzini@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 09:25:47AM +0800, Wei Yang wrote:
> RAMBlock->used_length is always passed to migration_bitmap_sync_range(),
> which could be retrieved from RAMBlock.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

