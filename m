Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5CDC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D11820848
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="achWDeH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D11820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ion91-0008Ow-Qe
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomVZ-0004Rj-LZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomVX-0007Dm-Up
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:54:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomVX-0007D9-RW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjodyhE9M9oMNhZED49rT8Ro16OowE6OEG/lcmHdm+4=;
 b=achWDeH1FO5tPr6SRl+uP8IdAOVZ7+uASQ1EDXYaH105dryytstl86YDiZKtHNpl+/hsZU
 /5D6h/XIHfPdZyl6lxlOthkjWI28Zo74+hOtdas3LQMMfElW03Ggjeu2NDX1DXyZkhLg1i
 LDtzOBf4mdkz1uqPUBFwVDxXImQy7CY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-x5di-fJAPF2gZ6ztStcMCg-1; Tue, 07 Jan 2020 05:54:42 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so28470176wrt.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5457hFrQC5z9kErgtWtmvH8rSFNPXA9e5vzM+pY/1rY=;
 b=Z3vJqVpYYAhkdMn5cyxtX+fR2D0V4kMi9NLGIe3RQ4N6hnIIcUAryEoNQA9FqagMzs
 OGaZfwHZin8nAyrqkEBan8oXplo9V9K9JAmKNPB6gbb6YPk1U8WT//hZ4zTKdpZ42/6h
 z5LOUG/Mr4gdHGCOaFwoBOtvO8v89lLpo+E9VVJvBpimyQOs554RDVCH+/OmtrpaIWrV
 /hgNN/nKpkjOnIzyZnHBVT4uEYWclq4XCOuNIVsoUmqhJ4iqS8qFH4k0FdwI41op8IjP
 8663chGFuULkINhfpqtza1zeTjPkqEAAb0N1Abi7a2Kh0E7MdFI/lcCLNLICfOkzgTsa
 MF+Q==
X-Gm-Message-State: APjAAAXKrqxvkzc1MaKsTRqrjBtEYYKqYLrhOX+j/xK6FW10ZJcg57mc
 DMka3AZB6v49LS8nQ5cB1N6Dnqlterq/DZAAhiIbmc048TEkjIqp89oQrC4ZyKxFmhpk57YAJhB
 Pw44/VzHgEPcOh3I=
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr40202739wmg.146.1578394480659; 
 Tue, 07 Jan 2020 02:54:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxveQL3hZ2QnDilbrDEMNPP9vZyLZC+g3A3mQqLxulCBFmSQCH9Ui3lRCyB0gmc8tBAU61G8Q==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr40202714wmg.146.1578394480338; 
 Tue, 07 Jan 2020 02:54:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id f1sm76414366wru.6.2020.01.07.02.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:54:39 -0800 (PST)
Subject: Re: [PATCH v2 2/4] tcg: Search includes in the parent source directory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200101112303.20724-1-philmd@redhat.com>
 <20200101112303.20724-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f298aa7f-d9bf-36ea-ffdf-b07e02fe6575@redhat.com>
Date: Tue, 7 Jan 2020 11:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200101112303.20724-3-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: x5di-fJAPF2gZ6ztStcMCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/01/20 12:23, Philippe Mathieu-Daud=C3=A9 wrote:
> All the *.inc.c files included by tcg/$TARGET/tcg-target.inc.c
> are in tcg/, their parent directory. To simplify the preprocessor
> search path, include the relative parent path: '..'.
>=20
> Patch created mechanically by running:
>=20
>   $ for x in tcg-pool.inc.c tcg-ldst.inc.c; do \
>     sed -i "s,#include \"$x\",#include \"../$x\"," \
>       $(git grep -l "#include \"$x\""); \
>     done
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Another possibility is to move the .inc.c files to include/tcg (probably
renaming them to .inc.h in the meanwhile) but this is good too.

Paolo

> ---
>  tcg/aarch64/tcg-target.inc.c | 4 ++--
>  tcg/arm/tcg-target.inc.c     | 4 ++--
>  tcg/i386/tcg-target.inc.c    | 4 ++--
>  tcg/mips/tcg-target.inc.c    | 2 +-
>  tcg/ppc/tcg-target.inc.c     | 4 ++--
>  tcg/riscv/tcg-target.inc.c   | 4 ++--
>  tcg/s390/tcg-target.inc.c    | 4 ++--
>  tcg/sparc/tcg-target.inc.c   | 2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 3f921015d3..843fd0ca69 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -10,7 +10,7 @@
>   * See the COPYING file in the top-level directory for details.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
>  #include "qemu/bitops.h"
> =20
>  /* We're going to re-use TCGType in setting of the SF bit, which control=
s
> @@ -1541,7 +1541,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext=
, TCGReg d,
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     TCGMemOpIdx oi, uintptr_t ra)
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 94d80d79d1..fffb6611e2 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "elf.h"
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  int arm_arch =3D __ARM_ARCH;
> =20
> @@ -1131,7 +1131,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TC=
GArg *args,
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 9d8ed974e0..cdedcb2b25 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
> @@ -1647,7 +1647,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 5442167045..1da663ce84 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1107,7 +1107,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_un=
it *arg)
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  static void * const qemu_ld_helpers[16] =3D {
>      [MO_UB]   =3D helper_ret_ldub_mmu,
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index d308d69aba..ee1f9227c1 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "elf.h"
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #if defined _CALL_DARWIN || defined __APPLE__
>  #define TCG_TARGET_CALL_DARWIN
> @@ -1845,7 +1845,7 @@ static const uint32_t qemu_exts_opc[4] =3D {
>  };
> =20
>  #if defined (CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
>   *                                 int mmu_idx, uintptr_t ra)
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 7018509693..2bc0ba71f2 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -27,7 +27,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
> @@ -921,7 +921,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>   */
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     TCGMemOpIdx oi, uintptr_t ra)
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 8aaa4cebe8..b07e9ff7d6 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -29,7 +29,7 @@
>  #error "unsupported code generation mode"
>  #endif
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
>  #include "elf.h"
> =20
>  /* ??? The translation blocks produced by TCG are generally small enough=
 to
> @@ -1536,7 +1536,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, M=
emOp opc, TCGReg data,
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* We're expecting to use a 20-bit negative offset on the tlb memory ops=
.  */
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d7986cda5c..65fddb310d 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
>=20


