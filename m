Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F1C04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D220C2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D220C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSuqG-0005Pg-7G
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 22:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSupV-00055I-Lq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSupU-0005Y3-BC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:48:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:22911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSupR-0005Nu-Uj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:48:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 19:48:20 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 20 May 2019 19:48:18 -0700
Date: Tue, 21 May 2019 10:47:48 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190521024748.GA23193@richard>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-7-quintela@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH v3 6/8] migration: Make none operations
 into its own structure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:15:42PM +0200, Juan Quintela wrote:
>+
>+MultifdMethods multifd_none_ops = {
>+    .send_prepare = none_send_prepare,
>+    .send_write = none_send_write,
>+    .recv_pages = none_recv_pages
>+};
>+
> static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> {
>     MultiFDInit_t msg;
>@@ -904,6 +938,8 @@ struct {
>     uint64_t packet_num;
>     /* send channels ready */
>     QemuSemaphore channels_ready;
>+    /* multifd ops */
>+    MultifdMethods *ops;
> } *multifd_send_state;
> 
> /*
>@@ -1093,6 +1129,8 @@ static void *multifd_send_thread(void *opaque)
>     /* initial packet */
>     p->num_packets = 1;
> 
>+    multifd_send_state->ops = &multifd_none_ops;
>+

I am afraid it is not a good practice to assign ops when each thread starts
work.

>     while (true) {
>         qemu_sem_wait(&p->sem);
>         qemu_mutex_lock(&p->mutex);
>@@ -1102,7 +1140,12 @@ static void *multifd_send_thread(void *opaque)
>             uint64_t packet_num = p->packet_num;
>             uint32_t flags = p->flags;
> 
>-            p->next_packet_size = used * qemu_target_page_size();
>+            if (used) {
>+                ret = multifd_send_state->ops->send_prepare(p, used);
>+                if (ret != 0) {
>+                    break;
>+                }
>+            }
>             multifd_send_fill_packet(p);
>             p->flags = 0;
>             p->num_packets++;
>@@ -1120,8 +1163,7 @@ static void *multifd_send_thread(void *opaque)
>             }
> 
>             if (used) {
>-                ret = qio_channel_writev_all(p->c, p->pages->iov,
>-                                             used, &local_err);
>+                ret = multifd_send_state->ops->send_write(p, used, &local_err);
>                 if (ret != 0) {
>                     break;
>                 }
>@@ -1223,6 +1265,8 @@ struct {
>     QemuSemaphore sem_sync;
>     /* global number of generated multifd packets */
>     uint64_t packet_num;
>+    /* multifd ops */
>+    MultifdMethods *ops;
> } *multifd_recv_state;
> 
> static void multifd_recv_terminate_threads(Error *err)
>@@ -1324,6 +1368,7 @@ static void *multifd_recv_thread(void *opaque)
>     trace_multifd_recv_thread_start(p->id);
>     rcu_register_thread();
> 
>+    multifd_recv_state->ops = &multifd_none_ops;

same as here.

>     while (true) {
>         uint32_t used;
>         uint32_t flags;
>@@ -1353,8 +1398,7 @@ static void *multifd_recv_thread(void *opaque)
>         qemu_mutex_unlock(&p->mutex);
> 
>         if (used) {
>-            ret = qio_channel_readv_all(p->c, p->pages->iov,
>-                                        used, &local_err);
>+            ret = multifd_recv_state->ops->recv_pages(p, used, &local_err);
>             if (ret != 0) {
>                 break;
>             }
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me

