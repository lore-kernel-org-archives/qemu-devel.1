Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CFCC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D9620896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D9620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2XI-0004mr-Nk
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb24y-0001RY-IA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb1pY-0006XQ-G9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb1pW-0006VR-Ha
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A25E30984D1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 11:54:13 +0000 (UTC)
Received: from redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01818605CF;
 Wed, 12 Jun 2019 11:54:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190529163447.GK2882@work-vm> (David Alan Gilbert's message of
 "Wed, 29 May 2019 17:34:48 +0100")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-7-quintela@redhat.com>
 <20190529163447.GK2882@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 12 Jun 2019 13:54:10 +0200
Message-ID: <874l4vm331.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 11:54:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] migration: Make none operations
 into its own structure
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> It will be used later.
>
> 'none' is confusing - I think this is no-compression specifically -
> right?
> I'd be happy with something abbreviated like 'nocomp'

I don't care too much, I can change, but when you are setting the value
it gets:

micgration set-parameter compression none

That looks ok.

On the other hand, I can agree that I can call the functions nocomp.

Thanks, Juan.

>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 49 insertions(+), 5 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 1ca9ba77b6..6679e4f213 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -700,6 +700,40 @@ typedef struct {
>>      QemuSemaphore sem_sync;
>>  } MultiFDRecvParams;
>>  
>> +typedef struct {
>> +    /* Prepare the send packet */
>> +    int (*send_prepare)(MultiFDSendParams *p, uint32_t used);
>> +    /* Write the send packet */
>> +    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **perr);
>> +    /* Read all pages */
>> +    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **perr);
>> +} MultifdMethods;
>> +
>> +/* Multifd without compression */
>> +
>> +static int none_send_prepare(MultiFDSendParams *p, uint32_t used)
>> +{
>> +    p->next_packet_size = used * qemu_target_page_size();
>> +    return 0;
>> +}
>> +
>> +static int none_send_write(MultiFDSendParams *p, uint32_t used, Error **perr)
>> +{
>> +    return qio_channel_writev_all(p->c, p->pages->iov, used, perr);
>> +}
>> +
>> +static int none_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **perr)
>> +{
>> +    return qio_channel_readv_all(p->c, p->pages->iov, used, perr);
>> +
>> +}
>> +
>> +MultifdMethods multifd_none_ops = {
>> +    .send_prepare = none_send_prepare,
>> +    .send_write = none_send_write,
>> +    .recv_pages = none_recv_pages
>> +};
>> +
>>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>>  {
>>      MultiFDInit_t msg;
>> @@ -904,6 +938,8 @@ struct {
>>      uint64_t packet_num;
>>      /* send channels ready */
>>      QemuSemaphore channels_ready;
>> +    /* multifd ops */
>> +    MultifdMethods *ops;
>>  } *multifd_send_state;
>>  
>>  /*
>> @@ -1093,6 +1129,8 @@ static void *multifd_send_thread(void *opaque)
>>      /* initial packet */
>>      p->num_packets = 1;
>>  
>> +    multifd_send_state->ops = &multifd_none_ops;
>> +
>
> I agree with Wei Yang that is a bad idea; that should be done once
> before the first thread is started.
>
> Dave
>
>>      while (true) {
>>          qemu_sem_wait(&p->sem);
>>          qemu_mutex_lock(&p->mutex);
>> @@ -1102,7 +1140,12 @@ static void *multifd_send_thread(void *opaque)
>>              uint64_t packet_num = p->packet_num;
>>              uint32_t flags = p->flags;
>>  
>> -            p->next_packet_size = used * qemu_target_page_size();
>> +            if (used) {
>> +                ret = multifd_send_state->ops->send_prepare(p, used);
>> +                if (ret != 0) {
>> +                    break;
>> +                }
>> +            }
>>              multifd_send_fill_packet(p);
>>              p->flags = 0;
>>              p->num_packets++;
>> @@ -1120,8 +1163,7 @@ static void *multifd_send_thread(void *opaque)
>>              }
>>  
>>              if (used) {
>> -                ret = qio_channel_writev_all(p->c, p->pages->iov,
>> -                                             used, &local_err);
>> +                ret = multifd_send_state->ops->send_write(p, used, &local_err);
>>                  if (ret != 0) {
>>                      break;
>>                  }
>> @@ -1223,6 +1265,8 @@ struct {
>>      QemuSemaphore sem_sync;
>>      /* global number of generated multifd packets */
>>      uint64_t packet_num;
>> +    /* multifd ops */
>> +    MultifdMethods *ops;
>>  } *multifd_recv_state;
>>  
>>  static void multifd_recv_terminate_threads(Error *err)
>> @@ -1324,6 +1368,7 @@ static void *multifd_recv_thread(void *opaque)
>>      trace_multifd_recv_thread_start(p->id);
>>      rcu_register_thread();
>>  
>> +    multifd_recv_state->ops = &multifd_none_ops;
>>      while (true) {
>>          uint32_t used;
>>          uint32_t flags;
>> @@ -1353,8 +1398,7 @@ static void *multifd_recv_thread(void *opaque)
>>          qemu_mutex_unlock(&p->mutex);
>>  
>>          if (used) {
>> -            ret = qio_channel_readv_all(p->c, p->pages->iov,
>> -                                        used, &local_err);
>> +            ret = multifd_recv_state->ops->recv_pages(p, used, &local_err);
>>              if (ret != 0) {
>>                  break;
>>              }
>> -- 
>> 2.21.0
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

