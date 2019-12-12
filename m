Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7701F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXufODhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7701F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQz5-0001as-Gu
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifQyT-0001BJ-OZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifQyN-0006tc-BL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:05:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifQyM-0006qO-NS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576166749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7HxKSskk7Z/RVh2UDE9N3Z+ai+Hs4FPGhKWwTIBA7M=;
 b=EXufODhErt7u9TnR05th038cwb1X5eYs2wWBgNJN7Rnt52KdvAPOEa3EFoIzMIsbiJCkIe
 epnNYeW0m/IEqzEzLm4gxFmq8ZRJYhcc/BXmQl33pCdMLq8XA0FtDSAYy2+zRmB/o3flYR
 2cTwQwgYvsFmSgUuLIjwtuE/sYSdQE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-6Vy9ltwSN5udfM6KrNePqg-1; Thu, 12 Dec 2019 11:05:48 -0500
X-MC-Unique: 6Vy9ltwSN5udfM6KrNePqg-1
Received: by mail-wr1-f69.google.com with SMTP id o6so1204426wrp.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 08:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=TjnBY2MNbMHvH5DjG0JBVi5fdsNm/qCeJMGUZ4wCcN4=;
 b=H1FSGbtNv13ABKq/YkLdxii9rR66qewWpk/YAfaS5z/k3usLraMnKNHUaPuPnfucmf
 V8idj49SktP644r2OTlaHgy03knyby6MvqegDzNmo8pByxJg+6VloQvYffDXLbzHydif
 Elod45WgZGCoXCEHqGu4Cq/1TRnN/8Utd3b2SlQ9xOWkJbCQeXf4nPRKNkSpXQu6catu
 /kDsThpfeKkVjwuDf5BU8u0KIradMsfU2bnDbDcdPd/7Hm3P+FIV4SsV29Wic19czK3m
 9S9phcW+lZ4MXXaFhkB8Feg+lfTdg20+XNgkHPCdUQ6mfl62dxQ7JuFU8n2fiF+mMime
 vFmw==
X-Gm-Message-State: APjAAAW9dn2aYjgL5o+U++pbE0QCk3SkkuMMydBLHeMY1kdfaoGhoHp3
 bgGTdHmsT0BunvtfoZMpccQoHaHt9EP+JZPj/dsUIVf31MlKyDwq8L4GuHbRXsraOAkptu8Rkek
 zb/Hm0KASCT6tDRI=
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr7470269wml.100.1576166746831; 
 Thu, 12 Dec 2019 08:05:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqziCyxFPgWIJnuSZkcp/kpXxuX3lX7vmiTNwfgdXdcEz4cMIhv6EKY6Bmsf1HH726m8biaYVg==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr7470242wml.100.1576166746506; 
 Thu, 12 Dec 2019 08:05:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id o62sm5028441wme.7.2019.12.12.08.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 08:05:45 -0800 (PST)
Subject: Re: [PATCH 3/5] x86: move more functions to X86MachineState and x86.c
To: Sergio Lopez <slp@redhat.com>
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-4-git-send-email-pbonzini@redhat.com>
 <87y2vhbkm3.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f146dec-63de-33f7-ea1f-c189d85605f1@redhat.com>
Date: Thu, 12 Dec 2019 17:05:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87y2vhbkm3.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1MQHjG54pW5DOeLxpXbIUt0JCczuXupbj"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1MQHjG54pW5DOeLxpXbIUt0JCczuXupbj
Content-Type: multipart/mixed; boundary="pKOFrGhHWQStjb3IXDQsNmaFOZPHcVJYO"

