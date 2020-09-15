Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1FC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FE8208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgLo36eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FE8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEny-00061t-Tn
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEXH-0000U7-Jo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEXF-0002oo-0Y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600190067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HxArhFaDNTzDTzCKl3nWuUJ7NPEwdFS0QNzczofDcY=;
 b=WgLo36egGFz168AfFJF0BqR3cA+XisB9CDwb6ZjJ8hHU/OAgqFS6yALylfF6y30XSsebE1
 w4TIftNcb2wa5Hvmbqqq5G96WZSwHYlAefZtiTlH2NUoF3Fd0QwIH0IGfNiDRHOh/M6eoA
 wyStOmo90bjSOGG3gCtkWA8otCxGdeA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-sYuIdq92Pq2pre2oacHBUg-1; Tue, 15 Sep 2020 13:14:25 -0400
X-MC-Unique: sYuIdq92Pq2pre2oacHBUg-1
Received: by mail-wm1-f71.google.com with SMTP id b14so87788wmj.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8HxArhFaDNTzDTzCKl3nWuUJ7NPEwdFS0QNzczofDcY=;
 b=d4x3H/woMjEBrflk0tBF/yjcle0utoRWAMDkdWpBm3CYy5brgnZvJFyjRNpbZpR0Ee
 tiiIBtUYXqySv3XOsyoSh8nuGSdsyYtx5YmWxMPiJIEkM9E8bpQwoJgisXpIqw+Wlnwy
 mVIjM05oab9WuukyxJgo4bCJfoCgNJxFYdZDGeXI5k3vg5SXx4VdEyaQXKJAZNzLW7n6
 s/9eFTbaVVRvNKzaGwNShEFN11xZttbO9jYQCKwM07eYY6VqvW2/HHZNLDI4nTlwFi52
 nTBL4rJiyHQgKoXurs318NU7wsZhvhf7y2D3nzABvNFs3stYR8hvrZvV0wuis0D2YMhp
 5fvA==
X-Gm-Message-State: AOAM532a+N+YUfgimgZd9L8FLM/1gcF+lvF9yDCwiA1bonpJMrzfrsYa
 tX/QIByEF0MyB0Bhrx3ZoMOejJVHZj8W3cONQYL99y+leyRliDiX5BQY1ee7HyfQjqeBwCrAQn0
 vWKT9TwMljmeOfIQ=
X-Received: by 2002:adf:ef48:: with SMTP id c8mr22941625wrp.370.1600190064582; 
 Tue, 15 Sep 2020 10:14:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAECFKGCDL3SyHx8RcGfHJ5qTVkiEUDYoP2sDnc6yUGYTYO+udVibq61Hs0XLAiDWWpp0A5A==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr22941605wrp.370.1600190064343; 
 Tue, 15 Sep 2020 10:14:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:eac8:587f:8ca7:e1e8?
 ([2001:b07:6468:f312:eac8:587f:8ca7:e1e8])
 by smtp.gmail.com with ESMTPSA id c14sm20237163wrm.64.2020.09.15.10.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:14:23 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: luoyonggang@gmail.com
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
 <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
 <2444b9f2-3668-8ca8-2e9e-3215d55b1472@redhat.com>
 <CAE2XoE_9K7UwdOYTxPggGhA4x17qRAMGC7x0y5Lgc_2ta=m2sw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29b0e531-b6e0-ebec-4415-37af1b849b1f@redhat.com>
Date: Tue, 15 Sep 2020 19:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_9K7UwdOYTxPggGhA4x17qRAMGC7x0y5Lgc_2ta=m2sw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/20 19:07, 罗勇刚(Yonggang Luo) wrote:
> 
>     Linux distributions generally do not want to have bundled libraries, so
> 
> Yes, bundled libraries is a bad idea, but static linked library is
> another case, that won't affect
> the Linux distributions. 

As far as Linux distributions are concerned, static linking is a case of
bundling.  Bundling means that, for example, any security issue will
require rebuilding the package that does the bundling (this applies
especially to slirp among the three that QEMU we bundles).

Paolo


