Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB71C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B19721741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0ICGrby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B19721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUroa-0000Ku-HV
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrn9-0007d9-Ly
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrn7-0001Wo-7R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603200903;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TCQt3FONooNUrwcwJvSPeVrxwiAZEYXC2/Olx6YiSrw=;
 b=A0ICGrbyyX60jZJlsiF7XZi9di6HwFKuBLqKc+P3RREyVl5QXfHqxbL+1ZgYjReyD9mbeT
 TtmG+9E7uFHBKNmsJWDE3nWiDwZHeo89gwYsLzN+i3X22PszwlgsgVVRb9nUxhStpgAohH
 HBxuknANy9K+nDc0eWyBSq5a7WiKKfw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ck26CAe6OBGpp_YgEjykwQ-1; Tue, 20 Oct 2020 09:35:01 -0400
X-MC-Unique: ck26CAe6OBGpp_YgEjykwQ-1
Received: by mail-wm1-f70.google.com with SMTP id o15so473512wmh.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=TCQt3FONooNUrwcwJvSPeVrxwiAZEYXC2/Olx6YiSrw=;
 b=ZEV4drqAnKxTaLDk0c+khw/1ItebxCIqp4KHYBh1GB/Q3q7GEt64/UG+r4aMqFrmA4
 K1Ry9KPtNXJl+dHSKqGFXfVgs0lnPEGjIsGFSGk9oBSlJOx2IKTVJqe9+8UoQHSjvOo2
 2dH12lTj7ErQkQ3+g9pbIFW11lN/o9IsjwMqa50HUHjHQZiWXpJCJNCa1yVI7pe8KJ3e
 YiPnESLu09mJTwNyCvFRDvM6MpH1K+w4dKBIAI3Uz1qZVNUrX3Oyv9y2BuhYjO7+lGjG
 XNIfYKtxZVuo7RkzIWalrvmiF7mGOr/I0RtTa02xPoHhG0pGiFN+VDobdxdvzVtjb1mB
 eKMg==
X-Gm-Message-State: AOAM5309PKy78EA/0bAhN0QPlPIvqqsTxBn5LQwHyQsaFMyoiGaWDl8C
 ffwLayNy3FlZXhyUzp1e9j4y9F+XeL61J8d59TM0BYFiqqYrYa1npclf9wk9s3GsHWhDU8o2SoC
 n7AP0NxXmYeRMpBg=
X-Received: by 2002:adf:f50d:: with SMTP id q13mr3481796wro.215.1603200900459; 
 Tue, 20 Oct 2020 06:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM/GnDCQ4m7b+MpWPAPM3oAsSrN8MQPR75P2R/SICDSlFYJ9eheUW4NH5XEsVxQ9KelXuYIA==
X-Received: by 2002:adf:f50d:: with SMTP id q13mr3481771wro.215.1603200900290; 
 Tue, 20 Oct 2020 06:35:00 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 4sm2844570wrp.58.2020.10.20.06.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 06:34:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 1/8] migration: Do not use C99 // comments
In-Reply-To: <1603163448-27122-2-git-send-email-yubihong@huawei.com> (Bihong
 Yu's message of "Tue, 20 Oct 2020 11:10:41 +0800")
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
 <1603163448-27122-2-git-send-email-yubihong@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 20 Oct 2020 15:34:58 +0200
Message-ID: <87o8kxc96l.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: zhengchuan@huawei.com, qemu-trivial@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bihong Yu <yubihong@huawei.com> wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/block.c | 2 +-
>  migration/rdma.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Juan Quintela <quintela@redhat.com>


