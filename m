Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB27C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9072177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrC0pRKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9072177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZz5-0004FE-Im
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFZxz-00034m-3u
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFZxw-0001sn-09
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGXdMEenheQwjIlaqJKFKV4UjeiuNNi4crlLHPrbUD4=;
 b=DrC0pRKqK6v/o61cGbDRFyyrmvwDNq9eb6ZJahnvSQAZIi7En5heIBAfeo6zZ0E4bNiJ0r
 2lN6SiNa8Jxf7N74iH/y2Uxs5YkHVWlbxbS2SQryqOndOAanBQu/YrRtk+cHJWywMelTm+
 5uemgLEmD7OQFf5Bj6ZD1cMZtgJHV4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-6a9BvZjNMZe6Y_FGImfJEg-1; Tue, 08 Sep 2020 05:31:00 -0400
X-MC-Unique: 6a9BvZjNMZe6Y_FGImfJEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFDCD8018A7
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 09:30:59 +0000 (UTC)
Received: from work-vm (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 737255D9E2;
 Tue,  8 Sep 2020 09:30:55 +0000 (UTC)
Date: Tue, 8 Sep 2020 10:30:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 3/5] migration: Pass incoming state into
 qemu_ufd_copy_ioctl()
Message-ID: <20200908093052.GD3295@work-vm>
References: <20200903152646.93336-1-peterx@redhat.com>
 <20200903152646.93336-4-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903152646.93336-4-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: Xiaohui Li <xiaohli@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> It'll be used in follow up patches to access more fields out of it.  Meanwhile
> fetch the userfaultfd inside the function.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 11a70441a6..d333c3fd0e 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1128,10 +1128,12 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>      return 0;
>  }
>  
> -static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> +static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
>                                 void *from_addr, uint64_t pagesize, RAMBlock *rb)
>  {
> +    int userfault_fd = mis->userfault_fd;
>      int ret;
> +
>      if (from_addr) {
>          struct uffdio_copy copy_struct;
>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> @@ -1185,7 +1187,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
> +    if (qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb)) {
>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -1212,7 +1214,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>       * but it's not available for everything (e.g. hugetlbpages)
>       */
>      if (qemu_ram_is_uf_zeroable(rb)) {
> -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pagesize, rb)) {
> +        if (qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb)) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


