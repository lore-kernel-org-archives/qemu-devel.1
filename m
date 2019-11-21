Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0642071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/MTBlzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0642071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnbT-0005s5-JN
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXnZd-00042p-1G
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXnZb-0004bH-Lu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:36:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXnZb-0004b1-Iq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574347003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T47q2Zqo4Aq/PPyyOY8Fcg06Rz6zwfofsZ+iYd1k9Zg=;
 b=O/MTBlzfS8UzCf8kOvvErZOnjofEZuIazk4UojUKGckmo+rJNySttUkYjMB2vtgc/HLKDX
 6jbMecCSP84FL6lp2Kc3UMRiP9+rXvs1734MC0htbjuuaWg2GVvXbY6FW3/r0b8i+U9d6a
 ylrlaHCTXdI5EvLSxvIsxr2c+/mgJbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-JGMTXUZPNtuhqpUxCD7yFw-1; Thu, 21 Nov 2019 09:36:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 936691800D45;
 Thu, 21 Nov 2019 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 116E76E70F;
 Thu, 21 Nov 2019 14:36:33 +0000 (UTC)
Subject: Re: [PATCH 03/15] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9f9d9b6b-55e5-fe69-d6c2-f7c229b4021a@redhat.com>
Date: Thu, 21 Nov 2019 15:36:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-4-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JGMTXUZPNtuhqpUxCD7yFw-1
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
>=20
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
>=20
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
>=20
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d4813105db..7b8a493509 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>  #include "cpu.h"
>  #include "hw/qdev-core.h"
> =20
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;
> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved[84];
> +    uint8_t  reserved67[3];

What does the "67" mean here?

> +    uint8_t  version;
> +    uint32_t num_comp;
> +    uint64_t pv_header_addr;
> +    uint64_t pv_header_len;
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;

Given the fact that we had quite some headaches with QEMU_PACKED structs
in the past already, and the structs seem to be naturally aligned ...
what about dropping the QEMU_PACKED here and using QEMU_BUILD_BUG() to
assert that the struct has the correct size?

[...]
> @@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlock =
*iplb)
>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>  }
> =20
> +static inline bool iplb_valid_se(IplParameterBlock *iplb)
> +{
> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
> +}
> +
> +

Drop one empty line?

>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 067c667ba7..32049bb4ee 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -52,6 +52,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, ui=
nt64_t r3)
>  #define DIAG_308_RC_OK              0x0001
>  #define DIAG_308_RC_NO_CONF         0x0102
>  #define DIAG_308_RC_INVALID         0x0402
> +#define DIAG_308_RC_NO_PV_CONF      0x0a02
> +#define DIAG_308_RC_INV_FOR_PV      0x0b02
> =20
>  #define DIAG308_RES_MOD_CLR=09=090
>  #define DIAG308_RES_LOAD_NORM=09=091
> @@ -59,6 +61,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, ui=
nt64_t r3)
>  #define DIAG308_LOAD_NORMAL_DUMP=094
>  #define DIAG308_SET=09=09=095
>  #define DIAG308_STORE=09=09=096
> +#define DIAG308_PV_SET=09=09=098
> +#define DIAG308_PV_STORE=09=099
> +#define DIAG308_PV_START=09=0910
> =20
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t =
addr,
>                                uintptr_t ra, bool write)
> @@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
>      case DIAG308_SET:
> +    case DIAG308_PV_SET: /* Set SE parms */
>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> @@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
> =20
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> =20
> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
> +            !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >=3D 0=
)) {
>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>              goto out;
>          }
> @@ -128,10 +135,15 @@ out:
>          g_free(iplb);
>          return;
>      case DIAG308_STORE:
> +    case DIAG308_PV_STORE: /* Get SE parms */
>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> -        iplb =3D s390_ipl_get_iplb();
> +        if (subcode =3D=3D DIAG308_PV_STORE) {
> +            iplb =3D s390_ipl_get_iplb_secure();
> +        } else {
> +            iplb =3D s390_ipl_get_iplb();
> +        }
>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len)=
);
>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
> @@ -139,6 +151,16 @@ out:
>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>          }
>          return;
> +        break;

<hamletmode>
To return or to break, that's the question...
</hamletmode>

... please choose one of the two.

> +    case DIAG308_PV_START: /* SE start */
> +        iplb =3D s390_ipl_get_iplb_secure();
> +        if (!iplb_valid_se(iplb)) {
> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;
>=20

 Thomas


