Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC38ECA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661BF206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/oEqntb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661BF206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYie-0003qm-IV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYYhq-0002wc-Dp
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:28:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYYho-00031b-FV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589304514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kKuB+twe0f9Rj4w36GrX07xx6MAv17M4R5Tr2ZR7bw=;
 b=B/oEqntb768d4EKK0aC4hmo1Y5G4MfsZ3XMQ2TKVNg0gUdZVioGk4I+Sgk6/JK5g1aEC+1
 PqWhapvnFIoyqnoBR6TNjSNTBdkIDkogUNZuU+GlT8CljL7dUmzFiXAq2l/jAB6w1Yxpoi
 J+1zR/KIY3DudtrxMyfJwz6FHAsbfC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-r3cpafckOpqYyYqPQ4oTFA-1; Tue, 12 May 2020 13:28:32 -0400
X-MC-Unique: r3cpafckOpqYyYqPQ4oTFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7D31009617;
 Tue, 12 May 2020 17:28:31 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E84D60C80;
 Tue, 12 May 2020 17:28:26 +0000 (UTC)
Date: Tue, 12 May 2020 18:28:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <20200512172824.GI2802@work-vm>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
 <0380e994e53947cd961cc363d46561d3@intel.com>
 <20200507175421.185b48f8@luklap>
 <59eea784a36643b4b1fe32b0700f57f7@intel.com>
 <20200508081057.7f1db99b@luklap>
 <9cacfbefef504b94b2b3c19b2bffaff0@intel.com>
MIME-Version: 1.0
In-Reply-To: <9cacfbefef504b94b2b3c19b2bffaff0@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lukas Straub <lukasstraub2@web.de>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhang, Chen (chen.zhang@intel.com) wrote:
> 
> 
> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Friday, May 8, 2020 2:11 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
> > colo-compare is active
> > 
> > On Fri, 8 May 2020 02:26:21 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > 
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Thursday, May 7, 2020 11:54 PM
> > > > To: Zhang, Chen <chen.zhang@intel.com>
> > > > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > > > André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>
> > > > Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check
> > > > that colo-compare is active
> > > >
> > > > On Thu, 7 May 2020 11:38:04 +0000
> > > > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > > >
> > > > > > -----Original Message-----
> > > > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > > > Sent: Monday, May 4, 2020 6:28 PM
> > > > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>;
> > > > > > Marc- André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > > > <pbonzini@redhat.com>
> > > > > > Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check
> > > > > > that
> > > > > > colo- compare is active
> > > > > >
> > > > > > If the colo-compare object is removed before failover and a
> > > > > > checkpoint happens, qemu crashes because it tries to lock the
> > > > > > destroyed event_mtx in colo_notify_compares_event.
> > > > > >
> > > > > > Fix this by checking if everything is initialized by introducing
> > > > > > a new variable colo_compare_active which is protected by a new
> > > > > > mutex colo_compare_mutex. The new mutex also protects against
> > > > > > concurrent access of the net_compares list and makes sure that
> > > > > > colo_notify_compares_event isn't active while we destroy
> > > > > > event_mtx and event_complete_cond.
> > > > > >
> > > > > > With this it also is again possible to use colo without
> > > > > > colo-compare (periodic
> > > > > > mode) and to use multiple colo-compare for multiple network
> > interfaces.
> > > > > >
> > > > >
> > > > > Hi Lukas,
> > > > >
> > > > > For this case I think we don't need to touch vl.c code, we can
> > > > > solve this
> > > > issue from another perspective:
> > > > > How to remove colo-compare?
> > > > > User will use qemu-monitor or QMP command to disable an object, so
> > > > > we just need return operation failed When user try to remove
> > > > > colo-compare
> > > > object while COLO is running.
> > > >
> > > > Yeah, but that still leaves the other problem that colo can't be
> > > > used without colo-compare (qemu crashes then).
> > >
> > > Yes, the COLO-compare is necessary module in COLO original design.
> > > At most cases, user need it do dynamic sync.
> > > For rare cases, maybe we can add a new colo-compare parameter to
> > bypass all the network workload.
> > 
> > I think such an parameter would only be a workaround instead of a real
> > solution like this patch.
> 
> The root problem is why COLO-compare is necessary.
> Yes, maybe someone want to use pure periodic synchronization mode,
> But it means it will lost all guest network support(without colo-compare/filter-mirror/filter-redirector/filter-rewriter).
> The secondary guest just a solid backup for the primary guest, when occur failover the new build stateful connection (like TCP)
> will crashed, need userspace to handle this status. It lost the original meaning for COLO FT/HA solution, no need use do HA in application layer.
> it looks like normal/remote periodic VM snapshot here. 
> Dave or Jason have any comments here? 

