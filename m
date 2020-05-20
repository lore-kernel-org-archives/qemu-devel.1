Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0E9207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOX9P6+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E9207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbL7e-0000TO-MD
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbL77-0008UB-RD
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:34:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbL76-0007vc-AC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589967250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFQ8u5OCXg4mAGLYtfZ7gR1ICWZmw90nRVR2NTwF2FQ=;
 b=FOX9P6+ya8XlCgCMOOTrgT4z39tYOBCi/oTeaxlDZkpm+zlZLCXW2cOc4tLYXF/SodGts0
 UGOq11Ww0qCfPqjkaf2ylhKR5owD30K0qp8CMk5IbpDzOcGfsRQ0mSW/R4zECvUOws8jr5
 W9DHN+kNTgbgW9uuUazObDFzgTcHOuE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-DUtpdWCkOPGli79Hu3zW2Q-1; Wed, 20 May 2020 05:34:09 -0400
X-MC-Unique: DUtpdWCkOPGli79Hu3zW2Q-1
Received: by mail-wr1-f72.google.com with SMTP id z16so1148582wrq.21
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 02:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iFQ8u5OCXg4mAGLYtfZ7gR1ICWZmw90nRVR2NTwF2FQ=;
 b=R0NVamCKY6xhufegExS+hgcGJyn1DXxRFoyBtP0c/Y8yyivqnRI45pVvzLcTg3KYpz
 rGcYu03bAOjFz1/BDf1XpZCGYlpEmcX191w0WlVYOimgcmzKRBCC+4a7WrZReiaQcdj1
 Zh8v8Jgtm7ge8nuoJqHrNEp1MEi0kAy0GSnENv+WZ7G+LCZ9HOQnyeL2MC8fyRkaE3SZ
 t3QE5FjGl3PkpoJa8ANRt3GmC3QTtc2wszZ0EEyseMGLu5MBqYTRBLLaT/8ZsG+FT2K3
 ozbbxKqeuDSbEfCEqTfCZPw7qDhbQ7IQE4r3LztL6mGjhaYk0QeXSeBkOnAEIQBCB21z
 fILg==
X-Gm-Message-State: AOAM531XsoE4uNK8dm3584cMtZ0BNe8I6ij+5O3tNahM18j5EkG2nx2a
 txZyIh64q7rbg4/5vmREoMgsYa6gRBf3e7QlhbvrRIMgB83TUb8qpe2ue9S7ybFF11r7yuueDzF
 kA6lTxPQdF05wOmw=
X-Received: by 2002:adf:e80e:: with SMTP id o14mr3368747wrm.307.1589967247603; 
 Wed, 20 May 2020 02:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXg1JK3WP5fKa/4b+FOa3sW6T9qXJ8ZSug3FuyMNvO1H14RhFOPsdSwZz41Wuf0eVPxPR+oA==
X-Received: by 2002:adf:e80e:: with SMTP id o14mr3368728wrm.307.1589967247339; 
 Wed, 20 May 2020 02:34:07 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id s11sm2183771wrp.79.2020.05.20.02.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 02:34:06 -0700 (PDT)
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Li Feng <fengli@smartx.com>
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
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
 <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
 <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
Date: Wed, 20 May 2020 11:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 10:55, Li Feng wrote:
>>> After computing xor, the result is 0b1000000000.
>>> The bit 9 is set.
>> Are you running KVM with a 32-bit kernel.
>>
> No, I'm running 64 bit.
> 
> $ uname -a
> Linux 31_216 5.6.7-1.el7.centos.x86_64 #1 SMP Mon Apr 27 15:26:08 CST
> 2020 x86_64 x86_64 x86_64 GNU/Linux

Can you do "rdmsr 0x48f" (as root)?  On my machine for example I get
1ffffff00036dfb.

Thanks,

Paolo


