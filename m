Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB264C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109D0221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVWMmzpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109D0221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnzw-00035b-WC
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGnzR-0002gl-S8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:41:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGnzP-0002Pa-Lk
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599849697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5r0KtJRo40wObOloCnCppzzSQPOmhOLy//Z+n2z+HwM=;
 b=AVWMmzpWYHeDRCnVrn38ezMz12ui7D4t7rnS5H5THefLQs8KOscgFdPCX2KgV+FCtM+w5q
 mTiYPNHFoeH17jdPefxcmsVhU9aXenrapKzikmxzEuhiCnIqpOV8Kve8YInGZRVc+z8jyn
 mJKdKdXa/WrQKzzqfDQmpKaT3pbmn3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-xIkmzKYpNiix6PgKoG1zYA-1; Fri, 11 Sep 2020 14:41:35 -0400
X-MC-Unique: xIkmzKYpNiix6PgKoG1zYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A31DB2FD07;
 Fri, 11 Sep 2020 18:41:34 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5A981C48;
 Fri, 11 Sep 2020 18:41:20 +0000 (UTC)
Date: Fri, 11 Sep 2020 19:41:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>, alex.bennee@linaro.org,
 philmd@redhat.com
Subject: Re: [PATCH V1 13/32] gdbstub: gdb support for suspended state
Message-ID: <20200911184118.GS3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-14-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-14-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Modify the gdb server so a continue command appears to resume execution
> when in RUN_STATE_SUSPENDED.  Do not print the next gdb prompt, but do not
> actually resume instruction fetch.  While in this "fake" running mode, a
> ctrl-C returns the user to the gdb prompt.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

This patch doesn't feel like it lives here; it seems to be a separate
gdbstub patch and it'll get noticed/merged quicker just sent on it's
own.

Dave

> ---
>  gdbstub.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index f3a318c..2f0d9ff 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -461,7 +461,9 @@ static inline void gdb_continue(void)
>  #else
>      if (!runstate_needs_reset()) {
>          trace_gdbstub_op_continue();
> -        vm_start();
> +        if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +            vm_start();
> +        }
>      }
>  #endif
>  }
> @@ -490,7 +492,7 @@ static int gdb_continue_partial(char *newstates)
>      int flag = 0;
>  
>      if (!runstate_needs_reset()) {
> -        if (vm_prepare_start()) {
> +        if (!runstate_check(RUN_STATE_SUSPENDED) && vm_prepare_start()) {
>              return 0;
>          }
>  
> @@ -2835,6 +2837,9 @@ static void gdb_read_byte(uint8_t ch)
>          /* when the CPU is running, we cannot do anything except stop
>             it when receiving a char */
>          vm_stop(RUN_STATE_PAUSED);
> +    } else if (runstate_check(RUN_STATE_SUSPENDED) && ch == 3) {
> +        /* Received ctrl-c from gdb */
> +        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
>      } else
>  #endif
>      {
> @@ -3282,6 +3287,8 @@ static void gdb_sigterm_handler(int signal)
>  {
>      if (runstate_is_running()) {
>          vm_stop(RUN_STATE_PAUSED);
> +    } else if (runstate_check(RUN_STATE_SUSPENDED)) {
> +        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
>      }
>  }
>  #endif
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


