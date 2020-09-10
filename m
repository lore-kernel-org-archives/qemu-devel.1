Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEA1C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E4E207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRH/D+Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E4E207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIlQ-0004zN-Ju
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIkn-0004VW-6T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:20:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIkl-0007gX-Le
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599729626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO4bWm/cPcTUGLfCpzWg/uVQUUhYZlQj1nC54fzA/M8=;
 b=PRH/D+GcB45A24JF1ZRfJcxhiDIR3n4HdIZHy6GuGydV5Hf9q9Zq1abb8kMjzvIpsSFmXp
 C5WHtJbn5Y3AZ/N2JXlPBlY8bJKWFN1H/i95RCWhN99+W3EcZFk3V0b3ImJ6Ewwl8FMyc9
 waB04Jd8DddutFE3fthrvM0JG8qs1X4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221--Ztar0i2M1ya5yNEqwL7eQ-1; Thu, 10 Sep 2020 05:20:25 -0400
X-MC-Unique: -Ztar0i2M1ya5yNEqwL7eQ-1
Received: by mail-ej1-f69.google.com with SMTP id m24so2479813ejr.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 02:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SO4bWm/cPcTUGLfCpzWg/uVQUUhYZlQj1nC54fzA/M8=;
 b=DWmeUXFWXzmZdFg4JhNzs3nWneJeS6JMGFd4SVpZxtM+OQftiwe4x/cdpS497/O4bw
 peIzlZiKE+mLr3LTIyR5ls6jbkp8ECZHNwaTuzAZsW3IDYn9YMpenNkec3v1GhwGW08l
 VRvnecafTce+4TeHXARsQZIUgr/832QdhmagXgZ0qSJ8i6RdUvtK5YCEyq1a8iEoiqmi
 aviZlMnb6p5+uUBCbHu3mQp4Z//0DFZl3L6mEosZ+jjNhjmDpgrzdiCGMI+bGM8d74X8
 VeRhjz2R0LXN6VVvVWfvtOFXij/cMBUeI6BUMUlNuc3NgGduKu7pIzpcNTg2n1qYkm57
 QELQ==
X-Gm-Message-State: AOAM5304XLJ4i5SA9z8SehClxPkA9C+XnjQ4f80otvyNo1JSw5nMNmQK
 BX5P4EAXeiI2oesgJ4zDTpu6g1fdhwxM2KHEpgpJFMqF6djbB4JYt+0dnpyi6BmZt0dzbq+E7qk
 zN2kDwoAVtAUw+6s=
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr8369056edq.218.1599729624075; 
 Thu, 10 Sep 2020 02:20:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCXnWymC2DNmEis24kgZHf6f5Sw5QjpIfxT5XybcN5+ahR5wB4HShZF0uwqxcBzgzPTxQZjQ==
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr8369031edq.218.1599729623894; 
 Thu, 10 Sep 2020 02:20:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2744:1c91:fa55:fa01?
 ([2001:b07:6468:f312:2744:1c91:fa55:fa01])
 by smtp.gmail.com with ESMTPSA id d13sm6406624edl.68.2020.09.10.02.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 02:20:23 -0700 (PDT)
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Liviu Ionescu <ilg@livius.net>, Peter Maydell <peter.maydell@linaro.org>
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
 <CAFEAcA9m6Qd1C2EXHKBfVrq_bd_AJo8ggf0t02bLufkmT5jZ=w@mail.gmail.com>
 <F0F8F9BF-0B9F-430E-8381-87AD6B3077C8@livius.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8640871f-366c-e7a9-549a-8403c36c5a0b@redhat.com>
Date: Thu, 10 Sep 2020 11:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <F0F8F9BF-0B9F-430E-8381-87AD6B3077C8@livius.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 22:13, Liviu Ionescu wrote:
>> ... You still need a Python 3.5 or better for the other scripts 
>> QEMU has as part of its build process, so you will still need a
>> python other than the Apple /usr/bin/python to build even if you
>> have a standalone meson with its own python.
>
> Ah, sure, if the build script uses Python for other purposes you'll
> need one, but the embedded Python will allow the standalone meson to
> run properly regardless of what Python you install.

Note that if you use the version of Meson that is bundled with QEMU, you
can use

  --python=/path/to/python3 --meson=internal

and the build will automatically use that same Python executable to run
the scripts.

Paolo


