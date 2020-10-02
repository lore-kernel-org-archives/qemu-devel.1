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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6912206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCmEJXi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6912206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLki-0001GG-1C
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOLk7-0000pB-G7
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOLk4-0000O7-Vl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601647738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a+95HcwMGJni20WxrXIKy/jgCukmOeZlgWordW/2d4=;
 b=LCmEJXi8wGermF6+LLob8QasKKjr/r35IpAqZWAqO+bCTfEifeCH/i/dr8EcPvkHUdP/Xq
 hAByukFs8n6qnzl89B7MArCAYMiEQAx5zGcDOUjnhS9MKRjokrPmLEQ/us1YzLgLlRDTkE
 JVwfd59nwINxrjt31ntY98/pSr9AQAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-79yNUVUKNo-mrXgchTGUZQ-1; Fri, 02 Oct 2020 10:08:55 -0400
X-MC-Unique: 79yNUVUKNo-mrXgchTGUZQ-1
Received: by mail-wr1-f72.google.com with SMTP id v5so584297wrs.17
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7a+95HcwMGJni20WxrXIKy/jgCukmOeZlgWordW/2d4=;
 b=Et98BX77MkF0tHy7ffHraUgWnzl94igf+VywsIwD4csriCCxoptyxOpLqg56FGwodv
 O1ColNSQxd4+pt78FbqrsuCGEpvk8u59W5ZKFM0KIrwNAk6UWJzD4+YK4UnuIoXjr1MJ
 FPCzqHDmaOhOUYd4YI9eqM+/l6oAIBVJ4txXyI3gHk5PIt6BXqykueqZ9CQ+sZ8LXoOG
 RaEuuhSpzFB4noUNsZQ2GKXVfZ+QolzDgtjFkhyiUGGam2MgZKMUzBmCDEfWO/l5H8+L
 UMAgrdLPoU4IrhTv1iNhd6SJbD+lUfWn4yetiUY5bYNRi6VoGUkBmH/+peeA/GNuxwz+
 LEfQ==
X-Gm-Message-State: AOAM5308Wcpaa4R84kU2b31o1tqSJs/kn3G2YYXFMjvsnZpVYD4Re3ZG
 P/SUpv3R2UJDXhLQ6y/Eb6Buus2lj9BUmkzx/OBdcmFFX8odLfN9rtqPt7O1IObxmBmvi45NQqC
 8X9pjuwuVkhpssPY=
X-Received: by 2002:adf:f585:: with SMTP id f5mr3469026wro.64.1601647734284;
 Fri, 02 Oct 2020 07:08:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybVBHlPJNvpF+Jk4jYKpLHHS48MsQlBJBvNjEZYsGR1AGXUrFNR9LElPSp9cdnaA1UNjqRMQ==
X-Received: by 2002:adf:f585:: with SMTP id f5mr3468992wro.64.1601647733921;
 Fri, 02 Oct 2020 07:08:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id m3sm1855791wrs.83.2020.10.02.07.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:08:52 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <405d680b-d088-58ff-9364-fcfcea1345dc@redhat.com>
Date: Fri, 2 Oct 2020 16:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
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

On 02/10/20 15:09, Peter Maydell wrote:
> This duplicates the information that the thing that depends
> on libudev is mpath. Can we put this in a wrapper around
> dependency() so that we could just say something like
>   libudev = compile_checked_dependency('libudev',
>                        required: get_option('mpath').enabled(),
>                        static: enable_static)
> 
> for those dependencies that want to do the "does this compile"
> check ?

No, there's no functions at all.  You can of course put the detection and
test in a single loop:

  dependencies = {}
  ...
  if targetos == 'linux' and (have_system or have_tools)
    dependencies += {'libudev': 'mpath'}
  endif
  ...
  skeleton = 'int main(void) { return 0; }'
  foreach var, option: dependencies
    dep = dependency(var,
                     required: get_option(option).enabled(),
                     static: enable_static)
    if dep.found() and enable_static and not cc.links(skeleton, dependencies: get_variable(var))
      if get_option(option).enabled()
          error('Cannot link with @0@'.format(var))
        else
          warning('Cannot link with @0@, disabling'.format(skeleton))
          set_variable(var, not_found)
        endif
      endif
    endif
  endforeach

Doing this check for all libraries is certainly a good idea.

Paolo


