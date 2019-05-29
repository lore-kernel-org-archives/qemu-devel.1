Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDFC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1911423DB4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911423DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1YZ-0007xB-VC
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:36:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hW1XZ-0007YX-60
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hW1XX-000194-Eo
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hW1XX-00016t-5p
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:34:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57E786CFBE
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 16:34:55 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF5161781;
	Wed, 29 May 2019 16:34:50 +0000 (UTC)
Date: Wed, 29 May 2019 17:34:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190529163447.GK2882@work-vm>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-7-quintela@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 29 May 2019 16:34:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> It will be used later.

'none' is confusing - I think this is no-compression specifically -
right?
I'd be happy with something abbreviated like 'nocomp'

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1ca9ba77b6..6679e4f213 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -700,6 +700,40 @@ typedef struct {
>      QemuSemaphore sem_sync;
>  } MultiFDRecvParams;
>  
> +typedef struct {
> +    /* Prepare the send packet */
> +    int (*send_prepare)(MultiFDSendParams *p, uint32_t used);
> +    /* Write the send packet */
> +    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **perr);
> +    /* Read all pages */
> +    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **perr);
> +} MultifdMethods;
> +
> +/* Multifd without compression */
> +
> +static int none_send_prepare(MultiFDSendParams *p, uint32_t used)
> +{
> +    p->next_packet_size = used * qemu_target_page_size();
> +    return 0;
> +}
> +
> +static int none_send_write(MultiFDSendParams *p, uint32_t used, Error **perr)
> +{
> +    return qio_channel_writev_all(p->c, p->pages->iov, used, perr);
> +}
> +
> +static int none_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **perr)
> +{
> +    return qio_channel_readv_all(p->c, p->pages->iov, used, perr);
> +
> +}
> +
> +MultifdMethods multifd_none_ops = {
> +    .send_prepare = none_send_prepare,
> +    .send_write = none_send_write,
> +    .recv_pages = none_recv_pages
> +};
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
>      MultiFDInit_t msg;
> @@ -904,6 +938,8 @@ struct {
>      uint64_t packet_num;
>      /* send channels ready */
>      QemuSemaphore channels_ready;
> +    /* multifd ops */
> +    MultifdMethods *ops;
>  } *multifd_send_state;
>  
>  /*
> @@ -1093,6 +1129,8 @@ static void *multifd_send_thread(void *opaque)
>      /* initial packet */
>      p->num_packets = 1;
>  
> +    multifd_send_state->ops = &multifd_none_ops;
> +

I agree with Wei Yang that is a bad idea; that should be done once
before the first thread is started.

Dave

>      while (true) {
>          qemu_sem_wait(&p->sem);
>          qemu_mutex_lock(&p->mutex);
> @@ -1102,7 +1140,12 @@ static void *multifd_send_thread(void *opaque)
>              uint64_t packet_num = p->packet_num;
>              uint32_t flags = p->flags;
>  
> -            p->next_packet_size = used * qemu_target_page_size();
> +            if (used) {
> +                ret = multifd_send_state->ops->send_prepare(p, used);
> +                if (ret != 0) {
> +                    break;
> +                }
> +            }
>              multifd_send_fill_packet(p);
>              p->flags = 0;
>              p->num_packets++;
> @@ -1120,8 +1163,7 @@ static void *multifd_send_thread(void *opaque)
>              }
>  
>              if (used) {
> -                ret = qio_channel_writev_all(p->c, p->pages->iov,
> -                                             used, &local_err);
> +                ret = multifd_send_state->ops->send_write(p, used, &local_err);
>                  if (ret != 0) {
>                      break;
>                  }
> @@ -1223,6 +1265,8 @@ struct {
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> +    /* multifd ops */
> +    MultifdMethods *ops;
>  } *multifd_recv_state;
>  
>  static void multifd_recv_terminate_threads(Error *err)
> @@ -1324,6 +1368,7 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
> +    multifd_recv_state->ops = &multifd_none_ops;
>      while (true) {
>          uint32_t used;
>          uint32_t flags;
> @@ -1353,8 +1398,7 @@ static void *multifd_recv_thread(void *opaque)
>          qemu_mutex_unlock(&p->mutex);
>  
>          if (used) {
> -            ret = qio_channel_readv_all(p->c, p->pages->iov,
> -                                        used, &local_err);
> +            ret = multifd_recv_state->ops->recv_pages(p, used, &local_err);
>              if (ret != 0) {
>                  break;
>              }
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

