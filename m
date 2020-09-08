Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA9C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA6522527
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrE92SSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA6522527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeWN-0007Zp-VU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFeVC-00060N-Gx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:21:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFeVA-00060e-Sr
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gW41PBOq/8XQPHrO3xhupRYSCov3rduL+p/tX9LQnuo=;
 b=PrE92SSvQ1LL3iIo2lIyx5mPjwfO3rStEyDnGXCLq552pma/CQVc1d5vTchJkBByZmaTtT
 QQeC8GhOXvMSg5FeNFmmRazuRi6IGy6ycFhyBStAxz7rKTrd594KcTJ9JB7nd73uJ2q5Cm
 kh19PZTk8qrOjuiDiysh32esD+y2aUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-wZfXH6dgNh-vfC4IQ5eRlg-1; Tue, 08 Sep 2020 10:21:38 -0400
X-MC-Unique: wZfXH6dgNh-vfC4IQ5eRlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F5381005E5B
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 14:21:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB4B702E7;
 Tue,  8 Sep 2020 14:21:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A43AD113865F; Tue,  8 Sep 2020 16:21:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] monitor: Use LOCK_GUARD macros
References: <20200908135240.130403-1-dgilbert@redhat.com>
Date: Tue, 08 Sep 2020 16:21:35 +0200
In-Reply-To: <20200908135240.130403-1-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Tue, 8 Sep 2020 14:52:40 +0100")
Message-ID: <87363s8i34.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Use the lock guard macros in monitor/misc.c - saves
> a bunch of goto's, and a temporary variable, but mostly
> because I prefer not having to release them in error paths.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor/misc.c | 62 ++++++++++++++++----------------------------------
>  1 file changed, 20 insertions(+), 42 deletions(-)
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index e847b58a8c..7f0b313d53 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -141,13 +141,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      handle_hmp_command(&hmp, command_line);
>      cur_mon = old_mon;
>  
> -    qemu_mutex_lock(&hmp.common.mon_lock);
> -    if (qstring_get_length(hmp.common.outbuf) > 0) {
> -        output = g_strdup(qstring_get_str(hmp.common.outbuf));
> -    } else {
> -        output = g_strdup("");
> +    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
> +        if (qstring_get_length(hmp.common.outbuf) > 0) {
> +            output = g_strdup(qstring_get_str(hmp.common.outbuf));
> +        } else {
> +            output = g_strdup("");
> +        }
>      }
> -    qemu_mutex_unlock(&hmp.common.mon_lock);
>  
>  out:
>      monitor_data_destroy(&hmp.common);


Hardly an improvement here.  I figure you want it for the sake of
consistency.

> @@ -1248,7 +1248,7 @@ void qmp_getfd(const char *fdname, Error **errp)
>          return;
>      }
>  
> -    qemu_mutex_lock(&cur_mon->mon_lock);
> +    QEMU_LOCK_GUARD(&cur_mon->mon_lock);
>      QLIST_FOREACH(monfd, &cur_mon->fds, next) {
>          if (strcmp(monfd->name, fdname) != 0) {
>              continue;
> @@ -1256,7 +1256,6 @@ void qmp_getfd(const char *fdname, Error **errp)
>  
>          tmp_fd = monfd->fd;
>          monfd->fd = fd;
> -        qemu_mutex_unlock(&cur_mon->mon_lock);
>          /* Make sure close() is outside critical section */
>          close(tmp_fd);
>          return;
> @@ -1267,7 +1266,6 @@ void qmp_getfd(const char *fdname, Error **errp)
>      monfd->fd = fd;
>  
>      QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
> -    qemu_mutex_unlock(&cur_mon->mon_lock);
>  }
>  

This one makes more sense.

[More of the same...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


