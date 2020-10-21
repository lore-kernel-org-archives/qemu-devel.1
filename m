Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F084C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEEF20797
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir/+tEhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEEF20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVG1c-00062h-83
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVG0g-0005By-9r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVG0d-0003ZF-IF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603293998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfAy8ojnytx3VxaKZt91OReCIkXU0VD26UjSXFq2wL8=;
 b=ir/+tEhH+UX1wUMRdmaokihFZTIGTBzPuBGDJkCtXiNj1SkEgPFl3kwNxg90kjVdvPIPpU
 7/Wm3nY6bK+rvc3rRhUdWhZtabKiEPsVuoVF6Q2cdO0pV58wmRWWMHWiyT8O0r8lJcSzuC
 dOEWpN6X8L+SlMjgSf56fR7x5UpVvEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471--_-doxSGPOqS46wCgD3B9A-1; Wed, 21 Oct 2020 11:26:35 -0400
X-MC-Unique: -_-doxSGPOqS46wCgD3B9A-1
Received: by mail-wm1-f70.google.com with SMTP id y83so1702598wmc.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EfAy8ojnytx3VxaKZt91OReCIkXU0VD26UjSXFq2wL8=;
 b=lQGaOfm7gn+WSFXOAALH+yzqBvR7dGYLZ4aY0X1g+NezuDkbGxcJWXi3+K23k/RGpz
 q18iLYFvdyfv8zauI92Nza3crvRIk/TgEqrGmOZK4RCUchwoUWvKAMoEZg0sIWKFMPo0
 fPeBLiei9+RuZA56g1daenx6GoaDWaH1Bm0FLn0RcO7ULJo594wLJEAAnO/BV17q956+
 f5Fv6HSU875veC9IwNdLl0K1WPK9t02DViW1H7iH+MhiWLUbV9mIZsoSX5++/ep0W9U6
 qpCJsdttksjVd2viZ2q8kAsshK/gul5YLk62MdZ/FeJykIcjHDb+7+a0/gt3WdSR4Awg
 3aQw==
X-Gm-Message-State: AOAM533MI/Y6wSY1d0ZswEQ8mnXydW4OGVulhFpA6EbT7pnMjqWhGuxe
 cF8PnhYhKxvlOhtVBSCje+z4FVDuWfF/Zdzn5Z0iY6egdfHWPwnkAidTpB/fm0i1mP8tLr2oRlw
 ppHUM159Ld378xLM=
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr5377043wrx.76.1603293993815; 
 Wed, 21 Oct 2020 08:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW2xKJEBaiKIdUgwYbbVu/Yh8lo4EopJeSujKdUOziTqwY3vm7Qkue57xY8si2AcVnlLZGFQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr5377026wrx.76.1603293993618; 
 Wed, 21 Oct 2020 08:26:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id z18sm4521372wrs.82.2020.10.21.08.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 08:26:32 -0700 (PDT)
Subject: Re: [PATCH v5] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
References: <20201021123757.2058852-1-pbonzini@redhat.com>
 <b745024a-73df-cca4-d660-111454e68552@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5411d46d-68f1-94e6-4739-8b726f40a617@redhat.com>
Date: Wed, 21 Oct 2020 17:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b745024a-73df-cca4-d660-111454e68552@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 16:46, Claudio Fontana wrote:
> in your respin you have not included my change which surrounds
> 
> if (replay_can_snapshot())
> 
> around a
> 
> if (tcg_enabled()) {
> }
> 
> therefore leading to failure of all attempts to snapshot under --disable-tcg.
> 
> Alternatively, you can change the stub to return "true" (replay_can_snapshot()),
> although its meaning can be quite surprising for the reader under --disable-tcg.

Yeah, and it actually makes sense since

    return replay_mode == REPLAY_MODE_NONE
        || !replay_has_events();

would always be true.

Paolo


