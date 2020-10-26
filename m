Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650DAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBFD21D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxaM95iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBFD21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2t5-0003Ll-MR
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2oJ-0007E5-AT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2oG-0000YG-RF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603719916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3vruqAts1RsLV9pP70IWMm33wr6U/BQ8UrHyYp0srE=;
 b=DxaM95iWpc7jDiJyPMX5dmoFL/ZuyLGP2cmFzn5z0VO50Z4Pf5eDow/1VEoXw55wlSDfff
 9CV4X0+9HH1FK88W04P+LgDNmo7Q1CV9nE+Q10w9WpPVhnkiXpxEeDvQCk1Ej34dQ9Ncps
 rXsNWoA1uMWKKrhp808ajaHzsN+E4uo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-isaAyYPhOV-of3noAMoTdQ-1; Mon, 26 Oct 2020 09:45:13 -0400
X-MC-Unique: isaAyYPhOV-of3noAMoTdQ-1
Received: by mail-ej1-f71.google.com with SMTP id p18so4997279ejl.14
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q3vruqAts1RsLV9pP70IWMm33wr6U/BQ8UrHyYp0srE=;
 b=ppKNC/lcS9XKHMU6LZA+gk0Jn6aeKzXmS61a/4XvCJQlXcAIxYclICkxRixDVyUNBZ
 Rt2aI+W7rZ3qJg0smquVUoZS/m/P1FfZoC5gb/aZCe60ROhj8ciQHxQaqErih70cxoGE
 uh4PWMkfzW5Z6fOopuCv55EXwiQM5c6z50baD6GsIriEbVdbwGRmUs8RRFHUvIZbSzk8
 DhjCWa8+lpFPDs8pvhyE89iVyize/zc87pkRIaBFhI2841tkJKGQ96wIsQCyv7pI9oGS
 Yl034EIOaAXEhfO69wM/ewurkFxFoH9kVyGyPvlvPzF6EiTmcNxPcilktOMCeTubFQnI
 ZaIw==
X-Gm-Message-State: AOAM531kh//tLCTahQSTk3zeXcwjxvGoQfLLF6AuHALQtthwyg+UReOy
 E80fjXU0O8H53ff4LMo8mG3rOwRIXuC+RXegk62bZpludyV3eSU7DOTtVG2mj8tOQa8YsCrFdEs
 Ywlh2Z82HHLC8S4Y=
X-Received: by 2002:a17:907:270f:: with SMTP id
 w15mr15226323ejk.505.1603719911750; 
 Mon, 26 Oct 2020 06:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOHxAw3RuXAW4xgcuVhszoshKqn8UdaQLtkB06YtPQ0O7PpLW8iQpGQxBGxdrqLFxAq7D2vQ==
X-Received: by 2002:a17:907:270f:: with SMTP id
 w15mr15226306ejk.505.1603719911575; 
 Mon, 26 Oct 2020 06:45:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q3sm5238030edv.17.2020.10.26.06.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 06:45:11 -0700 (PDT)
Subject: Re: [PATCH 3/4] target/ppc: Fix kvmppc_load_htab_chunk() error
 reporting
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371604713.305923.5264900354159029580.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <54c8018a-bf59-6988-7525-e17816992200@redhat.com>
Date: Mon, 26 Oct 2020 14:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160371604713.305923.5264900354159029580.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 1:40 PM, Greg Kurz wrote:
> If kvmppc_load_htab_chunk() fails, its return value is propagated up
> to vmstate_load(). It should thus be a negative errno, not -1 (which
> maps to EPERM and would lure the user into thinking that the problem
> is necessarily related to a lack of privilege).
> 
> Return the error reported by KVM or ENOSPC in case of short write.
> While here, propagate the error message through an @errp argument
> and have the caller to print it with error_report_err() instead
> of relying on fprintf().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c       |    4 +++-
>   target/ppc/kvm.c     |   11 +++++------
>   target/ppc/kvm_ppc.h |    5 +++--
>   3 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


