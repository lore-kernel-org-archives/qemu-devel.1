Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29791C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80852177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc8p+hFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80852177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3z3N-000469-BF
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3z2i-0003gb-Lm
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:52:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3z2g-0005GW-ML
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596793921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQn8fyY8ixqUuyTYkRumPmTI/uAx8Fb+rLZ2AAwuGvo=;
 b=Gc8p+hFHG3j0uh/ILyiq+pouZDs/1pqPphzAQ/vQPVQXDgxw8/U1JYZoNX6UzYzuwF0ZDo
 zGZ+k163qwNe/Bv6BnWOihnwsCk0g69J7eT3rkbzYaO1Ei0Qw2D3GQ1X75bslbnpQXqCps
 gJpN/lcwU7GJ+jFNL+Yiqnlo/qqBSbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-hUSl-OpGO1WrU_LwpK-OIw-1; Fri, 07 Aug 2020 05:52:00 -0400
X-MC-Unique: hUSl-OpGO1WrU_LwpK-OIw-1
Received: by mail-wr1-f72.google.com with SMTP id b13so535707wrq.19
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZQn8fyY8ixqUuyTYkRumPmTI/uAx8Fb+rLZ2AAwuGvo=;
 b=LSD3k6Hmge1FCeXl/dysL1dZJOJ4IwekmfJ0P0EfIxHTWa+KITL7ZqlFaid8I704Sc
 kjOkhGHAZjjO1zDOhPXxkTcHes7JC3lo0hjkcUxF0tR3/j1HlUMisb2OyzrZhXRG6d4f
 SxJmDUvCBs3Uz7N9RNZL+0Q7SKnJxukxapkq0xX1RDDAyKGO7aca9WbKKOKezGGPigJ4
 oHz43m3uygm+t/ucR9JwcElAYrPa9NZ2q2CTrcx7+rIvLwNtjoWlFBap6MtUWkWJgaUQ
 bETRP5oepmZNeagvd5z8dKTSJywplXuhtCLWPNkLfXUziBLWrO3KYAjl+DzpmlqzGM7s
 Hv8g==
X-Gm-Message-State: AOAM533G/LxAGz1JoVfPt7c9ZriCf+dS+ZGtlbpV7533XVnoeW7t388s
 uAXz6oqpOHtJm6a9BLUPrZ9GNwjuee3zr1Le9PnGR3GSw8seivzJFA00UAxlt6wcTT2qLTTdnIg
 3uepJW1H7vdu+jCE=
X-Received: by 2002:a5d:4701:: with SMTP id y1mr11774289wrq.416.1596793919210; 
 Fri, 07 Aug 2020 02:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3EDz3Ehe74u/Fe4aAEv2dzyCfIgdtwzgbtR8YT7osnhNkvpFD7glEvsZL/m903QXnICppuw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr11774262wrq.416.1596793918967; 
 Fri, 07 Aug 2020 02:51:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id l18sm9890556wrm.52.2020.08.07.02.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:51:58 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
Date: Fri, 7 Aug 2020 11:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:45, Thomas Huth wrote:
> On 07/08/2020 11.31, Paolo Bonzini wrote:
>> On 07/08/20 10:51, Thomas Huth wrote:
>>> 2) With --meson=git added, I also do not get much further:
>>>  "./ui/meson.build:77:0: ERROR: Program 'keycodemapdb/tools/keymap-gen'
>>> not found"
>>>
>>>  https://gitlab.com/huth/qemu/-/jobs/675546229
>>>
>>> Any idea what's going wrong here?
>>
>> This is also a submodule not being initialized,
>> ui/keycodemapdb/tools/keymap-gen comes from a submodule.
> 
> Ok. I've added a hack to my configure script to checkout the submodules,
> but still, it does not compile yet:
> 
>  ../tools/virtiofsd/meson.build:1:0: ERROR: Unknown variable
> "libvhost_user".
>  https://gitlab.com/huth/qemu/-/jobs/675665455

Fixed, thanks:

diff --git a/meson.build b/meson.build
index 38f1f40..cc96d07 100644
--- a/meson.build
+++ b/meson.build
@@ -1091,9 +1091,10 @@ if have_tools
     subdir('contrib/ivshmem-client')
     subdir('contrib/ivshmem-server')
   endif
+
+  subdir('tools')
 endif

-subdir('tools')
 subdir('scripts')
 subdir('pc-bios')
 subdir('tests')

(This is an example of Meson doing a much stronger check on the validity
of the build).

Paolo


