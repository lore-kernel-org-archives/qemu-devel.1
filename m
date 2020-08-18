Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBC020786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXzLm2Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBC020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82G6-0000RN-CL
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k82F5-0008QV-UJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:05:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52204
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k82F3-0006YC-76
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E9epHG6VgAJzm/Kz3YR5fUBllA+Sj8z0e7+B2hhHrXA=;
 b=PXzLm2Y64L0Af5/YSXzUbZY7pumDckJS/Zu7sC57YeRo6Wc7FO9gloKt2LSEPn59p9uAw5
 1Xzh2rwbByFFMVSBLcVP2XuqFr3DZ6IXR/Ns3ZZ5dX1rbG22T3UrCUkRnmantWtm17700Y
 Ae4Ma1OUmR+sdU/Jd5pEvu2qxA59K/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-bMZxoJwKMbWoEPg7MwypHQ-1; Tue, 18 Aug 2020 10:05:30 -0400
X-MC-Unique: bMZxoJwKMbWoEPg7MwypHQ-1
Received: by mail-wm1-f70.google.com with SMTP id c184so5218961wme.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 07:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E9epHG6VgAJzm/Kz3YR5fUBllA+Sj8z0e7+B2hhHrXA=;
 b=hSdMlJQ5R1t1jSesqD32ojp7tmoGilikcnhaCMR38vtTKXqiPfEaWVUM+xKjMD5jOO
 l21qkREK3D9qwugCHNZTT4EVfHKElX8L2iqC7HtRa/ta5/vZ8mNWjsRsQaMSYvHT7/yc
 t5/DeUGyvxAERDYfm4cUPvkglcLskSRlMFrfWzk2fHiYPbYSpq/rEhZ6DC9q9j9OJLQC
 fGMjmmPKn3p1Bv79NfSxeA99hOqDXRhBp4o4EJ0tkNQzPlIR2xEU95QN4v6l+ODgBlKW
 Am6OCbChUB3RWCYQGBoA2JEcHnEzz1NCDzAacZxdUWsqd04rHmJbBC34P3NdeI0KeGP0
 qvxw==
X-Gm-Message-State: AOAM532yHhyn1L/uKK4u6ENz4GEQ5Ctw2nxpkWbco3o0s1rHmX0LSL9z
 a1Q8LvozDHMeEfjWgMRVJTV3ax98Ids4QyCJieH3Sv2q0TzgmKsRWpPBo4t1tZIUtMuJzMZcP0q
 IKcVapDTNhS7/meQ=
X-Received: by 2002:adf:91a1:: with SMTP id 30mr22031736wri.29.1597759529206; 
 Tue, 18 Aug 2020 07:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdbKjsUUt5MSUSPNmlyXns1TQlSKWdMDEPD558B8k/8a3ftuwnAGkTLUOOqN5CJ2/Kz3MPfg==
X-Received: by 2002:adf:91a1:: with SMTP id 30mr22031705wri.29.1597759528867; 
 Tue, 18 Aug 2020 07:05:28 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m126sm116339wmf.3.2020.08.18.07.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 07:05:27 -0700 (PDT)
Subject: Re: [PATCH v3 000/150] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <bbecf5e0-33a2-4dc9-3098-618b6813d3f0@redhat.com>
Date: Tue, 18 Aug 2020 16:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 4:34 PM, Paolo Bonzini wrote:
> - Simplified/rewrote handling of the modules variable [Howard]
> - Fixed access to gdb-xml files [Howard]
> - Fixed cross-compilation failure due to mingw prefix [Howard]
> - Fixed SDL2 detection on cross compiles [Howard]
> - Fixed sub-makefiles that include config-host.mak
> 
> You can find it at the usual place, https://gitlab.com/bonzini/qemu.git
> branch meson-poc-next.

Also for later, 'make help' doesn't list various targets:

---
 Generic targets:
   all                            - Build all
   dir/file.o                     - Build specified target only
   install                        - Install QEMU
   ctags/TAGS                     - Generate tags file for editors
   cscope                         - Generate cscope index
