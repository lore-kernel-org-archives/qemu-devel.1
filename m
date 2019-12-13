Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9082077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gow5unGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9082077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhH9-0001ss-H4
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifhGT-0001T0-VQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifhGR-0001id-6v
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:29:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifhGQ-0001fz-Ln
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576229373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNTqULCyhfE1cjwHMs/sENzvenS+xM8x7YOFrrGnK5s=;
 b=Gow5unGkmu6LDlle3ebbpF8GGspkAbykqIqVE1J3toaGxQaHwhFDFzI5uTt717h7blgrG6
 uoPLZShZrNhoMzHEh3GjBQYORTQHp3TaIyh5fPbzNkr4Y0wlniGWxPCESnXJyZ1I5DHIwu
 ws8137qNWBHzvtwj9lu2TyZb7K9l/Yk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_9A5ORI7NRiv-hI1qQ9L1w-1; Fri, 13 Dec 2019 04:29:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id l11so2523014wmi.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 01:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AyEy9SjQyGizwWThlyinscYyugEXJ/lQNfRfUXLa2TE=;
 b=TLe9Adjsw3HDgxO0Rdc65NS2gOcGJOhGIExev9wF82N9Qa+Va1d7ad5fEwqT946qGp
 cO++M4Yq3FlUFyA6C+QS6xIGMIuPBRhrxfobxTYdtoIp/mp5Gx97BRvjvCdkZELyTWE2
 hjsaTaBpg6WH56e7W/g8B65JF8tQtoCT2V2enMK+y3KaONmAhGATUvG0XXluar7Kl6Q6
 As3j2EImPLRU/IMqBA+gLjEY+Z+CiaxR2DiAalFgGlSs0O9KxXPF1a3+e59TQLBIKMy4
 n0Bmb8x58uzZWqa0k1euc2qNZVLUatI7W0gfVI7L+dywmBOVGp5lubAbbMRQ2VFD9jDh
 soNg==
X-Gm-Message-State: APjAAAW333H+7gq1bM+oKuM4QTU9ywTa6am9Nat2/9/jpvRgr03lYoG4
 nzZof2PVtUCzthRmMp4CfLYOIvdgIxr9+sZh4jXBZRxb6Rjxzrmm2Sha+KbgOojNLj+jPLDfv0X
 pdKUblAqiShv7NMo=
X-Received: by 2002:adf:df03:: with SMTP id y3mr12413898wrl.260.1576229370878; 
 Fri, 13 Dec 2019 01:29:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqygdzoBRHtuUk90UyuZ1Rw7xU80dCGFwSdNb10LcB+FlZU7HVAg9sllEg5pWYX68Zd37ltiCw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr12413858wrl.260.1576229370458; 
 Fri, 13 Dec 2019 01:29:30 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id h127sm10132626wme.31.2019.12.13.01.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 01:29:29 -0800 (PST)
Subject: Re: [PATCH v26 20/21] Add rx-softmmu
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20191014115757.51866-1-ysato@users.sourceforge.jp>
 <20191014115757.51866-21-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9aba318c-48fb-1768-30b6-a70696f37d04@redhat.com>
