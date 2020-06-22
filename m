Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC6C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DA4206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWVwRWe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DA4206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJIa-0002DC-Eq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnJHq-0001m2-Gq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:02:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41534
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnJHo-0007CJ-Eo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592820163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LUqGJEZ9d7pemoW9r6jWeIJwv7AlTMlPdFaPrLSR1mw=;
 b=AWVwRWe567qTfOlot4X+o1RFR530Rvl9iLgKgnSnMvlX5bPM68lmmdO/D8WYHnCiv7uPMm
 4YAM/TNccB1OwEEFH/PdDOd0BfAOb+YFGqXaESAKc8aPBWD3s1lk0BSjC+GhZYJwJ9Hg6m
 hX9P2jHxnJ+yEm43s0mb9VnohsJcsUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-NUJAxVWZORqF3Ybfth4aRg-1; Mon, 22 Jun 2020 06:02:39 -0400
X-MC-Unique: NUJAxVWZORqF3Ybfth4aRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733D28018AC;
 Mon, 22 Jun 2020 10:02:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DDD7C20A;
 Mon, 22 Jun 2020 10:02:29 +0000 (UTC)
Subject: Re: [PATCH v4 2/9] pc-bios: s390x: Consolidate timing functions into
 time.h
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200622074235.32528-1-frankja@linux.ibm.com>
 <20200622074235.32528-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <98bf10d9-76cb-0196-5fef-8a4e3a5b1c4f@redhat.com>
Date: Mon, 22 Jun 2020 12:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622074235.32528-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 09.42, Janosch Frank wrote:
> Let's consolidate timing related functions into one header.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c        |  1 +
>  pc-bios/s390-ccw/netmain.c     | 15 +++------------
>  pc-bios/s390-ccw/s390-ccw.h    |  8 ++++----
>  pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      | 18 +++---------------
>  7 files changed, 36 insertions(+), 31 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/s390-time.h
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index ce3815b201..de8260a5d6 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -12,6 +12,7 @@
>  #include "libc.h"
>  #include "s390-ccw.h"
>  #include "sclp.h"
> +#include "s390-time.h"

You could maybe drop these additional includes...

> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 21f27e7990..fae1de363f 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -74,8 +74,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
>  bool virtio_is_supported(SubChannelId schid);
>  void virtio_blk_setup_device(SubChannelId schid);
>  int virtio_read(ulong sector, void *load_addr);
> -u64 get_clock(void);
> -ulong get_second(void);
>  
>  /* bootmap.c */
>  void zipl_load(void);
> @@ -153,11 +151,13 @@ static inline void yield(void)
>  
>  #define MAX_SECTOR_SIZE 4096
>  
> +#include "s390-time.h"

... since you already include s390-time.h here in this central header
file...

>  static inline void sleep(unsigned int seconds)
>  {
> -    ulong target = get_second() + seconds;
> +    ulong target = get_time_seconds() + seconds;
>  
> -    while (get_second() < target) {
> +    while (get_time_seconds() < target) {
>          yield();
>      }
>  }

... or you could move the sleep() function into s390-time.h, too?

Anyway, both ways are fine for me, so:

Acked-by: Thomas Huth <thuth@redhat.com>


