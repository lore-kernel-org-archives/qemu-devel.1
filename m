Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9292720674
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEnPJyT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9292720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEkJ-0008CQ-Qc
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyEjV-0007SJ-Cy
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:24:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyEjT-0000XW-8t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595424265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWwG6iWELdeZ4b/QetaZxLZcnyir1yShlRldSJ66uDo=;
 b=PEnPJyT81HOoaQi+b5Kj380b/qNSagfhLi9+cKIHEpNRc6gezIdLGkiKU15nQrhYmV97Ie
 dDXd1ZXTSB1lZdG44/nuUOPJAsybWfZpkUytYoRyX0pEy41xA86Hq/Ye6D7PAqlMNhCpg8
 rEW2CcXF4epSIYoicUKyAisjP+BByD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-v1zu0I9dMJOMOzziCBz-Ng-1; Wed, 22 Jul 2020 09:24:24 -0400
X-MC-Unique: v1zu0I9dMJOMOzziCBz-Ng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E53C98017FB;
 Wed, 22 Jul 2020 13:24:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB4A71D01;
 Wed, 22 Jul 2020 13:24:21 +0000 (UTC)
Subject: Re: [PATCH 3/6] x86: cpuhp: refuse cpu hot-unplug request earlier if
 not supported
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200720141610.574308-1-imammedo@redhat.com>
 <20200720141610.574308-4-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5e6b9302-d847-1423-35fe-2076263ccd61@redhat.com>
Date: Wed, 22 Jul 2020 15:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200720141610.574308-4-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/20/20 16:16, Igor Mammedov wrote:
> CPU hot-unplug with SMM requires firmware participation to prevent
> guest crash (i.e. CPU can be removed only after OS _and_ firmware
> were prepared for th action).

(1) s/th action/the action/

> Previous patches introduced ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT
> feature bit, which is advertised by firmware when it has support
> for CPU hot-unplug. Use it to check if guest is able to handle
> unplug and make device_del fail gracefully if hot-unplug feature
> hasn't been negotiated.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ich9.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 0acc9a3107..98fc363186 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -460,6 +460,17 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                        errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !lpc->pm.cpu_hotplug_legacy) {
> +        uint64_t negotiated = lpc->smi_negotiated_features;
> +
> +        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +            error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
> +                             "by firmware");
> +            error_append_hint(errp, "update machine type to newer than 5.1 "
> +                "and firmware that suppors CPU hot-unplug with SMM");

(2) I think the "machine type to newer than 5.1" reference should be removed at this point. (Similarly to how "x-smi-cpu-hotunplug" should default to "false" at this point in time, in patch#1.) We don't know when hot-unplug will work; we only know that it doesn't work now.

We could say something like

            error_append_hint(errp, "update machine type to a version having "
                              "x-smi-cpu-hotunplug=on and firmware that "
                              "suppors CPU hot-unplug with SMM");


> +            return;
> +        }
> +
>          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
>                                     dev, errp);
>      } else {
> 

These superficial comments aside, the patch works for me:

Tested-by: Laszlo Ersek <lersek@redhat.com>

and with (1) and (2) fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


