Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C485FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC752084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeTDHqQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC752084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTL9-000737-Nr
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icSwQ-0005hn-Bn
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icSwH-0005wo-Eh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:35:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icSwF-0005gK-BC
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575459318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=W394iKNjpXdEgwRChIc0d0VVfOTGU/iFjjrC+xpUYjA=;
 b=WeTDHqQ9NLyr7jMHixUJ6WX+VsPd3h6XFWMhG1rML5AdC958GKJUIG/gc/qOFK1GfyNjrA
 j2aCm7Bao2lfbQbl+2PrfoD90nImau3LG1dMnJ6xl1WSoXZHa00J7yA+MCJKPCTLerFY9M
 CfYzGkGNaCzvHzalJ+IL+JqexOx4ReE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-v9jZYNNxP_K2TgA6uQg8Og-1; Wed, 04 Dec 2019 06:35:17 -0500
X-MC-Unique: v9jZYNNxP_K2TgA6uQg8Og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631698BE7DF;
 Wed,  4 Dec 2019 11:35:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A50471036C61;
 Wed,  4 Dec 2019 11:34:47 +0000 (UTC)
Subject: Re: [PATCH v2 03/13] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-4-frankja@linux.ibm.com>
 <3f891828-f7d1-91a4-08de-71ac2ed00ad1@redhat.com>
 <a58e50cf-ebbe-fc83-6405-592617e05d1e@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d0c17ceb-3c45-7754-0750-a3c75682f346@redhat.com>
Date: Wed, 4 Dec 2019 12:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a58e50cf-ebbe-fc83-6405-592617e05d1e@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ls6QG0VpCOToF61IYR6gyjiuVHNFRyyMI"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ls6QG0VpCOToF61IYR6gyjiuVHNFRyyMI
Content-Type: multipart/mixed; boundary="0nsHP4Cyt6LHUssonKr3V4CSy6QDtGgbT";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Message-ID: <d0c17ceb-3c45-7754-0750-a3c75682f346@redhat.com>
Subject: Re: [PATCH v2 03/13] s390x: protvirt: Support unpack facility
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-4-frankja@linux.ibm.com>
 <3f891828-f7d1-91a4-08de-71ac2ed00ad1@redhat.com>
 <a58e50cf-ebbe-fc83-6405-592617e05d1e@linux.ibm.com>
In-Reply-To: <a58e50cf-ebbe-fc83-6405-592617e05d1e@linux.ibm.com>

