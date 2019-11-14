Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E075C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFC720715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLWJzRre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFC720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBuD-0003l5-PF
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVBjB-0000QU-38
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVBj9-0005hK-Cf
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:47:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVBj9-0005gn-87
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573724866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ojOq2wu0mVLtGFE7nGG21vwE2WrVKKE8wMdSINZBWBU=;
 b=DLWJzRreeCAjn5NcuQzufqOofnV3eeJYA8yBr1ws931omvl91cbvC50zbBvu+N9MGl5zDu
 fe1H56J34GvkRaZ8rpQOJ+Bk+AOPSdRoVz5/JxuNbrLe7OXrMoWRWurAwU7jLD8+JXxxnj
 +qSTmZQCqvZeTPpSWENz3ExGPrXI/P8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-w9qELwVqOQ2kjBQ-_q5HBw-1; Thu, 14 Nov 2019 04:47:45 -0500
Received: by mail-wr1-f71.google.com with SMTP id j17so4087584wru.13
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ZQayYqt85CI2kT7kzP3q5CrsAdYdXt1NILertHaAPk=;
 b=VHVwPb8T1WG0C9xm/tztkACL4SWS+ijtvChH3anlTLx1DfGTbF7SHdPzW2naP711AC
 DQXUKNe+J4eUnC/BNgWmHmVo3+rYiYwgslVAV2FQOtHNnaUCf1UxMz5cJwTYqLsb/W9I
 ECvWazyYqeIUE9Akv553xqR7tUPxEXKGgs4JQE69LL8m31zHV1N5NqW4sCc4rOztWEtg
 Kz1xseKR1y8Jq2yb0A7I4A40YGCFd1alHNSj976mT+wggHdECcGGu+TBbsOGKUr0FO7u
 RYZy10DBnHTedFf99tdn8ANzPswbOXPSUYdmjbcsoAH6kog73dWkCKDYBbJ8Sp334CFe
 qhMQ==
X-Gm-Message-State: APjAAAXmUBGQgillUuQVaH+eU6mP2SjDdjEIJAUqxJlycrdefn+d013R
 KPWRUOqdh1GE42Mk48w7C5PReUW6K+K5p/gUfDFRq/YRj7dyBVnBI8vx9NUWhnar4Q6uiLbfUlu
 PEW0uRm6wudeq5dY=
X-Received: by 2002:adf:93e1:: with SMTP id 88mr7160613wrp.198.1573724863782; 
 Thu, 14 Nov 2019 01:47:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvvx4EEiPEEhfla6gzpjAcB2GVS1eFShzSLtkQcn/7XUE+V15PwBNpzhMXKAumEmsPgAA69w==
X-Received: by 2002:adf:93e1:: with SMTP id 88mr7160586wrp.198.1573724863377; 
 Thu, 14 Nov 2019 01:47:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id t13sm6160943wrr.88.2019.11.14.01.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 01:47:42 -0800 (PST)
Subject: Re: [PATCH 13/16] xen: convert "-machine igd-passthru" to an
 accelerator property
To: Paul Durrant <pdurrant@gmail.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-14-git-send-email-pbonzini@redhat.com>
 <CACCGGhB=Sp8jcp+hhQjU0sXqhyQ8ug7nT-PuijS-eXPq4kog-w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3b5cbfb9-0de9-ae52-6695-12579bc42c09@redhat.com>
Date: Thu, 14 Nov 2019 10:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACCGGhB=Sp8jcp+hhQjU0sXqhyQ8ug7nT-PuijS-eXPq4kog-w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: w9qELwVqOQ2kjBQ-_q5HBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 10:39, Paul Durrant wrote:
> On Wed, 13 Nov 2019 at 14:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The first machine property to fall is Xen's Intel integrated graphics
>> passthrough.  The "-machine igd-passthru" option does not set anymore
>> a property on the machine object, but desugars to a GlobalProperty on
>> accelerator objects.
>>
>> The setter is very simple, since the value ends up in a
>> global variable, so this patch also provides an example before the more
>> complicated cases that follow it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Did something go wrong with get_maintainers here? The Xen maintainers
> ought to have been cc-ed. The Xen toolstack will require consequent
> modification.

