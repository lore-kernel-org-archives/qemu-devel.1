Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A440C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE41324125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZFflezi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE41324125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHnt-0003mC-V9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuHnA-0003Cx-8v
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuHn7-0007iu-TE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuHn7-0007iO-Pu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579706377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voEQnMwPd3Kno9wrkxk6ceQj6qg1Y6hRuAhfwfjh9tU=;
 b=YZFflezioL0g/HWI1tKxjjOVbNV36ZDikYRi0gsng9SuamBdr36l9QmjJRecu+4aEAUw36
 ydTX/BN7HHrShyGBXPrNbUQ3vJGBo5joxdh9jBEA4dKMG1OQStcodln4JN6imZyXgpMMAJ
 qqIEwLVnP6ABl0lgLxRy9x09nNto9NE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-tmIeuFdjM-ave1zpzE1QoA-1; Wed, 22 Jan 2020 10:19:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so3231832wrw.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=voEQnMwPd3Kno9wrkxk6ceQj6qg1Y6hRuAhfwfjh9tU=;
 b=URBTy0YtirXiLvg2MzseLv31MDLz0EjScwYBYy2IN97R1vkw4sPLcUZNN6CjJJqgbP
 tZ6l1xT/ltHpQmBPcfBeC7H2kdChqQVJ3gT65prnkQHg3+RBh0Qnoc/XbXIzGDauUA6H
 gk5X8zjWxxEAztbPP3MaNeCwQJkpF0K3y4uLO4qOSnQrbZH2AUzqmCNOHSRZJZyTsLxu
 xG9pq5x1jUmfgtQskrt+Yot9WqnZnalIzC+6G6yok/J+R8R8CPAORceKT3v9HXJKgqXz
 v6j5iHcipPj19ueyp3gQtJ65nXQJ4vbkom/hoxKh+1U5J29yQGWEG9sbMxcrgiFeORpb
 9INg==
X-Gm-Message-State: APjAAAVGLUAOZdlFbyeJ5gsq4lYgt5DEkL37jAVtETNxlrDmQHgjbsyj
 uaWASm0vF00pu6VdSXmi3arrC8EbpOr1ZGZKiuW5rWptuXTkRkTbFHi3p0YLzKC7NWMEqjmE1bV
 9Zk3Qv0npGWrTOns=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3500757wmk.172.1579706372439; 
 Wed, 22 Jan 2020 07:19:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzK+VB38KPTsDAaT0NznE21uqJWmQZOIxhIdVqIrbY5IEHaARQ7WFAZLA1Kc8CNcRK7Fynqaw==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3500732wmk.172.1579706372116; 
 Wed, 22 Jan 2020 07:19:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id h2sm62069050wrt.45.2020.01.22.07.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:19:31 -0800 (PST)
Subject: Re: [PATCH v2 0/2] fix mismatches between g_strsplit and g_free
To: pannengyuan@huawei.com, mdroth@linux.vnet.ibm.com
References: <20200110091710.53424-1-pannengyuan@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ab5b3a7-b0e3-71e0-cfc8-30773157b176@redhat.com>
Date: Wed, 22 Jan 2020 16:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200110091710.53424-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: tmIeuFdjM-ave1zpzE1QoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/20 10:17, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> v1: fix a mismatch in vl.c
> v2: fix mismatch in vl.c and qga/main.c
> 
> Pan Nengyuan (2):
>   vl: Don't mismatch g_strsplit()/g_free()
>   qga/main: Don't mismatch g_strsplit/g_free in split_list()
> 
>  qga/main.c | 2 +-
>  vl.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Queued patch 1, thanks.

Paolo


