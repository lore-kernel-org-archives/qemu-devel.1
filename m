Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E80C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6A22168B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjPJGPMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6A22168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLf2-0004Zl-CB
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaKyi-00005T-S1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaKye-0001aY-3Y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:41:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaKyc-0001Vb-TI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574952059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TKlTX6HFnw2gyDnrdDUfSY3uCJDvk1E1h4HaRELYzeA=;
 b=GjPJGPMAcW4CHe0YcUQhoq7Nck0rUEZm6KF/Ii0ZdLf6K1HXGlEvSV9tnmBRqY5LfbjniQ
 Bl86eMHo0+phG+huk2vCADoOArvl4PhsfhhC5Bsc/qIHp5R1bBmeM6trehyKjTJpsl8qCu
 CkQ/LICfmBs1e1xmh2GptN3Ox9dvQ0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-P2UO5UKYO3mcw-koXhPV1Q-1; Thu, 28 Nov 2019 09:40:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA8519057A0;
 Thu, 28 Nov 2019 14:40:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69FBC19C4F;
 Thu, 28 Nov 2019 14:40:52 +0000 (UTC)
Subject: Re: [PATCH 13/15] s390x: protvirt: Move diag 308 data over SIDAD
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-14-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ad100b6-db72-4a21-6715-399a6ff69dc0@redhat.com>
Date: Thu, 28 Nov 2019 15:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-14-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: P2UO5UKYO3mcw-koXhPV1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> For protected guests the IPIB is written/read to/from the sattelite

satellite

> block, so we need to make those accesses virtual to make them go
> through KBM mem ops.

What's KBM ?

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/diag.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index db6d79cef3..d96d8bdc6c 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -88,6 +88,7 @@ static int diag308_parm_check(CPUS390XState *env, uint6=
4_t r1, uint64_t addr,
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintp=
tr_t ra)
>  {
>      CPUState *cs =3D env_cpu(env);
> +    S390CPU *cpu =3D S390_CPU(cs);
>      uint64_t addr =3D  env->regs[r1];
>      uint64_t subcode =3D env->regs[r3];
>      IplParameterBlock *iplb;
> @@ -118,14 +119,27 @@ void handle_diag_308(CPUS390XState *env, uint64_t r=
1, uint64_t r3, uintptr_t ra)
>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> +
>          iplb =3D g_new0(IplParameterBlock, 1);
> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        if (!env->pv) {
> +            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        } else {
> +            s390_cpu_virt_mem_read(cpu, 0, 0, iplb, sizeof(iplb->len));
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);

I'm looking forward to protected virt support in TCG ;-)

> +        }
> +
>          if (!iplb_valid_len(iplb)) {
>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>              goto out;
>          }
> =20
> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +        if (!env->pv) {
> +            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len))=
;
> +        } else {
> +            s390_cpu_virt_mem_read(cpu, 0, 0, iplb, be32_to_cpu(iplb->le=
n));
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        }
> +
> =20
>          if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
>              !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >=3D 0=
)) {
> @@ -149,7 +163,13 @@ out:
>              iplb =3D s390_ipl_get_iplb();
>          }
>          if (iplb) {
> -            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len)=
);
> +            if (!env->pv) {
> +                cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->=
len));
> +            } else {
> +                s390_cpu_virt_mem_write(cpu, 0, 0, iplb,
> +                                        be32_to_cpu(iplb->len));
> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            }
>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>          } else {
>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>=20

I wonder whether we maybe want to have some wrapper functions for these
reads and writes, something like:

void s390_cpu_physical_memory_write(...)
{
    if (!env->pv) {
        cpu_physical_memory_write(...);
    } else {
        s390_cpu_virt_mem_write(...);
    }
}

?

 Thomas


