Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331EBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850062072D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7fPLp6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850062072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmQt-00019P-F6
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTmQ3-0000kP-Qx
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTmQ0-0000mw-VL
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602941922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPeAfMKJAShn0hgLKmUTJ9kXDGtQz2PKkr96n6XhEKs=;
 b=F7fPLp6t94VxaAd9KnejCWPtOvw/MFQI4GaVpz9D3mnlBzcxhQc3psOMY2sGEqEQ+UvyRI
 g/ZA1ihbm9HLqzAMssKZzLXElmO2G/oaugLWcTBT+7TlL9H9z+hRm12Q8TcVyuuPH76uvT
 CPGH7pkm0O5CFjg7yB1i7WzJNSPWVpc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-BWS6GPEqNW6vTrJpxfBv8Q-1; Sat, 17 Oct 2020 09:38:41 -0400
X-MC-Unique: BWS6GPEqNW6vTrJpxfBv8Q-1
Received: by mail-wr1-f72.google.com with SMTP id b11so5149482wrm.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 06:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uPeAfMKJAShn0hgLKmUTJ9kXDGtQz2PKkr96n6XhEKs=;
 b=RT+/xsQRI3w/1U17ECZSoz6yoNr0fmOyA5s/IAl3IsVoNJ11W/pUnxrnOHazlnYc1y
 hI0ym1Q+fam7/0vSS1S2Z+hJ2PmKJsxiht5wOr5UhQn6H4jGGtWAh/pZ3j7a+jnddGYo
 0ocdciazTR+2xiLJJo8iv0S6zBdyv/l+HGjTUdQHWH8GXYPOmSg500BhP9YUDmXPHdbb
 oVVfHiyYC7fO1tTkyVdlgwj/H9g+8RxJ6kXTKZdsPCDr99vQmfhgDHU9bp6NcmYmpjXE
 ozOr8P53WpIzlsNMCokqHqXXfKgP5b22H80mAurF2szWcOFnjXmhcX4z4HpFhvwYbrYi
 8mtw==
X-Gm-Message-State: AOAM531NSy1/lYl8dfxumAlbGfhqDF4tcnglU9BNq8IX+rFTG8ZI8s4q
 2EAgg9dQau8MZZAfWGjkHaR9Uz4qKR5iYkdQdWEW/QJEDHD1JLdkV9AQjDdp/dGssCQ/PZngmis
 FqJfQtXLC5tbJzRE=
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr10777770wrp.210.1602941919738; 
 Sat, 17 Oct 2020 06:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6/8R82KV6mJt+UekJcFwrHc66c0iT9KifDLsQm1b53sCJvIIbtH40a76Ckzraai2eo1fXtA==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr10777750wrp.210.1602941919467; 
 Sat, 17 Oct 2020 06:38:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1f71:1cc3:938:d96d?
 ([2001:b07:6468:f312:1f71:1cc3:938:d96d])
 by smtp.gmail.com with ESMTPSA id n5sm8810927wrm.2.2020.10.17.06.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 06:38:38 -0700 (PDT)
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
Date: Sat, 17 Oct 2020 15:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:57:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17/10/20 15:09, Peter Maydell wrote:
> Traceback (most recent call last):
>   File "scripts/mtest2make.py", line 37, in <module>
>     introspect = json.load(sys.stdin)
>   File "/usr/lib/python3.6/json/__init__.py", line 299, in load
>     parse_constant=parse_constant, object_pairs_hook=object_pairs_hook, **kw)
>   File "/usr/lib/python3.6/json/__init__.py", line 354, in loads
>     return _default_decoder.decode(s)
>   File "/usr/lib/python3.6/json/decoder.py", line 339, in decode
>     obj, end = self.raw_decode(s, idx=_w(s, 0).end())
>   File "/usr/lib/python3.6/json/decoder.py", line 357, in raw_decode
>     raise JSONDecodeError("Expecting value", s, err.value) from None
> json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
> make: *** Deleting file 'Makefile.mtest'
> 
> followed by:
> 
> ERROR: Cannot find Ninja

The most likely cause is that the Makefile is forcing configure to rerun
because you don't have ninja in config-host.mak; this works (as shown by
the error) but only after mtest2make has barfed.  I can add a dependency
from Makefile.mtest to config-host.mak which technically isn't needed
but doesn't hurt.

OpenBSD and NetBSD call the ninja package "ninja-build" unlike FreeBSD.
 I'm sure I had used the right name but well I didn't.  I'll send a v3.

Paolo


