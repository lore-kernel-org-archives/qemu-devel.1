Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5874C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDA0208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUfmuInJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDA0208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbPY-0000hL-H1
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbOm-000084-C8
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbOl-0007Nm-A0
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:09:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbOl-0007NQ-6b
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569056986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=IrjdrZmZOhNi7iFeQbgynym/QgBv8C061CtjawhSCoY=;
 b=FUfmuInJMV8UgRQJM9q09GHuF5LUpBl34343oxOFW5JtXID3IX+Va1xND7KUXPizHgry8B
 Z9XQgFMF05u9bc6ohh1k1PuCLFX/tu34G4mh3nrdx/G7iNsLODZx4erjigzBLcY2k+GNic
 ouZkDdC3EwagBChc0aBW8Ng/WLCb3bg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-dEtHa5OpMVm5qU7OEqfnjw-1; Sat, 21 Sep 2019 05:09:45 -0400
Received: by mail-wm1-f70.google.com with SMTP id s25so2051353wmh.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 02:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nFjhIWtduZHQY94ch308hyAJWP3SBBzrxN5BCuK3sAU=;
 b=EX5qbnpuMUXRvNeFBLIQ4V6biLgmDMY3nHyTlVC2CMJkhz23FepA1nvClkrqbxOswz
 SKog7orQpUFF0n5DkZxeqcXQqaWM3btx4V63HSWZtWVhZgQuZji7G0UuVP1aKbfiQ6ee
 GgPXyzf2tUMVephzkgtmJbxWSuXYCTkUiF1GNMpLK0gEfCvb0gLDGNIStmwU1DqDTefd
 yfzy36/3sK7uZrvXxIkjr3OP1U75PUvsJ+s+4p/1OeG3J/PTBULS6Hy1ncIFa9+TIS58
 jd9mzIOggQWicczfTliCfMFHtYLcDz5KtPi196tyYA7M/9nzsW4L8FGi6ikZY1Qte2c7
 8TXw==
X-Gm-Message-State: APjAAAX0vYvqm1eHrFAvR22Fpu6k6yYbb4+z2v2xKemyA2x2HaLeKo8D
 DIQ8vV+syZU7cXnRFyRNQZmB/syE9Ssz4TkTToYZTCfdi7b+NOXN/SigCUSAjmr78XiABweGgC9
 1DakyzOWADfHsGn0=
X-Received: by 2002:a1c:d188:: with SMTP id i130mr6632685wmg.101.1569056984320; 
 Sat, 21 Sep 2019 02:09:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwB6ALck3NNsRbFvVJtz3CWgpQRc5Nua/T+hr0V3FtysjgqjpGk4No17ITW70l0lMHwZl6ZQA==
X-Received: by 2002:a1c:d188:: with SMTP id i130mr6632678wmg.101.1569056984157; 
 Sat, 21 Sep 2019 02:09:44 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q192sm5084554wme.23.2019.09.21.02.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 02:09:43 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v1 1/2] RISC-V: Handle bus errors in the page
 table walker
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1568762497.git.alistair.francis@wdc.com>
 <dfb8bc9fb7cad494d53f89774a3a4a5f3e478792.1568762497.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b4647794-d9d1-fc47-a14c-71b5f91a2835@redhat.com>
Date: Sat, 21 Sep 2019 11:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dfb8bc9fb7cad494d53f89774a3a4a5f3e478792.1568762497.git.alistair.francis@wdc.com>
Content-Language: en-US
X-MC-Unique: dEtHa5OpMVm5qU7OEqfnjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 1:22 AM, Alistair Francis wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>=20
> We directly access physical memory while walking the page tables on
> RISC-V, but while doing so we were using cpu_ld*() which does not report
> bus errors.  This patch converts the page table walker over to use
> address_space_ld*(), which allows bus errors to be detected.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6ece..c82e7ed52b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -169,7 +169,8 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      /* NOTE: the env->pc value visible here will not be
>       * correct, but the value visible to the exception handler
>       * (riscv_cpu_do_interrupt) is correct */
> -
> +    MemTxResult res;
> +    MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      int mode =3D mmu_idx;
> =20
>      if (mode =3D=3D PRV_M && access_type !=3D MMU_INST_FETCH) {
> @@ -256,11 +257,16 @@ restart:
>              1 << MMU_DATA_LOAD, PRV_S)) {
>              return TRANSLATE_PMP_FAIL;
>          }
> +
>  #if defined(TARGET_RISCV32)
> -        target_ulong pte =3D ldl_phys(cs->as, pte_addr);
> +        target_ulong pte =3D address_space_ldl(cs->as, pte_addr, attrs, =
&res);
>  #elif defined(TARGET_RISCV64)
> -        target_ulong pte =3D ldq_phys(cs->as, pte_addr);
> +        target_ulong pte =3D address_space_ldq(cs->as, pte_addr, attrs, =
&res);
>  #endif
> +        if (res !=3D MEMTX_OK) {
> +            return TRANSLATE_FAIL;
> +        }
> +
>          hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> =20
>          if (!(pte & PTE_V)) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


