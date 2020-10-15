Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5854722243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/H+vbg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854722243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSxzh-0004AN-9U
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSxxy-0003Di-Dq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSxxv-0006Os-IF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602747981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxTf25B14F3eAb+ijzZvQS8pDiXzU9GSA98qXZ1zhWk=;
 b=h/H+vbg9yq07gaE0J2xKUEjFxDXVoDcQtr3F5vPJaJh4eiaHWfTkOUg7yKt24NzI6VWC+T
 rX84tnyJLHMNzONyM9YZ8CjhJ3QzPXrYcZEXwjlZ6B3FVm8+WacgneTkwXH0qyZtVvSJjd
 Ymw4Czc+3t5CbLrvCRTUV8AqEinwniE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-9AAbT7pJPu2ILK9fkC1W-w-1; Thu, 15 Oct 2020 03:46:17 -0400
X-MC-Unique: 9AAbT7pJPu2ILK9fkC1W-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43AF5803626;
 Thu, 15 Oct 2020 07:46:16 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 046D219C4F;
 Thu, 15 Oct 2020 07:46:14 +0000 (UTC)
Date: Thu, 15 Oct 2020 09:46:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] monitor: Fix order in monitor_cleanup()
Message-ID: <20201015074613.GA4610@merkur.fritz.box>
References: <20201013125027.41003-1-kwolf@redhat.com>
 <878sc8yba7.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <878sc8yba7.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
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
Cc: f4bug@amsat.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.10.2020 um 19:20 hat Alex Bennée geschrieben:
> 
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > We can only destroy Monitor objects after we're sure that they are not
> > in use by the dispatcher coroutine any more. This fixes crashes like the
> > following where we tried to destroy a monitor mutex while the dispatcher
> > coroutine still holds it:
> >
> >  (gdb) bt
> >  #0  0x00007fe541cf4bc5 in raise () at /lib64/libc.so.6
> >  #1  0x00007fe541cdd8a4 in abort () at /lib64/libc.so.6
> >  #2  0x000055c24e965327 in error_exit (err=16, msg=0x55c24eead3a0 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:37
> >  #3  0x000055c24e9654c3 in qemu_mutex_destroy (mutex=0x55c25133e0f0) at ../util/qemu-thread-posix.c:70
> >  #4  0x000055c24e7cfaf1 in monitor_data_destroy_qmp (mon=0x55c25133dfd0) at ../monitor/qmp.c:439
> >  #5  0x000055c24e7d23bc in monitor_data_destroy (mon=0x55c25133dfd0) at ../monitor/monitor.c:615
> >  #6  0x000055c24e7d253a in monitor_cleanup () at ../monitor/monitor.c:644
> >  #7  0x000055c24e6cb002 in qemu_cleanup () at ../softmmu/vl.c:4549
> >  #8  0x000055c24e0d259b in main (argc=24, argv=0x7ffff66b0d58, envp=0x7ffff66b0e20) at ../softmmu/main.c:51
> >
> > Reported-by: Alex Bennée <alex.bennee@linaro.org>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> LGTM:
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Who's tree is going to take it?

In theory Markus, but he's on vacation this week. As this seems to
affect multiple people and we want to unblock testing quickly, I'll just
take it through mine.

Kevin


