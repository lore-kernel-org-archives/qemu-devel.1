Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6435CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F13A20706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWc59/uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F13A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9ge-000544-CO
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY9fj-0004f0-5g
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY9fg-0003CE-V5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:12:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY9fg-0003Au-Qr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574431948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kSZmJ0vAM14nD8SzXPdgH7fgMSmDFXjwmogQBfg8yUM=;
 b=EWc59/uhWKeS250RJ0KBq5JKH7UZwYV7Jz6UsQrhFnK2py0QdJlEKjO6RAZUWhyGzJUpzL
 gis7+umrvPyrbvs/qrpo2mUCOpn49H3dGdFFbgaNMpLYjdRu/N7M07rvlN3K/cWJo5SBR4
 prUtjzg7vtI1zbi0iRYKc7cgO4NJcOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-RzNT21zPM1iAZ-mkyX-LnA-1; Fri, 22 Nov 2019 09:12:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1AC802690;
 Fri, 22 Nov 2019 14:12:23 +0000 (UTC)
Received: from [10.36.116.122] (ovpn-116-122.ams2.redhat.com [10.36.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 951925D9E1;
 Fri, 22 Nov 2019 14:12:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] s390x: Move reset normal to shared reset handler
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191122140002.42972-1-frankja@linux.ibm.com>
 <20191122140002.42972-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <72fabff0-c984-76aa-747c-69695f8e0920@redhat.com>
Date: Fri, 22 Nov 2019 15:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122140002.42972-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RzNT21zPM1iAZ-mkyX-LnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.11.19 14:59, Janosch Frank wrote:
> Let's start moving the cpu reset functions into a single function with
> a switch/case, so we can use fallthroughs and share more code between
> resets.
>=20
> This patch introduces the reset function by renaming cpu_reset() and
> cleaning up leftovers.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/cpu-qom.h |  6 +++++-
>  target/s390x/cpu.c     | 17 +++++++++++------
>  target/s390x/cpu.h     |  2 +-
>  target/s390x/sigp.c    |  2 +-
>  4 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index b809ec8418..f3b71bac67 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -34,6 +34,10 @@
>  typedef struct S390CPUModel S390CPUModel;
>  typedef struct S390CPUDef S390CPUDef;
> =20
> +typedef enum cpu_reset_type {
> +    S390_CPU_RESET_NORMAL,
> +} cpu_reset_type;
> +
>  /**
>   * S390CPUClass:
>   * @parent_realize: The parent class' realize handler.
> @@ -57,7 +61,7 @@ typedef struct S390CPUClass {
>      DeviceRealize parent_realize;
>      void (*parent_reset)(CPUState *cpu);
>      void (*load_normal)(CPUState *cpu);
> -    void (*cpu_reset)(CPUState *cpu);
> +    void (*reset)(CPUState *cpu, cpu_reset_type type);
>      void (*initial_cpu_reset)(CPUState *cpu);
>  } S390CPUClass;
> =20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd..cf13472472 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,18 +82,23 @@ static void s390_cpu_load_normal(CPUState *s)
>  }
>  #endif
> =20
> -/* S390CPUClass::cpu_reset() */
> -static void s390_cpu_reset(CPUState *s)
> +/* S390CPUClass::reset() */
> +static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>  {
>      S390CPU *cpu =3D S390_CPU(s);
>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>      CPUS390XState *env =3D &cpu->env;
> =20
> -    env->pfault_token =3D -1UL;
> -    env->bpbc =3D false;
>      scc->parent_reset(s);
>      cpu->env.sigp_order =3D 0;
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
> +
> +    switch (type) {
> +    case S390_CPU_RESET_NORMAL:
> +        env->pfault_token =3D -1UL;
> +        env->bpbc =3D false;
> +        break;
> +    }
>  }
> =20
>  /* S390CPUClass::initial_reset() */
> @@ -102,7 +107,7 @@ static void s390_cpu_initial_reset(CPUState *s)
>      S390CPU *cpu =3D S390_CPU(s);
>      CPUS390XState *env =3D &cpu->env;
> =20
> -    s390_cpu_reset(s);
> +    s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
>      /* initial reset does not clear everything! */
>      memset(&env->start_initial_reset_fields, 0,
>          offsetof(CPUS390XState, end_reset_fields) -
> @@ -473,7 +478,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>  #if !defined(CONFIG_USER_ONLY)
>      scc->load_normal =3D s390_cpu_load_normal;
>  #endif
> -    scc->cpu_reset =3D s390_cpu_reset;
> +    scc->reset =3D s390_cpu_reset;
>      scc->initial_cpu_reset =3D s390_cpu_initial_reset;
>      cc->reset =3D s390_cpu_full_reset;
>      cc->class_by_name =3D s390_cpu_class_by_name,
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 17460ed7b3..18123dfd5b 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -741,7 +741,7 @@ static inline void s390_do_cpu_reset(CPUState *cs, ru=
n_on_cpu_data arg)
>  {
>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
> =20
> -    scc->cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_NORMAL);
>  }
> =20
>  static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_da=
ta arg)
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 2ce22d4dc1..850139b9cd 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -266,7 +266,7 @@ static void sigp_cpu_reset(CPUState *cs, run_on_cpu_d=
ata arg)
>      SigpInfo *si =3D arg.host_ptr;
> =20
>      cpu_synchronize_state(cs);
> -    scc->cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_NORMAL);
>      cpu_synchronize_post_reset(cs);
>      si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>  }
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb


