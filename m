Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92601C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226FC221E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se3gMluq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226FC221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmyQ-0004Gg-3V
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGmxS-0002Zq-2w
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:35:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGmxQ-0001gn-AO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599845731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fUQDJVGFEjiJJ/u2KB+BqhYg/Ze7AzOAVewXjT9Stgg=;
 b=Se3gMluq0z/tcEu11bwqGji3da46zxshobo8jh14d1Yi8Uj8PJ98fjOaSzC8CRFxvQ1fZZ
 H9j9Ofl5h4NLVS24JeqIu87MTP2rjxKKD+aJAOEhOBUG5Ovv9lbD4tVzd6A/Nn08L8ADAf
 JRFAlgoL9hYqfZQXGOKzoJg1DslQTNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-_pNtptcQPweWPJpy3ed4xA-1; Fri, 11 Sep 2020 13:35:30 -0400
X-MC-Unique: _pNtptcQPweWPJpy3ed4xA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1F08010C7;
 Fri, 11 Sep 2020 17:35:28 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC39310013D7;
 Fri, 11 Sep 2020 17:35:14 +0000 (UTC)
Date: Fri, 11 Sep 2020 18:35:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 09/32] savevm: prevent cprsave if memory is volatile
Message-ID: <20200911173512.GO3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-10-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-10-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> cprsave and cprload require that guest ram be backed by an externally
> visible shared file.  Check that in cprsave.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  exec.c                | 32 ++++++++++++++++++++++++++++++++
>  include/exec/memory.h |  2 ++
>  migration/savevm.c    |  4 ++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 6f381f9..02160e0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2726,6 +2726,38 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
>      return block->offset + offset;
>  }
>  
> +/*
> + * Return true if any memory regions are writable and not backed by shared
> + * memory.  Exclude x86 option rom shadow "pc.rom" by name, even though it is
> + * writable.

Tell me about 'pc.rom' - this is a very odd hack.
Again note the trick done by the existing migration capability
x-ignore-shared ; it doesn't special case, it just doesn't migrate
the 'shared' blocks.

Dave


> + */
> +bool qemu_ram_volatile(Error **errp)
> +{
> +    RAMBlock *block;
> +    MemoryRegion *mr;
> +    bool ret = false;
> +
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        mr = block->mr;
> +        if (mr &&
> +            memory_region_is_ram(mr) &&
> +            !memory_region_is_ram_device(mr) &&
> +            !memory_region_is_rom(mr) &&
> +            (!mr->name || strcmp(mr->name, "pc.rom")) &&
> +            (block->fd == -1 || !qemu_ram_is_shared(block))) {
> +
> +            error_setg(errp, "Memory region %s is volatile",
> +                       memory_region_name(mr));
> +            ret = true;
> +            break;
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
>  /* Generate a debug exception if a watchpoint has been hit.  */
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 307e527..6aafbb0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2519,6 +2519,8 @@ bool ram_block_discard_is_disabled(void);
>   */
>  bool ram_block_discard_is_required(void);
>  
> +bool qemu_ram_volatile(Error **errp);
> +
>  #endif
>  
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1509173..f101039 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2713,6 +2713,10 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>          return;
>      }
>  
> +    if (op == VMS_REBOOT && qemu_ram_volatile(errp)) {
> +        return;
> +    }
> +
>      f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
>      if (!f) {
>          return;
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


