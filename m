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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69BC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B39206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiUOVyfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B39206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMyh-0004tH-1G
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOMmC-0008NS-KA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOMm2-0000i0-Jr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601651702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za7TTZQVCsQcbz/kEEwAeYjZE6N33tpYWV8tCzVC+2g=;
 b=aiUOVyfNvsQcZy1AQ/iXDh5xeGgyC/Kv+o+nlpl2wpTCnqdsnEtGxPl/g+m8t9+5CvcznT
 /AWj/w+8MpZYuiDb1xAFYFxIE7m5dE5QlspUXD+vLI+NCoCGTCtK9Lklb+jNBjNY/joHAe
 48P6k2RaQ4TXQm2A+VTCyYJtp+8pmYY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-BdV8vYfJMo-aAtWkLXfWBw-1; Fri, 02 Oct 2020 11:14:44 -0400
X-MC-Unique: BdV8vYfJMo-aAtWkLXfWBw-1
Received: by mail-wr1-f69.google.com with SMTP id d13so651354wrr.23
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=za7TTZQVCsQcbz/kEEwAeYjZE6N33tpYWV8tCzVC+2g=;
 b=eGYzj8jJst8UwXAaVufOnMFM7kB6Nzmeggz0VEac2+eGrBBK/QJitAiIAcPKYCfEsj
 V0DJWIH+x2bW76yqOJmpSPjJi8Ij/AZzAuz9pfBvqFTAdcFAgkwYDiQ3XEdCLzge9V17
 pzs7sfNvilP4bCVy9o7/8UmsYgk9lHmoPK4JU8Sbr9UxC5F1EFrKlPGbw0vmXuDy8VVK
 zVWItb/d7k1kKQLZzZEBvub+fUZhsOTAeipXFJyE9fjjbmWMYwFYs47ooikfe2DkYcI4
 0JKtBD0lfhg4o6HKU4v0ONdOCIow8Mn0H4zms3SM/YQbi3psXYH41AKzCD2DOR4OfXcM
 6DVQ==
X-Gm-Message-State: AOAM530kPf5dwzdcz8CtOA9XVtJ+eGutyJv0FJ7MF3lV5Kt0AoPoDuen
 PXiG42vZN6U4u0MJcnSWI8a5vCK5JskdkyQ87cnJiVNYlE/Q9ChimngRo4QSryWAdu9iYeMtSpT
 blGabfBoSzvQOGUg=
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr3447797wmj.101.1601651682891; 
 Fri, 02 Oct 2020 08:14:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUbBPAXcpXvAh5VHT1dTkH25G38HuCJpj3Y/ZvJDfVeB4lnLeBxyMfrMeOXpK0hronlkF18Q==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr3447769wmj.101.1601651682616; 
 Fri, 02 Oct 2020 08:14:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id 76sm2365849wma.42.2020.10.02.08.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:14:41 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <405d680b-d088-58ff-9364-fcfcea1345dc@redhat.com>
 <CAFEAcA9vr+HKe3HnNECo8=pP7KcdjZXr1cJqg8HTbYKbaNDY3A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1ef11fc-7652-056e-bfcc-db0f8fcfc13f@redhat.com>
Date: Fri, 2 Oct 2020 17:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vr+HKe3HnNECo8=pP7KcdjZXr1cJqg8HTbYKbaNDY3A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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

On 02/10/20 16:18, Peter Maydell wrote:
>> No, there's no functions at all.  You can of course put the detection and
>> test in a single loop:
>>
>>   dependencies = {}
>>   ...
>>   if targetos == 'linux' and (have_system or have_tools)
>>     dependencies += {'libudev': 'mpath'}
>>   endif
>>   ...
>>   skeleton = 'int main(void) { return 0; }'
>>   foreach var, option: dependencies
>>     dep = dependency(var,
>>                      required: get_option(option).enabled(),
>>                      static: enable_static)
>>     if dep.found() and enable_static and not cc.links(skeleton, dependencies: get_variable(var))
>>       if get_option(option).enabled()
>>           error('Cannot link with @0@'.format(var))
>>         else
>>           warning('Cannot link with @0@, disabling'.format(skeleton))
>>           set_variable(var, not_found)
>>         endif
>>       endif
>>     endif
>>   endforeach
> That is a lot uglier.

The code above is ugly but it is also botched; it should be more like:

  dependencies = {}
  ...
  if targetos == 'linux' and (have_system or have_tools)
    dependencies += {'libudev': get_option('mpath')}
  else
    libudev = not_found
  endif
  ...

  skeleton = 'int main(void) { return 0; }'
  foreach var, opt: dependencies
    dep = dependency(var,
                     required: opt.enabled(),
                     static: enable_static)
    if dep.found() and enable_static and not cc.links(skeleton, dependencies: dep)
      # Meson should have already warned about the lack of a static library
      if opt.enabled()
        error('Cannot link with @0@'.format(var))
      else
      dep = not_found
    endif
    set_variable(var, dep)
  endforeach

which both shorter and more readable.

Or is it loops vs. functions that you find ugly?

Paolo


