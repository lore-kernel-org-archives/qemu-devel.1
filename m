Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FFC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5052087D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHFu/JRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5052087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBkG6-0006Sy-V4
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBkFa-00062W-67
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBkFX-0006SW-Ns
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598643682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKCN8ryRJqFG3ryCmuU1NgwEVKT4Qr6mBU6auwiutTs=;
 b=YHFu/JRUlZdsUGr3kTx2R5lwlDfG9LomlJAPusbRE7ndQduAFA6qEL0aA7TJ0vIYcfJ3c7
 rh3FSsDIsarPIL5fptpJs2+aqoaw2kTUtW8Niua49mJjc4a8MaFwso2zKo+ssJ0g/x9Kfq
 xS7WG3Tp5BSmT4PAkK68D6wnZcAEiIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-eqvWAGs9NWquxsLckX7KyQ-1; Fri, 28 Aug 2020 15:41:20 -0400
X-MC-Unique: eqvWAGs9NWquxsLckX7KyQ-1
Received: by mail-wr1-f71.google.com with SMTP id z1so89621wrn.18
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 12:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cKCN8ryRJqFG3ryCmuU1NgwEVKT4Qr6mBU6auwiutTs=;
 b=XPbXBTY9aMpY/by53p7LIfoCm3LuYi9j0xD56Z0Ir85JlzENwVH6kDT6Ux5+/i3QwP
 BtclUn7GeCjvbR8hiGwxXGkaE5ihP9qJ1aNhZnlule47/jTYPPimhcpJy3QgFUMQ/0nP
 3S047KOrC5p8FJ6M/dzHzphy+VK4zKJv0O5Xi1YTZSx489Mu8imHg4luZaO/vEFH0br2
 i36V6OYXP5TMByqYq/UGwCw4SsSyCShsYDVL5iskJyWWMAaR90mMZ0zuSxQs6C/oWPiC
 oMmlb/yTDC1+aBDium/SfIfmz7pfTfW2Ww7n0bgao+xbl6xUSZ0zNs2nKzfUAR7FqsSh
 zWMw==
X-Gm-Message-State: AOAM533v4gZTK4Ytf/u0/0a/StLRaMy2CkT0LMVcYONDSIdZGS/lxebJ
 8uWxFDWXqksD1H1MPxgPkqWYA1+KL48GEyW8E1Q6IQ+9vE7V+Sx4Ya5oF4Z5pwPHl349awuZ+io
 Gp/TSU7W5mXvnPak=
X-Received: by 2002:adf:f786:: with SMTP id q6mr515536wrp.2.1598643678891;
 Fri, 28 Aug 2020 12:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJBEOi2Itm9TjsTd+hn8mP3QqTR/cemG6kY/alaGU5FUrNyyAd5BxJC1uHb9NP4U31OoTaTQ==
X-Received: by 2002:adf:f786:: with SMTP id q6mr515514wrp.2.1598643678584;
 Fri, 28 Aug 2020 12:41:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c924:73d2:e509:7a3f?
 ([2001:b07:6468:f312:c924:73d2:e509:7a3f])
 by smtp.gmail.com with ESMTPSA id g15sm720459wrx.66.2020.08.28.12.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 12:41:18 -0700 (PDT)
Subject: Re: [Fwd] Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
 <CABgObfZtGY-TuTLXNJNU9m_yQLfE6AM-+MdfqaaRjfMcWC8+Og@mail.gmail.com>
 <20200826135513.ay5ga3xi2ilcagqf@mozz.bu.edu>
 <CABgObfbxqPH1p-0ZD2wZWiKP0GjOjV6s+umgmOMKjm2ic7R=zg@mail.gmail.com>
 <20200828183305.6lbuwvmleqtn7fx3@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dfe703d-5c78-36d0-bc15-17ff6f9179d7@redhat.com>
Date: Fri, 28 Aug 2020 21:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200828183305.6lbuwvmleqtn7fx3@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 15:41:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/20 20:33, Alexander Bulekov wrote:
>> Create a fuzz.cmd that includes the correct path to fuzz.ld in the
>> source tree (using configure_file) and pass this file to the linker
>> using @tests/libqtest/fuzz/fuzz.cmd in link_args (and also
>> link_depends). See libblock and block for an example.
> I'm not sure whether this solves the problem that the linker-script is
> placed in between --start-group and --end-group arguments.  It seems
> that no matter what I do to specify the linker script with -Wl,-T, and
> link_args, the flag ends up placed between --start-group and --end-group
> due to some parsing that meson does in
> mesonbuild/compilers/mixins/clike.py.

Looks like you need to ensure that the link_args for -T and -wrap come
before everything else.

For example:

-Wl,--whole-archive qom/libqom.fa io/libio.fa crypto/libcrypto.fa
authz/libauthz.fa hw/core/libhwcore.fa libblock.fa libqmp.fa
chardev/libchardev.fa -Wl,--no-whole-archive -Wl,--warn-common
-Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong
migration/libmigration.fa -Wl,--start-group libqemuutil.a qom/libqom.fa
io/libio.fa crypto/libcrypto.fa authz/libauthz.fa hw/core/libhwcore.fa
libblock.fa libqmp.fa chardev/libchardev.fa @block.syms @qemu.syms

libqemuutil.a is what triggers --start-group.  So if you can add them
using add_project_link_arguments it should work.

Paolo


