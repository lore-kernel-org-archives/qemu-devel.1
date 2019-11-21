Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C73AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0583C206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvYBoJKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0583C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXn8f-0003Yq-5F
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXn78-0002Hb-Nl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXn76-0002UF-NE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:07:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXn76-0002To-Iu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574345235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkvZ1w22jHCmGzCKE7i29gRYzALFF0sEi7DXEkYPW8c=;
 b=DvYBoJKT2YzqY0mtxuGDK3aWwTXcraV4uKg2d6dnDO4rkRNUEMzwjlmvJu5nGjjwbRBF2k
 60NZ22YERMpdjp+bkHPncYI4bSki6blS75q+X60wzPHNtGTYQJ3dd06yEm+VCISQko64cP
 VTIE75kzs6Ky/d602SPxs2hibmw8ft8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-uiSBstdbM4iiFmxoI4OBNg-1; Thu, 21 Nov 2019 09:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23C281800D45;
 Thu, 21 Nov 2019 14:07:11 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3399A692AE;
 Thu, 21 Nov 2019 14:07:07 +0000 (UTC)
Date: Thu, 21 Nov 2019 15:07:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 08/15] s390x: protvirt: KVM intercept changes
Message-ID: <20191121150704.4d5a09ef.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-9-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-9-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: uiSBstdbM4iiFmxoI4OBNg-1
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

On Wed, 20 Nov 2019 06:43:27 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Secure guests no longer intercept with code 4 for an instruction
> interception. Instead they have codes 104 and 108 for secure
> instruction interception and secure instruction notification
> respectively.
>=20
> The 104 mirrors the 4, but the 108 is a notification, that something
> happened and the hypervisor might need to adjust its tracking data to
> that fact. An example for that is the set prefix notification
> interception, where KVM only reads the new prefix, but does not update
> the prefix in the state description.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 418154ccfe..58251c0229 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -115,6 +115,8 @@
>  #define ICPT_CPU_STOP                   0x28
>  #define ICPT_OPEREXC                    0x2c
>  #define ICPT_IO                         0x40
> +#define ICPT_PV_INSTR                   0x68
> +#define ICPT_PV_INSTR_NOT               0x6c

_NOTIF ?

> =20
>  #define NR_LOCAL_IRQS 32
>  /*
> @@ -151,6 +153,7 @@ static int cap_s390_irq;
>  static int cap_ri;
>  static int cap_gs;
>  static int cap_hpage_1m;
> +static int cap_protvirt;
> =20
>  static int active_cmma;
> =20
> @@ -336,6 +339,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
> +    cap_protvirt =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED);

You don't seem to do anything with this yet?

> =20
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
>              (long)cs->kvm_run->psw_addr);
>      switch (icpt_code) {
>          case ICPT_INSTRUCTION:
> +        case ICPT_PV_INSTR:
> +        case ICPT_PV_INSTR_NOT:
>              r =3D handle_instruction(cpu, run);

Doesn't handle_instruction() want to know whether it got a request for
emulation vs a notification?

>              break;
>          case ICPT_PROGRAM:


