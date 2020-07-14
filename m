Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72EC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9668522200
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQ7zKssZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9668522200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIdb-00069h-TW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvIcN-0004nX-Jy
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvIcL-0004NE-Sl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkD3nJgdt08CwzUbQp6tN0BzIevzpa/9L9UdWzEcFug=;
 b=AQ7zKssZoRL4vmR+7oe2h9E/MIVWvLIO8t2U9Ti3goHv3HPAecALoBcaqpPRgFCVm+sUjD
 13ThzpsU+AGNCLi5BLq/tn407ccfBU65+IsebcfgiFt3zSeQvAouQ2jqe3zFp4YciHZ5tD
 Qwy9PPM6SowYpgE7LJNZhiNQAw/4p+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-FON2jF2eNcit5BqHxhHCgg-1; Tue, 14 Jul 2020 06:56:53 -0400
X-MC-Unique: FON2jF2eNcit5BqHxhHCgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988D51086;
 Tue, 14 Jul 2020 10:56:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88D967B408;
 Tue, 14 Jul 2020 10:56:51 +0000 (UTC)
Subject: Re: [RFC 2/3] x86: cphp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-3-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e3598f14-2e91-436c-9a8c-c3b3a36b9190@redhat.com>
Date: Tue, 14 Jul 2020 12:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710161704.309824-3-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 18:17, Igor Mammedov wrote:
> There were reports of guest crash on CPU hotplug, when using q35 machine
> type and QVMF with Secure Boot, due to hotplugged CPU trying to process SMI

(1) typo: s/QVMF/OVMF/ please

(2) Please replace "Secure Boot" with "SMM". In everyday practice it's
OK to use them interchangeably, but in this commit message I'd like us
to be more precise.

> at default SMI handler location without it being relocated by firmware first.
>
> Fix it by refusing hotplug if firmware hasn't negotiatiad CPU hotplug SMI

(3) s/negotiatiad/negotiated/

> support while SMI broadcast is in use.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ich9.c | 12 +++++++++++-
>  hw/i386/pc.c   | 11 +++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 2d204babc6..a22b434e0b 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -408,10 +408,20 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
>
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> -        !lpc->pm.acpi_memory_hotplug.is_enabled)
> +        !lpc->pm.acpi_memory_hotplug.is_enabled) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: %s.memory-hotplug-support "
>                     "is not set", object_get_typename(OBJECT(lpc)));
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        uint64_t negotiated = lpc->smi_negotiated_features;

Wow, this is a relief. I thought it would be a difficult problem to
access the ICH9-LPC object cleanly, on the call stack of the device_add
command. I didn't imagine it would be at our disposal immediately.

> +
> +        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> +            error_setg(errp, "cpu hotplug SMI was not enabled by firmware");

(4) Please let's call this

  cpu hotplug *with* SMI

not just

  cpu hotplug SMI

(Emphasis added on "with" just for the sake of this discussion; no need
to embed the asterisks in the message.)

Because:

In my thinking, the feature that the firmware negotiates is not:

  SMI or no SMI, on CPU hotplug

Instead, the firmware negotiates:

  CPU hotplug with SMI, or no CPU hotplug

IOW, "SMI-or-no-SMI" is not a sub-feature of CPU hotplug; the feature
being negotiated, when SMI broadcast is enabled, is CPU hotplug as a
whole. That's exactly what this patch implements.


> +            error_append_hint(errp, "update machine type to newer than 5.0 "
> +                "and firmware that suppors CPU hotplug in Secure Boot mode");

(5) Please replace

  "in Secure Boot mode"

with

  "with SMM"

(for "firmware that suppors CPU hotplug with SMM")

> +        }
> +    }
>  }
>
>  void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6fe80c84d7..dc1e9157d7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1508,6 +1508,17 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>
> +    if (pcms->acpi_dev) {
> +        Error *local_err = NULL;
> +
> +        hotplug_handler_pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> +                                 &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      init_topo_info(&topo_info, x86ms);
>
>      env->nr_dies = x86ms->smp_dies;
>

(6) This looks sane to me, but I have a question for the *pre-patch*
code.

I notice that hotplug_handler_pre_plug() is already called from the
(completely unrelated) function pc_memory_pre_plug().

In pc_memory_pre_plug(), we have the following snippet:

    /*
     * When -no-acpi is used with Q35 machine type, no ACPI is built,
     * but pcms->acpi_dev is still created. Check !acpi_enabled in
     * addition to cover this case.
     */
    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
        error_setg(errp,
                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
        return;
    }

Whereas in pc_cpu_pre_plug(), the present patch only adds a
"pcms->acpi_dev" nullity check.

Should pc_cpu_pre_plug() check for ACPI enablement similarly to
pc_memory_pre_plug()?

I'm asking for two reasons:

(6a) for the feature at hand (CPU hotplug with SMI), maybe we should
write:

    if (pcms->acpi_dev && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {

(6b) or maybe more strictly, copy the check from memory hotplug (just
update the error message):

    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
        error_setg(errp,
                   "CPU hotplug is not enabled: missing acpi device or acpi disabled");
        return;
    }

Because CPU hotplug depends on ACPI too, just like memory hotplug,
regardless of firmware, and regardless of guest-SMM. Am I correct to
think that?

Basically, I'm asking if we should replicate original commit
8cd91acec8df ("pc: fail memory hot-plug/unplug with -no-acpi and Q35
machine type", 2018-01-12) for CPU hotplug first (in a separate patch!),
before dealing with "lpc->smi_negotiated_features" in this patch.

Hmm... I'm getting confused. I *do* see similar checks in pc_cpu_plug()
and pc_cpu_unplug_request_cb(). But:

- I don't understand what determines whether we put the ACPI check in
*PRE* plug functions, or the plug functions,

- and I don't understand why pc_cpu_plug() and
pc_cpu_unplug_request_cb() only check "pcms->acpi_dev", and not
x86_machine_is_acpi_enabled().


(7) According to my request under patch#1, I propose that we should
implement a similar rejection for CPU hot-unplug, in this series. (Can
be a separate patch, of course.)

Thanks!
Laszlo