-
-Architecture specific targets:
-  aarch64-softmmu/all            - Build for aarch64-softmmu
-  alpha-softmmu/all              - Build for alpha-softmmu
-  arm-softmmu/all                - Build for arm-softmmu
-  avr-softmmu/all                - Build for avr-softmmu
-  cris-softmmu/all               - Build for cris-softmmu
-  hppa-softmmu/all               - Build for hppa-softmmu
-  i386-softmmu/all               - Build for i386-softmmu
-  lm32-softmmu/all               - Build for lm32-softmmu
-  m68k-softmmu/all               - Build for m68k-softmmu
-  microblazeel-softmmu/all       - Build for microblazeel-softmmu
-  microblaze-softmmu/all         - Build for microblaze-softmmu
-  mips64el-softmmu/all           - Build for mips64el-softmmu
-  mips64-softmmu/all             - Build for mips64-softmmu
-  mipsel-softmmu/all             - Build for mipsel-softmmu
-  mips-softmmu/all               - Build for mips-softmmu
-  moxie-softmmu/all              - Build for moxie-softmmu
-  nios2-softmmu/all              - Build for nios2-softmmu
-  or1k-softmmu/all               - Build for or1k-softmmu
-  ppc64-softmmu/all              - Build for ppc64-softmmu
-  ppc-softmmu/all                - Build for ppc-softmmu
-  riscv32-softmmu/all            - Build for riscv32-softmmu
-  riscv64-softmmu/all            - Build for riscv64-softmmu
-  rx-softmmu/all                 - Build for rx-softmmu
-  s390x-softmmu/all              - Build for s390x-softmmu
-  sh4eb-softmmu/all              - Build for sh4eb-softmmu
-  sh4-softmmu/all                - Build for sh4-softmmu
-  sparc64-softmmu/all            - Build for sparc64-softmmu
-  sparc-softmmu/all              - Build for sparc-softmmu
-  tricore-softmmu/all            - Build for tricore-softmmu
-  unicore32-softmmu/all          - Build for unicore32-softmmu
-  x86_64-softmmu/all             - Build for x86_64-softmmu
-  xtensaeb-softmmu/all           - Build for xtensaeb-softmmu
-  xtensa-softmmu/all             - Build for xtensa-softmmu
-  aarch64_be-linux-user/all      - Build for aarch64_be-linux-user
-  aarch64-linux-user/all         - Build for aarch64-linux-user
-  alpha-linux-user/all           - Build for alpha-linux-user
-  armeb-linux-user/all           - Build for armeb-linux-user
-  arm-linux-user/all             - Build for arm-linux-user
-  cris-linux-user/all            - Build for cris-linux-user
-  hppa-linux-user/all            - Build for hppa-linux-user
-  i386-linux-user/all            - Build for i386-linux-user
-  m68k-linux-user/all            - Build for m68k-linux-user
-  microblazeel-linux-user/all    - Build for microblazeel-linux-user
-  microblaze-linux-user/all      - Build for microblaze-linux-user
-  mips64el-linux-user/all        - Build for mips64el-linux-user
-  mips64-linux-user/all          - Build for mips64-linux-user
-  mipsel-linux-user/all          - Build for mipsel-linux-user
-  mips-linux-user/all            - Build for mips-linux-user
-  mipsn32el-linux-user/all       - Build for mipsn32el-linux-user
-  mipsn32-linux-user/all         - Build for mipsn32-linux-user
-  nios2-linux-user/all           - Build for nios2-linux-user
-  or1k-linux-user/all            - Build for or1k-linux-user
-  ppc64abi32-linux-user/all      - Build for ppc64abi32-linux-user
-  ppc64le-linux-user/all         - Build for ppc64le-linux-user
-  ppc64-linux-user/all           - Build for ppc64-linux-user
-  ppc-linux-user/all             - Build for ppc-linux-user
-  riscv32-linux-user/all         - Build for riscv32-linux-user
-  riscv64-linux-user/all         - Build for riscv64-linux-user
-  s390x-linux-user/all           - Build for s390x-linux-user
-  sh4eb-linux-user/all           - Build for sh4eb-linux-user
-  sh4-linux-user/all             - Build for sh4-linux-user
-  sparc32plus-linux-user/all     - Build for sparc32plus-linux-user
-  sparc64-linux-user/all         - Build for sparc64-linux-user
-  sparc-linux-user/all           - Build for sparc-linux-user
-  tilegx-linux-user/all          - Build for tilegx-linux-user
-  x86_64-linux-user/all          - Build for x86_64-linux-user
-  xtensaeb-linux-user/all        - Build for xtensaeb-linux-user
-  xtensa-linux-user/all          - Build for xtensa-linux-user
-
-Helper targets:
-  fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
-  scsi/qemu-pr-helper            - Build qemu-pr-helper
-  qemu-bridge-helper             - Build qemu-bridge-helper
-  vhost-user-gpu                 - Build vhost-user-gpu
-  virtiofsd                      - Build virtiofsd
-
-Tools targets:
-  qemu-ga                        - Build qemu-ga tool
-  qemu-keymap                    - Build qemu-keymap tool
-  elf2dmp                        - Build elf2dmp tool
-  ivshmem-client                 - Build ivshmem-client tool
-  ivshmem-server                 - Build ivshmem-server tool
-  qemu-nbd                       - Build qemu-nbd tool
-  qemu-storage-daemon            - Build qemu-storage-daemon tool
-  qemu-img                       - Build qemu-img tool
-  qemu-io                        - Build qemu-io tool
-  qemu-edid                      - Build qemu-edid tool
+  sparse                         - Run sparse on the QEMU source

 Cleaning targets:
   clean                          - Remove most generated files but keep
the config
@@ -105,7 +20,7 @@
   vm-help                        - Help about targets running tests
inside VM

 Documentation targets:
-  html info pdf txt              - Build documentation in specified format
+  html info pdf txt man          - Build documentation in specified format

   make [targets]                 - (quiet build, default)
   make V=1 [targets]             - (verbose build)
---

Regards,

Phil.


