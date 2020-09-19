Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC20C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0312098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0rNhfrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0312098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJePH-0005PN-0g
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJeOM-0004pD-Dm
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJeOK-0007XZ-HV
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600527787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swnZwxpLtegqnt3wqlIj88WC1uyZ0o0GcFQvA+vaVG0=;
 b=C0rNhfrzfkDNWjBdoJ8SHktiFrq9YkZqxB+szTI3eZB0L6PnuOf70i0QYUqKO4+yrYsc5n
 D0IUOxn1FDqKDFm17gVFRSbE8cauthbNv33TpoW00C9E4RLefxZ/aLn+bM9rR5CfM4v4U6
 0oOhSYRUoM+aDg8LOMfCzrVCZ3uGnlQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-rcfkqMEGOUq4J8ALSnQMcw-1; Sat, 19 Sep 2020 11:03:03 -0400
X-MC-Unique: rcfkqMEGOUq4J8ALSnQMcw-1
Received: by mail-wr1-f70.google.com with SMTP id l17so3510496wrw.11
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=swnZwxpLtegqnt3wqlIj88WC1uyZ0o0GcFQvA+vaVG0=;
 b=Nneip6FwR5XaOwUH+7kGP2viNgmmCxSitjUsa9xcueaFewt6bN35SWLZ+x7IlotwEQ
 Rr4JJmOrMTfzCujZ+ajVy8AB83hc9oTry2jhHdV5bRo2/1pqipfi9hb/57ULbMbDWhkP
 Kt9JuGKVoi7fRo90Mi05aZ6AnEFIbfDn80HRIfj5Auf0/48oXdTI7kesrOyD5n6sHnft
 SspYXBX0Z13qkRx1RleS40mmQghGQrf5mr7lBBR5yb7xbFASc21tRCnV9Lc+O9SEghqf
 FDHxnrCCE14BGcPJlxmVwED/Liyz2rgtSrLQhkAypimdwyi6+AzKLnHhBY2uIY60lfvQ
 rGgw==
X-Gm-Message-State: AOAM532f6rBWlYK0JSJ66quXqT9ZHPlfVOKNblLEqXvL84qgp4Oeoi4N
 nDJO4ueno5QZWSSGieLHoNzY9nx1LoVt+9MTYqZmJfLR3abN/g5y3tP9XLWBOCydFsl+OWqmWWU
 YocOO5B+++Ph1FLo=
X-Received: by 2002:a5d:430d:: with SMTP id h13mr46093035wrq.41.1600527782280; 
 Sat, 19 Sep 2020 08:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0kSk7q48TAWNdhwdlBBtXpJHBo6w1kdCcYFYPPGV3Sh7upF+q0adtu9byTpinDmMAsfPm/A==
X-Received: by 2002:a5d:430d:: with SMTP id h13mr46093013wrq.41.1600527782096; 
 Sat, 19 Sep 2020 08:03:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d?
 ([2001:b07:6468:f312:b20a:b600:521c:512d])
 by smtp.gmail.com with ESMTPSA id z127sm11129054wmc.2.2020.09.19.08.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 08:03:01 -0700 (PDT)
Subject: Re: [PATCH v5 0/4] Fixes curses on msys2/mingw
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <20200918160250.1141-1-luoyonggang@gmail.com>
 <CAE2XoE9Vf3Zixv6Ds0BmO9O5EWWjPbG-0EkP0BEbPikuCc4SVg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c0699e8-62ef-8f29-182f-a0744c727bae@redhat.com>
Date: Sat, 19 Sep 2020 17:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9Vf3Zixv6Ds0BmO9O5EWWjPbG-0EkP0BEbPikuCc4SVg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 18:10, 罗勇刚(Yonggang Luo) wrote:
> 
>> Yonggang Luo (4):
>>   curses: Fixes compiler error that complain don't have langinfo.h on
>>     msys2/mingw
>>   curses: Fixes curses compiling errors.
>>   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE
>>     are defined on msys2/mingw
>>   configure: Fixes ncursesw detection under msys2/mingw by convert them
>>     to meson

Hi, patches 1-3 are okay, but for patch 4 I think it's better to wait
for Meson 0.56 which will likely embed all the magic needed to test
curses (https://github.com/mesonbuild/meson/pull/7757).

Paolo