Date: Fri, 13 Dec 2019 10:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191014115757.51866-21-ysato@users.sourceforge.jp>
Content-Language: en-US
X-MC-Unique: _9A5ORI7NRiv-hI1qQ9L1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 1:57 PM, Yoshinori Sato wrote:
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Message-Id: <20190607091116.49044-17-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> pick ed65c02993 target/rx: Add RX to SysEmuTarget
> pick 01372568ae tests: Add rx to machine-none-test.c
> [PMD: Squashed patches from Richard Henderson modifying
>        qapi/common.json and tests/machine-none-test.c]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   configure                      | 8 ++++++++
>   default-configs/rx-softmmu.mak | 3 +++
>   qapi/machine.json              | 3 ++-
>   include/exec/poison.h          | 1 +
>   include/sysemu/arch_init.h     | 1 +
>   arch_init.c                    | 2 ++
>   tests/machine-none-test.c      | 1 +
>   hw/Kconfig                     | 1 +
>   8 files changed, 19 insertions(+), 1 deletion(-)
>   create mode 100644 default-configs/rx-softmmu.mak
>=20
> diff --git a/configure b/configure
> index 08ca4bcb46..fa5d4274b6 100755
> --- a/configure
> +++ b/configure
> @@ -7521,6 +7521,11 @@ case "$target_name" in
>       mttcg=3Dyes
>       gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bi=
t-csr.xml"
>     ;;
> +  rx)
> +    TARGET_ARCH=3Drx
> +    bflt=3D"yes"
> +    target_compiler=3D$cross_cc_rx
> +  ;;
>     sh4|sh4eb)
>       TARGET_ARCH=3Dsh4
>       bflt=3D"yes"
> @@ -7702,6 +7707,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>     riscv*)
>       disas_config "RISCV"
>     ;;
> +  rx)
> +    disas_config "RX"
> +  ;;
>     s390*)
>       disas_config "S390"
>     ;;
> diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.=
mak
> new file mode 100644
> index 0000000000..a3eecefb11
> --- /dev/null
> +++ b/default-configs/rx-softmmu.mak
> @@ -0,0 +1,3 @@
> +# Default configuration for rx-softmmu
> +
> +CONFIG_RX_VIRT=3Dy
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..4409c113c2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,6 +21,7 @@
>   #        is true even for "qemu-system-x86_64".
>   #
>   # ppcemb: dropped in 3.1
> +# rx: added in 4.2

Richard, if you take this series, do you mind changing 4.2 -> 5.0?

>   #
>   # Since: 3.0
>   ##
> @@ -28,7 +29,7 @@
>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>                'x86_64', 'xtensa', 'xtensaeb' ] }
>  =20
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 955eb863ab..7b9ac361dc 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -26,6 +26,7 @@
>   #pragma GCC poison TARGET_PPC
>   #pragma GCC poison TARGET_PPC64
>   #pragma GCC poison TARGET_ABI32
> +#pragma GCC poison TARGET_RX
>   #pragma GCC poison TARGET_S390X
>   #pragma GCC poison TARGET_SH4
>   #pragma GCC poison TARGET_SPARC
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4cf1..6c011acc52 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>       QEMU_ARCH_NIOS2 =3D (1 << 17),
>       QEMU_ARCH_HPPA =3D (1 << 18),
>       QEMU_ARCH_RISCV =3D (1 << 19),
> +    QEMU_ARCH_RX =3D (1 << 20),
>   };
>  =20
>   extern const uint32_t arch_type;
> diff --git a/arch_init.c b/arch_init.c
> index 0a1531124c..7a37fb2c34 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -73,6 +73,8 @@ int graphic_depth =3D 32;
>   #define QEMU_ARCH QEMU_ARCH_PPC
>   #elif defined(TARGET_RISCV)
>   #define QEMU_ARCH QEMU_ARCH_RISCV
> +#elif defined(TARGET_RX)
> +#define QEMU_ARCH QEMU_ARCH_RX
>   #elif defined(TARGET_S390X)
>   #define QEMU_ARCH QEMU_ARCH_S390X
>   #elif defined(TARGET_SH4)
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..8bb54a6360 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] =3D {
>       { "hppa", "hppa" },
>       { "riscv64", "rv64gcsu-v1.10.0" },
>       { "riscv32", "rv32gcsu-v1.9.1" },
> +    { "rx", "rx62n" },
>   };
>  =20
>   static const char *get_cpu_model_by_arch(const char *arch)
> diff --git a/hw/Kconfig b/hw/Kconfig
> index b45db3c813..77bbc59cc7 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -54,6 +54,7 @@ source nios2/Kconfig
>   source openrisc/Kconfig
>   source ppc/Kconfig
>   source riscv/Kconfig
> +source rx/Kconfig
>   source s390x/Kconfig
>   source sh4/Kconfig
>   source sparc/Kconfig
>=20


