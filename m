Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F5C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA51F2087D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0mC4qyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCer-0002uN-SD
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQCXK-0001XQ-Rz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQCXH-0000yS-Om
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602089006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qv1qn82YLRFHmBycsrSc4fqvKuCS0ltG4NeYle3TGY=;
 b=T0mC4qyvEg0wa7L9AdySWHwmcSjGl7knOeU9ZgTbuedN5Ix/VUgyzd7c8hufbTTrB6U+4s
 bZGe+mM9KrXfjFjDTgMyC6VtB+hnr9yW70zEks+h3At7W97bDUxcQ66nBy+ca4PidCmUaA
 2CMX8sFhrp0vnSkEQHthl6Rd3F7d4K0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-qsaDZGHjOsaKEX9vLUN6Ig-1; Wed, 07 Oct 2020 12:43:24 -0400
X-MC-Unique: qsaDZGHjOsaKEX9vLUN6Ig-1
Received: by mail-wm1-f72.google.com with SMTP id z7so1081957wmi.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Qv1qn82YLRFHmBycsrSc4fqvKuCS0ltG4NeYle3TGY=;
 b=oChNsDbWQiFatk73cosIr0RSkPPqZNgWv0fUKEnVL9wfD8V83SLaqM21PHFRfN/qXi
 jWWTNMAxICMHAut1qQeHjJxZ6RqfGzj2Qnx8nxr87OlTum6g4ZYxj8h0bm2ZUhDH8rFO
 XEWOglwcfApsVxh8PGciyYUeFoyWDHc83Em8Wt/lJ0seMnF0jbWP7aIsXwKcqhnTtBFd
 DXeo146wKQgTZoOxLkEcKQgLATGmIqor7t1zm0QC5qWkufnY9/ShSeAmQoGNXtgLYONL
 fdEnYjRKJdritBgDt1xN7aA/qZSWe3HSDLiualqdYUcc+T7XF/UXPIdKzwhBbkkfThHy
 OpgQ==
X-Gm-Message-State: AOAM533uiboB94Qv+igGq27aWT+YZKpTM7AfJcACzLzipxkAlZVN4/e5
 n6dYBaoZOGRQlDd+Tf1IoSCzSuc7vYRx6NuhwEbWNMCWH6iq3dbrZWa+rKNcg74nYRMDWSh4dbi
 yiZ0ExAI1TOQ6/CE=
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr4871266wrb.29.1602089002729; 
 Wed, 07 Oct 2020 09:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8OLbOaEGGUoFP9QIBFl+kfBue1OI+r0n5042LURkN3BSQ8zaWIGZXa1STk+Wt0VJ3f6pxxg==
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr4871248wrb.29.1602089002498; 
 Wed, 07 Oct 2020 09:43:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id x15sm4032599wrr.36.2020.10.07.09.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 09:43:21 -0700 (PDT)
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <20201007162138.425-1-luoyonggang@gmail.com>
 <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
Date: Wed, 7 Oct 2020 18:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 18:23, 罗勇刚(Yonggang Luo) wrote:
>> +    if not pkgversion and os.path.exists('.git'):
>> +        # The quote of v* should preserve, otherwise git command
> would fail
>> +        pc = subprocess.run(['git', 'describe', '--match', "'v*'",
> '--dirty', '--always'],
>> +                            stdout=subprocess.PIPE,
> stderr=subprocess.DEVNULL, encoding='utf8')

It's a total mess.

On Linux, if you use 'v*' git is invoked with an argument that looks
like 'v*', that is as if you used \'v\*\' on bash.

On Windows, wildcard expansion is done by the program so you need to
pass a quoted value to stop the wildcard expansion.

I have no idea how to fix it.  Probably it can be made to work using a
string argument and "shell=True", but at this point it makes more sense
to keep the shell script version.

Paolo


