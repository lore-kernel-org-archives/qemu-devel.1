Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A5EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A0A207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjiZ+jC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A0A207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPTA-0004g3-ES
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbPNR-0002rW-SF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:07:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbPNR-0002Jo-5S
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589983640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YR2FoUY7vdTYcYyk7WUgvCbigEn6xSFvQxyQJ1F8nKM=;
 b=HjiZ+jC+Qkb/VuX5piskAF9xiN9FRdKVWHZQLB1dtVphj1Qg+6kucQ5j2ihAh6r79NT8pB
 OepbknwYNsU1a68BGRfMpo1hhJG1s/52tH5Hf4oTEcHpJ0nE/0WTG6py0ubmzBo+Z7xzsG
 x8pywqaU6vanr6n6aARkWJj5EmGyuKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-XecUaje-NEa1nIv0VSSaIg-1; Wed, 20 May 2020 10:07:16 -0400
X-MC-Unique: XecUaje-NEa1nIv0VSSaIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C113835B40;
 Wed, 20 May 2020 14:07:15 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A13105D9CA;
 Wed, 20 May 2020 14:07:03 +0000 (UTC)
Date: Wed, 20 May 2020 16:07:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 13/22] x86: coldplug cpus
Message-ID: <20200520160701.2157aad0@redhat.com>
In-Reply-To: <20200520132003.9492-14-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-14-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 15:19:54 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> microvm needs this, for correct madt creation
> (make sure enable bit is set).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/x86.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 7a3bc7ab6639..ac7a0a958781 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -118,6 +118,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>  void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>      Object *cpu = NULL;
>      Error *local_err = NULL;
>  
> @@ -126,6 +127,16 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>      object_property_set_bool(cpu, true, "realized", &local_err);
>  
> +    if (!mc->has_hotpluggable_cpus) {
> +        /* coldplug cpu */
> +        MachineState *ms = MACHINE(x86ms);
> +        int i = 0;
> +        while (ms->possible_cpus->cpus[i].arch_id != apic_id) {
> +            i++;
> +        }
> +        ms->possible_cpus->cpus[i].cpu = cpu;
> +    }

I'm thinking about removing x86_cpu_new alogether (in favor of device_add),
so I'd preffer avoid adding direct access to possible_cpus here.

that's the job of pc_cpu_plug (and possibly pc_cpu_pre_plug) in combination with
static const TypeInfo pc_machine_info = {
    .name = TYPE_PC_MACHINE,
...
    .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
    },
};

I'd reuse common code if possible in microvm or make microvm specific simplified version of it
if it makes job easier.

>      object_unref(cpu);
>      error_propagate(errp, local_err);
>  }