No, I just didn't use getmaintainers, my bad.  But backwards-compatible
syntactic sugar is provided, so no modifications are needed to Xen.  See
here in the code:

+    if (g_str_equal(qom_name, "igd-passthru")) {
+        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, valu=
e);
+        return 0;
+    }

Paolo

> Cc-ing (rest of) Xen maintainers and xen-devel manually.
>=20
>   Paul
>=20
>> ---
>>  hw/core/machine.c   | 20 --------------------
>>  hw/xen/xen-common.c | 16 ++++++++++++++++
>>  include/hw/boards.h |  1 -
>>  qemu-options.hx     |  9 +++++----
>>  vl.c                | 14 ++++----------
>>  5 files changed, 25 insertions(+), 35 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 45ddfb6..d7a0356 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -412,20 +412,6 @@ static void machine_set_graphics(Object *obj, bool =
value, Error **errp)
>>      ms->enable_graphics =3D value;
>>  }
>>
>> -static bool machine_get_igd_gfx_passthru(Object *obj, Error **errp)
>> -{
>> -    MachineState *ms =3D MACHINE(obj);
>> -
>> -    return ms->igd_gfx_passthru;
>> -}
>> -
>> -static void machine_set_igd_gfx_passthru(Object *obj, bool value, Error=
 **errp)
>> -{
>> -    MachineState *ms =3D MACHINE(obj);
>> -
>> -    ms->igd_gfx_passthru =3D value;
>> -}
>> -
>>  static char *machine_get_firmware(Object *obj, Error **errp)
>>  {
>>      MachineState *ms =3D MACHINE(obj);
>> @@ -862,12 +848,6 @@ static void machine_class_init(ObjectClass *oc, voi=
d *data)
>>      object_class_property_set_description(oc, "graphics",
>>          "Set on/off to enable/disable graphics emulation", &error_abort=
);
>>
>> -    object_class_property_add_bool(oc, "igd-passthru",
>> -        machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
>> -        &error_abort);
>> -    object_class_property_set_description(oc, "igd-passthru",
>> -        "Set on/off to enable/disable igd passthrou", &error_abort);
>> -
>>      object_class_property_add_str(oc, "firmware",
>>          machine_get_firmware, machine_set_firmware,
>>          &error_abort);
>> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
>> index 5284b0d..6cba30c 100644
>> --- a/hw/xen/xen-common.c
>> +++ b/hw/xen/xen-common.c
>> @@ -124,6 +124,16 @@ static void xen_change_state_handler(void *opaque, =
int running,
>>      }
>>  }
>>
>> +static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
>> +{
>> +    return has_igd_gfx_passthru;
>> +}
>> +
>> +static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **e=
rrp)
>> +{
>> +    has_igd_gfx_passthru =3D value;
>> +}
>> +
>>  static void xen_setup_post(MachineState *ms, AccelState *accel)
>>  {
>>      int rc;
>> @@ -177,6 +187,12 @@ static void xen_accel_class_init(ObjectClass *oc, v=
oid *data)
>>      ac->compat_props =3D g_ptr_array_new();
>>
>>      compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
>> +
>> +    object_class_property_add_bool(oc, "igd-passthru",
>> +        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
>> +        &error_abort);
>> +    object_class_property_set_description(oc, "igd-passthru",
>> +        "Set on/off to enable/disable igd passthrou", &error_abort);
>>  }
>>
>>  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 36fcbda..cdcf481 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -287,7 +287,6 @@ struct MachineState {
>>      bool mem_merge;
>>      bool usb;
>>      bool usb_disabled;
>> -    bool igd_gfx_passthru;
>>      char *firmware;
>>      bool iommu;
>>      bool suppress_vmdesc;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 3931f90..5b43a83 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -37,7 +37,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>      "                kvm_shadow_mem=3Dsize of KVM shadow MMU in bytes\n=
"
>>      "                dump-guest-core=3Don|off include guest memory in a=
 core dump (default=3Don)\n"
>>      "                mem-merge=3Don|off controls memory merge support (=
default: on)\n"
>> -    "                igd-passthru=3Don|off controls IGD GFX passthrough=
 support (default=3Doff)\n"
