Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E003C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9AD208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux7MJqdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9AD208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2ER-0006hD-Af
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2Av-0002k1-MD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2At-0003St-FW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETlDsM5BsbQlnmoD7SR98DHuPA5uYUETHPw/x3DOGwQ=;
 b=Ux7MJqdNFxs4L33wUhUXW70e7S77eyLLygivau8/sXa8/CuwYDlKhsOjL6FrfiKWsjGWVI
 57l3B57/si85pjT/Uvk2jfbyMvkNIdrLLrnoPoAPgmgwsIblZbv2XPlTx+w+QC+6SkSX9e
 6aPtiaeUdJRhZO/X+VmjajXUot6I77k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BRPEhd0JOZiE5mu667dGzA-1; Fri, 23 Oct 2020 14:52:24 -0400
X-MC-Unique: BRPEhd0JOZiE5mu667dGzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566CB64147;
 Fri, 23 Oct 2020 18:52:23 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7098B55774;
 Fri, 23 Oct 2020 18:52:11 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:52:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/4] microvm: reconfigure irqs if second ioapic is
 available
Message-ID: <20201023205209.7b6258d7@redhat.com>
In-Reply-To: <20201016114328.18835-5-kraxel@redhat.com>
References: <20201016114328.18835-1-kraxel@redhat.com>
 <20201016114328.18835-5-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 13:43:28 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Use GSI 16+ for PCIe (needs acpi_build_madt() tweak).
> Use GSI 24+ (second ioapic) for virtio-mmio.
> Use all irq lines of the second ioapic
> and allow up to 24 virtio-mmio devices.

description is  missing answer to question why it's done.


> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-common.c | 2 +-
>  hw/i386/microvm.c     | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index f0689392a39f..1653a8315248 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -122,7 +122,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>          intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
>      }
>  
> -    for (i = 1; i < 16; i++) {
> +    for (i = 1; i < 24; i++) {
>          if (!(x86ms->pci_irq_mask & (1 << i))) {
>              /* No need for a INT source override structure. */
>              continue;
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 15c3e078a4aa..70bb8a4e3954 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -205,7 +205,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>  
>      mms->virtio_irq_base = 5;
>      mms->virtio_num_transports = 8;
> -    if (x86_machine_is_acpi_enabled(x86ms)) {
> +    if (ioapic2) {
> +        mms->pcie_irq_base = 16;
> +        mms->virtio_irq_base = 24;
> +        mms->virtio_num_transports = 24;
> +    } else if (x86_machine_is_acpi_enabled(x86ms)) {
>          mms->pcie_irq_base = 12;
>          mms->virtio_irq_base = 16;
>      }


