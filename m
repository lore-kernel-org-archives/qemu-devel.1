Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B96C205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivodc3Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B96C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL2ks-0003ta-2V
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL2jt-00038F-Jk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL2jq-0003PM-SY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600859704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJhmqTlpYQ/LzmfaHIuam8D9fkxCstDt9d4EsQUsj48=;
 b=ivodc3VnF2wdNj7kZmbBJiBbsNMA2S6szZhJTNTIu4wm8cQHPbB4Tlo2dNZyv+nbtlMgN9
 UG0sG5LdG390WoMtj4OXEH2B7TKPpuuysBxRPH6jT0Cb2yvjkvY26WzFbQ2I/20faLbEjo
 I6ZKuT2GNzPdkK7IPK5uiF1wtyREwfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Rvfm_YsGPVGa-DPBa_ljxw-1; Wed, 23 Sep 2020 07:15:00 -0400
X-MC-Unique: Rvfm_YsGPVGa-DPBa_ljxw-1
Received: by mail-wm1-f69.google.com with SMTP id m125so2088900wmm.7
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 04:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vJhmqTlpYQ/LzmfaHIuam8D9fkxCstDt9d4EsQUsj48=;
 b=MPz6Aup9pWjq84tKkwLEA4CU8CQbn5C6eciQmZx6c+gDpVxbc70XwvhWWulom/UmfO
 EWeO7eo35ndnvJQKFP/NEmY0aqV2I3b4AiWM9AXMJrSbCTdYvpak7seKlGySu9eCWC03
 t6NLEGQI5fbN/Yylj6Y5rBjOmwI2HIYyz6DjIi3snkddp9KEAZIhTSM68YeK6XKe+tME
 OZ6P6NXuAJwhCb4APEIuS6C5cXC/Juwt10jHLAfLUM0DPeZnqGl/ccsJ8QJB363/9ut2
 D8a5cqpEy1NM9b1nEFz86wwNCJRAzK+oMwKSDXeXX2x/2wKCgHVwcl6vNDloDpJfC44F
 dKKA==
X-Gm-Message-State: AOAM530sNXBe7Nj7pOoY3yl6RRMQKlK8YMTIh8x6oZCjdJpQbQqxQIOU
 0fhQzoriA14tyUthar7B15TolrsZ9avQli9XxKPxrmUcBQCLjbTLtzlf/3R2w26w9/8/KkQy8Uy
 rRRGh/yAEuo6pu8U=
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr230707wrw.87.1600859699422;
 Wed, 23 Sep 2020 04:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZlUKHnQI3ML4qEIFJgZ6FiarqkJt9DwqeACE01WS+o37SW6vh7TVsBeNx+uvIYvo+86ImVQ==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr230683wrw.87.1600859699200;
 Wed, 23 Sep 2020 04:14:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id u126sm9734481wmu.9.2020.09.23.04.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 04:14:58 -0700 (PDT)
Subject: Re: [PATCH] Add execute bit back to scripts/tracetool.py
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20200923103620.1980151-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cbf1d90-849a-5046-d6f0-756000decaef@redhat.com>
Date: Wed, 23 Sep 2020 13:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923103620.1980151-1-anthony.perard@citrix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/20 12:36, Anthony PERARD wrote:
> Commit a81df1b68b65 ("libqemuutil, qapi, trace: convert to meson")
> removed it without explanation and it is useful to be able to run a
> script without having to figure out which interpreter to use.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  scripts/tracetool.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 scripts/tracetool.py
> 
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> old mode 100644
> new mode 100755
> 

The explanation is in docs/devel/build-system.rst

Support scripts
---------------

Meson has a special convention for invoking Python scripts: if their
first line is `#! /usr/bin/env python3` and the file is *not* executable,
find_program() arranges to invoke the script under the same Python
interpreter that was used to invoke Meson.  This is the most common
and preferred way to invoke support scripts from Meson build files,
because it automatically uses the value of configure's --python= option.

In case the script is not written in Python, use a `#! /usr/bin/env ...`
line and make the script executable.

Scripts written in Python, where it is desirable to make the script
executable (for example for test scripts that developers may want to
invoke from the command line, such as tests/qapi-schema/test-qapi.py),
should be invoked through the `python` variable in meson.build. For
example::

  test('QAPI schema regression tests', python,
       args: files('test-qapi.py'),
       env: test_env, suite: ['qapi-schema', 'qapi-frontend'])

This is needed to obey the --python= option passed to the configure
script, which may point to something other than the first python3
binary on the path.


