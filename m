Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15D1206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv7VYEgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15D1206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKlc-0003bW-1C
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOKkc-0002eq-AR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOKkZ-0001bY-Qr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601643926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZXTDjUB6Acu7ej99W7tIA8wOLoJYMs3ucvo85C3WXQ=;
 b=Iv7VYEgmu7OIvRfweQs7hdPThLC/WqtB5UklPxOS27CVss8MZtCbsNSJeidunBCgkyD9tr
 BMXo8CAquBIS17irGa4RF4fGRHOAYL1XbjixCwbtBhfgDtcgMXD81OGzinhrEvb50C4iQ3
 cdBVPbwH2Be86Bj9SY/WmUewMtKGKzI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-0DMCTRjeNemjHyzSoyLueA-1; Fri, 02 Oct 2020 09:05:24 -0400
X-MC-Unique: 0DMCTRjeNemjHyzSoyLueA-1
Received: by mail-wr1-f70.google.com with SMTP id a10so512200wrw.22
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xZXTDjUB6Acu7ej99W7tIA8wOLoJYMs3ucvo85C3WXQ=;
 b=Jg9u92U05P7rE5aGvNPJPxSyKbqbWGkTqB8/Z+0gcCnJMMPKxFi3P0i3C+HkFp6JTN
 1Fy4W2StUS3worNtpBaG4pdHcp/GDFCCGtAe0g9TXsngdOIEUtN+R6HHJTq7wAI2k9YV
 DI7DTCEZXpfH4XMI3ESXFjc25FiUoYleeEO2zgKmSG1PLGCmLNEqlF5cYKa3O0dWK8qs
 PhtOXpHvL501KwusZHKncrQGFYVZ2I3kk9cg3khtf4J2RMDhUsG7xyjqibMWyKCHhc2w
 PVVsanK3sOKI5JrQaLOz4/EQMKMmstJOaOtH0A6Ad13Qt53UzGCthZDJCGsrZr855rMr
 xmww==
X-Gm-Message-State: AOAM531PAYn59xU9f4AgJdmX5WwSGckt+kmiN6c+Kb//bENvTIst4ANW
 wbXhwFtp9VTvscbo0rUmj4H1l9d7/fJ8JFLzuX/B+Zzuzx25TuxulhkNvZuFbK4PusibJ91ySQ6
 iXMNrAXU0jAuzWCA=
X-Received: by 2002:a1c:b386:: with SMTP id c128mr2802625wmf.82.1601643923278; 
 Fri, 02 Oct 2020 06:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Iy8u4o26UIAfBcQW4FxdM4cs+0THWCesBe/OQNMj9B9AOBSoyqxHo19+N1pHSc2OmgRB8w==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr2802608wmf.82.1601643923064; 
 Fri, 02 Oct 2020 06:05:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id 70sm1905079wme.15.2020.10.02.06.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 06:05:22 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
Date: Fri, 2 Oct 2020 15:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 14:35, Peter Maydell wrote:
> 
> It would be better to do the "see if a static library is present"
> test. This isn't too hard to do in configure (compare that
> six line fix to the detection of libgio). Hopefully it is
> not too hard to do in meson ?

Yes, something like:

if enable_static
  skeleton = 'int main(void) { return 0; }'
  if not cc.links(skeleton, dependencies: libudev)
    if get_option('mpath').enabled()
        error('Cannot link with libudev')
      else
        warning('Cannot link with libudev, disabling')
        libudev = not_found
      endif
    endif
  endif
endif

It can be done in meson.build also for dependencies that are still
detected in configure, and we can place it in a loop if we want to do
many tests like these:

if enable_static
  dependencies = {'libudev': 'mpath', ...}
  skeleton = 'int main(void) { return 0; }'
  foreach var, option: dependencies
    if not cc.links(skeleton, dependencies: get_variable(var))
      if get_option(option).enabled()
          error('Cannot link with @0@'.format(var))
        else
          warning('Cannot link with @0@, disabling'.format(skeleton))
          set_variable(var, not_found)
        endif
      endif
    endif
  endforeach
endif

This way we don't have 500 lines of this kind of test.

Paolo