--pKOFrGhHWQStjb3IXDQsNmaFOZPHcVJYO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/12/19 16:59, Sergio Lopez wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> These are needed by microvm too, so move them outside of PC-specific fil=
es.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/i386/pc.c          |  99 -------------------------------------------=
------
>>  hw/i386/x86.c         | 101 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/i386/pc.h  |  12 ------
>>  include/hw/i386/x86.h |  13 +++++++
>>  4 files changed, 114 insertions(+), 111 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3d2c5d8..308248d 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -342,17 +342,6 @@ GlobalProperty pc_compat_1_4[] =3D {
>>  };
>>  const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
>> =20
>> -void gsi_handler(void *opaque, int n, int level)
>> -{
>> -    GSIState *s =3D opaque;
>> -
>> -    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
>> -    if (n < ISA_NUM_IRQS) {
>> -        qemu_set_irq(s->i8259_irq[n], level);
>> -    }
>> -    qemu_set_irq(s->ioapic_irq[n], level);
>> -}
>> -
>>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>>  {
>>      GSIState *s;
>> @@ -392,55 +381,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr =
addr, unsigned size)
>>      return 0xffffffffffffffffULL;
>>  }
>> =20
>> -/* TSC handling */
>> -uint64_t cpu_get_tsc(CPUX86State *env)
>> -{
>> -    return cpu_get_ticks();
>> -}
>> -
>> -/* IRQ handling */
>> -int cpu_get_pic_interrupt(CPUX86State *env)
>> -{
>> -    X86CPU *cpu =3D env_archcpu(env);
>> -    int intno;
>> -
>> -    if (!kvm_irqchip_in_kernel()) {
>> -        intno =3D apic_get_interrupt(cpu->apic_state);
>> -        if (intno >=3D 0) {
>> -            return intno;
>> -        }
>> -        /* read the irq from the PIC */
>> -        if (!apic_accept_pic_intr(cpu->apic_state)) {
>> -            return -1;
>> -        }
>> -    }
>> -
>> -    intno =3D pic_read_irq(isa_pic);
>> -    return intno;
>> -}
>> -
>> -static void pic_irq_request(void *opaque, int irq, int level)
>> -{
>> -    CPUState *cs =3D first_cpu;
>> -    X86CPU *cpu =3D X86_CPU(cs);
>> -
>> -    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
>> -    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
>> -        CPU_FOREACH(cs) {
>> -            cpu =3D X86_CPU(cs);
>> -            if (apic_accept_pic_intr(cpu->apic_state)) {
>> -                apic_deliver_pic_intr(cpu->apic_state, level);
>> -            }
>> -        }
>> -    } else {
>> -        if (level) {
>> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>> -        } else {
>> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>> -        }
>> -    }
>> -}
>> -
>>  /* PC cmos mappings */
>> =20
>>  #define REG_EQUIPMENT_BYTE          0x14
>> @@ -884,16 +824,6 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
>>      nb_ne2k++;
>>  }
>> =20
>> -DeviceState *cpu_get_current_apic(void)
>> -{
>> -    if (current_cpu) {
>> -        X86CPU *cpu =3D X86_CPU(current_cpu);
>> -        return cpu->apic_state;
>> -    } else {
>> -        return NULL;
>> -    }
>> -}
>> -
>>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
>>  {
>>      X86CPU *cpu =3D opaque;
>> @@ -1289,11 +1219,6 @@ uint64_t pc_pci_hole64_start(void)
>>      return ROUND_UP(hole64_start, 1 * GiB);
>>  }
>> =20
>> -qemu_irq pc_allocate_cpu_irq(void)
>> -{
>> -    return qemu_allocate_irq(pic_irq_request, NULL, 0);
>> -}
>> -
>>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
>>  {
>>      DeviceState *dev =3D NULL;
>> @@ -1480,30 +1405,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i=
8259_irqs)
>>      g_free(i8259);
>>  }
>> =20
>> -void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
>> -{
>> -    DeviceState *dev;
>> -    SysBusDevice *d;
>> -    unsigned int i;
>> -
>> -    if (kvm_ioapic_in_kernel()) {
>> -        dev =3D qdev_create(NULL, TYPE_KVM_IOAPIC);
>> -    } else {
>> -        dev =3D qdev_create(NULL, TYPE_IOAPIC);
>> -    }
>> -    if (parent_name) {
>> -        object_property_add_child(object_resolve_path(parent_name, NULL=
),
>> -                                  "ioapic", OBJECT(dev), NULL);
>> -    }
>> -    qdev_init_nofail(dev);
>> -    d =3D SYS_BUS_DEVICE(dev);
>> -    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
>> -
>> -    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
>> -        gsi_state->ioapic_irq[i] =3D qdev_get_gpio_in(dev, i);
>> -    }
>> -}
>> -
>>  static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
>>                                 Error **errp)
>>  {
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 394edc2..028bbf4 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -41,11 +41,15 @@
>>  #include "hw/i386/fw_cfg.h"
>> =20
>>  #include "hw/acpi/cpu_hotplug.h"
>> +#include "hw/i386/pc.h"
>=20
> Including pc.h from x86.h looks a bit weird to me. I think it'd be nicer
> moving the i8259 declarations to a separate header, and the all the
> GSI-related stuff to x86.h. I have a couple patches doing that, in case
> they can save you some time.

Hmm I wonder if the include is actually needed.  Thanks for pointing it out=
.

Paolo


--pKOFrGhHWQStjb3IXDQsNmaFOZPHcVJYO--

--1MQHjG54pW5DOeLxpXbIUt0JCczuXupbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl3yZVYACgkQv/vSX3jH
roPvzQf/eg3TAgbIaLyL6vrhbzK6tJTIs4jMfxRqNsYys1rUMN2aLsZ/VZrlU/Cx
3KLu9nFW6jPR9xBvh1N1s8JaPtJuS/0UCuZDPkwE7LBDWWYWjT/VYc7ERg9s2W16
JwAoHLkLNgC019lxQCUixb1o9qfyKfwFX7SLZD7Tr6lecKu/oRpgtyBjWy0Rmf07
3+yFMqZHLLp+qYM13jyBHYuw9/zpHCO0j4SFs1JUk2b4VTGvAo+UNmLG/S2c+wyo
+rvRmV5zejxAwPP/BtqjXTd/HfIFSzXYoRjRzIwz/xmdbvGyv5oM7G1h+Sy+4vpR
KmnX/aG/99lP0CwKpXB2OnCqpe6iFg==
=HFop
-----END PGP SIGNATURE-----

--1MQHjG54pW5DOeLxpXbIUt0JCczuXupbj--


