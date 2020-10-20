Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E094C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A153321741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vbyh4ueA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A153321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrsX-0006JJ-L0
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUro6-0000UW-SE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUrny-0001mf-J3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603200957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=Vbyh4ueANzjPNtuM245tZMvc100wOSgbvcx5zkwdFHb+klJI1+4KSiNFLMdSqtJgzjExHe
 ISgCv1yE2Ez+z2S/PfbmjFqt3yF5bRRsAgV55XJHZvBBXxA5CFd/065wIgaTneQWuLN1Lj
 KTU4KSf9WDSqCaaVLiZ54J3Urep51Jc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-vR0B-n7_NcealBeG_K70IQ-1; Tue, 20 Oct 2020 09:35:56 -0400
X-MC-Unique: vR0B-n7_NcealBeG_K70IQ-1
Received: by mail-wm1-f70.google.com with SMTP id v14so467491wmj.6
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=Q5wF88JL0QdclagRgYtwbNc7/5Wm60uvA6tierOxAx0=;
 b=tKzrH/uFMMFbyMW468vCKFI/ka2nCJNkvVpBM/EoeP/XOcNTlufMN2b+P8oXJEbBye
 NW5wjJcmSaYgzp0vo1+FOCtcBdZs6ct0xCY9/m9Y49+t0WOFjOquNFcSHNJ1joRjN9AY
 uERhjl36st7lVze2NRlrW5unAApryfBwsGVd5RRFjbUZBS3BLHe9Pq8hPEfRFVqmoGdt
 2Mf0QKZXfbXEtuHcPBU3i/pViGUsw8A/QtQMTnQkbeGEtArUKN+E+QUI7WnNMWAI6puE
 Pv+GbJyC6nkM0UqK8pl7Rdq067k29xcj7quhUYNTt7fcSm5X2CYEhP5hoVD+nAUA8u8G
 uYOQ==
X-Gm-Message-State: AOAM532O8mh2MFpbPBOZxwEsmICVpm60N4Ti3VqkSuWM/qs9757XEieh
 9AORdLAyPVeYTm1yeXh9ZWsHvwioWSym5HvJ0F3jA0Q7CYrhktkaZ06H9CVcmwpMkCxzl0Z+rvc
 QY5qT1ZyWo7ew+So=
X-Received: by 2002:a5d:508f:: with SMTP id a15mr3554250wrt.417.1603200954480; 
 Tue, 20 Oct 2020 06:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygfuIA4S9Djbbzb4bVWZf46V23omw/G9jODXA8FbJyrijiF4N6dFT0WX8z63R/ZCRxMlxCtg==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr3554238wrt.417.1603200954336; 
 Tue, 20 Oct 2020 06:35:54 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id w11sm3086515wrs.26.2020.10.20.06.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 06:35:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 5/8] migration: Add braces {} for if statement
In-Reply-To: <1603163448-27122-6-git-send-email-yubihong@huawei.com> (Bihong
 Yu's message of "Tue, 20 Oct 2020 11:10:45 +0800")
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
 <1603163448-27122-6-git-send-email-yubihong@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 20 Oct 2020 15:35:52 +0200
Message-ID: <87eeltc953.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


