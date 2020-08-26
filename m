Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DC6207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtTzK8WB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DC6207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0mc-0006vr-A4
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0lt-0005of-St
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0ls-00048d-7S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598468863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sUMH0Xc8mgPBEvhkAmZXhGliqOnaQmpumzAyZJMZ78=;
 b=NtTzK8WBAqVxVc3XEju4ElAWtz9TiIkarS4ANFnVmPwIn9uoeEOPRPyYa9KYD+t8WkH6zW
 CCWQJH4fd1vly5ONZsj1Zb/kI6iJRD/LWanpLs1vS93U3vuP/3p8T6kbdNQH57DA6I8utC
 E/l9Y0dd3W4UebBuHoO7CkIgCvubsp8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-yZ5d9UFwNkyxgLXFxIGgzw-1; Wed, 26 Aug 2020 15:07:41 -0400
X-MC-Unique: yZ5d9UFwNkyxgLXFxIGgzw-1
Received: by mail-qv1-f72.google.com with SMTP id q4so2354974qvu.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 12:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4sUMH0Xc8mgPBEvhkAmZXhGliqOnaQmpumzAyZJMZ78=;
 b=URPmGbMbmBlUrkpau2yvbiB5hugcQMt8XO30Cv+k0yHNto/Ml3uOK+MUAenTscla9c
 MtYZbEwRRkLspzqFYyAr0j0yZMQOB0ggpG4bbGP2gLs7hrvkY6f/sQFh9bV9BOLQd+a4
 d86akkZWfTJW0E7sp2jeSFtxuEj7ST6tA/2P5t2GJoAqP7f50YpTH+xyuRT7co1qi4Ab
 zVse/W65k9X47kLUv1eMCExfx0k/ZXHds8vK7ikQ6dbdg+FykX6qiRTb0I8eeuLOHZdD
 G+co4jWYleObjKqFlSD/GxN6oYcsJxJDspzjSMGvD52LJzhIfwIVnbXFcIlE9q/yeOuU
 TkYw==
X-Gm-Message-State: AOAM5303xq0lykJAMt7UsYAoWwg+1dY83AaFJ3MAnGilbZCY1k9W020b
 ZG26owiDnidMMnXPy1W/XEaqKxLPjHnOY75XS0y04fDqaD/Xc4cZd6aoX08WW3mUcbc+8PqESMw
 0t041WcvaTzFV+8g=
X-Received: by 2002:a37:8047:: with SMTP id b68mr14399220qkd.299.1598468861203; 
 Wed, 26 Aug 2020 12:07:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5cHxFPUe5202vRGt9razTTlpB35IPi0HtjYlGzmZufevEkVNsScqAhuMUFxWmpAofpBMY9Q==
X-Received: by 2002:a37:8047:: with SMTP id b68mr14399193qkd.299.1598468860945; 
 Wed, 26 Aug 2020 12:07:40 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 d8sm2628402qtr.12.2020.08.26.12.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 12:07:40 -0700 (PDT)
Subject: Re: [PATCH 2/4] sev/i386: Allow AP booting under SEV-ES
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <cover.1598382343.git.thomas.lendacky@amd.com>
 <a3fc1bfb697a85865710fa99a3e1169e7d355a18.1598382343.git.thomas.lendacky@amd.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <93275d7f-1bfd-c115-be4b-3d20952bf376@redhat.com>
Date: Wed, 26 Aug 2020 14:07:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3fc1bfb697a85865710fa99a3e1169e7d355a18.1598382343.git.thomas.lendacky@amd.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:10:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:05 PM, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> When SEV-ES is enabled, it is not possible modify the guests register
> state after it has been initially created, encrypted and measured.
> 
> Normally, an INIT-SIPI-SIPI request is used to boot the AP. However, the
> hypervisor cannot emulate this because it cannot update the AP register
> state. For the very first boot by an AP, the reset vector CS segment
> value and the EIP value must be programmed before the register has been
> encrypted and measured.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   accel/kvm/kvm-all.c    | 60 ++++++++++++++++++++++++++++++++++++++++++
>   accel/stubs/kvm-stub.c |  5 ++++
>   hw/i386/pc_sysfw.c     | 10 ++++++-
>   include/sysemu/kvm.h   | 16 +++++++++++
>   include/sysemu/sev.h   |  2 ++
>   target/i386/kvm.c      |  2 ++
>   target/i386/sev.c      | 47 +++++++++++++++++++++++++++++++++
>   7 files changed, 141 insertions(+), 1 deletion(-)

Just a heads-up: ./scripts/checkpatch.pl does report a couple of style 
errors. I've seen other series go by where maintainers didn't mind the 
line length errors, but there are a couple that have to do with braces 
around if-statement contents that may need to be addressed.


