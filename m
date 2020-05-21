Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21865C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8D1207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tta4ALFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8D1207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnF2-0003a6-0F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnET-0003B5-BT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnES-0007X6-H0
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xli3ng+xSqRDxcKJGkbEw8LmixS7Qx35O25Y7GwMiw8=;
 b=Tta4ALFh6F6HBlwSq3Xe1qzo8pbBCEkrJD6CzsP/ubhYmZfPVVdUoE93zuj1qbxx2KgvAR
 HD7rb8MCMhNAx8vYlFVBEQn2ph1kG8ZrZ/Ef6xRJeuureJ5FBMZf1DoUUTy3jrdCWxaW0I
 ATQbA7xxlQHQ40ti73kM8ijfF/nHPOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-IxuFgCYSPR2RChCjQpo55w-1; Thu, 21 May 2020 11:35:35 -0400
X-MC-Unique: IxuFgCYSPR2RChCjQpo55w-1
Received: by mail-wm1-f69.google.com with SMTP id y20so785845wmi.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xli3ng+xSqRDxcKJGkbEw8LmixS7Qx35O25Y7GwMiw8=;
 b=qJMpVB3C0f2n4f/QH3Wt72dSs1yviy2j2E0ASpCefVDFQDHnzQ2kkWwKHf+ma803uA
 4620kdBOiyxB9wLT4D7x4lORM8d4GJXfNj9gjB/XocmcN9OHRjoZ58iYtLcP5G/AInmr
 xhqZ8j+EN9t9oaPWPAs2AB9qec5AivDrW1EQQLYNruQNOHlTxDSYKVtiStgjOmfwD8D3
 VYyoEp9E9kq/ABH+pk1D+CSyl7Tl2O6l0udQSoZR8CBf2maSU42c53hm3DlqVGTlB6vu
 BZBg9y35SYNToO8siLJtwPulvTEnJtfxgD/PKBz535rUFKw74ZAL+mySDRnXaDrJP4Rl
 pS6g==
X-Gm-Message-State: AOAM532oRIuX7J8R7vDfSxwXskvOm7aJykBDl+JuevXmA+3gCjeAEX6Y
 zt4u7eZjzrNsxTbR6qyIXnShSvDu721FdEHZXuL9LTTWn3Hzp1cMDyJzCJ0tzb84ztZVYSZoDOe
 fns5+H43MbiQv4Qo=
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr10102976wmi.65.1590075334562; 
 Thu, 21 May 2020 08:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx85edMzVTPgQhJHh7KhS3tl5y17HQXnexr/VwPGbfZESvQ8nSOQ3W54dPTS6RpZQ8WjYco5Q==
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr10102948wmi.65.1590075334217; 
 Thu, 21 May 2020 08:35:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id f128sm7279152wme.1.2020.05.21.08.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:35:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Megasas: fix OOB access and NULL dereference issues
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20200513192540.1583887-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <014f5308-ded2-17eb-6ccc-e239636a4632@redhat.com>
Date: Thu, 21 May 2020 17:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513192540.1583887-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/20 21:25, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
>  Hello,
> 
> * First patch fixes an OOB access issue which may occur when a guest user
>   sets 'reply_queue_head' field to a negative or large positive value,
>   via 'struct mfi_init_qinfo' object in megasas_init_firmware(), such that
>   'index' variables in megasas_lookup_frame() goes beyond the
>   s->frames[MEGASAS_MAX_FRAMES=2048] array bounds.
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03131.html
> 
> * Second patch fixes a NULL pointer dereference issue which may occur
>   if megasas_enqueue_frame() routine returns a NULL frame for a given
>   'frame_addr' address.
>   -> https://bugs.launchpad.net/qemu/+bug/1878259
> 
> * Third patch updates other numeric fields of MegasasState to unsigned type.
> 
> Thank you.
> --
> Prasad J Pandit (3):
>   megasas: use unsigned type for reply_queue_head and check index
>   megasas: avoid NULL pointer dereference
>   megasas: use unsigned type for positive numeric fields
> 
>  hw/scsi/megasas.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> --
> 2.25.4
> 

Queued, thanks (but see my comment on patch 2).

Thanks,

Paolo


