Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C268F21973
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZzyFZew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C268F21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpgB-0006pO-Rg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIpfT-0006QJ-IQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIpfN-0001UR-9z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600332800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgZX71ET0dR7Xi+ONrTkL9r8cWWVd78lqODC6hUUE7s=;
 b=iZzyFZewA+TffPBmy0Hye7VbReAbVD3ZR5dcwVTtuuMHfNGmatzEExvuhq3e7e0Q1/DR8S
 C1eqHVD+Fp+TmPosTKyfXXGQ+H8gyiEU35Zbmxr4TAdNESMY0UvAa70haH6A+P+NKk8tmE
 8G71RSinPqPYS//OyOfWXDEyqicOOpk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-F9vTrLeHM7acE-mkKrk6Vw-1; Thu, 17 Sep 2020 04:53:16 -0400
X-MC-Unique: F9vTrLeHM7acE-mkKrk6Vw-1
Received: by mail-wr1-f71.google.com with SMTP id b7so614591wrn.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rgZX71ET0dR7Xi+ONrTkL9r8cWWVd78lqODC6hUUE7s=;
 b=Auwu8oY9T8qBB8lYKgZodU41yIayrQSphW/0zLMeckAGAQR1+/6kiGy8emFQXLbuqm
 aqO0pHaE9CokQZbg+fAbE+4VvEHJeed05qqmDBN9pvGJNW09nf2vUCd/uWVzuSyKDJ7m
 wBaFjpTdDvLKLzJB/5QEfe71e8iIz0wXfPeU0fGqXKJ3C2zNqGIUeviCfhlw9i25zuJ3
 fnKC7l2uFtb14iQnRBAbiZIXmhf7VsUZCU1Ub6syFaroK+p/eLOiz6QnV7ShGKYub/ln
 ghZsv+w1dw42eE0IYHrhPCOWyMC9BtXHqLCNr6rjU6gNQEtYqgsI9CgsQAU30VdD+CIK
 Ch4Q==
X-Gm-Message-State: AOAM531K7zrNGVFDMmX4pqtKBO7rHcSmKdFCFWA97MZWmchdoxN9Kk2p
 rqLkZBQW963ccdiYDHrGcFM9c2v80yp9AGjU1fWU0DPcLXdXyTb96PXc6xPPUqhW+s5h0CqAUXU
 fdwvbUl9tVlofuMg=
X-Received: by 2002:adf:b602:: with SMTP id f2mr29686969wre.186.1600332794759; 
 Thu, 17 Sep 2020 01:53:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy52dtuChD9uVylhFP/BgMLn/Dhhs44w3Jlz2E86SOLtm0hUDtmSj2WbKDpuzSmzs7k2VwByg==
X-Received: by 2002:adf:b602:: with SMTP id f2mr29686960wre.186.1600332794519; 
 Thu, 17 Sep 2020 01:53:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d003:b94f:6314:4839?
 ([2001:b07:6468:f312:d003:b94f:6314:4839])
 by smtp.gmail.com with ESMTPSA id s2sm38805951wrw.96.2020.09.17.01.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 01:53:14 -0700 (PDT)
Subject: Re: Use patchew to push successfully applied series to GitLab
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <22951108-74c2-a98b-9316-b17c4d8188e0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f90ee77c-11f8-e025-8f4f-38e78e0fe618@redhat.com>
Date: Thu, 17 Sep 2020 10:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <22951108-74c2-a98b-9316-b17c4d8188e0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: patchew-devel@redhat.com, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 10:16, Philippe Mathieu-Daudé wrote:
> patchew is currently pushing successfully applied series
> (using the cover Message-ID as tag) to GitHub.
> This is very handy (no need to apply patches manually):
> https://github.com/patchew-project/qemu/tags
> 
> Can we push the same that to an equivalent GitLab account?
> We could then have a script replying to the series if the
> series fails CI. Doing so would save reviewer/tester time
> (I'd rather have a series not failing on our CI tests before
> starting to review/test it).

Yes, we could.  Indeed we could also look at the pipeline result instead
of needing Patchew's custom testers (using a webhook).  It would be a
bit on the heavy side for GitLab's resources; while right now they're
still providing unlimited CI time, in principle the "gold" tier provides
"only" 833 hours and a full CI run takes more or less 1.

So it would work great but we would have to set up our own runners,
and/or have a cheaper pipeline for this gating CI.  Is that possible to
configure in Gitlab?

Paolo


