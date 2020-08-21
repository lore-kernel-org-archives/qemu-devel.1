Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02AF20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/bOXZzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02AF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BHe-000629-55
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9B8W-0006Pi-1A
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:47:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9B8T-0003jR-Qn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598032045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86gKNecevr/rTg0ofF7Oy5+/RD0VjGTMr49Qav1l8IQ=;
 b=K/bOXZziuCXMz2AakCSnUIHLo2o6r4Loo/Z1bqjq+k3can54B5CJBQB3JFuvNRGCfQljyK
 eYJJN/F9Fj5PthzUTWDiZuL6CG8ovlW8ARxKp19Tci+k9ydxrp7FGwJXwar0jFxU2n7IEM
 6kOjmsKRK/KcqoAieK6Rz9apx4i2PkQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-Ex10VGMPMgS1G9QaJFnBjQ-1; Fri, 21 Aug 2020 13:47:22 -0400
X-MC-Unique: Ex10VGMPMgS1G9QaJFnBjQ-1
Received: by mail-wr1-f69.google.com with SMTP id f7so782647wrs.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=86gKNecevr/rTg0ofF7Oy5+/RD0VjGTMr49Qav1l8IQ=;
 b=e99/mZPwfXtWR4jDFvM3mibDi6OXdEWygWHaYQxRSLt28mxU0k+aZ7QevxAA9paOuh
 dwvDRRKBGGZXWBavD9NW6BdRqdTwUBFUxv4Q3xFEASz1kHYbFUgP/hzOqq6VNbpn1yQQ
 e9gERgMCdIgXZPrF7MYgUMvvJ864R06oV8l0nuL+/P+Rnj/L6FVroReL+ESsAo0fs8+N
 N2QNZnrZem94sxroMyp9vg78EafnZJqx3ujd28atSEPW9fISzzVmYqx2kEgZDkCpwdUn
 Kcbgh3lRj5okTRn1XK1jaVv7LEeC5dvw81+p5S6qJH9waGVYAX8CwczvIisXvAEDoAkV
 Pffw==
X-Gm-Message-State: AOAM532SlqqTiLZrKZR7J5HqU5DssyUPpZUo4hO8dyg3M4/O7zhQUtQM
 pTDqwhPi8RD3mqizKkbyLgvNL7uYCqCnqva9oFNGZ1koj304UO/er0NfJjfr5qw0UvVr2v6Aj1u
 2pwkCljVZOz/e0co=
X-Received: by 2002:a7b:c258:: with SMTP id b24mr4830513wmj.122.1598032041574; 
 Fri, 21 Aug 2020 10:47:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6hyzEVjvYcjzgknJFfQaLADgrykfWwHJzDRY+758tk33z5jcPWKbuU32L49QtJTyyIdubLw==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr4830493wmj.122.1598032041290; 
 Fri, 21 Aug 2020 10:47:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d51:8db6:e10d:b5ef?
 ([2001:b07:6468:f312:d51:8db6:e10d:b5ef])
 by smtp.gmail.com with ESMTPSA id g14sm6898811wme.16.2020.08.21.10.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 10:47:20 -0700 (PDT)
Subject: Re: [PATCH v8 1/1] audio/jack: fix use after free segfault
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200821134554.101397-1-geoff@hostfission.com>
 <20200821134554.101397-2-geoff@hostfission.com> <3291053.UyeazdVyI9@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f297508-2b27-9303-002b-2eaa9983cabc@redhat.com>
Date: Fri, 21 Aug 2020 19:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3291053.UyeazdVyI9@silver>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 19:34, Christian Schoenebeck wrote:
>>
>>  static void qjack_fini_out(HWVoiceOut *hw)
>>  {
>>      QJackOut *jo = (QJackOut *)hw;
>>      qjack_client_fini(&jo->c);
>> +
>> +    qemu_bh_delete(jo->c.shutdown_bh);
> Paolo wrapped that qemu_bh_delete() call inside the lock as well. So I guess 
> it makes a difference for the BH API?

It is not a problem as long as qjack_client_fini is idempotent.

>> +    qemu_mutex_destroy(&jo->c.shutdown_lock);
>>  }
> 
> Hmmm, is this qemu_mutex_destroy() safe at this point?

Perhaps make the mutex global and not destroy it at all.

Paolo


