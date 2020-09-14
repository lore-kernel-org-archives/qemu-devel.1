Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96884C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CD2222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnLfCmcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CD2222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnWr-00064E-4u
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHnUs-0004WF-Qq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:22:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHnUq-0007J3-MP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600086131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6dmFNjjqKE0UMS6LNjbuT8z9ovZVRpuWGq0pjmwLAE=;
 b=hnLfCmcsICW7Z8VESh/iLO9YNBQ/0xTaZ4I9FJWKwQhHVzPRrHSP4qt56aujrgcisRxCbt
 8Pzn3r/kcNNVMVLIFW0QiGlGUh2MxDRN5phptI1FfBLLooARRLtpKw3/k15k3ZHzeDnAyX
 BxjgML/zQyuhH42gxsJT4I4b+rv5RR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-kUWo7Uk1OZy8vWZk4b-pYw-1; Mon, 14 Sep 2020 08:22:05 -0400
X-MC-Unique: kUWo7Uk1OZy8vWZk4b-pYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 775F010066FA;
 Mon, 14 Sep 2020 12:22:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AEBD19C4F;
 Mon, 14 Sep 2020 12:21:57 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:21:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH 4/9] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
Message-ID: <20200914142156.4835cfd1@redhat.com>
In-Reply-To: <20200911180755.28409-4-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-4-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: jusual@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 23:37:50 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> When ACPI hotplug for the root bus is disabled, the bsel property for that
> bus is not set. Please see the following commit:
> 
> 3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").
> 
> As a result, when acpi_pcihp_find_hotplug_bus() is called
> with bsel set to 0, it may return the root bus. This can cause devices attached to
> the root bus to get hot-unplugged if the user issues the following set of commmands:
> 
> outl 0xae10 0
> outl 0xae08 your_slot
> 
> Thanks to Julia for pointing this out here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html
> 
> In this patch, we fix the issue in this function by checking if the bus which is
> returned by the function is actually hotpluggable. If not, we simply return NULL.
> This avoids the scenario where we were returning a non-hotpluggable bus.
> 

> This patch is based off of tag v5.10
I'd put this type of comment below --- or in cover letter
so it won't be committed into git history
 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/pcihp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 39b1f74442..32ae8b2c0a 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
>      if (!bsel && !find.bus) {
>          find.bus = s->root;
>      }
> +
> +    /*
> +     * Check if find.bus is actually hotpluggable. If bsel is set to
> +     * NULL for example on the root bus in order to make it
> +     * non-hotpluggable, find.bus will match the root bus when bsel
> +     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
> +     * bus is not hotpluggable however, we should not select the bus.
> +     * Instead, we should set find.bus to NULL in that case. In the check
> +     * below, we generalize this case for all buses, not just the root bus.
> +     * The callers of this function check for a null return value and
> +     * handle them appropriately.
> +     */
> +    if (find.bus && !qbus_is_hotpluggable(BUS(find.bus))) {
> +        find.bus = NULL;
> +    }
>      return find.bus;
>  }
>  


