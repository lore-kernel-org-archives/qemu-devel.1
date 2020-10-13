Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60997C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD706248A7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnO9eGEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD706248A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLjz-0003xa-Hj
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSLir-0003Ts-MH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSLig-0005WI-LL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602600963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgJL2kFH+OPl+d1UJPk3htzwo9QsFQDODtMULui+JJI=;
 b=JnO9eGEPy6tTOInounYZDP/AX32tzdTh2mNTZ4LufGgsWaID4Zy6M01S68t6h+QNZXL05K
 PfHkeeEsev0R9q52sZdyupqt/W+F3Z4sna+d3iZKICQn0gtJuhKUDDvooEZjGuD5YczD2/
 IKA6a/D9bQoM93MAjj4qvPYFyVWghTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-C9KzS3vnOTimJlIgJeW7Yg-1; Tue, 13 Oct 2020 10:56:00 -0400
X-MC-Unique: C9KzS3vnOTimJlIgJeW7Yg-1
Received: by mail-wm1-f69.google.com with SMTP id z7so79889wmi.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pgJL2kFH+OPl+d1UJPk3htzwo9QsFQDODtMULui+JJI=;
 b=klofWyVIRk3m6TCu4n2T0y5Dazz+C9nhMt1y15DZPdW663U4WD6xti8Zd6BZTo6lgG
 1xQ/R8Okz2OvgTd+v0wHjzC+O9HVFGyog7L3EQthgpC/BsDO3Abqlflx/00ci7gZn54d
 X3kHmsL4P988ur/rfhNU7MdhXl8KNZajHmdmRnHRuh9ITngKfsUiB+UZKeSoZQx5VX32
 /ee6nMzO3clV4nC/f9qg1D2VGZEtMl6aUC/XZacG+ru72fT+BSss5vnGbaGiUuhdf5+I
 +4Vju/Edd35DxVqAMA5P9R473Hk24yLUIz6GX0ejDleWtwK3X8n+j6TP+SGbB6WqCYCl
 bNqg==
X-Gm-Message-State: AOAM5312Lsv7x5kVyMQhbTzFL+DzmUNYGlT+NArUw6808x/Hih39QIq2
 nhIjRmKyBulmCCz46FH2qs4gN/YMSlOnNHl8wOo62dcQYUShB0msPw8rPZ6jOiT2VsGnuR9fdIa
 SQaMqh9WzFX2ZoPU=
X-Received: by 2002:a1c:6004:: with SMTP id u4mr268369wmb.44.1602600959495;
 Tue, 13 Oct 2020 07:55:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIDPmQbEz1bO0DboVc4CZS0a0W1hDLbVYwTiQzcaNw0G6DvD9jPCQX8fAfGP/rWjJfheCZ2Q==
X-Received: by 2002:a1c:6004:: with SMTP id u4mr268345wmb.44.1602600959291;
 Tue, 13 Oct 2020 07:55:59 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o186sm10916wmb.12.2020.10.13.07.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 07:55:58 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] unbreak non-tcg builds
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20201013143806.14321-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd8e9295-dcd0-18c4-e7a2-86bed74f967c@redhat.com>
Date: Tue, 13 Oct 2020 16:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013143806.14321-1-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:38 PM, Claudio Fontana wrote:
> This series now unbreaks current non-tcg builds
> (!CONFIG_TCG).
> 
> tests Makefiles need to avoid relying on all non-native
> archs binaries to be present,
> 
> bios-tables-test needs to skip tests that are tcg-only,
> 
> and notably the replay framework needs to consider that
> it might not be functional (or its code present at all)
> without TCG.
> 
> Tested ok target x86_64-softmmu on x86_64 host with:
> 
> ./configure --enable-tcg --disable-kvm
> ./configure --enable-kvm --disable-tcg
> ./configure --enable-tcg --enable-kvm

If you want to avoid these configurations to bitrot,
consider covering them by adding Gitlab jobs :)))


