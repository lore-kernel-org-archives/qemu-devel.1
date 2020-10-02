Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4838C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC25420672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnBPPkAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC25420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFsC-0006IT-U8
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFrI-0005Zz-Mp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFrG-00063G-VJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ivkSKsH2SMbCFNJJ/SA1jIYh//S27iTFJYfGDtaqfI8=;
 b=MnBPPkAYxv4VH+RNHJidX0OMlWC0YVw1xiqKSom9Q/B02FnIPjOHy8asa2uk8NorEmkCAW
 61OHV3kLBgQkhqShUDzMjtGcsSRDqN7El/R5q+0XwC7xubrvYMkyQlvImYSDJWWkcDLf/A
 gz+KT53S7Ak/cEpOqQFBNuUz2SgtCBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-zWxNlKJIMNiRFDEKM3A2dg-1; Fri, 02 Oct 2020 03:52:00 -0400
X-MC-Unique: zWxNlKJIMNiRFDEKM3A2dg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C1B9107464C;
 Fri,  2 Oct 2020 07:51:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BEE51002C01;
 Fri,  2 Oct 2020 07:51:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 085531132784; Fri,  2 Oct 2020 09:51:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 03/13] monitor: Use getter/setter functions for cur_mon
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-4-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 09:51:55 +0200
In-Reply-To: <20200909151149.490589-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:39 +0200")
Message-ID: <87v9ftoyjo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> cur_mon really needs to be coroutine-local as soon as we move monitor
> command handlers to coroutines and let them yield. As a first step, just
> remove all direct accesses to cur_mon so that we can implement this in
> the getter function later.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
[...]
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index af9f5c0c70..6c50dbf051 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -52,6 +52,7 @@ static void test_fd_is_socket_good(void)
>  
>  static int mon_fd = -1;
>  static const char *mon_fdname;
> +__thread Monitor *cur_mon;
>  
>  int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  {
> @@ -66,15 +67,12 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  
>  /*
>   * Syms of stubs in libqemuutil.a are discarded at .o file granularity.
> - * To replace monitor_get_fd() we must ensure everything in
> - * stubs/monitor.c is defined, to make sure monitor.o is discarded
> - * otherwise we get duplicate syms at link time.
> + * To replace monitor_get_fd() and monitor_cur(), we must ensure that we also
> + * replace any other symbol that is used in the binary and would be taken from
> + * the same stub object file, otherwise we get duplicate syms at link time.

Wrapping the comment around column 70 or so would make it easier to
read.  File has no maintainers.  Up to you.

>   */
> -__thread Monitor *cur_mon;
> +Monitor *monitor_cur(void) { return cur_mon; }
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp) {}
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp) {}
> -
>  
>  static void test_socket_fd_pass_name_good(void)
>  {
[...]


