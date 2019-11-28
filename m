Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1026EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3E221771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr6NST/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3E221771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLa3-00026R-WA
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaKSm-0007hc-RB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaKSe-0007oE-II
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:08:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaKSe-0007d3-D9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9IovY7Zm/jx6vaSCF+0uBvmDzAACSFaTJDzrlSPqkOU=;
 b=Kr6NST/1tOs0HYICCgKb/obixVBSa8iqahE/JlM1PMGDr/+UWGxxxVtzGHZCvRQNPTbk7h
 QETIAN59t0K/sqnmh3M0Q4F6DkNIc7JXwB4/dzCfhhrMZPyTQBQvwd71C1djj9tycVJYDr
 733InrCt+YTbwb7CN+2kHVrwkDI0QPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-1QnonueZPP6I_R4Ati5u7w-1; Thu, 28 Nov 2019 09:07:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B972107ACC9;
 Thu, 28 Nov 2019 14:07:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AD2360BE0;
 Thu, 28 Nov 2019 14:07:47 +0000 (UTC)
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b00e03a4-6ed8-f109-102a-dfb40009c8e5@redhat.com>
Date: Thu, 28 Nov 2019 15:07:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1QnonueZPP6I_R4Ati5u7w-1
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
> When a guest has saved a ipib of type 5 and call diagnose308 with
> subcode 10, we have to setup the protected processing environment via
> Ultravisor calls. The calls are done by KVM and are exposed via an API.
>=20
> The following steps are necessary:
> 1. Create a VM (register it with the Ultravisor)
> 2. Create secure CPUs for all of our current cpus
> 3. Forward the secure header to the Ultravisor (has all information on
> how to decrypt the image and VM information)
> 4. Protect image pages from the host and decrypt them
> 5. Verify the image integrity
>=20
> Only after step 5 a protected VM is allowed to run.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index a077926f36..50501fcd27 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -33,6 +33,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/option.h"
>  #include "exec/exec-all.h"
> +#include "pv.h"
> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -668,6 +669,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
> =20
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    int rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
> +                               ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].siz=
e),
> +                            ipib_pv->components[i].tweak_pref);
> +        if (rc) {
> +            return rc;
> +        }
> +    }
> +    return rc;
> +}

For both functions, s390_ipl_prepare_pv_header() and
s390_ipl_pv_unpack(), you're ignoring the return code at the calling
site, so errors go completely unnoticed. I suggest to either do an
error_report() here or at the calling site...

> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..0218070322
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,118 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2019
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +
> +#include <linux/kvm.h>
> +
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "pv.h"
> +
> +static int s390_pv_cmd(uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc);
> +        exit(1);
> +    }
> +    return rc;
> +}
> +
> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd, r=
c);
> +        exit(1);
> +    }
> +    return rc;
> +}

... or even better, since these functions exit on error anyway, make
these functions and all the others "void" instead?

 Thomas