People have done fixed-rate VM synchronisation in the past;
and there are workloads where the packet stream is particularly random
so you almost always get comparison miscompares.

But in those setups, the rest of the configuration is very different -
since the destination isn't running at the same time as the source, the
block mirroring also gets simpler in those scenarious.

One thing we played with in the past was dynamically turning
comparison on and off; switching back to simpler synchronisation
if the workload turns out to suit it.

Dave

> Thanks
> Zhang Chen
> 
> > 
> > Regards,
> > Lukas Straub
> > 
> > > Thanks
> > > Zhang Chen
> > >
> > > >
> > > > Regards,
> > > > Lukas Straub
> > > >
> > > > > Thanks
> > > > > Zhang Chen
> > > > >
> > > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > > > ---
> > > > > >  net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
> > > > > >  net/colo-compare.h |  1 +
> > > > > >  softmmu/vl.c       |  2 ++
> > > > > >  3 files changed, 32 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > > > 56db3d3bfc..c7572d75e9 100644
> > > > > > --- a/net/colo-compare.c
> > > > > > +++ b/net/colo-compare.c
> > > > > > @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =
> > > > > > #define REGULAR_PACKET_CHECK_MS 3000  #define
> > > > DEFAULT_TIME_OUT_MS
> > > > > > 3000
> > > > > >
> > > > > > +static QemuMutex colo_compare_mutex; static bool
> > > > > > +colo_compare_active;
> > > > > >  static QemuMutex event_mtx;
> > > > > >  static QemuCond event_complete_cond;  static int
> > > > > > event_unhandled_count; @@ -906,6 +908,12 @@ static void
> > > > > > check_old_packet_regular(void *opaque) void
> > > > > > colo_notify_compares_event(void *opaque, int event, Error **errp)
> > {
> > > > > >      CompareState *s;
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > > +
> > > > > > +    if (!colo_compare_active) {
> > > > > > +        qemu_mutex_unlock(&colo_compare_mutex);
> > > > > > +        return;
> > > > > > +    }
> > > > > >
> > > > > >      qemu_mutex_lock(&event_mtx);
> > > > > >      QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7
> > > > > > @@ void colo_notify_compares_event(void *opaque, int event,
> > Error **errp)
> > > > > >      }
> > > > > >
> > > > > >      qemu_mutex_unlock(&event_mtx);
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >  }
> > > > > >
> > > > > >  static void colo_compare_timer_init(CompareState *s) @@ -1274,7
> > > > > > +1283,14 @@ static void colo_compare_complete(UserCreatable *uc,
> > > > Error **errp)
> > > > > >                             s->vnet_hdr);
> > > > > >      }
> > > > > >
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > > +    if (!colo_compare_active) {
> > > > > > +        qemu_mutex_init(&event_mtx);
> > > > > > +        qemu_cond_init(&event_complete_cond);
> > > > > > +        colo_compare_active = true;
> > > > > > +    }
> > > > > >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >
> > > > > >      s->out_sendco.s = s;
> > > > > >      s->out_sendco.chr = &s->chr_out; @@ -1290,9 +1306,6 @@
> > > > > > static void colo_compare_complete(UserCreatable
> > > > > > *uc, Error **errp)
> > > > > >
> > > > > >      g_queue_init(&s->conn_list);
> > > > > >
> > > > > > -    qemu_mutex_init(&event_mtx);
> > > > > > -    qemu_cond_init(&event_complete_cond);
> > > > > > -
> > > > > >      s->connection_track_table =
> > > > > > g_hash_table_new_full(connection_key_hash,
> > > > > >                                                        connection_key_equal,
> > > > > >                                                        g_free,
> > > > > > @@
> > > > > > -1384,12 +1397,19 @@ static void colo_compare_finalize(Object
> > > > > > *obj)
> > > > > >
> > > > > >      qemu_bh_delete(s->event_bh);
> > > > > >
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > >      QTAILQ_FOREACH(tmp, &net_compares, next) {
> > > > > >          if (tmp == s) {
> > > > > >              QTAILQ_REMOVE(&net_compares, s, next);
> > > > > >              break;
> > > > > >          }
> > > > > >      }
> > > > > > +    if (QTAILQ_EMPTY(&net_compares)) {
> > > > > > +        colo_compare_active = false;
> > > > > > +        qemu_mutex_destroy(&event_mtx);
> > > > > > +        qemu_cond_destroy(&event_complete_cond);
> > > > > > +    }
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >
> > > > > >      AioContext *ctx = iothread_get_aio_context(s->iothread);
> > > > > >      aio_context_acquire(ctx);
> > > > > > @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object
> > *obj)
> > > > > >          object_unref(OBJECT(s->iothread));
> > > > > >      }
> > > > > >
> > > > > > -    qemu_mutex_destroy(&event_mtx);
> > > > > > -    qemu_cond_destroy(&event_complete_cond);
> > > > > > -
> > > > > >      g_free(s->pri_indev);
> > > > > >      g_free(s->sec_indev);
> > > > > >      g_free(s->outdev);
> > > > > >      g_free(s->notify_dev);
> > > > > >  }
> > > > > >
> > > > > > +void colo_compare_init_globals(void) {
> > > > > > +    colo_compare_active = false;
> > > > > > +    qemu_mutex_init(&colo_compare_mutex);
> > > > > > +}
> > > > > > +
> > > > > >  static const TypeInfo colo_compare_info = {
> > > > > >      .name = TYPE_COLO_COMPARE,
> > > > > >      .parent = TYPE_OBJECT,
> > > > > > diff --git a/net/colo-compare.h b/net/colo-compare.h index
> > > > > > 22ddd512e2..eb483ac586 100644
> > > > > > --- a/net/colo-compare.h
> > > > > > +++ b/net/colo-compare.h
> > > > > > @@ -17,6 +17,7 @@
> > > > > >  #ifndef QEMU_COLO_COMPARE_H
> > > > > >  #define QEMU_COLO_COMPARE_H
> > > > > >
> > > > > > +void colo_compare_init_globals(void);
> > > > > >  void colo_notify_compares_event(void *opaque, int event, Error
> > > > > > **errp); void colo_compare_register_notifier(Notifier *notify);
> > > > > > void colo_compare_unregister_notifier(Notifier *notify); diff
> > > > > > --git a/softmmu/vl.c b/softmmu/vl.c index 32c0047889..a913ed5469
> > > > > > 100644
> > > > > > --- a/softmmu/vl.c
> > > > > > +++ b/softmmu/vl.c
> > > > > > @@ -112,6 +112,7 @@
> > > > > >  #include "qapi/qmp/qerror.h"
> > > > > >  #include "sysemu/iothread.h"
> > > > > >  #include "qemu/guest-random.h"
> > > > > > +#include "net/colo-compare.h"
> > > > > >
> > > > > >  #define MAX_VIRTIO_CONSOLES 1
> > > > > >
> > > > > > @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char
> > > > **envp)
> > > > > >      precopy_infrastructure_init();
> > > > > >      postcopy_infrastructure_init();
> > > > > >      monitor_init_globals();
> > > > > > +    colo_compare_init_globals();
> > > > > >
> > > > > >      if (qcrypto_init(&err) < 0) {
> > > > > >          error_reportf_err(err, "cannot initialize crypto: ");
> > > > > > --
> > > > > > 2.20.1
> > > > >
> > >
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


