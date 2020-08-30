Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B02C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 16:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFF020714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 16:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PF//elVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFF020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCQPT-0008Vu-8i
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 12:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCQOf-000800-Nv
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 12:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCQOd-0005QV-69
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598805693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3H96eYfu5c6XMQfg0jpYIxfzO797bwfa5iXK9Esvos=;
 b=PF//elVx+Ce5Bg1aqFlOFjdRMczpNd9yy8YFse1UKwXclofa62DuKkwmIvsf2pV7TGZOOL
 eWGM5S1Mopf71S2L6Q+2B+Ld66ZsZtid8rY+YqCMGDVSM/nvwUKktkx5ERITrk5Ww9DEGS
 kQ8egXP1QBHz4fOx+s8cHGB1P3d7rBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-ExB2XZd1MTWZ7TdBnSYzbQ-1; Sun, 30 Aug 2020 12:41:31 -0400
X-MC-Unique: ExB2XZd1MTWZ7TdBnSYzbQ-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1760969wrv.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 09:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y3H96eYfu5c6XMQfg0jpYIxfzO797bwfa5iXK9Esvos=;
 b=qO+GM7eqodl/wWwMK5ShYResGYu9aYsEoeLct0pKXMoAeDeUPXwBLSqxZTPHFL76dh
 MMl8bvQBPPZoU37sGGEvc5JKwrxJVbGHAL6v2HVbkaW6uev5wPwRiXBw390LhXTcUDCM
 2WHQfm4P4K/qSdle3Rjs0JY/fixL7wcOxwo7ywzCBhcTS3yTQtuTiuhJ2Nc93Shi0W+j
 K7Eykd7EKyUwS4gWdZudkdqUiJ+XEdurIC0Jbwli4atRdlqhvCHAT71NrMuCgkrwYf20
 nLt2aERCQhjv4dCB1XhVS9Mkyl2SzUiEuF6FrlieLXYhpuGYiHhz0qCQtaGOPSCxSK/G
 78pw==
X-Gm-Message-State: AOAM53137nKo0KOgG6mAG6YtQcvNqEfOBJ+gjMtMXG+8pg17hxNDB1tJ
 OQ0izmZAEmnnnoZq4f8YUyfPDFrp3SzGfOn9/MvZE9w7zoTgp2AV23AXKJa9yp7ie5IN0U9PHVC
 j048wq5eALxMCP9I=
X-Received: by 2002:a5d:6685:: with SMTP id l5mr7963488wru.264.1598805690757; 
 Sun, 30 Aug 2020 09:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxKZo5KXUudekcUPXQ5xYsZ6ueHze6CRKTQSlp2ci4cGMl2PPuzL8Y9uTJoIA8c6CKyjq9lQ==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr7963472wru.264.1598805690508; 
 Sun, 30 Aug 2020 09:41:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id c10sm8065564wro.84.2020.08.30.09.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 09:41:29 -0700 (PDT)
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
To: Claudio Fontana <cfontana@suse.de>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
 <d65ff2d0-0859-ae68-6186-6fa6e5e63370@suse.de>
 <2eee7264-efa8-08a7-d1df-0afb30deec3c@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ca544ba-47e5-435f-7b2d-d9620f36fbfc@redhat.com>
Date: Sun, 30 Aug 2020 18:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2eee7264-efa8-08a7-d1df-0afb30deec3c@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 11:40:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.207, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Colin Xu <colin.xu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/08/20 15:34, Claudio Fontana wrote:
> Ciao Paolo,
> 
> just a ping on this one, it would seem that qemu_clock_get_ns needs to be called before
> any accelerator is initialized, before ticks are enabled, as part of qcow2 initialization.
> 
> I could add a check specifically for this and a comment in the cpus_get_virtual_clock(), but do you have any thoughts?

I think you could always return 0 before the accelerator is initialized;
the CPUs haven't started yet so the return value must be 0.

However, I wonder if that is already causing problems with live
migration (where the QEMU_CLOCK_VIRTUAL jumps from 0 to a possibly high
value after migration is completed).  So independent of this series,
perhaps QEMU_CLOCK_REALTIME should be used instead.  CCing Berto.

Paolo


