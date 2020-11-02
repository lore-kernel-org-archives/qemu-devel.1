Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBFE2231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLv3NdWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBFE2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZc19-000124-Up
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbzO-00084e-5n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbzM-0002S3-AV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shQNn1czOwThYAKmNytNJQPNGFjAA++TBm9c9tDBJZ0=;
 b=HLv3NdWcLP2zt8aN7BfmV9w7R5xzz64vYvFz8Gyt9SgYxjQWnlBqzba7XADmEwENi8eStU
 ZqSdLusNIb53QSHVJCGuVEv5Pg7Y3MNLznkuvAwJ2XI5QzVLFO9slHzPoZq+oKzKnf+Z2D
 92XC8w6tlbxDV92TUD+9ly38lSKEag8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-gUBdUhpwNCqco5Za_zbgnQ-1; Mon, 02 Nov 2020 10:43:15 -0500
X-MC-Unique: gUBdUhpwNCqco5Za_zbgnQ-1
Received: by mail-ed1-f69.google.com with SMTP id b16so6296732edn.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=shQNn1czOwThYAKmNytNJQPNGFjAA++TBm9c9tDBJZ0=;
 b=q4s0DRccMb3K91qEs3+1IS7gCSNYEXP/GQUbo9PYHdiQ3YFO9AfVIV3mLnvyTRWaTc
 4GhRw3gSrqfYxREzAXPCB04sIJejda9ULfifqJb7vHmXMblS8KKaqZoAMWMApfjlLiKd
 9EslCZPO047uipGO/yFrNaaUTsVThYDFDRT1FE2ep9DjuqxkingAdBGPOcHX2WzdNUQT
 K7yb8qryiPO3+0FdprEJRSiXq6y2wHVjvayIdrLo1kvdJoPnJYWvlmjZUrh5p1lrD620
 V+/OxhyvLQJxOt6QJ3HcACp1bBqB4hcBB0D67XsLAM9A2gRA/L3G1i1X0LYYT9+0U5FS
 Kapw==
X-Gm-Message-State: AOAM532NlsMscDPhOyp42FGuCGtHwZBddFz5boG9UtuliNWrgzYf0Rzo
 fIySaPZrXSYUTf1U6VSP31XTQ4GElmhEmDui0RTwBaSFdrsN2eaHo2p3JRRu3EGi7qHSeMtw0by
 28QT9JsREUpgHQMY=
X-Received: by 2002:a17:906:1c0f:: with SMTP id
 k15mr15312097ejg.343.1604331793807; 
 Mon, 02 Nov 2020 07:43:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjJUz01f/qdS+yDBoTTjz2cTKYUy5+KS5gouGZ4iUGl+VYPJ7+R5qq292yubFW8/aSZNAKEQ==
X-Received: by 2002:a17:906:1c0f:: with SMTP id
 k15mr15312074ejg.343.1604331793604; 
 Mon, 02 Nov 2020 07:43:13 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g20sm9657499ejz.88.2020.11.02.07.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 07:43:12 -0800 (PST)
Subject: Re: [PULL] nvme emulation patches for 5.2
To: Keith Busch <kbusch@kernel.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20201102152747.GA28552@redsun51.ssa.fujisawa.hgst.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1067800a-a1d4-55a0-436d-920255ca5aab@redhat.com>
Date: Mon, 2 Nov 2020 16:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102152747.GA28552@redsun51.ssa.fujisawa.hgst.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: its@irrelevant.dk, k.jensen@samsung.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 4:27 PM, Keith Busch wrote:
> Hi Peter,
> 
> We are sorting out Klaus' signature authentication this week, but in the
> interest of timing, I've signed our pull request for this round.
> 
> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:
> 
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/qemu-nvme.git tags/pull-nvme-20201102
> 
> for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:
> 
>   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)
> 

FYI this part ...

> nvme emulation patches for 5.2
> 
>   - lots of cleanups
>   - add support for scatter/gather lists
>   - add support for multiple namespaces (adds new nvme-ns device)
>   - change default pci vendor/device id
>   - add support for per-namespace smart log
> 
> ----------------------------------------------------------------
> nvme pull 2 Nov 2020

... goes here, this is the tag part committed (the part before
the --- mark is removed).

> ----------------------------------------------------------------
> Dmitry Fomichev (1):
>       hw/block/nvme: report actual LBA data shift in LBAF
> 
> Gollu Appalanaidu (4):
>       hw/block/nvme: add support for sgl bit bucket descriptor
>       hw/block/nvme: fix prp mapping status codes
>       hw/block/nvme: fix create IO SQ/CQ status codes
>       hw/block/nvme: fix queue identifer validation
> 
> Keith Busch (5):
>       hw/block/nvme: remove pointless rw indirection
>       hw/block/nvme: fix log page offset check
>       hw/block/nvme: support per-namespace smart log
>       hw/block/nvme: validate command set selected
>       hw/block/nvme: support for admin-only command set
> 
> Klaus Jensen (20):
>       hw/block/nvme: fix typo in trace event
>       pci: pass along the return value of dma_memory_rw
>       hw/block/nvme: handle dma errors
>       hw/block/nvme: commonize nvme_rw error handling
>       hw/block/nvme: alignment style fixes
>       hw/block/nvme: add a lba to bytes helper
>       hw/block/nvme: fix endian conversion
>       hw/block/nvme: add symbolic command name to trace events
>       hw/block/nvme: refactor aio submission
>       hw/block/nvme: default request status to success
>       hw/block/nvme: harden cmb access
>       hw/block/nvme: add support for scatter gather lists
>       hw/block/nvme: refactor identify active namespace id list
>       hw/block/nvme: support multiple namespaces
>       pci: allocate pci id for nvme
>       hw/block/nvme: change controller pci id
>       hw/block/nvme: update nsid when registered
>       hw/block/nvme: reject io commands if only admin command set selected
>       hw/block/nvme: add nsid to get/setfeat trace events
>       hw/block/nvme: add trace event for requests with non-zero status code
> 
>  MAINTAINERS            |   1 +
>  docs/specs/nvme.txt    |  23 ++
>  docs/specs/pci-ids.txt |   1 +
>  hw/block/meson.build   |   2 +-
>  hw/block/nvme-ns.c     | 168 +++++++++
>  hw/block/nvme-ns.h     |  74 ++++
>  hw/block/nvme.c        | 915 +++++++++++++++++++++++++++++++++++--------------
>  hw/block/nvme.h        |  83 ++++-
>  hw/block/trace-events  |  32 +-
>  hw/core/machine.c      |   1 +
>  include/block/nvme.h   |  18 +-
>  include/hw/pci/pci.h   |   4 +-
>  12 files changed, 1022 insertions(+), 300 deletions(-)
>  create mode 100644 docs/specs/nvme.txt
>  create mode 100644 hw/block/nvme-ns.c
>  create mode 100644 hw/block/nvme-ns.h
> 
> 


