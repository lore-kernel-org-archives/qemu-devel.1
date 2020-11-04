Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A92C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8CE2224E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av4RqMJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8CE2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFhF-0004jr-AO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFgV-00046u-Sr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFgU-0000Jt-8x
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604484389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gy5WYj7UMPiZF9/fsfs4rakfLPCwETeGPd8FcsHGdzY=;
 b=Av4RqMJQNKy0pAbv9aUuBuV2Qk9XpVuJYbUQUAUjmiLj3t8TL5tvbhCqDgEFbh49J3w9rh
 N86H2FuzT8noyKxEzzjWit2xQXqZCfuctg+aUxXVPmCOSOCnf7Vjmoi0XvjR62+F8ABp+t
 Ss/7klziVBntVSCS4raV7ZWSf9TL9lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-PmGPSC7XOrewKOIgoIbkEQ-1; Wed, 04 Nov 2020 05:06:27 -0500
X-MC-Unique: PmGPSC7XOrewKOIgoIbkEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DADCF86ABD0;
 Wed,  4 Nov 2020 10:06:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 176061C926;
 Wed,  4 Nov 2020 10:06:23 +0000 (UTC)
Subject: Re: [PULL 15/30] hw/block/nvme: support multiple namespaces
To: Klaus Jensen <its@irrelevant.dk>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20201027104932.558087-1-its@irrelevant.dk>
 <20201027104932.558087-16-its@irrelevant.dk>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ae2d0834-f556-6742-0d55-4692d7797729@redhat.com>
Date: Wed, 4 Nov 2020 11:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027104932.558087-16-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.10.20 11:49, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This adds support for multiple namespaces by introducing a new 'nvme-ns'
> device model. The nvme device creates a bus named from the device name
> ('id'). The nvme-ns devices then connect to this and registers
> themselves with the nvme device.
> 
> This changes how an nvme device is created. Example with two namespaces:
> 
>   -drive file=nvme0n1.img,if=none,id=disk1
>   -drive file=nvme0n2.img,if=none,id=disk2
>   -device nvme,serial=deadbeef,id=nvme0
>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> 
> The drive property is kept on the nvme device to keep the change
> backward compatible, but the property is now optional. Specifying a
> drive for the nvme device will always create the namespace with nsid 1.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  hw/block/nvme-ns.h    |  74 +++++++++++++
>  hw/block/nvme.h       |  46 ++++----
>  hw/block/nvme-ns.c    | 167 ++++++++++++++++++++++++++++
>  hw/block/nvme.c       | 249 +++++++++++++++++++++++++++---------------
>  hw/block/meson.build  |   2 +-
>  hw/block/trace-events |   6 +-
>  6 files changed, 428 insertions(+), 116 deletions(-)
>  create mode 100644 hw/block/nvme-ns.h
>  create mode 100644 hw/block/nvme-ns.c

Hi,

Coverity reports that nvme_exit() still contains a

    g_free(n->namespaces);

call, which becomes wrong with this commit (because @namespaces is now
an array).

(This leads to qemu crashing when deleting an NVMe device.)

Max