>>      "                aes-key-wrap=3Don|off controls support for AES key=
 wrapping (default=3Don)\n"
>>      "                dea-key-wrap=3Don|off controls support for DEA key=
 wrapping (default=3Don)\n"
>>      "                suppress-vmdesc=3Don|off disables self-describing =
migration (default=3Doff)\n"
>> @@ -71,8 +70,6 @@ more than one accelerator specified, the next one is u=
sed if the previous one
>>  fails to initialize.
>>  @item kernel_irqchip=3Don|off
>>  Controls in-kernel irqchip support for the chosen accelerator when avai=
lable.
>> -@item gfx_passthru=3Don|off
>> -Enables IGD GFX passthrough support for the chosen machine when availab=
le.
>>  @item vmport=3Don|off|auto
>>  Enables emulation of VMWare IO port, for vmmouse etc. auto says to sele=
ct the
>>  value based on accel. For accel=3Dxen the default is off otherwise the =
default
>> @@ -118,8 +115,9 @@ Select CPU model (@code{-cpu help} for list and addi=
tional feature selection)
>>  ETEXI
>>
>>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>> -    "-accel [accel=3D]accelerator[,thread=3Dsingle|multi]\n"
>> +    "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>>      "                select accelerator (kvm, xen, hax, hvf, whpx or tc=
g; use 'help' for a list)\n"
>> +    "                igd-passthru=3Don|off (enable Xen integrated Intel=
 graphics passthrough, default=3Doff)\n"
>>      "                tb-size=3Dn (TCG translation block cache size)\n"
>>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\=
n", QEMU_ARCH_ALL)
>>  STEXI
>> @@ -130,6 +128,9 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By=
 default, tcg is used. If th
>>  more than one accelerator specified, the next one is used if the previo=
us one
>>  fails to initialize.
>>  @table @option
>> +@item igd-passthru=3Don|off
>> +When Xen is in use, this option controls whether Intel integrated graph=
ics
>> +devices can be passed through to the guest (default=3Doff)
>>  @item tb-size=3D@var{n}
>>  Controls the size (in MiB) of the TCG translation block cache.
>>  @item thread=3Dsingle|multi
>> diff --git a/vl.c b/vl.c
>> index 06c6ad9..7d8fed1 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1256,13 +1256,6 @@ static void configure_msg(QemuOpts *opts)
>>  }
>>
>>
>> -/* Now we still need this for compatibility with XEN. */
>> -bool has_igd_gfx_passthru;
>> -static void igd_gfx_passthru(void)
>> -{
>> -    has_igd_gfx_passthru =3D current_machine->igd_gfx_passthru;
>> -}
>> -
>>  /***********************************************************/
>>  /* USB devices */
>>
>> @@ -2645,6 +2638,10 @@ static int machine_set_property(void *opaque,
>>      if (g_str_equal(qom_name, "accel")) {
>>          return 0;
>>      }
>> +    if (g_str_equal(qom_name, "igd-passthru")) {
>> +        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, v=
alue);
>> +        return 0;
>> +    }
>>
>>      r =3D object_parse_property_opt(opaque, name, value, "type", errp);
>>      g_free(qom_name);
>> @@ -4449,9 +4446,6 @@ int main(int argc, char **argv, char **envp)
>>              exit(1);
>>      }
>>
>> -    /* Check if IGD GFX passthrough. */
>> -    igd_gfx_passthru();
>> -
>>      /* init generic devices */
>>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
>>      qemu_opts_foreach(qemu_find_opts("device"),
>> --
>> 1.8.3.1
>>
>>
>>
>=20


