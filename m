Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A382DC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B45C206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuAqQkea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B45C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPCV-0006Rb-Ej
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOP91-0002R1-BF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOP8u-0004Oh-AK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601660811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JphseXmbF3DtuDEJXKV9gUbNcfK1JdNueUI5kBWrZ6U=;
 b=ZuAqQkeaWBPK1RF9kLdSL7vWA/2fGKrv0ojlXNxj6ZTw5bjpnYbkU1FvRwBxw14uE4Pqav
 zpf2xtD0GrYN6+uxrrMxtr2yp1ug0D1orauDQzMsrdyhi6l9lNPR3HS6WJ31A16i9leheQ
 udNAHFNAVLXHjkwN7jmB8A6AOFl8P6Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-SalTW6oVPtOacAWjoOiMMQ-1; Fri, 02 Oct 2020 13:46:49 -0400
X-MC-Unique: SalTW6oVPtOacAWjoOiMMQ-1
Received: by mail-wm1-f70.google.com with SMTP id g125so116153wme.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JphseXmbF3DtuDEJXKV9gUbNcfK1JdNueUI5kBWrZ6U=;
 b=Rt3fJ+C+HH6g4XGIiwFYu/N8hjBUEqh6l/woOdtnFZyLo7k7/8gdbOam9RDYk5g0lJ
 nuW/Jcbe7TZzVi15BRTHmRlejOX8M+MR1DUs0SwSaAwj4+X5d3CsW1F2QXGWxCKJPPYG
 bguMr1J2yqIpaDQFC1heGRr3mLcLIvCoU37a5cnB0dVbp3LRUaOi/mX68M3SdVmHp7wJ
 DgN/NCKwwcbLCEIb0y0psDk5MJAFsIbulqanRaBc8a8QrufkvWzs79kh23K9aAEejNk4
 dkXPLgbKalRya/inFzP/t37dtrUCxIsNc2BXdqWtoA3F3Bfwu/+ZTWpsnUqrVGLHZDEZ
 Cpmg==
X-Gm-Message-State: AOAM533s3UrLr3k4I/BRj/55XeN3DFvWF20cQk166MFynSZvRLOU/zm1
 BE0ZqBMVgsqxlQjCj1qYazc17vOSSZ2D83xKVE9yGUePcT2ICI1/ST6CIZrJz5gQvhX5pkf91dC
 +bnmFGq3s508dAtE=
X-Received: by 2002:adf:e304:: with SMTP id b4mr4157946wrj.141.1601660808164; 
 Fri, 02 Oct 2020 10:46:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIXv8Krjg/M3yd2GwEJCyCdMoQMHrSvUAWbEKaXesI5nekXgSLkmKWsaeHNUxhSep6fnzg6w==
X-Received: by 2002:adf:e304:: with SMTP id b4mr4157930wrj.141.1601660807978; 
 Fri, 02 Oct 2020 10:46:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id v9sm2908093wrv.35.2020.10.02.10.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 10:46:47 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
 <20201002153559.GJ2338114@redhat.com>
 <CAE2XoE_z3j+_+Oh1Kn-GSAT4q0_nXnT0sLHMLCw0+r1o0WBJSA@mail.gmail.com>
 <20201002164232.GO2338114@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6574b572-4bc9-3cbb-dbc6-3e4a1da695b6@redhat.com>
Date: Fri, 2 Oct 2020 19:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002164232.GO2338114@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 18:42, Daniel P. Berrangé wrote:
> I don't see why the configure change has any dependancy on meson 0.56.
> It just requires you to remove the mentioned header file and function
> from the configure check. This patch needs to include that or it is
> incomplete IMHO

I agree, moving the check to Meson is waiting for 0.56 but for now the
configure check needs to be maintained.

Paolo


