Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD135C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F122311B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgytyyZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F122311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJO5p-000840-D9
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJO56-0006kg-FT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJO54-0003ld-5W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600465089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uyJ5JZaJK8JJiVYTLU2EJ6Le4fciimlNUsaF2/e3Xk=;
 b=AgytyyZECxLLZ3jUP2wa+I4D65Sbn10oOYfeZ824Xv5nbiMXgZg6RNLw5xwRWtW61sotf/
 MkluSp9AVIthgCFHyqJsrJFsUHNCbLna2Qhqs9jUueUJEWF140aG5JFukVLe9TbikhdCDJ
 GAxTk6HCf4f7FIJl7OkbHKOVSVP0NBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-u8pxoVRFPnWjH_uckvpAgg-1; Fri, 18 Sep 2020 17:38:07 -0400
X-MC-Unique: u8pxoVRFPnWjH_uckvpAgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534031084D79;
 Fri, 18 Sep 2020 21:38:06 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 096B01992F;
 Fri, 18 Sep 2020 21:38:02 +0000 (UTC)
Date: Fri, 18 Sep 2020 17:38:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 10/10] i386: Simplify CPUID_8000_001E for AMD
Message-ID: <20200918213802.GA57321@habkost.net>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 01:43:07PM -0500, Babu Moger wrote:
> apic_id contains all the information required to build
> CPUID_8000_001E. core_id and node_id is already part of
> apic_id generated by x86_topo_ids_from_apicid.
> 
> Also remove the restriction on number bits on core_id and
> node_id.
> 
> Remove all the hardcoded values and replace with generalized
> fields.
> 
> Refer the Processor Programming Reference (PPR) documentation
> available from the bugzilla Link below.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
[...]
> @@ -6019,7 +5914,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x8000001E:
>          assert(cpu->core_id <= 255);

I assume we still want to remove this assert()?  Do you plan to
redo and resubmit
  Subject: [PATCH] target/i386: Remove core_id assert check in CPUID 0x8000001E
  https://lore.kernel.org/qemu-devel/159257395689.52908.4409314503988289481.stgit@naples-babu.amd.com
?

> -        encode_topo_cpuid8000001e(cs, cpu,
> +        encode_topo_cpuid8000001e(cpu, &topo_info,
>                                    eax, ebx, ecx, edx);
>          break;
>      case 0xC0000000:
> 
> 

-- 
Eduardo


