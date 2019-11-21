Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCADE2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfbNjHQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCADE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnDi-0000Sa-Sp
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXnBJ-0006It-N8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXnBH-0006B3-E6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:11:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXnBH-0006AS-8I
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574345493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQYCUa9bljjrO3Jb+kS72aFEkgAxJaKCWRx6bz1n6eo=;
 b=bfbNjHQLhZ4mqH9mzq+oaE6/mOeaOzb/q9B4Be+VOHOh2hBVsLezCPl/50MIw/qXSs9ZGN
 v/4Xk0pU8vsoDL+pbpipMZunq4RXmqDeGbSY0VD6GQXPppIpIWRcvkKscjRXdf5Dw02mNv
 FDTx4E2q3gPwng8BIRWGO5okU0Zmd90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-BnPn4_q6MOmO8f_IEzRaag-1; Thu, 21 Nov 2019 09:11:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93DE6100550E;
 Thu, 21 Nov 2019 14:11:25 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B12D6CE76;
 Thu, 21 Nov 2019 14:11:21 +0000 (UTC)
Date: Thu, 21 Nov 2019 15:11:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 09/15] s390x: protvirt: SCLP interpretation
Message-ID: <20191121151118.4caa8523.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-10-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-10-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BnPn4_q6MOmO8f_IEzRaag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:28 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> SCLP for a protected guest is done over the SIDAD, so we need to use
> the s390_cpu_virt_mem_* functions to access the SIDAD instead of guest
> memory when reading/writing SCBs.
>=20
> To not confuse the sclp emulation, we set 0x42000 as the address, but
> ignore it for reading/writing the SCCB.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/sclp.c         | 16 ++++++++++++++++
>  include/hw/s390x/sclp.h |  2 ++
>  target/s390x/kvm.c      |  8 +++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index f57ce7b739..00d08adc7f 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -193,6 +193,22 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *scc=
b, uint32_t code)
>      }
>  }
> =20
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp =3D get_sclp_device();
> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len =3D sizeof(SCCB);
> +
> +    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_len)=
;
> +    sclp_c->execute(sclp, &work_sccb, code);
> +    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
> +                            be16_to_cpu(work_sccb.h.length));
> +    sclp_c->service_interrupt(sclp, sccb);
> +    return 0;
> +}
> +
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp =3D get_sclp_device();
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index c54413b78c..c0a3faa37d 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code);
> =20
>  #endif
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 58251c0229..0f2458b553 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1172,7 +1172,13 @@ static int kvm_sclp_service_call(S390CPU *cpu, str=
uct kvm_run *run,
>      sccb =3D env->regs[ipbh0 & 0xf];
>      code =3D env->regs[(ipbh0 & 0xf0) >> 4];
> =20
> -    r =3D sclp_service_call(env, sccb, code);
> +    if (run->s390_sieic.icptcode =3D=3D ICPT_PV_INSTR ||
> +        run->s390_sieic.icptcode =3D=3D ICPT_PV_INSTR_NOT) {
> +        r =3D sclp_service_call_protected(env, 0x42000, code);

I fear that confuses the reader instead of the emulation :)

Especially as you end up passing that value to
sclp_c->service_interrupt()...

> +    } else {
> +        r =3D sclp_service_call(env, sccb, code);
> +    }
> +
>      if (r < 0) {
>          kvm_s390_program_interrupt(cpu, -r);
>      } else {


