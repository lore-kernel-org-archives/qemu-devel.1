Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A768B22247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuSlEYSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A768B22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrwK-0002BO-6H
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrpq-0002s9-5M
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrpn-0001y8-GZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603201069;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=WuSlEYSYQQ6WyicxKyWNIrpPg+LtiQdfK5SHG5n+/YxIig3IN0SOTNFCxFa4cGSWi9LhLz
 zalcDa2Zx36IqSY2Q1I+L82e3+V4r62Pc/Ne4NaK/maer41zJkmHJsskVxlDDRiO14Dg+N
 XJiHO8spIZhmGZRGJ1fwfk4XA8/5a5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-WQfry9PzP7KYXzBu2IkKVQ-1; Tue, 20 Oct 2020 09:37:47 -0400
X-MC-Unique: WQfry9PzP7KYXzBu2IkKVQ-1
Received: by mail-wm1-f71.google.com with SMTP id f191so407502wmf.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=kDv1lX4bJiMLOs727DWuEjWxdgg32BX71qEgPwdH1FPBkV9LapeUHEs9MbvcO5sG48
 zLm7FGOC3mVafSsivQvjQKc2T/ZkjpTfI/VZp/cBXmaasvtxRLvgYfr6I2W1DdRLgaDz
 ImCkQbkTbAacEgnHvOyJucpI3FsepZ4vARoJbHKV9IH29zO8z6tYRBAx3yDwZu1AMLqt
 +OOV0FDKLW9yHUxnkh2AgMV42R2VroNu6iPbhEJP7fzTmlo6VsNZiBTNfz+MeISlH1Mv
 83w0Oh0WoMGisnyM9DBgvvUrvUTI6J6wnDMJ0Z+5ePALDXtf/G210MfGI6ci7DLqHlAM
 ir3w==
X-Gm-Message-State: AOAM532uXuq2XdJoQp1SRsDw+BYTJdJBipSc8hXr60a96gsj1gddpD0n
 xcqyckaZ5Gh81pJnEoU2fnIjKJNRsRIvfAe7vks+Ecao/UO6lfcfihvKO3Ycod8/XALlWh2xG9v
 93AzyOMM5ECVEh2Y=
X-Received: by 2002:adf:f903:: with SMTP id b3mr3695473wrr.142.1603201066871; 
 Tue, 20 Oct 2020 06:37:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNL5nS+K8fS7CPdrqCU6BXLyASYXLanWpDlMyDFb1YjqQ+6h7ljb46l1skumtpKGC2SxzG8g==
X-Received: by 2002:adf:f903:: with SMTP id b3mr3695460wrr.142.1603201066732; 
 Tue, 20 Oct 2020 06:37:46 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 40sm3257225wrc.46.2020.10.20.06.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 06:37:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 4/8] migration: Open brace '{' following struct go on
 the same line
In-Reply-To: <1603163448-27122-5-git-send-email-yubihong@huawei.com> (Bihong
 Yu's message of "Tue, 20 Oct 2020 11:10:44 +0800")
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
 <1603163448-27122-5-git-send-email-yubihong@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 20 Oct 2020 15:37:45 +0200
Message-ID: <875z75c91y.fsf@secure.mitica>
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

Reviewed-by: Juan Quintela <quintela@redhat.com>


