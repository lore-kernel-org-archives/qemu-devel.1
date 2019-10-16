Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7ECE588
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19735205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19735205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfPg-0005KT-9Y
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iKfOQ-0004OE-Pb
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iKfOP-0003dR-Ob
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iKfOP-0003ck-JF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9F288E581
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:14:52 +0000 (UTC)
Received: from work-vm (ovpn-117-133.ams2.redhat.com [10.36.117.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A92660C5D;
 Wed, 16 Oct 2019 09:14:46 +0000 (UTC)
Date: Wed, 16 Oct 2019 10:14:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/4] migration: Check in savevm_state_handler_insert
 for dups
Message-ID: <20191016091444.GC2978@work-vm>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016022933.7276-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016022933.7276-5-peterx@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 16 Oct 2019 09:14:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Before finally register one SaveStateEntry, we detect for duplicated
> entries.  This could be helpful to notify us asap instead of get
> silent migration failures which could be hard to diagnose.
> 
> For example, this patch will generate a message like this (if without
> previous fixes on x2apic) as long as we wants to boot a VM instance
> with "-smp 200,maxcpus=288,sockets=2,cores=72,threads=2" and QEMU will
> bail out even before VM starts:
> 
> savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=apic, instance_id=0x0
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Right, lets see what this triggers :-)

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1e44f06d7a..83e91ddafa 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -264,6 +264,8 @@ static SaveState savevm_state = {
>      .global_section_id = 0,
>  };
>  
> +static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
> +
>  static bool should_validate_capability(int capability)
>  {
>      assert(capability >= 0 && capability < MIGRATION_CAPABILITY__MAX);
> @@ -714,6 +716,18 @@ static void savevm_state_handler_insert(SaveStateEntry *nse)
>  
>      assert(priority <= MIG_PRI_MAX);
>  
> +    /*
> +     * This should never happen otherwise migration will probably fail
> +     * silently somewhere because we can be wrongly applying one
> +     * object properties upon another one.  Bail out ASAP.
> +     */
> +    if (find_se(nse->idstr, nse->instance_id)) {
> +        error_report("%s: Detected duplicate SaveStateEntry: "
> +                     "id=%s, instance_id=0x%"PRIx32, __func__,
> +                     nse->idstr, nse->instance_id);
> +        exit(EXIT_FAILURE);
> +    }
> +
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (save_state_priority(se) < priority) {
>              break;
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

