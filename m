Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B2DC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0904E2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJXwWMve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0904E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8UZ-0000yv-0N
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY8TI-0008Rm-AY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY8TG-0002D0-9Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603980005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWiYaY6LxFj9TJFpjuUTIRLeU07ujNRwUgKBglleY4M=;
 b=dJXwWMveWNnN71Q3wKAInIw/6I7hG1hcgATpnxyjWBDVFpfIzPZ5dx/5TQ7sGO7xtkWwHQ
 07N0QrfMfz2OyrfIn0zfZ0rjbvOei+l22GBx1/1/fppZXq9SRjwaJMYJFBxT3q89F+QYJq
 NaUJrjQ0wmADDNUXoo5gk9g5nFXiLLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-TD9DrzFEOFCGUNFzhNGDaw-1; Thu, 29 Oct 2020 10:00:01 -0400
X-MC-Unique: TD9DrzFEOFCGUNFzhNGDaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BE7801ABC;
 Thu, 29 Oct 2020 13:59:59 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BAB260CCC;
 Thu, 29 Oct 2020 13:59:53 +0000 (UTC)
Date: Thu, 29 Oct 2020 14:59:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 1/2] acpi/crs: Prevent bad ranges for host bridges
Message-ID: <20201029145951.45db8912@redhat.com>
In-Reply-To: <20201026193924.985014-1-ben.widawsky@intel.com>
References: <20201026193924.985014-1-ben.widawsky@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 12:39:23 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Prevent _CRS resources being quietly chopped off and instead throw an
> assertion. _CRS is used by host bridges to declare regions of io and/or
> memory that they consume. On some (all?) platforms the host bridge
> doesn't have PCI header space and so they need some way to convey the
> information.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> 1. I'm not aware of this being a real issue on platforms today as I think
>    many platforms that use ACPI and actually have regions, constrain to
>    32b to be complaint with legacy.
> 2. Since host bridges aren't usually hot plugged, it can't be invoked by
>    a user, so assert() seems like the right way to handle this.
> ---
>  hw/i386/acpi-build.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index eee7b57c37..df13abecf4 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -869,6 +869,8 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
>      crs_range_merge(temp_range_set.mem_ranges);
>      for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
>          entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
> +        assert(entry->limit <= UINT32_MAX &&
> +               (entry->limit - entry->base + 1) <= UINT32_MAX);
>          aml_append(crs,
>                     aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
>                                      AML_MAX_FIXED, AML_NON_CACHEABLE,


