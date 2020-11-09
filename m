Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66673C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF88206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2ByNCXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF88206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4mC-0008WM-76
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc4kV-0007tM-5V
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc4kT-0000Np-GE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604919008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JkKnqwVg26tdRfbOTNiNdCvhxKi+BcdeTFW1kdQQK0=;
 b=P2ByNCXEcSnDUzM1/pMnhSWJkJ0oKOOs4VMdzoB+QtcKlhNEzwYUKb7iq1NK+jv0JYArgU
 xmLExhcuqn9ePo+FzMY7cEhbxNDeTP0ykUpWuWMzMNP7cDbhIKhecQbFgFYKh+mz3Gm8Zj
 3eXwPBcO55peFsiqyxq8+vWluWRFoyw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-jHY5_PMRN6iAnMQCwb0H1g-1; Mon, 09 Nov 2020 05:50:05 -0500
X-MC-Unique: jHY5_PMRN6iAnMQCwb0H1g-1
Received: by mail-ej1-f71.google.com with SMTP id p18so3315323ejl.14
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 02:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1JkKnqwVg26tdRfbOTNiNdCvhxKi+BcdeTFW1kdQQK0=;
 b=G2bV+m5m5LhUNnln1vw+XjNxWp4CHhXccOLysmJ2XaxplTOsnzQsmYB808ICQzPyEf
 I+j0GjIHUL1tFEVYlDF4gHiRhvPQ7nVquIR35hW3bg0mUMaHW15LiQxaS0mUy75h03s/
 Hxcf5QA4AIPPpix/fPbhYVIbaUxOGeR+tyIsmmh9xbwi/gvCh8GPnn3PTvFEdncROa6I
 o0+B4D7qPs8QIWsdtsg/KAmSlUyoGHIIh9EhUpjVkpsg/SA+tcLLLn0Nc5I3e5EuuflB
 7J47+nCGZvQU/bQ9s0099Hz83nBePNDS8Zzd6VrwX8htOf4hBUay0SNSE1HQI+Cbd2Uv
 L7fA==
X-Gm-Message-State: AOAM530xXdCnP0q6BJj2t7rNFka2ZcLGpaXTH6Jh45y8ygsJXXJ0U8R0
 /dkTBWE9oA9fdHyb9axG2KzKDbFjbiLfPb84MdWZqZwgZyXOHgMv3TKYv1SKp7rB5CFWv4TzOPE
 jcWCEKiPjCcUskbo=
X-Received: by 2002:aa7:d8c4:: with SMTP id k4mr12872979eds.248.1604919004325; 
 Mon, 09 Nov 2020 02:50:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj4ZnBg84h5mUpIlStBaF/pAYCu+53RGnsC/exeSfkxuckPXhhLjS5t1Q+tLs1FfD9SaCeFA==
X-Received: by 2002:aa7:d8c4:: with SMTP id k4mr12872973eds.248.1604919004160; 
 Mon, 09 Nov 2020 02:50:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e1sm8477571edy.8.2020.11.09.02.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 02:50:03 -0800 (PST)
Subject: Re: [PATCH 0/3] accel: Remove system-mode stubs from user-mode builds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109094547.2456385-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5d2bedf-20f7-c5ae-4c64-5ac8e4706949@redhat.com>
Date: Mon, 9 Nov 2020 11:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109094547.2456385-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Laurent Vivier <laurent@vivier.eu>, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 10:45, Philippe Mathieu-Daudé wrote:
> It is pointless to build/link these stubs into user-mode binaries.
> 
> Philippe Mathieu-Daudé (3):
>    accel: Only include TCG stubs in user-mode only builds
>    accel/stubs: Restrict system-mode emulation stubs
>    accel/stubs: Simplify kvm-stub.c
> 
>   accel/stubs/kvm-stub.c  |  5 -----
>   accel/meson.build       | 10 ++++++----
>   accel/stubs/meson.build | 12 ++++++++----
>   3 files changed, 14 insertions(+), 13 deletions(-)
> 

The series makes sense.  It probably also shows that it makes sense to 
have a "specific_softmmu_ss" sourceset in meson.build.  Let's review 
Alex Bennée's patches and then get back to this one.

Paolo


