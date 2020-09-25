Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A2FC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3533321D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PV4cEALN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3533321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjfO-0000xi-2R
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLje8-0000Bo-Aa
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLje5-00070y-Ij
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:04:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601024640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXvHtfuVOlkqoJoypJxIGAeTTW1MOP7VxHduXp9ZOQg=;
 b=PV4cEALNg1lW/uUq9yJuZvTuxWEns06ixTb4a2jWQiGKoAi8zwrjzTF4vZN6c3AbX3MFey
 p/eyzziSxE1YeXKHlkXhhyIk45fXxBim74Krdx95nLUIG5rE+ubrh8U0wfwiszTGkRV9MY
 amTE8RYAbVRsvoy4y6iuZoQZVG4cY3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-lYVK6Po7OTGPVwcBA3Q_8w-1; Fri, 25 Sep 2020 05:03:58 -0400
X-MC-Unique: lYVK6Po7OTGPVwcBA3Q_8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E2B10082EA;
 Fri, 25 Sep 2020 09:03:57 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 971BF60C17;
 Fri, 25 Sep 2020 09:03:43 +0000 (UTC)
Date: Fri, 25 Sep 2020 10:03:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>, mtosatti@redhat.com
Subject: Re: [PATCH V1 11/32] cpu: disable ticks when suspended
Message-ID: <20200925090340.GC2873@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-12-git-send-email-steven.sistare@oracle.com>
 <20200911175318.GQ3310@work-vm>
 <9b3fa2f8-2457-6c67-dd6e-c861cbd6f309@oracle.com>
MIME-Version: 1.0
In-Reply-To: <9b3fa2f8-2457-6c67-dd6e-c861cbd6f309@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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

* Steven Sistare (steven.sistare@oracle.com) wrote:
> On 9/11/2020 1:53 PM, Dr. David Alan Gilbert wrote:
> > * Steve Sistare (steven.sistare@oracle.com) wrote:
> >> After cprload, the guest console misbehaves.  You must type 8 characters
> >> before any are echoed to the terminal.  Qemu was not sending interrupts
> >> to the guest because the QEMU_CLOCK_VIRTUAL timers_state.cpu_clock_offset
> >> was bad.  The offset is usually updated at cprsave time by the path
> >>
> >>   save_cpr_snapshot()
> >>     vm_stop()
> >>       do_vm_stop()
> >>         if (runstate_is_running())
> >>           cpu_disable_ticks();
> >>             timers_state.cpu_clock_offset = cpu_get_clock_locked();
> >>
> >> However, if the guest is in RUN_STATE_SUSPENDED, then cpu_disable_ticks is
> >> not called.  Further, the earlier transition to suspended in
> >> qemu_system_suspend did not disable ticks.  To fix, call cpu_disable_ticks
> >> from save_cpr_snapshot.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Are you saying this is really a more generic bug with migrating when
> > suspended and we should fix this anyway?
> 
> Yes.  Or when suspended and calling save_vmstate(), or qmp_xen_save_devices_state().
> Each of those functions needs the same fix unless someone identifies a more
> centralized way in the state transition logic to disable ticks.

OK, in that case please split this out of the series and we can take a
fix as normal;  please cc in mtosatti@redhat.com .

Dave

> 
> - Steve
> 
> >> ---
> >>  migration/savevm.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index f101039..00f493b 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -2729,6 +2729,11 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
> >>          return;
> >>      }
> >>  
> >> +    /* Update timers_state before saving.  Suspend did not so do. */
> >> +    if (runstate_check(RUN_STATE_SUSPENDED)) {
> >> +        cpu_disable_ticks();
> >> +    }
> >> +
> >>      vm_stop(RUN_STATE_SAVE_VM);
> >>  
> >>      ret = qemu_savevm_state(f, op, errp);
> >> -- 
> >> 1.8.3.1
> >>
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


