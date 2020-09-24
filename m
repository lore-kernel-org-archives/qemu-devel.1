Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EBC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3299D238E3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCPDPuRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3299D238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSOb-0006Yx-3u
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmaloy@redhat.com>) id 1kLSNV-0005bo-29
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jmaloy@redhat.com>) id 1kLSNR-0005PW-Qu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600958260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYFgrGjaR/8j8xo2o9AsvkT4/ZW8P1+49iGRi4Kw4vs=;
 b=UCPDPuRMlOTgKWa0OfQjNWmO2afn3LCi+Veq966puZ/qH5FpbIs1+3Ed70+6AJK0vJYKIM
 hHkVjYNzu6UinBSEGNa7VbDtV6eR5/dBT4cRwY5GIdeoQM4RSBklHJ1vkj4AoLSdceduyy
 hEabDaS3D89cucLk/EPKs4vPA7yr0rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-2EOnV5hjNsiePo6fvdUSdA-1; Thu, 24 Sep 2020 10:36:27 -0400
X-MC-Unique: 2EOnV5hjNsiePo6fvdUSdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7322800493;
 Thu, 24 Sep 2020 14:36:25 +0000 (UTC)
Received: from [10.10.117.215] (ovpn-117-215.rdu2.redhat.com [10.10.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7DDC5D9D2;
 Thu, 24 Sep 2020 14:36:21 +0000 (UTC)
Subject: Problems with building using meson and fuzzing
References: <3d188586-5301-30ba-1a19-db34a273cbb0@redhat.com>
From: Jon Maloy <jmaloy@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
X-Forwarded-Message-Id: <3d188586-5301-30ba-1a19-db34a273cbb0@redhat.com>
Message-ID: <615f663c-f935-1401-5042-4436da257a96@redhat.com>
Date: Thu, 24 Sep 2020 10:36:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d188586-5301-30ba-1a19-db34a273cbb0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmaloy@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jmaloy@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex, Stefan & al
I am trying to build and run Marc-Andrés Lureaus libslirp code with 
fuzzing activated, but I am running into build issues.
https://gitlab.freedesktop.org/elmarco/libslirp/-/commit/9fba8af484ec6bc10b22e3f49d9e34d95c28b086
Since I am new to meson I thought it might be quicker to ask somebody 
instead of spending a lot of time on this myself.

1: I cloned the repository.
2: I made a "regular" build as you suggested in the mommit log, using 
gcc, and made a run. No problem.
3: I then try to build using clang and with fuzzing activated, also as 
suggested in the commit log:
[jmaloy@f31 libslirp]$ CFLAGS="-fsanitize=fuzzer" CC=clang CXX=clang++  
meson build-clang -Db_lundef=false
(*** Note that the build directory is missing in the commit log's 
example command)
The Meson build system
Version: 0.55.3
Source dir: /home/jmaloy/fuzzing/lureau/libslirp
Build dir: /home/jmaloy/fuzzing/lureau/libslirp/build-clang
Build type: native build
Project name: slirp
Project version: 4.0.0
Using 'CC' from environment with value: 'clang'
Using 'CFLAGS' from environment with value: '-fsanitize=fuzzer'

meson.build:1:0: ERROR: Compiler clang can not compile programs.

A full log can be found at 
/home/jmaloy/fuzzing/lureau/libslirp/build-clang/meson-logs/meson-log.txt
[jmaloy@f31 libslirp]$


The content of the indicated log file:
------------------------------------------------
Build started at 2020-09-17T19:04:23.217850
Main binary: /usr/bin/python3
Build Options: -Db_lundef=false
Python system: Linux
The Meson build system
Version: 0.55.3
Source dir: /home/jmaloy/fuzzing/lureau/libslirp
Build dir: /home/jmaloy/fuzzing/lureau/libslirp/build-clang
Build type: native build
None of 'PKG_CONFIG_PATH' are defined in the environment, not changing 
global flags.
None of 'PKG_CONFIG_PATH' are defined in the environment, not changing 
global flags.
Project name: slirp
Project version: 4.0.0
Using 'CC' from environment with value: 'clang'
Using 'CFLAGS' from environment with value: '-fsanitize=fuzzer'
None of 'LDFLAGS' are defined in the environment, not changing global flags.
None of 'CPPFLAGS' are defined in the environment, not changing global 
flags.
None of 'CC_LD' are defined in the environment, not changing global flags.
Sanity testing C compiler: clang
Is cross compiler: False.
None of 'CC_LD' are defined in the environment, not changing global flags.
Sanity check compiler command line: clang 
/home/jmaloy/fuzzing/lureau/libslirp/build-clang/meson-private/sanitycheckc.c 
-o 
/home/jmaloy/fuzzing/lureau/libslirp/build-clang/meson-private/sanitycheckc.exe 
-fsanitize=fuzzer -pipe -D_FILE_OFFSET_BITS=64
Sanity check compile stdout:

-----
Sanity check compile stderr:
/usr/bin/ld: /tmp/sanitycheckc-689218.o: in function `main':
sanitycheckc.c:(.text.main[main]+0x0): multiple definition of `main'; 
/usr/lib64/clang/9.0.1/lib/linux/libclang_rt.fuzzer-x86_64.a(FuzzerMain.cpp.o):(.text.startup[.text.startup.group]+0x0): 
first defined here
/usr/bin/ld: 
/usr/lib64/clang/9.0.1/lib/linux/libclang_rt.fuzzer-x86_64.a(FuzzerMain.cpp.o): 
in function `main':
(.text.startup[.text.startup.group]+0xf): undefined reference to 
`LLVMFuzzerTestOneInput'
clang-9: error: linker command failed with exit code 1 (use -v to see 
invocation)

-----

meson.build:1:0: ERROR: Compiler clang can not compile programs.

My environment:
----------------------
[jmaloy@f31 libslirp]$ which clang
/usr/bin/clang
[jmaloy@f31 libslirp]$ clang --version
clang version 9.0.1 (Fedora 9.0.1-2.fc31)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
[jmaloy@f31 libslirp]$ which meson
~/.local/bin/meson
[jmaloy@f31 libslirp]$ meson --version
0.55.3
[jmaloy@f31 libslirp]$

I updated from meson 0.52.0 to 0.55.3, but the result is exactly the same.
I commented out "main()" in fuzz-main.c  just to check, but that is not 
the issue of course.
To me it looks like the sanity checker is trying to link to 
libclang_rt.fuzzer-x86_64.a  twice, and at the same time is incapable of 
finding LLVMFuzzerTestOneInput() which clearly is there.

Does anybody have any ideas about this?

BR
///Jon Maloy


