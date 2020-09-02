Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C55BC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B7320773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9mcxd7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B7320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOIG-00051a-2e
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDOHB-0004BR-0e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDOH8-0005sk-H9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599035869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjxCKwG0dKjecIZHkVZuvJMQrvK2nqlvjLkwOqpagjQ=;
 b=E9mcxd7pSW0p/pRqtAYzGnX8us6QO3RsQH6cBsNhT/TQgPLgMFACySPtAybL8O+15WCK2b
 tzBqDIZieGo67O+/qhB3VgzvoN3qZ/q2vkMyep3zIS+HOBHXxmK0zwTFD49jUbLH7grWSU
 WMUHGgHvwF7RvwhFzMMC3G0d0OHjNNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-UQhtM1xtNhivalJqP4LR7A-1; Wed, 02 Sep 2020 04:37:48 -0400
X-MC-Unique: UQhtM1xtNhivalJqP4LR7A-1
Received: by mail-wm1-f71.google.com with SMTP id a144so1332801wme.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rjxCKwG0dKjecIZHkVZuvJMQrvK2nqlvjLkwOqpagjQ=;
 b=fngDPq4mkW4omC+K9v6BFb48csg3ZkBO04MCncVY+o5LRtmAjcyDioQou7jdHL2Sly
 2/eOMF0giu2u7Cc03Ybn1ujQKFVMKS0P2gGpNKqh1TvIymSLGPzpiHCIScnCL6kdJQrD
 Ekf/zp+bjZ4lEHBg66vY1wi3Mh+vtoqCh9m15cGlCZkbej1kDennu2TVqjKFEirg8/Zs
 WqNRKYR7vOtNhm0twzYPmAles0m+2OQ46yy1v+Ve3U7pPtxbz0F0KGSjs0GzgZ864hrC
 m+sO57sMYJE04oXMjQF8ZR/h6CyDtut5qHMpKCafCh7DxxccBxmrkWGnTerMjH3hLV/K
 FiEQ==
X-Gm-Message-State: AOAM532Dwdt8R72+AvasR+50PmMa3zGsI9CDVQFygTkOkG/hrIzf1BGR
 0mOkSvm6I4MailjZLSzJa9104KG/0EpM6IjQ/xnEUTwW3fKmBOxwD25Nkst47rwaF6hLSAWFoKN
 /v8FLQdAEIV75kMA=
X-Received: by 2002:a1c:2086:: with SMTP id g128mr5758043wmg.89.1599035867035; 
 Wed, 02 Sep 2020 01:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxulL7MDyNw5KLqpN9FGIO7+2U5Zo3056izSlj/PHdu33WBBU6MWgM2JSWqyT7XAUquNazuVw==
X-Received: by 2002:a1c:2086:: with SMTP id g128mr5758023wmg.89.1599035866798; 
 Wed, 02 Sep 2020 01:37:46 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id n16sm6280791wrj.25.2020.09.02.01.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:37:46 -0700 (PDT)
Subject: Re: [PATCH] qemu-iotests: move check-block back to Makefiles
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200902080046.10412-1-pbonzini@redhat.com>
 <20200902081933.GE403297@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <579e9d08-6235-0cdc-bbf6-07f2fc489426@redhat.com>
Date: Wed, 2 Sep 2020 10:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902081933.GE403297@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 10:19, Daniel P. Berrangé wrote:
> On Wed, Sep 02, 2020 at 04:00:46AM -0400, Paolo Bonzini wrote:
>> check-block has its own test harness, unlike every other test.  If
>> we capture its output, as is in general nicer to do without V=1,
>> there will be no sign of progress.  So for lack of a better option
>> just move the invocation of the test back to Makefile rules.
> 
> I expect the correct long term solution here is to stop using the
> check-block.sh script.  Instead have code which sets up each
> of the I/O tests as an explicit test target in meson. We could
> use meson's test grouping features too.

I'm not sure, "check-acceptance" will never be integrated in Meson, and
it may well be the same for "check-block".  Actually I wonder if Avocado
would be a better check-block.sh than check-block.sh.

Paolo