--0nsHP4Cyt6LHUssonKr3V4CSy6QDtGgbT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/12/2019 12.32, Janosch Frank wrote:
> On 12/4/19 11:48 AM, Thomas Huth wrote:
>> On 29/11/2019 10.47, Janosch Frank wrote:
>>> When a guest has saved a ipib of type 5 and call diagnose308 with
>>> subcode 10, we have to setup the protected processing environment via
>>> Ultravisor calls. The calls are done by KVM and are exposed via an API.
>>>
>>> The following steps are necessary:
>>> 1. Create a VM (register it with the Ultravisor)
>>> 2. Create secure CPUs for all of our current cpus
>>> 3. Forward the secure header to the Ultravisor (has all information on
>>> how to decrypt the image and VM information)
>>> 4. Protect image pages from the host and decrypt them
>>> 5. Verify the image integrity
>>>
>>> Only after step 5 a protected VM is allowed to run.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>> [...]
>>> +++ b/hw/s390x/pv.c
>>> @@ -0,0 +1,118 @@
>>> +/*
>>> + * Secure execution functions
>>> + *
>>> + * Copyright IBM Corp. 2019
>>> + * Author(s):
>>> + *  Janosch Frank <frankja@linux.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
>>> + * your option) any later version. See the COPYING file in the top-lev=
el
>>> + * directory.
>>> + */
>>> +#include "qemu/osdep.h"
>>> +#include <sys/ioctl.h>
>>> +
>>> +#include <linux/kvm.h>
>>> +
>>> +#include "qemu/error-report.h"
>>> +#include "sysemu/kvm.h"
>>> +#include "pv.h"
>>> +
>>> +static int s390_pv_cmd(uint32_t cmd, void *data)
>>> +{
>>> +    int rc;
>>> +    struct kvm_pv_cmd pv_cmd =3D {
>>> +        .cmd =3D cmd,
>>> +        .data =3D (uint64_t)data,
>>> +    };
>>> +
>>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>>> +    if (rc) {
>>> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc);
>>> +        exit(1);
>>> +    }
>>> +    return rc;
>>> +}
>>> +
>>> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
>>> +{
>>> +    int rc;
>>> +    struct kvm_pv_cmd pv_cmd =3D {
>>> +        .cmd =3D cmd,
>>> +        .data =3D (uint64_t)data,
>>> +    };
>>> +
>>> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
>>> +    if (rc) {
>>> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd,=
 rc);
>>> +        exit(1);
>>> +    }
>>> +    return rc;
>>> +}
>>> +
>>> +int s390_pv_vm_create(void)
>>> +{
>>> +    return s390_pv_cmd(KVM_PV_VM_CREATE, NULL);
>>> +}
>>> +
>>> +int s390_pv_vm_destroy(void)
>>> +{
>>> +    return s390_pv_cmd(KVM_PV_VM_DESTROY, NULL);
>>> +}
>>> +
>>> +int s390_pv_vcpu_create(CPUState *cs)
>>> +{
>>> +    return s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
>>> +}
>>> +
>>> +int s390_pv_vcpu_destroy(CPUState *cs)
>>> +{
>>> +    S390CPU *cpu =3D S390_CPU(cs);
>>> +    CPUS390XState *env =3D &cpu->env;
>>> +    int rc;
>>> +
>>> +    rc =3D s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_DESTROY, NULL);
>>> +    if (!rc) {
>>> +        env->pv =3D false;
>>> +    }
>>> +    return rc;
>>> +}
>>> +
>>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>>> +{
>>> +    struct kvm_s390_pv_sec_parm args =3D {
>>> +        .origin =3D origin,
>>> +        .length =3D length,
>>> +    };
>>> +
>>> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
>>> +}
>>> +
>>> +/*
>>> + * Called for each component in the SE type IPL parameter block 0.
>>> + */
>>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
>>> +{
>>> +    struct kvm_s390_pv_unp args =3D {
>>> +        .addr =3D addr,
>>> +        .size =3D size,
>>> +        .tweak =3D tweak,
>>> +    };
>>> +
>>> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
>>> +}
>>> +
>>> +int s390_pv_perf_clear_reset(void)
>>> +{
>>> +    return s390_pv_cmd(KVM_PV_VM_PERF_CLEAR_RESET, NULL);
>>> +}
>>> +
>>> +int s390_pv_verify(void)
>>> +{
>>> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
>>> +}
>>> +
>>> +int s390_pv_unshare(void)
>>> +{
>>> +    return s390_pv_cmd(KVM_PV_VM_UNSHARE, NULL);
>>> +}
>>> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
>>> new file mode 100644
>>> index 0000000000..eb074e4bc9
>>> --- /dev/null
>>> +++ b/hw/s390x/pv.h
>>> @@ -0,0 +1,26 @@
>>> +/*
>>> + * Protected Virtualization header
>>> + *
>>> + * Copyright IBM Corp. 2019
>>> + * Author(s):
>>> + *  Janosch Frank <frankja@linux.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
>>> + * your option) any later version. See the COPYING file in the top-lev=
el
>>> + * directory.
>>> + */
>>> +
>>> +#ifndef HW_S390_PV_H
>>> +#define HW_S390_PV_H
>>> +
>>> +int s390_pv_vm_create(void);
>>> +int s390_pv_vm_destroy(void);
>>> +int s390_pv_vcpu_destroy(CPUState *cs);
>>> +int s390_pv_vcpu_create(CPUState *cs);
>>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
>>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>>> +int s390_pv_perf_clear_reset(void);
>>> +int s390_pv_verify(void);
>>> +int s390_pv_unshare(void);
>>
>> I still think you should make all those functions returning "void"
>> instead of "int" - since errors results in an exit() in s390_pv_cmd()
>> and s390_pv_cmd_vcpu() anyway...
>=20
> Hey Thomas,
>=20
> I have requested an error code for diag 308 subcode 10 that tells the
> VM, that we didn't succeed starting a secure guest. Once that is in
> place, I'll need to check the return codes.

Ok, but then the exit()s need to go away, I assume?

 Thomas


--0nsHP4Cyt6LHUssonKr3V4CSy6QDtGgbT--

--ls6QG0VpCOToF61IYR6gyjiuVHNFRyyMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl3nmdUACgkQLtnXdP5w
LbXZSA//R4HTgNAqJrIug9rNedE0SzCBOCW8ISdTdtCeTFcKOL4dHz3hmJO5bIxW
+tl5XkReLVFoddNYF29Ca6o/Z5A12uDR9pSbIlV7KLoROX9eLwhfGG/7o7u0ue5O
4pSOp/h8CTiPNwZTKbbU0KUO51rgJXHjqDS46u+3PiO2NhMotu5SaakQR9isEDRa
tKB97sY2gUVlwGBVghwTgTAQsZXRGlFPgrGlpRZKO9fTSMmXD+gByqF5cl21ktUD
mkFce9NX7aXyAhLaeUZKJLnL0O2WY1lV72Cjyou0qw4tyVN5lqvjqYVT4PLz8ytd
2JGvC0s95xwd0lClugjjdsl17Sb+RAi7D6o29tWsLlXoCAx/4WnRf/2NleZJvmGI
AxwXV3ZRqEBLRC1COtKlolhbABDHM5VWmxXt78mudtLcEyUl2I7T2+5YBSQ2NCV1
Fs/0uQkE4w1Xp3o0ObZY/I6ycdKFDZOuLNQHtnuss/JrVHU98Wi8ddFdGC8/jRnx
demU8zS5RobFo8+KF5EmYEQMkGckaZZ+CHdGMwC/DXmslRBp2B/5WCfp4nXT34Zj
hBxfcE73UuL6xRhSGO/vnnbVHvZ+ahs3aHW5Avm9VIU2nzkga+JYpSSvRwphs3az
RrKoRnklWB2ZdSH1zl1FyL/c1AMjNb2TL9E3Q/sOUql1dV/hIJk=
=i9tP
-----END PGP SIGNATURE-----

--ls6QG0VpCOToF61IYR6gyjiuVHNFRyyMI--


