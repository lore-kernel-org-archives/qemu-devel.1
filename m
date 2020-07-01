Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78670C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421D920663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFy8xiPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421D920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqWpm-0007pp-JC
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 03:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqWp3-0007QM-DN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:06:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqWp1-0007W0-Gn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593587175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5N0efCjvXN0ZgBlBGl1Jljp0aLrVZDAwT3j9wwkYJ8=;
 b=NFy8xiPK2pUUOYxUoTfticqwdBLBMyKxsODUgvkbPsGB65eJD5VTHszaidTiVZdM1uqfZ+
 qkNaGUgweFMh5cZpy039uOc00pE2SKjBotxtgrPjIvbE/F5UXfsxR+i/sxeri5mv/3MvDq
 HXx3tVfqPRR2x4xRlGJog6fjTWOlQAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-qQpyCNNyNNiseqwR0liZhQ-1; Wed, 01 Jul 2020 03:06:12 -0400
X-MC-Unique: qQpyCNNyNNiseqwR0liZhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4251110059A5;
 Wed,  1 Jul 2020 07:06:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FEE3101E677;
 Wed,  1 Jul 2020 07:06:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9983611384A6; Wed,  1 Jul 2020 09:06:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: lichun <lichun@ruijie.com.cn>
Subject: Re: [PATCH v2] chardev/tcp: fix error message double free error
References: <20200621213017.17978-1-lichun@ruijie.com.cn>
Date: Wed, 01 Jul 2020 09:06:06 +0200
In-Reply-To: <20200621213017.17978-1-lichun@ruijie.com.cn>
 (lichun@ruijie.com.cn's message of "Mon, 22 Jun 2020 05:30:17 +0800")
Message-ID: <87zh8jbtpd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, 706701795@qq.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lichun <lichun@ruijie.com.cn> writes:

> Signed-off-by: lichun <lichun@ruijie.com.cn>
> ---
>  chardev/char-socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index afebeec5c3..569d54c144 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr,
>                            "Unable to connect character device %s: ",
>                            chr->label);
>          s->connect_err_reported = true;
> +    } else {
> +        error_free(err);
>      }
>      qemu_chr_socket_restart_timer(chr);
>  }
> @@ -1086,7 +1088,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>          check_report_connect_error(chr, err);
> -        error_free(err);
>          goto cleanup;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

and queued, thanks!


