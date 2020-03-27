Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C679C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453652072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPyUHFcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453652072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHs0f-0002Ca-Gx
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHryD-0000Fp-Qh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHryC-0006EU-MA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHryC-0006DP-H0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585326992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtaYyBmsS1WL7Rv6nm0rjI5B89mlmF+VqGJFTj8B4RE=;
 b=HPyUHFcHVrdSjsw7Xj3xIGFKVgs1JzGa2VJ8UjZ/8fsQi+f4PoTy0USVc8KNkh3tvmThq3
 s6ZeIAsvQz5k0fDLJ5DzQ9MCFbLeiKqzKa6lKHVwoa0l3xbBZuMSRGi3eHI1o54cxRn51q
 m/rly05RIjp3ChEu8zLQIKEIa2khhjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-fMBO72lmNDS-64HYVh8hXw-1; Fri, 27 Mar 2020 12:36:30 -0400
X-MC-Unique: fMBO72lmNDS-64HYVh8hXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C70D1935790;
 Fri, 27 Mar 2020 16:36:29 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0365DA75;
 Fri, 27 Mar 2020 16:36:23 +0000 (UTC)
Date: Fri, 27 Mar 2020 17:36:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200327173622.0fb2f5dc@redhat.com>
In-Reply-To: <20200327104828.12647-1-imammedo@redhat.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

could you take it along with Olaf's xenfv patch?


On Fri, 27 Mar 2020 06:48:28 -0400
Igor Mammedov <imammedo@redhat.com> wrote:

> Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> machine fails to start with:
>    qemu-system-i386: xen: failed to populate ram at 0
> 
> The reason is that xen_ram_alloc() which is called by
> memory_region_init_ram(), compares memory region with
> statically allocated 'global' ram_memory memory region
> that it uses for RAM, and does nothing in case it matches.
> 
> While it's possible feed machine->ram to xen_ram_alloc()
> in the same manner to keep that hack working, I'd prefer
> not to keep that circular dependency and try to untangle that.
> 
> However it doesn't look trivial to fix, so as temporary
> fixup opt out Xen machine from memdev based RAM allocation,
> and let xen_ram_alloc() do its trick for now.
> 
> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
>    - compile tested only
> 
>  hw/i386/pc_piix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e6756216f9..6cb352363d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -953,6 +953,10 @@ static void xenfv_machine_options(MachineClass *m)
>      m->desc = "Xen Fully-virtualized PC";
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
> +    /*
> +     * opt out of system RAM being allocated by generic code
> +     */
> +    m->default_ram_id = NULL;
>  }
>  
>  DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,


