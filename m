Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E1C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632A120738
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ/fHUsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632A120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIR9F-00065L-BJ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIR8O-0005Mc-Iu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:41:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIR8L-0000ss-Ej
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600238496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdMKJrVw0ufayS2sdVts8VFVNIJ2ITrsYq3dutI4ZtE=;
 b=LQ/fHUsO8mZOIfLP9YzEEsTbhHA8CpFC+EbREUUgV+LqUYFubzFw5ZDXql/RvTuXKK9vgj
 u+j3VW/l4jQcJKLh6tnnMHy0TErReKMO57ofF5prmR4K3ZTkfhY2wOzMGvBNI9CFCq7QYJ
 4gF1mEmsOnPinMloYFWeMGw8ek5ppUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-jYTJbs-2NkCSGs6xrz-p1w-1; Wed, 16 Sep 2020 02:41:32 -0400
X-MC-Unique: jYTJbs-2NkCSGs6xrz-p1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48010802B51;
 Wed, 16 Sep 2020 06:41:31 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD0F1002393;
 Wed, 16 Sep 2020 06:41:19 +0000 (UTC)
Date: Wed, 16 Sep 2020 08:41:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v4 04/11] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
Message-ID: <20200916084118.245b206e@redhat.com>
In-Reply-To: <20200916061335.14045-5-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916061335.14045-5-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 11:43:28 +0530
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
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/pcihp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> change log:
> v1: initial patch
> v4: commit log updated as per suggestion.
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


