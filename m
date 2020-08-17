Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF8C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A46C205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCOp/erG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A46C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7i9o-00069O-7t
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7i9B-0005Np-Se
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:38:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7i99-0007gL-Ia
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597682286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzTceLykt/J0pmt8gKcDNliXiiAqyQwhZk3z9UUkoQw=;
 b=eCOp/erGhM+KFK7ytSsckojk2qC1AmNA5WWtWrlXtNNDXpLt3EuJYCcI84FnF0lTny/DYT
 e5/AIkrqT41YDlY+etqIZkLzqgNyPCfx7mh/gBiugCqXaFHXViZYrATsydmI7hdf8cseOB
 lPbTFaa6zRwgE6HmTXlCmzuQ6+2p5hs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-gMYzk7eMOh6fqZhFHl7npw-1; Mon, 17 Aug 2020 12:38:05 -0400
X-MC-Unique: gMYzk7eMOh6fqZhFHl7npw-1
Received: by mail-wm1-f70.google.com with SMTP id c184so4229080wme.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kzTceLykt/J0pmt8gKcDNliXiiAqyQwhZk3z9UUkoQw=;
 b=JvFmqt4Rr+8I8lIlCEgnGCobs9kMB8pLRDwDK/MKR2fJHSEJJE4S+kTAiE1UXtZkg7
 M3TcYDncBjryw/Sr90vaFRdUpMSxSgjPJcVR676yKwLnz2eJBA9WhhqyYNONk5WFqKej
 CUuq5bSC/fxLvgQFrsWbzsaKzhm8F7rS76C7mLVYt+fi7neqB6J+JpKY2L+2vBqJtphx
 HjcCfPFT4EYeToVRA1Mupt5HZnm/709sEywNoDBxngCaAgAPX1ZsiN9Mf13DkAorRFKS
 8+aHXsvwcYMDIcuL6ETzFaMAYWe6gXLwzhmgF57CE83FFami96LC5CtnH4LmSgRE3yJH
 DXeg==
X-Gm-Message-State: AOAM531v+eMdjaqN50TCIbws1/1kma7h5tV/phrV9BBqXI478cg6Muyq
 chfRbtaOYgoFRNJwuMBrHVJNpP1Su/fdXTDnZ/giNCD34ommvOEJVUrap+qkcdSlBkB14/0lyQ0
 AOGzYlia/1LkCbtM=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr16009472wrw.362.1597682283685; 
 Mon, 17 Aug 2020 09:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKQehD//OgZctf/YxaukLgD0a5AryeWch5yDWM9X1ZxmTTf+iFApWPaKJTj3Q+0JkPzw8/cw==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr16009446wrw.362.1597682283464; 
 Mon, 17 Aug 2020 09:38:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id p25sm29384601wma.39.2020.08.17.09.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 09:38:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] block; scsi-generic: Fix max transfer size calculation
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, Kevin Wolf <kwolf@redhat.com>, 
 Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d01fb82b-7f09-ddcc-4161-36cfd6e65f22@redhat.com>
Date: Mon, 17 Aug 2020 18:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/08/20 00:51, Dmitry Fomichev wrote:
> When a host-managed zoned device is passed through to the
> guest system using scsi-generic driver, the maximum i/o size for the
> drive at the guest may end up being larger than at the host, causing
> i/o errors while accessing the backing zoned drive at the host system.
> 
> Two problems prevent correct setting of the maximum i/o transfer size
> at the guest in this configuration. One issue is specific to
> host-managed zone devices - scsi-generic driver doesn't recognize the
> SCSI type of HM-zoned devices. The other problem is that file-posix
> code for finding max_segments system value doesn't correctly handle
> SG nodes.
> 
> The following two patches fix these problems.
> 
> Based-on: <20200424084338.26803-16-armbru@redhat.com>
> 
> Dmitry Fomichev (2):
>   file-posix: Correctly read max_segments of SG nodes
>   scsi-generic: Fix HM-zoned device scan
> 
>  block/file-posix.c       | 55 +++++++++++++++++++++++-----------------
>  hw/scsi/scsi-generic.c   | 10 +++++---
>  include/scsi/constants.h |  1 +
>  3 files changed, 39 insertions(+), 27 deletions(-)
> 

The patches are more or less unrelated; I have queued the second, while
the first is outside my maintenance area.

Paolo


