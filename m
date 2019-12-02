Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB2A2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjzK0wOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB2A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibgWQ-00075r-CS
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ibgV8-00068E-F9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ibgV6-00073K-4o
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ibgV5-000730-Vy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575273127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNjzYLM431CnrlHjGDtHoPTLbvOO0a3LHOSns0ParpQ=;
 b=YjzK0wOesoMv6O08Y5JRHZF0/7xN83FrF9TpHjamyWGfl2GXBw5EMx3rntUUPRF0vLU1Xs
 +AB2Nvw+1GHbCoHjYvYOcC8Wdb2pWazfCyn1PbCRgYV1EGQaoWa1MFO3r7OiYj7gmwJt+Z
 DwfSEmJqarDSxBb90D7aZm6KIRh7V3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-i7IYwSR4M6K3xi-sKz8hCA-1; Mon, 02 Dec 2019 02:52:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17132107ACE4;
 Mon,  2 Dec 2019 07:52:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEC93600C8;
 Mon,  2 Dec 2019 07:51:59 +0000 (UTC)
Date: Mon, 2 Dec 2019 08:51:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 09/21] hw/acpi: Fix latent legacy CPU plug error
 handling bug
Message-ID: <20191202085159.0a1372a2@redhat.com>
In-Reply-To: <20191130194240.10517-10-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-10-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: i7IYwSR4M6K3xi-sKz8hCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 Nov 2019 20:42:28 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> legacy_acpi_cpu_plug_cb() crashes when acpi_set_cpu_present_bit()
> fails and its @errp argument is null.  Messed up in commit cc43364de7
> "acpi/cpu-hotplug: introduce helper function to keep bit setting in
> one place".
> 
> The bug can't bite as no caller actually passes null, and
> acpi_set_cpu_present_bit() can't actually fail.  Fix it anyway.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/cpu_hotplug.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 3ac2045a95..9c3bcc84de 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -55,8 +55,7 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
>      },
>  };
>  
> -static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
> -                                     Error **errp)
> +static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
>  {
>      CPUClass *k = CPU_GET_CLASS(cpu);
>      int64_t cpu_id;
> @@ -74,10 +73,7 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
>  void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>                               AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
>  {
> -    acpi_set_cpu_present_bit(g, CPU(dev), errp);
> -    if (*errp != NULL) {
> -        return;
> -    }
> +    acpi_set_cpu_present_bit(g, CPU(dev));
>      acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
>  }
>  
> @@ -92,7 +88,7 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>      gpe_cpu->device = owner;
>  
>      CPU_FOREACH(cpu) {
> -        acpi_set_cpu_present_bit(gpe_cpu, cpu, &error_abort);
> +        acpi_set_cpu_present_bit(gpe_cpu, cpu);
>      }
>  }
>  


