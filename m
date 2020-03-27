Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523DC2D0E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2272520716
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlZU1S2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2272520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrP4-0007U1-Tz
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHrO1-0006Ps-VD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHrNy-0004bX-SE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:59:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHrNy-0004Ux-LM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585324745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urPEWi8bNxhmPHyxhHCz5KMMw1qDmImArdNNtIqizm0=;
 b=UlZU1S2ncN1d5lVB14JTJFmb3uGDiZ4CF4cnuoy4wKkmhGC/ee39EKspG2aIUWbRW7pJAD
 JvEv/IhKqkdhAONgUufsfEXMENLOonvIzw6KM5tK9Y3zw+/1cwRoC1hf401mZq7XSdtEnE
 AQVFZPFUTb4obnycgBf0XDLAa8NYVC8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-C03ubxcYOcq_ETCdEjOkIw-1; Fri, 27 Mar 2020 11:59:04 -0400
X-MC-Unique: C03ubxcYOcq_ETCdEjOkIw-1
Received: by mail-wm1-f69.google.com with SMTP id f9so4005782wme.7
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=urPEWi8bNxhmPHyxhHCz5KMMw1qDmImArdNNtIqizm0=;
 b=Yy69bCIWNjOwgowCuQccja5LudINWZ6aGB00bfSzeSgA2NO3pnHwccE2TDMlM+J/XL
 4e8F4MNgtfG1mVxuGlb6HlRSUgE2yRoDp/hY3fXl38SaXs1R7vUZdwjAhi/QB1EfLRAk
 9Hmb6pQfjpB4GpsE4h3rs5wQKqaKSjZuJ0G2kjaeqB+ezsX1JMMsQtLyx8J4xf+wlzfN
 4p8NTDNuUOZGo/N5UHb8EoPXzGik5OGnyisd9IT5BuEyXJZ8ZkTPbo+KPG3ZFKotaaCh
 6Re9r+69YsPeXdspqA0mRsw8+Sc+sIUQXJwSdhVxJYL8HODi+T9HSL3wBb/4K7SZdtJR
 bQfw==
X-Gm-Message-State: ANhLgQ1km4N0H2lNfwULK2ikuI+y4uJCpqp5U/7m4lix7fkoGk5vJarw
 sxR/Al8a8tKLYS16aThLFeTIsGZ7Eh706Byg92ZzoZypQNgX4bZajSd6SjfiA9+e4aasb8j+Rd+
 JU93MIWkn4DbwY8c=
X-Received: by 2002:a5d:474b:: with SMTP id o11mr122702wrs.4.1585324742696;
 Fri, 27 Mar 2020 08:59:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvwUfLD+WlaFW7w59OhctCY7AmXuh1jLf8IA/Cd6U824rq9DnKlfc3aN8XSAb9JF5RsKEC8OA==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr122681wrs.4.1585324742443;
 Fri, 27 Mar 2020 08:59:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id z16sm8947650wrr.56.2020.03.27.08.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 08:59:01 -0700 (PDT)
Subject: Re: [PATCH v4] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
To: Olaf Hering <olaf@aepfle.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200327151841.13877-1-olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90544ada-060e-169b-c0cb-94d869070d97@redhat.com>
Date: Fri, 27 Mar 2020 16:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327151841.13877-1-olaf@aepfle.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks good, I would just do the following adjustments to have more
consistency between pc and xenfv machine types:

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c565f41791..eb7b273508 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -948,26 +948,26 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 
 
 #ifdef CONFIG_XEN
-static void xenfv_qemu_4_x_machine_options(MachineClass *m)
+static void xenfv_4_2_machine_options(MachineClass *m)
 {
     pc_i440fx_4_2_machine_options(m);
-    m->desc = "Xen Fully-virtualized PC (qemu 4.x compat)";
+    m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen";
-    m->smbus_no_migration_support = false;
 }
 
-DEFINE_PC_MACHINE(xenfv_qemu4, "xenfv-qemu4", pc_xen_hvm_init,
-                  xenfv_qemu_4_x_machine_options);
+DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
+                  xenfv_4_2_machine_options);
 
-static void xenfv_machine_options(MachineClass *m)
+static void xenfv_3_1_machine_options(MachineClass *m)
 {
     pc_i440fx_3_1_machine_options(m);
     m->desc = "Xen Fully-virtualized PC";
+    m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen";
 }
 
-DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
-                  xenfv_machine_options);
+DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
+                  xenfv_3_1_machine_options);
 #endif


On 27/03/20 16:18, Olaf Hering wrote:
> With qemu4 an incompatible change was added to pc_piix, which makes it
> practical impossible to migrate domUs started with qemu2 or qemu3 to
> newer qemu versions. Commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea
> added and enabled a new member "smbus_no_migration_support". In commit
> 4ab2f2a8aabfea95cc53c64e13b3f67960b27fdf the vmstate_acpi got new
> elements, which are conditionally filled. As a result, an incoming
> migration expected smbus related data unless smbus migration was
> disabled for a given MachineClass. Since first commit forgot to handle
> 'xenfv', domUs started with qemu4 are incompatible with their qemu3
> siblings.
> 
> Using other existing machine types, such as 'pc-i440fx-3.1', is not
> possible because 'xenfv' creates the 'xen-platform' PCI device at
> 00:02.0, while all other variants to run a domU would create it at
> 00:04.0.
> 
> To cover both the existing and the broken case of 'xenfv' in a single
> qemu binary, a new compatibility variant of 'xenfv-qemu4' must be added
> which targets domUs started with qemu-4.0, qemu-4.1 and qemu-4.2. The
> existing 'xenfv' restores compatibility of qemu5+ with qemu2/3.
> 
> Host admins who started domUs with qemu-4.x have to use a wrapper script
> which appends '-machine xenfv-qemu4' to the device-model command line.
> This is only required if there is no maintenance window which allows to
> temporary shutdown the domU and restart it with a fixed device-model.
> 
> The wrapper script is as simple as this:
>   #!/bin/sh
>   exec /usr/bin/qemu-system-i386 "$@" -machine xenfv-qemu4
> 
> With xl this script will be enabled with device_model_override=, see
> xl.cfg(5). To live migrate a domU, adjust the existing domU.cfg and pass
> it to xl migrate or xl save/restore:
>   xl migrate -C new-domU.cfg domU remote-host
>   xl save domU CheckpointFile new-domU.cfg
>   xl restore new-domU.cfg CheckpointFile
> 
> With libvirt this script will be enabled with the <emulator> element in
> domU.xml. Use 'virsh edit' prior 'virsh migrate' to replace the existing
> <emulator> element to point it to the wrapper script.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  hw/i386/pc_piix.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e6756216f9..c565f41791 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -948,8 +948,21 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>  
>  
>  #ifdef CONFIG_XEN
> +static void xenfv_qemu_4_x_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_4_2_machine_options(m);
> +    m->desc = "Xen Fully-virtualized PC (qemu 4.x compat)";
> +    m->max_cpus = HVM_MAX_VCPUS;
> +    m->default_machine_opts = "accel=xen";
> +    m->smbus_no_migration_support = false;
> +}
> +
> +DEFINE_PC_MACHINE(xenfv_qemu4, "xenfv-qemu4", pc_xen_hvm_init,
> +                  xenfv_qemu_4_x_machine_options);
> +
>  static void xenfv_machine_options(MachineClass *m)
>  {
> +    pc_i440fx_3_1_machine_options(m);
>      m->desc = "Xen Fully-virtualized PC";
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
> 


