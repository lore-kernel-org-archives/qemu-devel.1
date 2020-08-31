Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EB320693
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4ALFWm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EB320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCgiM-00013Q-2e
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCgha-0000Zc-Sh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:06:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCghX-0001G2-Gv
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598868369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XedzdkWIOX0hrpxsxdp73EPFai+sgjd3UbR24q9x5bM=;
 b=H4ALFWm5ruwBWIRWTsb6W6qHFazu3OwA1mBo+sgVWpQ3mmLiNY8Fm0c43XrZAGoBiqLy7F
 RyGV6GjXuWGbFvP1zR+YlWzDIPxqWU8zxiz7/2YWVyogYktEEpT9H/cF8HAjTOu67vR3OY
 gVL/duwJPHWVeaE2ZRQgdXxZwFdQ1UQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-jtpLb77gNDq3EqRJMF5Puw-1; Mon, 31 Aug 2020 06:06:06 -0400
X-MC-Unique: jtpLb77gNDq3EqRJMF5Puw-1
Received: by mail-wr1-f70.google.com with SMTP id m7so3015528wrb.20
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 03:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XedzdkWIOX0hrpxsxdp73EPFai+sgjd3UbR24q9x5bM=;
 b=sk0rFp7ezICEmRw1VweEih/LEXFcH2W3T40H12CeXQ6RzeKIb6fyGJCuQ00mLdbn7V
 WWJ57nNicH95umvltWMhkSH3ZKUPzhkhdSKhsoyvk6SG6hHGoATax7AEuVFyKI47IKDk
 9a5LxmPdqCPxcP/jZhoCf1Jga1D9GS0FyMceo/Ap15NgCEhrgFVc6qGkDbz8YeGvdvII
 z4P69CS0v36lpK0XznFfNIDipLPkMyE+7RoxbmrRe67vFzZgaHIj1Sv5nj9y/CjAeHyW
 oIL9PKPuOmJWOR9OeZ3XVHX7qyElpdOPxnF93IPMtdg4gzll/sO9EoMSCs833nPc99PG
 KE/Q==
X-Gm-Message-State: AOAM533sUWv/LsA6eHiLi5hqLxudayciYCmRD3Pu3Pwk+uhz0YreyPcx
 IPdjjkhX3fo30xmm6oxZV8Rk1vf7kwUIQw352k730NU75dQXPyzdskMBB3vhI0SI7cSbNGRi5nC
 i7WkGJWbLT/CvPrI=
X-Received: by 2002:adf:9125:: with SMTP id j34mr1013676wrj.157.1598868365295; 
 Mon, 31 Aug 2020 03:06:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaPbnajwsTshN+FdClOYfXY7H6udfcgS5+f5RCRDsGeL6yinVEOO0wAqzDUY4tTfYB61pBCw==
X-Received: by 2002:adf:9125:: with SMTP id j34mr1013661wrj.157.1598868365080; 
 Mon, 31 Aug 2020 03:06:05 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.203])
 by smtp.gmail.com with ESMTPSA id k22sm9162573wrd.29.2020.08.31.03.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 03:06:04 -0700 (PDT)
Subject: Re: Meson build on macOS: undefined symbol treatment
To: Emmanuel Blot <eblot.ml@gmail.com>
References: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
 <24ac4d35-ff2b-4381-ab1b-1a8f31ba36fb@redhat.com>
 <9b3f88da-ec74-96d0-41a4-8fd89b845a6f@redhat.com>
 <764F294F-6A6F-4E1E-B8C1-5FB6D9BC9F33@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf60926c-4a81-9a5d-a9eb-6f27bbc007aa@redhat.com>
Date: Mon, 31 Aug 2020 12:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <764F294F-6A6F-4E1E-B8C1-5FB6D9BC9F33@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.207, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/20 10:12, Emmanuel Blot wrote:
> 
>> This is done by "b_lundef=false".  I think it was added for modules, but
>> maybe it's not necessary.  Emmanuel, can you try removing it (line 3 of
>> meson.build) and seeing if --enable-modules still works for you?
> 
> Removing this option does restore the regular behavior on macOS (link
> stage fails whenever some symbols are missing), and QEMU still builds ok
> with --enable-modules option, but I have not actually tested this feature
> - I did not know it even existed. Do you want me to test some specific
> use cases?

That's good enough for now, thanks!

Paolo


