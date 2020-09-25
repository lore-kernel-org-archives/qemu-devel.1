Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325CBC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFE1221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJVyo3vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE1221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtIH-0004jd-R3
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLtH1-0003QG-7A
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLtGv-0004de-SK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:20:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601061644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xzoys+nnpgabGc26QNFbL7ZKUujtfycjztw29Y/WPEE=;
 b=ZJVyo3vqbEcH9gnuyudMKTb3YOCdsHCP/jYHsxp47PabXr2rT+ScwS97QNSVyV1tJNfYhj
 tvx47s0Z+w9cwD+HtJa3Sqqx7LNVww0HUhDns5pQJr05YKQoV45cULmfM9fDvPV1eBSrT1
 eJlqYv9UxAIJIwqL/4hwIwOfR+iw3pQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-hN8IVLS1MuqxwTzxacj4Yg-1; Fri, 25 Sep 2020 15:20:42 -0400
X-MC-Unique: hN8IVLS1MuqxwTzxacj4Yg-1
Received: by mail-wm1-f70.google.com with SMTP id 23so6335wmk.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xzoys+nnpgabGc26QNFbL7ZKUujtfycjztw29Y/WPEE=;
 b=LwZ3rQcdmXnKjVKtssStpfWNrSWnm8moSCaxKsDfwhfyJMc99jyWO5Zx8AzKkypwh/
 vCz3hkwCX/79yayjU83ruR0f7+tKPxfNko4JEMadxmxgDsuXhd4YI4P06z3fKI9kC+F/
 DHNKCQ/eL5H8LU9oRprrXLMpPBUwoMX+RTqXGbc2EP6plxuavLMWWn8uyc/BkS1keNWD
 rjSVsNQGorjrKg7qsyr9/8lgINuzsLy/wElqpsmekPhIgZbsSaL25r3qCVFAp5jfpF6y
 hvkkdGdSWI4qLBxk2QUyPUsy4zRbgRz0NOG3LrI4rNLWVwAmteIiEnedI/RZPOCI6B9X
 IkGA==
X-Gm-Message-State: AOAM533AI2/9so1AOniZRQqmw3H4UjAh7pmXcpzCuF1diEan0MXxwtE4
 3esV3x0M5bwowsL/zAmMXPBzSsWpaAH1UBMWEgoDjdwyxkCu2ZsQyP6vhmID5p/LhDulod9jlra
 iB2G+44o08a44DxQ=
X-Received: by 2002:a1c:f608:: with SMTP id w8mr61781wmc.161.1601061641050;
 Fri, 25 Sep 2020 12:20:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytxCsle08DbHak215MK0AY+X88pfUfpdtZdxFIlrMaCzX3bHVDK7ySF+giYwEnMEoOk5enOQ==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr61758wmc.161.1601061640697;
 Fri, 25 Sep 2020 12:20:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id d19sm42384wmd.0.2020.09.25.12.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 12:20:40 -0700 (PDT)
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
Date: Fri, 25 Sep 2020 21:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 25/09/20 21:12, 罗勇刚(Yonggang Luo) wrote:
> currently the empty.c plugin are failed of linkage error
> 
> The fowlloing are the failing message:
> Compiling C object tests/plugin/libbb.dll.p/bb.c.obj
> Linking target tests/plugin/libempty.dll
> Linking target tests/plugin/libinsn.dll
> Linking target tests/plugin/libmem.dll
> ../tests/plugin/bb.c: In function 'vcpu_tb_exec':
> ../tests/plugin/bb.c:75:29: error: cast from pointer to integer of
> different size [-Werror=pointer-to-int-cast]
>    75 |     unsigned long n_insns = (unsigned long)udata;
>       |                             ^
> ../tests/plugin/bb.c: In function 'vcpu_tb_trans':
> ../tests/plugin/bb.c:95:46: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>    95 |                                              (void *)n_insns);
>       |                                              ^

Plugins cannot work on Windows, because they would be specific to one
executable as far as I know.  Plugins would have to link with the
emulator's import library, but there would be one import library per
emulator.

Paolo

> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libempty.dll.p/empty.c.obj: in function `qemu_plugin_install':
> C:\work\xemu\qemu\build/../tests/plugin/empty.c:30: undefined reference
> to `qemu_plugin_register_vcpu_tb_trans_cb'
> cc1.exe: all warnings being treated as errors
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:2433：tests/plugin/libempty.dll] 错误 1
> make: *** 正在等待未完成的任务....
> make: *** [Makefile.ninja:2420：tests/plugin/libbb.dll.p/bb.c.obj] 错误 1
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libinsn.dll.p/insn.c.obj: in function `vcpu_tb_trans':
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:29: undefined reference
> to `qemu_plugin_tb_n_insns'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:33: undefined reference
> to `qemu_plugin_tb_get_insn'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:36: undefined reference
> to `qemu_plugin_register_vcpu_insn_exec_inline'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:39: undefined reference
> to `qemu_plugin_register_vcpu_insn_exec_cb'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libinsn.dll.p/insn.c.obj: in function `plugin_exit':
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:48: undefined reference
> to `qemu_plugin_outs'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libinsn.dll.p/insn.c.obj: in function `qemu_plugin_install':
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:59: undefined reference
> to `qemu_plugin_register_vcpu_tb_trans_cb'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/insn.c:60: undefined reference
> to `qemu_plugin_register_atexit_cb'
> collect2.exe: error: ld returned 1 exit status
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libmem.dll.p/mem.c.obj: in function `plugin_exit':
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:33: undefined reference to
> `qemu_plugin_outs'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_mem':
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:41: undefined reference to
> `qemu_plugin_get_hwaddr'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:42: undefined reference to
> `qemu_plugin_hwaddr_is_io'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libmem.dll.p/mem.c.obj: in function `vcpu_tb_trans':
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:54: undefined reference to
> `qemu_plugin_tb_n_insns'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:58: undefined reference to
> `qemu_plugin_tb_get_insn'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:61: undefined reference to
> `qemu_plugin_register_vcpu_mem_inline'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:65: undefined reference to
> `qemu_plugin_register_vcpu_mem_cb'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/plugin/libmem.dll.p/mem.c.obj: in function `qemu_plugin_install':
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:96: undefined reference to
> `qemu_plugin_register_vcpu_tb_trans_cb'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> C:\work\xemu\qemu\build/../tests/plugin/mem.c:97: undefined reference to
> `qemu_plugin_register_atexit_cb'
> make: *** [Makefile.ninja:2440：tests/plugin/libinsn.dll] 错误 1
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:2447：tests/plugin/libmem.dll] 错误 1
> make -C /c/work/xemu/qemu/slirp
> BUILD_DIR="/c/work/xemu/qemu/build/slirp" PKG_CONFIG="pkg-config"
> CC="cc" AR="ar" LD="ld" RANLIB="ranlib" CFLAGS="-m64 -mcx16
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
>  -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
> -fstack-protector-strong -g -fno-pie -mthreads -std=gnu99 -Wall"
> LDFLAGS="-Wl,--warn-common -m64  -fstack-protector-strong"
> make[1]: 进入目录“/c/work/xemu/qemu/slirp”
> make[1]: 对“all”无需做任何事。
> make[1]: 离开目录“/c/work/xemu/qemu/slirp”
> make -I/c/work/xemu/qemu/dtc VPATH=/c/work/xemu/qemu/dtc -C dtc V="1"
> LIBFDT_lib="" CPPFLAGS="-I/c/work/xemu/qemu/dtc/libfdt" CFLAGS="-g
> -fno-pie -mthreads -std=gnu99 -Wall -m64 -mcx16 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
> -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
> -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
> -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
> -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong"
> LDFLAGS="-Wl,--warn-common -m64  -fstack-protector-strong" ARFLAGS="rv"
> CC="cc" AR="ar" LD="ld"  libfdt
> make[1]: 进入目录“/c/work/xemu/qemu/build/dtc”
> make[1]: 对“libfdt”无需做任何事。
> make[1]: 离开目录“/c/work/xemu/qemu/build/dtc”
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> "qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
> "C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then
> printf '%s\n' qemu-version.h > qemu-version.h.stamp; fi
> "ar" csrD libqemuutil.a @libqemuutil.a.rsp
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> "C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_2b18a272e12652a9e7600847543c3524867d85d7.dat"
> && if test -e block.syms; then printf '%s\n' block.syms >
> block.syms.stamp; fi
> "ar" csrD libblock.fa @libblock.fa.rsp
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--unpickle"
> "C:/work/xemu/qemu/build/meson-private/meson_exe_python3.exe_269c5ec9ac7976b6693320b9cb25885f5b2f71c7.dat"
> && if test -e qemu.syms; then printf '%s\n' qemu.syms > qemu.syms.stamp; fi
> "c++" @qemu-system-ppc.exe.rsp
> 
> -- 
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


