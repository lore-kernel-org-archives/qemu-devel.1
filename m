Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96075C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9652075C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9652075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEdq-0003jm-OL
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVEd3-0003Ld-9N
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVEd2-0003d5-CQ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hVEd1-0003c3-Br
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73C8381DE8;
	Mon, 27 May 2019 12:21:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A9885D97A;
	Mon, 27 May 2019 12:21:18 +0000 (UTC)
Date: Mon, 27 May 2019 14:21:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190527142114.521ab953@redhat.com>
In-Reply-To: <20190411071739.22889-1-richardw.yang@linux.intel.com>
References: <20190411071739.22889-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 27 May 2019 12:21:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, thuth@redhat.com, rth@twiddle.net,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Apr 2019 15:17:39 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> pc_memory_pre_plug() is called during hotplug for both pc-dimm and
> nvdimm. This is more proper to check apci hotplug capability before
> check nvdimm specific capability.
not sure what this about.
Currently we are checking if ACPI is enabled
  if (!pcms->acpi_dev || !acpi_enabled) { ...
before nvdimm check and it looks better to me that we cancel
nvdimm hotplug earlier than passing it to
    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err)
with this patch ACPI device handler will be called before
nvdimm check happens, so it's +1 unnecessary call chain in
the case of nvdimm, which I'd rather not have.

Are there any issues with current call flow?
(commit message doesn't really explaining why we need this patch)

> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/pc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf1f2..d48b6f9582 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
> -        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> -        return;
> -    }
> -
>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> +    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> +        return;
> +    }
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>                       pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>  }


