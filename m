Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B120207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inhOxtYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B120207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLgp-0007Gi-Oe
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbLgE-0006mL-HE
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:10:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbLgD-000659-C8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589969428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxJgemOdXxhLVV92AKtu3lyJ/mMqJO9EouLkZcUeiRk=;
 b=inhOxtYzTFmsbJf20RsTY7clnFe02uIVMN7SFKGUXyKsME0hApWU83lPZsWQm9UiZMXeOK
 H10Sfj54LUjD4m9o2j7nmG/p/jmmBWOsCR1LBmPGdf8eCNjjbhLgw9xs6+FvubbHfUZUZ8
 GF0T+CIUb0LZz1SWgS8SanxEXYx3Qhg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-4l_CmehVNMWYv7AuweOsZg-1; Wed, 20 May 2020 06:10:26 -0400
X-MC-Unique: 4l_CmehVNMWYv7AuweOsZg-1
Received: by mail-wr1-f70.google.com with SMTP id 90so1184122wrg.23
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sxJgemOdXxhLVV92AKtu3lyJ/mMqJO9EouLkZcUeiRk=;
 b=TJl0Anh+fSdFggBUhFjnrjJ0UW3LMZET8d0RM5itkf6TwpzX4MffGnkPPPliTNySJK
 P1tYkXJ7y/bsy0tyRmu0w97Jnc3a6kqq+PCr0VGLkrvEYO+1yXcB7cR+pcYMx9XqMbs8
 QbV8c99NWPf5LFQdvk+tbR9eToiLqQy9WiqxnsSqfyf9OvgWvDEu0K5ADKQgmU+G2ZBw
 k3tzvKabTxTmL6pCIU1pP0RUnTQpBKbRDQweuoeYPDfNyxysX7LphlAT0XXC66t6NAwk
 5X5vMmNbbv4SidIfwDz9sbkgQ7Y/VogPbi++GM2mjHO7CtLuUJmrIokS4vPM5Wgqw6GK
 aTYA==
X-Gm-Message-State: AOAM531M2mAVTOIa2N5xSdSa/GNB9K0xvr4GRFwGo7t5M+hg8rxg6P2y
 SPT8+SS4+bogG//vamHfr7J+XIATV4gpweiosxWvgNsm+lNopV9rmA00F5JZnlvP/wcZV50tUke
 L9zR9QdLFmh/dYVw=
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr3760301wmt.129.1589969425588; 
 Wed, 20 May 2020 03:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZTFAHc8Dv7C+nA/VM8m3gaTTl5fsxbF/KSKrYxbPwhY5ofmH3RSiyLIFrXzkSmr7g5aBi6g==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr3760288wmt.129.1589969425337; 
 Wed, 20 May 2020 03:10:25 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id v126sm2916293wma.9.2020.05.20.03.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:10:24 -0700 (PDT)
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
 <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
 <CAHckoCyZmYXU8bz-3UAVXGi1MpdNdb20no1-kB09MoWOGPz_VA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ce60286-85a5-f338-c079-20e868da59dd@redhat.com>
Date: Wed, 20 May 2020 12:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCyZmYXU8bz-3UAVXGi1MpdNdb20no1-kB09MoWOGPz_VA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20/05/20 11:36, Li Feng wrote:
>> Can you do "rdmsr 0x48f" (as root)?  On my machine for example I get
>> 1ffffff00036dfb.
>>
> $ rdmsr 0x48f
> 3fffff00036dfb
> 

Hmm, weird.  What is exactly your QEMU command line?

Paolo


