Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B83C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557A320735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0+peHox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557A320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZWO-0006sd-Hm
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVZVg-0006PK-M7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:43:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVZVf-0003OX-IT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588592621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HC6izqmuztkiIEZO0ukTQ5tiHkfTyjT8LGMdJFQz1Xk=;
 b=Y0+peHoxHaxt0ZNGBOrSwErsxSgp15YKZfK+7HvzTdfhTmGwEO3Z4BRZ7X6PhbsA9z1X/P
 EEKASIOYPW0O2mp8fPNjlXtTFW9nZVHIciKKZjd3V9yjGhClvzCkJHQnoM/PInNN4BhEJ6
 aYio7vsWNUs6+kYsy7qbqvUQAtCBWxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-hu_ziSd6Ony5CRzR-yGdbA-1; Mon, 04 May 2020 07:43:38 -0400
X-MC-Unique: hu_ziSd6Ony5CRzR-yGdbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ED40100CCC9;
 Mon,  4 May 2020 11:43:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA7C610013D9;
 Mon,  4 May 2020 11:43:32 +0000 (UTC)
Message-ID: <dc58b1574c2f7b2ad8d2f6a126a0241d364890bd.camel@redhat.com>
Subject: Re: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 04 May 2020 14:43:31 +0300
In-Reply-To: <8bb0f2e6-fae8-794b-7954-f9c4add34eee@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200504105949.GD354891@stefanha-x1.localdomain>
 <8bb0f2e6-fae8-794b-7954-f9c4add34eee@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 13:38 +0200, Paolo Bonzini wrote:
> On 04/05/20 12:59, Stefan Hajnoczi wrote:
> > Regarding drive_del, I guess the issue here is that this HMP command's
> > semantics need to include not synchronize_rcu() but some kind of
> > drain_call_rcu() operation as well that ensures deletion has completed?
> 
> Good idea, this would be Linux's rcu_barrier().
> 
> It would be a pity though that we have to do this instead of just having
> the test rely on the DEVICE_DELETED event.
> 
> > drain_call_rcu() can be implemented by invoking call_rcu(temp,
> > drain_call_rcu_cb, rcu) where drain_call_rcu_cb() sets a QemuEvent that
> > the caller is waiting on. This way the caller can be sure that all
> > previously queued call_rcu() callbacks have completed. call_rcu_thread()
> > needs to be tweaked to avoid g_usleep() and instead use a timed wait so
> > that drain_call_rcu() can immediately wake up the thread.
> 
> This was actually intentional in order to let some RCU callbacks pile up
> (based on the observation, or the hope, that RCU data structures are
> written rarely).  But the overall delay would be 50 ms so I don't think
> it's a big deal to keep the unconditional sleep. The synchronize_rcu()
> call could be on the order of 50 ms if --enable-membarrier is in use.
> 
> Another thing to care about is that call_rcu needs the iothread lock, so
> you need to release it around the qemu_event_wait() call.
> 
> Paolo
> 
Thank a lot for the suggestions!
I'll try to implement this in the next version of these patches.

Best regards,
	Maxim Levitsky


