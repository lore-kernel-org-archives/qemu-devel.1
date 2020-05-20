Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE50C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F447205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFRDdQQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F447205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJAY-0005t3-Jf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 03:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbJ9t-0005Mk-H9
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:28:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbJ9r-0000jd-DU
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589959733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1dETefqmN9rGmc4gC19ENkZgGC6ZAxVQC3ZVSsOR+Y=;
 b=DFRDdQQWSpLF+dPQ0OZgnaWy1lO3/++efyl+T1fuu1j3fXoqTa8kAQDKWy9zhmvRbXdLmo
 iPr7lvFiN8jlkNXK5xIgJZc98XNbe66aJ/Ecad4ZvFVZLYT60iYwR0zk8SMFPNRI1QLXPG
 PEafefHqXcpK0edxmKtdjV2IztZ4sz0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-5xFD8HaYOsKlotdQKG_MKQ-1; Wed, 20 May 2020 03:28:51 -0400
X-MC-Unique: 5xFD8HaYOsKlotdQKG_MKQ-1
Received: by mail-wm1-f71.google.com with SMTP id f9so848046wml.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 00:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x1dETefqmN9rGmc4gC19ENkZgGC6ZAxVQC3ZVSsOR+Y=;
 b=EHPaz1KKt+ErnZsRnflk+8LS8gBaVOEmwTbPfeFtbPTGk53k8CXCzrsg2IrgFYD9Tb
 9pEwAb9Lq5oTinE9y2oKWB4DzArYgWNdAo69lHW0kOAVCxynvcpZpwTm6q7dULj6dWZv
 bvChER3/83SHrd06v+pd4aYsZ21oduIXbY7s+SqKLmbgM8ZlboV/zmahbRcWXW8afvqC
 +T9bvtaDL5ULVwXmwzYQJrSsfVDfr4QaZPkT2eGC8HVe5axOsIdXzEI4WeNHOuYoh7Lj
 coRcBGCK3JIuGpIVQSFtFuj/Knc+QBZs/xu16eXTVfoqPSxkhcX3uR+pPAtScXt0ivga
 JOvw==
X-Gm-Message-State: AOAM531DhKnqVeFcniwqPTFluc5DhuczS4/RpTDlCN4vaefl6LlCZnHL
 pQ/TH7QpNYEu7Fj1XpzvS2uxrzP0Tgqs3soy3q5nigt60nN5QE4COqm+Cw8X2kNBfonFh6okAaR
 WBWc6+JE62zKmwHM=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr3305433wmh.39.1589959730394; 
 Wed, 20 May 2020 00:28:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjiRt1CSNU9ryvQBXWXDb65IeTm7rX4yV1IfKvucMQH/OhX4SP+8mEMxwrxiUZcgZsWrIm7A==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr3305418wmh.39.1589959730170; 
 Wed, 20 May 2020 00:28:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:591e:368f:1f3f:27d2?
 ([2001:b07:6468:f312:591e:368f:1f3f:27d2])
 by smtp.gmail.com with ESMTPSA id d6sm2089495wra.63.2020.05.20.00.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 00:28:49 -0700 (PDT)
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Li Feng <fengli@smartx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
Date: Wed, 20 May 2020 09:28:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 05:50, Li Feng wrote:
>>>>>>>>> qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb

The high 32 bits are 0111 1111 1110 1111 1111 1111.

The low 32 bits are  0000 0011 0110 1101 1111 1011.

The features that are set are the xor, so 0111 1100 1000 0010 0000 0100:

- bit 2, vmx-exit-nosave-debugctl
- bit 9, host address space size, is handled automatically by QEMU
- bit 15, vmx-exit-ack-intr
- bit 17, vmx-exit-save-pat
- bit 18, vmx-exit-load-pat
- bit 19, vmx-exit-save-efer
- bit 20, vmx-exit-load-efer
- bit 21, vmx-exit-save-preemption-timer

Try removing all of these and see if QEMU starts:

qemu-kvm ... -cpu
host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-vmx-exit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-preemption-timer

And then add them back one at a time.

Paolo


