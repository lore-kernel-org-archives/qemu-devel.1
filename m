Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD42C4BA25
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF4620732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrAFZlDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF4620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71ed-0006Mr-0X
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j71dj-0005pF-1B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j71dh-0003HQ-8h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:42:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j71dg-0003AA-V5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582742550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNC1nK3q6qsiH8hC1c93bXn2oe2aHRYx8IUc2dvXJr4=;
 b=CrAFZlDGM8p4i7BKAfpCRecOEk66SGwkIioXB0r80vCQaGgcKA9zGPQTxnV+dvbIRCb0Py
 baVQhkxrozzQ1IX+JcL+j7tuctLSyp3FCgZZIpgJbw5etbTvDWPqnwj/o6AcwniWcIqwxh
 1RWiDXOcm+FdSftI+NcEnbzw6dBPbjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-CBIoge6VN8-Gvr7SrbM1rg-1; Wed, 26 Feb 2020 13:42:27 -0500
X-MC-Unique: CBIoge6VN8-Gvr7SrbM1rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99A61937FD1;
 Wed, 26 Feb 2020 18:42:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 305A060BE2;
 Wed, 26 Feb 2020 18:42:20 +0000 (UTC)
Date: Wed, 26 Feb 2020 19:42:18 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 2/2] hw/arm/virt: kvm: allow gicv3 by default if host does
 not support v2
Message-ID: <20200226184218.g5id5lnhzowiicxf@kamzik.brq.redhat.com>
References: <20200226170500.17028-1-eric.auger@redhat.com>
 <20200226170500.17028-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226170500.17028-3-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 06:05:00PM +0100, Eric Auger wrote:
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility. In that case we end up with this error:
>=20
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> and qemu aborts.
>=20
> This patch keeps the default v2 selection in all cases except
> in the KVM accelerated mode when the host does not support v2.
> This case did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case.

> Also if the end-user explicitly
> sets v2 whereas this latter is not supported, we also are
> informed that v2 is not selected by thos host instead of getting the
> above PMU related message.

I would change the above to:

Also, if the end-user explicitly sets v2 and this is not supported by
the host, then the user gets a more informative error message than
the PMU invalid argument message above.

>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a196bbf0d5..b37b0c40c1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1554,6 +1554,33 @@ static void machvirt_init(MachineState *machine)
>                  }
>              }
>          }
> +    } else if (kvm_enabled()) {
> +        int probe_bitmap =3D kvm_arm_vgic_probe();
> +
> +        if (!probe_bitmap) {
> +            error_report(
> +                "Unable to determine GIC version supported by host");
> +            exit(1);
> +        }
> +        if (!vms->gic_version_user_selected) {
> +            /*
> +             * by default v2 is supposed to be chosen: check it is
> +             * supported by the host. Otherwise take v3.
> +             */
> +            if (probe_bitmap & KVM_ARM_VGIC_V2) {
> +                vms->gic_version =3D 2;
> +            } else if (probe_bitmap & KVM_ARM_VGIC_V3) {
> +                vms->gic_version =3D 3;
> +            }
> +        } else { /* user explicitly set the version to 2 or 3 */
> +            if (vms->gic_version =3D=3D 2 && !(probe_bitmap & KVM_ARM_VG=
IC_V2)) {
> +                error_report("GICv2 is not supported by the host");
> +                exit(1);
> +            } else if (vms->gic_version =3D=3D 3 && !(probe_bitmap & KVM=
_ARM_VGIC_V3)) {
> +                error_report("GICv3 is not supported by the host");
> +                exit(1);
> +            }
> +        }
>      }
> =20
>      if (!cpu_type_valid(machine->cpu_type)) {
> @@ -1840,6 +1867,7 @@ static void virt_set_gic_version(Object *obj, const=
 char *value, Error **errp)
>  {
>      VirtMachineState *vms =3D VIRT_MACHINE(obj);
> =20
> +    vms->gic_version_user_selected =3D true;
>      if (!strcmp(value, "3")) {
>          vms->gic_version =3D 3;
>      } else if (!strcmp(value, "2")) {
> @@ -1851,6 +1879,7 @@ static void virt_set_gic_version(Object *obj, const=
 char *value, Error **errp)
>      } else {
>          error_setg(errp, "Invalid gic-version value");
>          error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
> +        vms->gic_version_user_selected =3D false;
>      }
>  }
> =20
> @@ -2103,6 +2132,7 @@ static void virt_instance_init(Object *obj)
>                                      NULL);
>      /* Default GIC type is v2 */
>      vms->gic_version =3D 2;
> +    vms->gic_version_user_selected =3D false;
>      object_property_add_str(obj, "gic-version", virt_get_gic_version,
>                          virt_set_gic_version, NULL);
>      object_property_set_description(obj, "gic-version",
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 71508bf40c..e363cde452 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -124,6 +124,7 @@ typedef struct {
>      bool its;
>      bool virt;
>      int32_t gic_version;
> +    bool gic_version_user_selected;
>      VirtIOMMUType iommu;
>      struct arm_boot_info bootinfo;
>      MemMapEntry *memmap;
> --=20
> 2.20.1
>=20
>

I just noticed that virt_get_gic_version() returns "2" if the user didn't
explicitly request "3". I guess that hasn't been a problem for "max"
and "host" because nobody is looking, at least not until after gic_version
has been fully initialized. It is wrong though (for example, with TCG
"max" should be "3", not "2"). Ideally virt_get_gic_version() would always
return what will actually be used by the guest, but maybe pre-init it
could return "max", "host", and "nosel" instead. We could then use the
property value "nosel" in machvirt_init() to determine whether or not the
user provided input, rather than adding gic_version_user_selected.

Thanks,
drew


