Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A0F20787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPQC681b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A0F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabxs-0004aM-0f
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabwp-0003LU-O9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:20:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabwo-00014X-Qv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589793633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26tLFnlPLiAEWSiHegUZMo+1itJ4wSaQMYZeBdznfVI=;
 b=DPQC681bUFOio4+GIpAs0t+bU1NSwOrfujp3oaL3x66G9qgdIzMRx0F4xty/JbMu0k2I5X
 Nxo3LTEHn3H2koT0q16+3er2oRpDglD9nwXEnZDKwYUUYET4sppDxSTK6ZUSKaunJouucM
 ruNdu44zvs++Cen4N+NP4N3ZZmF++mI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-7-FLMoCcP4ixdWfbKeAerw-1; Mon, 18 May 2020 05:20:31 -0400
X-MC-Unique: 7-FLMoCcP4ixdWfbKeAerw-1
Received: by mail-wm1-f70.google.com with SMTP id o8so2057408wmd.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=26tLFnlPLiAEWSiHegUZMo+1itJ4wSaQMYZeBdznfVI=;
 b=KPqXrYHuSeMYUvs1pie0X9+T/SaWOS2Rd8rXov0rt9YaWJTOeNjr/vaOw7w2Ao/DJg
 3Z6mA2zR1yScdp2suOPQyLmbUs0F4hIK87z9v51VQDt4M5EoPFx9ad1ULgab1kt7X4YD
 vGRFLK1Wxk7CiU00qdXdAiyyK6zCwHtXoVP5EH3T+NhoZghuQlUCWWR9+WOnzDQ+/Rdi
 4yAjQ25R4CGVSG72JzEu3O6zy/ekE/XcJmSINX+xtnL7azG18STq/KKKmPAb4zNk/Ps2
 7bT+E3ZDLY6HAJl6b2uXN0dhVarBxz2MAtp0LWtZHjimpGraX6Gv4GAz7zCmMZQ0zgmO
 ouuQ==
X-Gm-Message-State: AOAM532mrrD0jjnCWmDkoZbuhL3TgwYuVlx22sQwgdRS0b/3CMZwXGfw
 0JOR/iAgVrqWA8cyMnUAkYSNrK9OUL+reAm2lXRdmpp1+tjm/sRrQuUgu1Zhfxu6D3tf1ATyVRx
 0p2s2AEJql9/lHkA=
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr17979935wme.71.1589793630741; 
 Mon, 18 May 2020 02:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqFjlq/wh617Shg1D+p5f9g64z31sAvpKmryzx600bWn+60XrY6cvnFaXB3DdaSniYmijVBg==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr17979921wme.71.1589793630559; 
 Mon, 18 May 2020 02:20:30 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x6sm15118331wrv.57.2020.05.18.02.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 02:20:30 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] virtio-balloon: free page hinting fixes
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200518083704.52646-1-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed47036d-5224-9493-5d15-a2a464f5050a@redhat.com>
Date: Mon, 18 May 2020 11:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518083704.52646-1-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Wei Wang <wei.w.wang@intel.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:37 AM, David Hildenbrand wrote:
> Some fixes for VIRTIO_BALLOON_F_FREE_PAGE_HINT. First issue was reported by
> Alexander Bulekov [1], the other ones were discovered by me when digging
> into the details.
> 
> [1] https://lkml.kernel.org/r/20200511044121.eihns2tdimdzgi4i@mozz.bu.edu
> 
> David Hildenbrand (3):
>    virtio-balloon: fix free page hinting without an iothread
>    virtio-balloon: fix free page hinting check on unrealize
>    virtio-balloon: unref the iothread when unrealizing
> 
>   hw/virtio/virtio-balloon.c | 38 ++++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 

All this series deserves a 'Cc: qemu-stable@nongnu.org' tag, right?


