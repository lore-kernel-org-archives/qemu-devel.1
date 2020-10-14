Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA362C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8876214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWUAcifA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8876214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmN6-0000ws-6R
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSmLQ-0000DV-CS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSmLO-0001sP-QR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602703310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9fVfOuvd8RNRZl12KnnUQyO9PLzLmh7oBoLCj4+puo=;
 b=QWUAcifA7p1/WRys8JYgzfsgwIglsCp+1XmxriHdpfVKguSoUyvPpPkeHMiUbqqZHmsjAk
 G+amEyubmNtePX9DuPLSr5M7m6wYF9SB4E6gUfJ0pQObHCPIDlWl5loBAG0Q7IbPv2JUbU
 sJnLhWRJGPnwxvMKaoyfWgL96YQDOY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-buTkpci9PsK7CBBrOwRlag-1; Wed, 14 Oct 2020 15:21:48 -0400
X-MC-Unique: buTkpci9PsK7CBBrOwRlag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6ED879539;
 Wed, 14 Oct 2020 19:21:46 +0000 (UTC)
Received: from work-vm (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD7BD19C4F;
 Wed, 14 Oct 2020 19:21:44 +0000 (UTC)
Date: Wed, 14 Oct 2020 20:21:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v2 6/8] migration: Do not initialise statics and globals
 to 0 or NULL
Message-ID: <20201014192142.GL2996@work-vm>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-7-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-7-git-send-email-yubihong@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bihong Yu (yubihong@huawei.com) wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>

OK, sometimes  I find initialisation clearer


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c    | 2 +-
>  migration/savevm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 09178cc..2da2b62 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2743,7 +2743,7 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
>   */
>  static inline RAMBlock *ram_block_from_stream(QEMUFile *f, int flags)
>  {
> -    static RAMBlock *block = NULL;
> +    static RAMBlock *block;
>      char id[256];
>      uint8_t len;
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9e95df1..f808bc2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -64,7 +64,7 @@
>  #include "qemu/bitmap.h"
>  #include "net/announce.h"
>  
> -const unsigned int postcopy_ram_discard_version = 0;
> +const unsigned int postcopy_ram_discard_version;
>  
>  /* Subcommands for QEMU_VM_COMMAND */
>  enum qemu_vm_cmd {
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


