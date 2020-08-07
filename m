Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA196C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7300620866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2SE8tPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45cQ-0007EF-GS
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k45bs-0006o5-3d
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:52:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k45bp-0004bB-Js
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596819164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pIG/aH2wc8pY2KNeDuIKmGNA5chpYixi7BZ8A2QlNmM=;
 b=J2SE8tPpmEQG6IOibj3sNEuw7IsS52iugkTuMFDzr2i6AM/J2Kt9UD8yMMGWAL2vmCoA+p
 hsu+uC/NjOgjNs4nWibXxvXjJPw5Tb4sGvlYCL8u/QhgRMmk43bcD3kihnlwtE+7wytPGp
 zEE19HANhnpkRK+H747ppbksbBTKk7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-cJRY--xSMW2OBy08H3Mccg-1; Fri, 07 Aug 2020 12:52:42 -0400
X-MC-Unique: cJRY--xSMW2OBy08H3Mccg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDE1C8017FB;
 Fri,  7 Aug 2020 16:52:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9866610F3;
 Fri,  7 Aug 2020 16:52:25 +0000 (UTC)
Date: Fri, 7 Aug 2020 17:52:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies
 for EPYC
Message-ID: <20200807165222.GB120942@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 11:32:51AM -0500, Babu Moger wrote:
> Adding a new check to warn the users to configure 'dies' when
> topology is numa configured. It makes it easy to build the
> topology for EPYC models.

This says you're adding a warning....

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/x86.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 67bee1bcb8..2a6ce56ef1 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>  
>      /* Check for apicid encoding */
>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> +        if ((ms->numa_state->num_nodes > 0) &&
> +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
> +            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
> +                       "parameter. Configure the cpu topology properly with "
> +                       "max_cpus = sockets * dies * cores * threads");

...but you're actually making this a fatal error, not a warning.

I'm not sure this is really OK. Wouldn't this mean that existing VMs
deployed today, risk triggering this fatal error next time they
are booted, or live migrated.  If it is possible someone is using
such a config today, I don't think we can break it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


