Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83952CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8BE204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coGLl8hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8BE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPtA8-0004w4-EV
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 14:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iPrpr-000529-1s
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 13:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iPrpo-0003Js-77
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 13:32:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iPrpo-0003If-0H
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 13:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572456758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFPWQ4hku5UrfMDQUlywWJpzED7nJAf6sv+yEZ7SyGA=;
 b=coGLl8hmRoUodPEspUTltXx9PcqI+lY8U7v0plZgVicQrXU5KEXWq4hvwJYlI1UzsHzAuj
 Ows6+0LLi5JtlgX6fkwb4jfrdE4Q03bvxIbOCics6ORNrQLwCt7PvbwoSeOmzj9Q/0qnp3
 vCjbShHBkzSETFxD/iGd0Yof28ATdMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Td67mw9xMeye5mdSBmF3Sw-1; Wed, 30 Oct 2019 13:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 673351800D56;
 Wed, 30 Oct 2019 17:32:33 +0000 (UTC)
Received: from [10.36.116.178] (ovpn-116-178.ams2.redhat.com [10.36.116.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACCFA1A7E5;
 Wed, 30 Oct 2019 17:32:29 +0000 (UTC)
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
To: David Gibson <david@gibson.dropbear.id.au>, jdenemar@redhat.com
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7899d767-8a17-0d50-1893-bc8437978437@redhat.com>
Date: Wed, 30 Oct 2019 18:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Td67mw9xMeye5mdSBmF3Sw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30.10.19 17:32, David Gibson wrote:
> We have to set the default model of all machine classes, not just for the
> active one. Otherwise, "query-machines" will indicate the wrong CPU model
> ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".

Maybe use ppc CPU models here instead of s390x ones :)

>=20
> s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model fo=
r
> all machine classes".  This patch applies a similar fix for the pseries-*
> machine types on ppc64.
>=20
> Doing a
>      {"execute":"query-machines"}
> under KVM now results in
>      {
>        "hotpluggable-cpus": true,
>        "name": "pseries-4.2",
>        "numa-mem-supported": true,
>        "default-cpu-type": "host-powerpc64-cpu",
>        "is-default": true,
>        "cpu-max": 1024,
>        "deprecated": false,
>        "alias": "pseries"
>      },
>      {
>        "hotpluggable-cpus": true,
>        "name": "pseries-4.1",
>        "numa-mem-supported": true,
>        "default-cpu-type": "host-powerpc64-cpu",
>        "cpu-max": 1024,
>        "deprecated": false
>      },
>      ...
>=20
> Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> currently see the wrong CPU model under KVM.
>=20
> Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>   target/ppc/kvm.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7d2e8969ac..c77f9848ec 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -100,7 +100,7 @@ static bool kvmppc_is_pr(KVMState *ks)
>       return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
>   }
>  =20
> -static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> +static int kvm_ppc_register_host_cpu_type(void);
>   static void kvmppc_get_cpu_characteristics(KVMState *s);
>   static int kvmppc_get_dec_bits(void);
>  =20
> @@ -147,7 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           exit(1);
>       }
>  =20
> -    kvm_ppc_register_host_cpu_type(ms);
> +    kvm_ppc_register_host_cpu_type();
>  =20
>       return 0;
>   }
> @@ -2534,13 +2534,19 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>       return pvr_pcc;
>   }
>  =20
> -static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> +static void pseries_machine_class_fixup(ObjectClass *oc, void *opaque)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> +}
> +
> +static int kvm_ppc_register_host_cpu_type(void)
>   {
>       TypeInfo type_info =3D {
>           .name =3D TYPE_HOST_POWERPC_CPU,
>           .class_init =3D kvmppc_host_cpu_class_init,
>       };
> -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>       PowerPCCPUClass *pvr_pcc;
>       ObjectClass *oc;
>       DeviceClass *dc;
> @@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(MachineS=
tate *ms)
>       }
>       type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>       type_register(&type_info);
> -    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
> -        /* override TCG default cpu type with 'host' cpu model */
> -        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> -    }
> +    /* override TCG default cpu type with 'host' cpu model */
> +    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE=
,
> +                         false, NULL);
>  =20
>       oc =3D object_class_by_name(type_info.name);
>       g_assert(oc);
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb


