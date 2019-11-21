Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B6920679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1J6jiBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmsR-0002jO-TV
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXmqk-0001OF-7P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXmqh-0002QM-39
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:50:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXmqg-0002PQ-Tg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=843rk/hvHKTUdND560tL1cPITIt9NEEhwK3/nwRPi5s=;
 b=B1J6jiBU6j35VlAwtkewLkAAO5ZFpgZYaZO5V+2NmHBz2/5RP80UwRslIWQyHMoXeV+/gP
 m7Nqm/bX/Gjnh3XW4nRXedXxwIjJEodl7T5Bb5dOmFC8Ptlfieb4S14f8tkyGVasfBO/Dj
 nPyix4BLCB1y9RuyjxLKwAExWAmHPno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-eZoAQ1QSM5ac1mqOijSe_A-1; Thu, 21 Nov 2019 08:50:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F32107ACC4;
 Thu, 21 Nov 2019 13:50:13 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95C6B692AB;
 Thu, 21 Nov 2019 13:50:03 +0000 (UTC)
Date: Thu, 21 Nov 2019 14:50:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 07/15] s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
Message-ID: <20191121145001.5e7a182d.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-8-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-8-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eZoAQ1QSM5ac1mqOijSe_A-1
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

On Wed, 20 Nov 2019 06:43:26 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Now that we know the protection state off the cpus, we can start
> handling all diag 308 subcodes in the protected state.

"As we now have access to the protection state of the cpus, we can
implement special handling of diag 308 subcodes for cpus in the
protected state."

?

>=20
> For subcodes 0 and 1 we need to unshare all pages before continuing,
> so the guest doesn't accidently expose data when dumping.
>=20
> For subcode 3/4 we tear down the protected VM and reboot into
> unprotected mode. We do not provide a secure reboot.
>=20
> Before we can do the unshare calls, we need to mark all cpus as
> stopped.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 30 +++++++++++++++++++++++++++---
>  target/s390x/diag.c        |  4 ++++
>  2 files changed, 31 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7262453616..6fd50b4c42 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -319,11 +319,26 @@ static inline void s390_do_cpu_ipl(CPUState *cs, ru=
n_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
> =20
> +static void s390_pv_prepare_reset(CPUS390XState *env)
> +{
> +    CPUState *cs;
> +
> +    if (!env->pv) {
> +        return;
> +    }
> +    CPU_FOREACH(cs) {
> +        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
> +    }
> +    s390_pv_unshare();
> +    s390_pv_perf_clear_reset();
> +}
> +
>  static void s390_machine_reset(MachineState *machine)
>  {
>      enum s390_reset reset_type;
>      CPUState *cs, *t;
>      S390CPU *cpu;
> +    CPUS390XState *env;
> =20
>      /* get the reset parameters, reset them once done */
>      s390_ipl_get_reset_request(&cs, &reset_type);
> @@ -332,29 +347,38 @@ static void s390_machine_reset(MachineState *machin=
e)
>      s390_cmma_reset();
> =20
>      cpu =3D S390_CPU(cs);
> +    env =3D &cpu->env;
> =20
>      switch (reset_type) {
>      case S390_RESET_MODIFIED_CLEAR:  /* Subcode 0 */
> +        subsystem_reset();
> +        s390_crypto_reset();
> +        s390_pv_prepare_reset(env);
>          CPU_FOREACH(t) {
>              run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>          }
> -        subsystem_reset();
> -        s390_crypto_reset();

This also switches the order in which different parts are reset for
normal guests. I presume that order doesn't matter here?

>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
>      case S390_RESET_LOAD_NORMAL: /* Subcode 1*/

missing blank before */ (introduced in a previous patch)


> +        subsystem_reset();
> +        s390_pv_prepare_reset(env);
>          CPU_FOREACH(t) {
>              if (t =3D=3D cs) {
>                  continue;
>              }
>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>          }
> -        subsystem_reset();
>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
>      case S390_RESET_EXTERNAL:

Annotate this with the subcode as well? (in the patch introducing it)

>      case S390_RESET_REIPL: /* Subcode 4 */
> +        if (env->pv) {
> +            CPU_FOREACH(t) {
> +                s390_pv_vcpu_destroy(t);
> +            }
> +            s390_pv_vm_destroy();
> +        }
>          qemu_devices_reset();
>          s390_crypto_reset();
>          /* configure and start the ipl CPU only */
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 32049bb4ee..db6d79cef3 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -68,6 +68,10 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, u=
int64_t r3)
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t =
addr,
>                                uintptr_t ra, bool write)
>  {
> +    /* Handled by the Ultravisor */
> +    if (env->pv) {
> +        return 0;
> +    }
>      if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return -EINVAL;


