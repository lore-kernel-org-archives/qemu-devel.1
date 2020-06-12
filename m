Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D7DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F737207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcWufKvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F737207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjm5R-0003wM-Ls
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jjm4i-0003Iv-MQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:58:36 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37047)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jjm4h-0007CP-4D
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:58:36 -0400
Received: by mail-pl1-x644.google.com with SMTP id y18so3914264plr.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=weMvZslEdSVlBYz6n2J8T66q9SDJwAZ3g7FDMCCWpIY=;
 b=OcWufKvAAZe1aSBwLyY1jmjzjsCibisozxJaxwH6dluMUV3WimKbGBKhUhvtIJ/L+N
 Eq0wKlN3T8tiQ28r1Y2vfmEm/JQPwh7VvLEVuV5TYhhzwm47hpHI33U5BgTuLp/XiG4c
 5b0ONsS9a+BRmQVc43LBNnduMH/O3QTs8w84cBbyigX6YQ/IkC52NaK7b21rT5v7cqJL
 UXXT0qb7ncQEx8q4xXShQoeDDkr05sXXkN/7ZWHvyL3fLE7rSMDN/jBqhq+c/A1Rqh35
 VQtc1MyOGi2W6iHrBPiLpn9yca/BjAT69QVQRB7cSzn4onpVqHakImpiX8MtQbjgM1RJ
 pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=weMvZslEdSVlBYz6n2J8T66q9SDJwAZ3g7FDMCCWpIY=;
 b=ItQjeqZBu4VdUxbA+cXNmUo950HyHI2g8en6M+qi8Sv2Rsbt2pUyXCQBcU4AzlDBXI
 CGGmgwnD56JoEAfy01aAy6j1dkiLks6PLAQAioLIRuKlQAfAUTqvUcrFbl+qZv9NwLlB
 IYicsjLn6wAlNHMEYEGikc8EI/4uFq/ARx/IPxE0Hci3yvYs5x17hSBaxpYnQFm6PFmY
 aQxJTlGjSsIFHCZsHsQT7I8wKY8H/oJfWZdPqOhirXFXpzSTqSMGmqzEkKh87Uwb8FcY
 P3FTfOKP6PJ0rsf7vWVHcO2swl4hhE6pWQkQeMp5t2sSKtfZ2rAgNJ/H7ysH9wPS65HX
 RIOQ==
X-Gm-Message-State: AOAM531/9oznKQv2VL9eI6xAexBDlRksAWw5PiSSLKSqOf3TpvBlkNR5
 +zld9xC4ig82x2K4fU3ezwg=
X-Google-Smtp-Source: ABdhPJzJsWOLg8pmovhXBhb4nXCFHM0n9VvU3v57NUovh+vSDOOTUJRl+PPwIF9ohCAUacTgykdXOA==
X-Received: by 2002:a17:90a:1a17:: with SMTP id
 23mr13490542pjk.231.1591977507292; 
 Fri, 12 Jun 2020 08:58:27 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id iq19sm5645990pjb.48.2020.06.12.08.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 08:58:26 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 12 Jun 2020 23:58:22 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8 0/4] vhost-user block device backend implementation
Message-ID: <20200612155822.k25elf3hpciw67lk@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200611152744.GD77457@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200611152744.GD77457@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 04:27:44PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 05, 2020 at 07:35:34AM +0800, Coiby Xu wrote:
>> v8
>>  - re-try connecting to socket server to fix asan error
>>  - fix license naming issue
>
>Great, thanks for posting these patches!
>
>I have posted feedback. I'd like to merge this soon. If you are busy I
>can send you patches that address the comments I've made, please let me
>know.

Thank you for reviewing my work! I'll post v9 to address all the comments this
weekend, does you think it's soon enough?

Best regards,
Coiby

