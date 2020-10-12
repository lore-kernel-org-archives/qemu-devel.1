Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A179620735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz2SuYsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A179620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS08P-0006j4-Nr
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRzqS-00075r-66
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kRzqL-0007K1-7J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602516871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdHMrQKgcxRXfLDvQ+1YLDqCa4F/2upjZ5B+bFIqTGo=;
 b=Rz2SuYsj8eoyPwBLlsD/WutLsLvzvnUtd7xLpBm9DRCEN8gSwElUZbOEOAgH47jCDwp8yG
 KeHV0E1DG7oG0xI0vXnmmO+4CQpm6ogfppxU/w7cE2l/u+8hvGiG+gKOfwNZHChS5KnMc0
 EDELmg+22alW+vtJ76pEhTxEIrcAJVM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-vbbj9CzsOWqPbkhz_tBlUA-1; Mon, 12 Oct 2020 11:34:29 -0400
X-MC-Unique: vbbj9CzsOWqPbkhz_tBlUA-1
Received: by mail-wm1-f72.google.com with SMTP id 13so5891963wmf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdHMrQKgcxRXfLDvQ+1YLDqCa4F/2upjZ5B+bFIqTGo=;
 b=Lx4LOuavUaTP412u2OFBU8Wg2HUoTiziCB5Mri+N2S2WsPiuxtEw6Bewxn2L9CXPFK
 bw7b78Hy5haYq+QPGe1JEGpyQrvzdaVaNxJgIg+CXu3uDGVEUOY1goRLBhFay0VyPHWZ
 8qFxDJWS3l5cIgJDTyFjpB97FnXDWI5gUNl/NrVoRoB7vSbQoh8V84bEh6aFWZwnrxKO
 wU5bvU1+HjXJdwMXZmZoLuRCFewvIm6HlzHajqglS3JAgBB+hIdR1dxWIQUWFV1cICWM
 3DsIn862NuPq0eK4ZJyzFvuwQpR93S4rFCWmIjPItWnjWdjZV6OnhrbGpMX+2JOiEXH4
 WXuw==
X-Gm-Message-State: AOAM532Z+Lm0EzVc1jQCrxp25O2K9joulVvgwmOyGH7hCsXf5ixoSLlF
 MBSj1L5d2Bun9vUKgjehXs1b4Vuvt00Ya5QNbDxM2vTHMVbY9yabsHCJ6Fpw6mWXg5TZHB/536A
 L5XgLkTU3peaAEwQ=
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr12017466wmi.56.1602516866754; 
 Mon, 12 Oct 2020 08:34:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAakJQGUizc/HK0CxsRPCYuLMEy5unpqToSxQl/z1VTo6Vzim7AmzH3MM3d8WWEboXxPxCOA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr12017449wmi.56.1602516866485; 
 Mon, 12 Oct 2020 08:34:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id z127sm23691600wmc.2.2020.10.12.08.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 08:34:24 -0700 (PDT)
Subject: Re: [PATCH] scripts: display how long each test takes to execute
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200914110948.1425082-1-berrange@redhat.com>
 <fa7c5d50-cfc5-78c2-edf9-416231322f81@redhat.com>
 <20201012150916.GJ39408@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <475a8cc8-9cb2-4ad0-304f-a98ec6d4993b@redhat.com>
Date: Mon, 12 Oct 2020 17:34:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012150916.GJ39408@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 17:09, Daniel P. Berrangé wrote:
> On Mon, Oct 12, 2020 at 05:07:18PM +0200, Thomas Huth wrote:
>> On 14/09/2020 13.09, Daniel P. Berrangé wrote:
>>> Sometimes under CI tests non-deterministically take longer to execute
>>> than expected which can trigger timeouts. It is almost impossible to
>>> diagnose this though without seeing execution time for each test case.
>>>
>>> With this change, when passing "V=1" to make, we get a duration printed
>>> at test completion:
> 
> I wasn't intending to update this given paolo's negative response to
> the patch.

FWIW I opened https://github.com/mesonbuild/meson/issues/7830 with ideas
on how to improve "meson test".  All the items I added are more or less
blockers for QEMU, but feel free to add more if you have any ideas from
your experience with Libvirt.

Paolo


