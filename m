Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D55C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E757D223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q88nQsBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E757D223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXRc-0001id-Og
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUXQQ-0000hn-JL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUXQO-0007nL-Q5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603122615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfcUaYLtnabqgMxsF/q8dbclYZFbtGYur06IBrFgaTE=;
 b=Q88nQsBlmSRnM6721p4O7BTfOUiqly5eH3WLVy++WFCNKRuzoysr4hK2uuB7a0/17waG5L
 IIX6SaUkj5x23ZuHqo1cxRXwd3OfaDsegGTXMt4ejkMYJ3707lE54vhAVYHRNzJLip2mcp
 tXI4tVi6Aspqdxd6rWa665m5fCh3wZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-Wx2yGYyhPLu3YpD297ESug-1; Mon, 19 Oct 2020 11:50:14 -0400
X-MC-Unique: Wx2yGYyhPLu3YpD297ESug-1
Received: by mail-wr1-f69.google.com with SMTP id j15so34015wrd.16
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qfcUaYLtnabqgMxsF/q8dbclYZFbtGYur06IBrFgaTE=;
 b=fUpL/V177fTw5QLsDqLr0fKhozNACe74mIwFAACY3LxV0mSoMZhwHZZWI1h1LOFnc2
 g1jdPDwuWC5N2PmVSQH6ljdmgPDFki+JJ54DEVf1NLvv1csSkXFKlW0eFSS4UOB1rnS+
 Dv/1MYfiJ3rBszQmG1esCkZUyZ2Z1gyx4KY61+YukLKksxh09qZH2uyUSyW3WQLuu9lf
 y5zgIMaTCZSoaI33h25U0m4VZU33oOZBQTx0SZ7+Sp8zE0lZCKM8WrE6JVLwk4fy06YN
 RR+Yo4sbTOEvOgQ6VFKTu9l37OSdOWidFxr49ZZEaJ71nMk+pvC7oxbyfxtQIATutHUj
 odJg==
X-Gm-Message-State: AOAM5335qfFndsSeadXVTp2C19PKacNUjDf8mxaCGmZ5k36knT9lxErP
 qo7zm0zOvnqgMuTqUGvBwDw3MxUvMaXFTOeNdHZ5Ayg5xmNXaxzzHyusimdGDd/bL/U5OnhJ2Bh
 GLzIyV8gBIHQFs6A=
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr137092wrs.303.1603122613101;
 Mon, 19 Oct 2020 08:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPYuj0ERpG1SxNl5qqKrZ0ttjc6A/G8GXu+1gRSWbR3NHpN4C5fnRr7FMx2dxUp71ZYeff1A==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr137078wrs.303.1603122612903;
 Mon, 19 Oct 2020 08:50:12 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n4sm111569wrr.91.2020.10.19.08.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:50:12 -0700 (PDT)
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
To: Emmanuel Blot <eblot.ml@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
Date: Mon, 19 Oct 2020 17:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus/John/Paolo

On 10/19/20 5:33 PM, Emmanuel Blot wrote:
> Hi,
> 
> I’m using the current master (ba2a9a9e)
> I tried to build with both ‘ninja’ and also with ‘make’, as I’m not sure 
> of the current status of the meson refactoring.
> 
> The build fails with a weird error message:
> 
> ld: file not found: _PreallocMode_lookup
> 
> PreallocMode_lookup should be a symbol, shouldn’t it?
> Why is ld trying to load of file with this name?
> 
[...]

> libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-visit-machine-target.c.o 
> libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-events-machine-target.c.o 
> libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-types.c.o 
> -Wl,-dead_strip_dylibs -Wl,-headerpad_max_install_names 
> -Wl,-undefined,error -Wl,-force_load libhwcore.fa -Wl,-force_load 
> libchardev.fa -Wl,-force_load libqmp.fa -Wl,-force_load libauthz.fa 
> -Wl,-force_load libqom.fa -Wl,-force_load libio.fa -Wl,-force_load 
> libcrypto.fa -Wl,-force_load libblock.fa -m64 -framework CoreFoundation 
> -framework IOKit -arch x86_64 -fstack-protector-strong libfdt.a 
> libcapstone.a libqemuutil.a libmigration.fa libhwcore.fa libchardev.fa 
> libqmp.fa libauthz.fa libqom.fa libio.fa libcrypto.fa libblock.fa 
> @block.syms @qemu.syms -lsnappy 
> /usr/local/Cellar/pixman/0.40.0/lib/libpixman-1.dylib -llzo2 
> -L/usr/local/Cellar/libusb/1.0.23/lib -lusb-1.0 /usr/lib/libz.dylib 
> -framework Cocoa -framework CoreAudio 
> -L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib 
> -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl 
> -L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib 
> -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl 
> /usr/local/Cellar/libpng/1.6.37/lib/libpng16.dylib @block.syms 
> -L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib 
> -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl 
> -L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib 
> -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl 
> -L/usr/local/Cellar/gnutls/3.6.15/lib -lgnutls -lutil -lm 
> -L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib 
> -lgmodule-2.0 -lglib-2.0 -lintl -lpam 
> -L/usr/local/Cellar/gnutls/3.6.15/lib -lgnutls 
> -L/usr/local/Cellar/nettle/3.6/lib -lnettle -framework IOKit -framework 
> CoreFoundation -lxml2 -Wl,-rpath,/usr/local/Cellar/pixman/0.40.0/lib 
> -Wl,-rpath,/usr/lib -lc++
> ld: file not found: _PreallocMode_lookup

Looks like incorrect generated QAPI headers (unsync?).

> clang: error: linker command failed with exit code 1 (use -v to see 
> invocation)
> [2036/2125] Compiling C object tests/fp/fp-bench.p/.._.._fpu_softfloat.c.o
> ninja: build stopped: subcommand failed.
> 
> eblot@thurso ~/S/G/g/Q/f/build (master) [1]> cc --version
> Apple clang version 12.0.0 (clang-1200.0.32.2)
> Target: x86_64-apple-darwin19.6.0
> Thread model: posix
> InstalledDir: 
> /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin 
> 
> 


