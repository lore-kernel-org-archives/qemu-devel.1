Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39454C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7C020575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgN0vfgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7C020575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhvD-0006s5-Pb
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhir-0001nR-BJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhip-0005IE-CB
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:04:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhip-0005I2-8a
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586955894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX4NKjQaIT6y+qxfeigOFk8WuHnkmkz5xen/o8xFSzw=;
 b=EgN0vfgiUqTvVb5WFPjoUru12xoNQAQKmCxqgNdeTYcNAD4TymbcOXgIjG7DyXQc4n9JuF
 79kGrYjTLLP6I7tX14ecnx9U0N+cxnwb2Y6bhrV4wPWi2XYn6JF3GOwoufneIYSN7Fd5FB
 UD481uGdiTg8zQBbL1uhEVKiA9e2/ro=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-RfZje3PkPkyGv2zOo_hkxg-1; Wed, 15 Apr 2020 09:04:51 -0400
X-MC-Unique: RfZje3PkPkyGv2zOo_hkxg-1
Received: by mail-ed1-f69.google.com with SMTP id d1so2856447edq.11
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XOofiCgDkNBk1D3kGg35dI93R6dLdc2o6KFbDoD1hls=;
 b=FinE0j1dXKGGFB/3Ht4s65+IKzWiLnb0Ljpa7jsYzHeobrmhGD3lABwdAZw7y5xvoV
 UqEqdpuVEfoQvmfKJUOm127Q2hGMn7I7pGADRrdTzaTp+wIJA5XlPMNhneUjQnELwHFh
 y3qqPC5ItEcp/pyJ2b4JxAhGroQX1oSY+Lb70TNWkV4PDq0CYrXk1pkJJgnbH++x+3hH
 LYvDWaCUiwwHBOX74laazKPeojcOhnB3DkF1J2ba/TXUgeCNz4ucdcVuwYViZeLV8CkC
 Z7Cyr4dhFxYJifMkyaARJEpMwkN1iSeuD7RoloqOf65b3VIxAZegmx0yNPIiMohltGo0
 vdrg==
X-Gm-Message-State: AGi0PubQgJ82qrWmWeLGg/8ISRQtTQhamDDJO+syjgtN1RowJtk7vMMb
 PSjersXhH/ZFOihrcrkD+XwVnXodhV0HrvTA9JLkdfo5vzGgPFj2KnrGSNceQZJh09T5kfTIv1j
 czeSpXg3a3BN7CXM=
X-Received: by 2002:a05:6402:74f:: with SMTP id
 p15mr6342652edy.227.1586955890031; 
 Wed, 15 Apr 2020 06:04:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypICkboC3hd9peQNUR3/DLkjnhGKbWZyoXarKhaJ0bgE2YcabNp8DDA19HnCW5qi1YtaUMahuA==
X-Received: by 2002:a05:6402:74f:: with SMTP id
 p15mr6342630edy.227.1586955889832; 
 Wed, 15 Apr 2020 06:04:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g20sm2625649ejb.41.2020.04.15.06.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:04:49 -0700 (PDT)
Subject: Re: [PATCH v2 02/16] nvme: rename trace events to pci_nvme
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe3c25d8-c2a5-a581-4a4a-36779ee10dc8@redhat.com>
Date: Wed, 15 Apr 2020 15:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-3-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Change the prefix of all nvme device related trace events to 'pci_nvme'
> to not clash with trace events from the nvme block driver.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c       | 190 +++++++++++++++++++++---------------------
>   hw/block/trace-events | 172 +++++++++++++++++++-------------------
>   2 files changed, 180 insertions(+), 182 deletions(-)

Thanks for updating.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


