Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3368C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17C12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdjEcc1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17C12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYPj-0006ah-Vc
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 08:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAYPD-00065p-Id
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:50:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAYPB-00005P-0F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598359823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9tvBSaJMSYFv1fc5cVSCYsKK7qn9VQWyWAIG8G2kc4=;
 b=EdjEcc1zSwHCDqjmd+yGFW8dbvM6ITJgIuXA8et8xOEmvPJu9+W0uRByBpegRxKdgjleOF
 ZOPzzZb6jvhFkcEiHltVj6WNYNgy64+oAG/DG1w54jbXcrH5TgdRH/5Fr0E1+U4Qk933ut
 Bk5/+vmGoXkDCmOq5dFChzIhs9+b/G4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-EowPkB_SMaqieEY9fauHdA-1; Tue, 25 Aug 2020 08:50:21 -0400
X-MC-Unique: EowPkB_SMaqieEY9fauHdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C55A8030AD;
 Tue, 25 Aug 2020 12:50:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-0.ams2.redhat.com
 [10.36.113.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66376808A6;
 Tue, 25 Aug 2020 12:50:19 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] x86: cpuhp: refuse cpu hot-unplug request earlier
 if not supported
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-4-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a0349df3-ab2f-1fa4-6a4b-f7edaa06e7fa@redhat.com>
Date: Tue, 25 Aug 2020 14:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818122208.1243901-4-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/18/20 14:22, Igor Mammedov wrote:
> CPU hot-unplug with SMM requires firmware participation to prevent
> guest crash (i.e. CPU can be removed only after OS _and_ firmware
> were prepared for the action).
> Previous patches introduced ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT
> feature bit, which is advertised by firmware when it has support
> for CPU hot-unplug. Use it to check if guest is able to handle
> unplug and make device_del fail gracefully if hot-unplug feature
> hasn't been negotiated.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v2:
>  - fix typo in commit message
>  - drop 5.1 version from hint message (Laszlo)
> ---
>  hw/acpi/ich9.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 0acc9a3107..95cb0f935b 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -460,6 +460,18 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                        errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !lpc->pm.cpu_hotplug_legacy) {
> +        uint64_t negotiated = lpc->smi_negotiated_features;
> +
> +        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +            error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
> +                             "by firmware");
> +            error_append_hint(errp, "update machine type to a version having "
> +                                    "x-smi-cpu-hotunplug=on and firmware that "
> +                                    "supports CPU hot-unplug with SMM");
> +            return;
> +        }
> +
>          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
>                                     dev, errp);
>      } else {
> 

A trivial comment:

Patch#2 says "x86: cphp: " in the subject line, but patch#3 says "x86:
cpuhp: " (note the extra "u").

I'm fine with either "cphp" or "cpuhp", but the subjects should be
consistent -- both patches should use the same word.

Preserve my T-b and R-b on both patches #2 and #3, after fixing up one
of the subjects. (Up to you which one.)

Thanks!
Laszlo


