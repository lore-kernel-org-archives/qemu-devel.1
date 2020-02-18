Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE200C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938D0207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2T0+8C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938D0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4AwP-0001Kd-NN
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4AuY-0000Xt-2v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4AuW-0002IP-0M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:00:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4AuV-0002F6-Hk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+W53ILTXmHOlq3XbKJCYxzxzVXDkZrpwBwGxafkzbNY=;
 b=D2T0+8C2tRAo1KFpSRJkKalez1yodV6ZJVqkcntPLR7QvvtJy5RUJYqGRQBb8Y7DYtJQSl
 yYOJlQ4QZV18muZ0tKTQVQlwd2QUP2b5PAj0bcdQtJMCDhSAVAUXs5AkhfRFFtc4/Y1yQr
 M+rYJyyvVR54nMcTxEXTj/43ygodOwg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-sESt9gyWNW-DlbEEiL-95w-1; Tue, 18 Feb 2020 17:00:03 -0500
Received: by mail-qk1-f197.google.com with SMTP id q2so15197877qkq.19
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cpd/buwQ5LZ4CQPY0bxUseKVyE7r0EQCx7JXI1leWlM=;
 b=Dki7oyS6YCnrbAUUsq28dy14UymPJWwqYcT+6OXQDJl7ou3q/9acYLfVI2EpLCQL1O
 f+LlijgElZlN8pBRoi1Wfe+cOkocYEaogdIkByWF4BLBcNsoibIdJHxy7cVALOV6HEAX
 0/3sNVtzJ1XJ02eFjk8BAnAK/upmodfhRuZ10YSJlc/f1cfMi0XZ6NLv3gT7ncho14/W
 Z+xT9ikc2f1N9ExU9WamKV2xkVzCpJb9/lki7+LVE/Xlb5TwpbOwe+NMwq847TVkbx76
 ltzYt8j6e5ICW17gTY3C5a1kEpwA7QbFVeB0mcnh0T9qpF00qvDhlVQGrevWCQKgg9jU
 Rulg==
X-Gm-Message-State: APjAAAXLGfBQSWkfwWfhqsy4+X9GZL6vs3Zs45H/BWAIOPGQZDqQRUBM
 zRCc8UHsF20tA5U1TEcX2F5Rp1ZfLWk9ZLn4GWQTt2CCClm7WG9KMcRg5nxWJp4Z+9neJt/LuQV
 mo4pbwMIl5SkpDzU=
X-Received: by 2002:a37:91c2:: with SMTP id
 t185mr18826983qkd.284.1582063203462; 
 Tue, 18 Feb 2020 14:00:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5D7t/Oox7IPuNqUVDV5TZsCot6ZSLbJWi5gnGWozWeNc8JX7GXgdHpenorloqdE8Ez7kcqw==
X-Received: by 2002:a37:91c2:: with SMTP id
 t185mr18826964qkd.284.1582063203188; 
 Tue, 18 Feb 2020 14:00:03 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t2sm2533478qkc.62.2020.02.18.14.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:00:02 -0800 (PST)
Date: Tue, 18 Feb 2020 17:00:01 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 01/16] util: vfio-helpers: Factor out and fix
 processing of existing ram blocks
Message-ID: <20200218220001.GE7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-2-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-2-david@redhat.com>
X-MC-Unique: sESt9gyWNW-DlbEEiL-95w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:39PM +0100, David Hildenbrand wrote:
> Factor it out into common code when a new notifier is registered, just
> as done with the memory region notifier. This allows us to have the
> logic about how to process existing ram blocks at a central place (which
> will be extended soon).
>=20
> Just like when adding a new ram block, we have to register the max_length
> for now. We don't have a way to get notified about resizes yet, and some
> memory would not be mapped when growing the ram block.
>=20
> Note: Currently, ram blocks are only "fake resized". All memory
> (max_length) is accessible.
>=20
> We can get rid of a bunch of functions in stubs/ram-block.c . Print the
> warning from inside qemu_vfio_ram_block_added().
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c                    |  5 +++++
>  hw/core/numa.c            | 14 ++++++++++++++
>  include/exec/cpu-common.h |  1 +
>  stubs/ram-block.c         | 20 --------------------
>  util/vfio-helpers.c       | 28 +++++++---------------------
>  5 files changed, 27 insertions(+), 41 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index 67e520d18e..05cfe868ab 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2017,6 +2017,11 @@ ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>      return rb->used_length;
>  }
> =20
> +ram_addr_t qemu_ram_get_max_length(RAMBlock *rb)
> +{
> +    return rb->max_length;
> +}
> +
>  bool qemu_ram_is_shared(RAMBlock *rb)
>  {
>      return rb->flags & RAM_SHARED;
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 0d1b4be76a..6599c69e05 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -899,9 +899,23 @@ void query_numa_node_mem(NumaNodeMem node_mem[], Mac=
hineState *ms)
>      }
>  }
> =20
> +static int ram_block_notify_add_single(RAMBlock *rb, void *opaque)
> +{
> +    const ram_addr_t max_size =3D qemu_ram_get_max_length(rb);
> +    void *host =3D qemu_ram_get_host_addr(rb);
> +    RAMBlockNotifier *notifier =3D opaque;
> +
> +    if (host) {
> +        notifier->ram_block_added(notifier, host, max_size);
> +    }
> +    return 0;
> +}
> +
>  void ram_block_notifier_add(RAMBlockNotifier *n)
>  {
>      QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
> +    /* Notify about all existing ram blocks. */
> +    qemu_ram_foreach_block(ram_block_notify_add_single, n);
>  }
> =20
>  void ram_block_notifier_remove(RAMBlockNotifier *n)
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 81753bbb34..9760ac9068 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -59,6 +59,7 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
>  void *qemu_ram_get_host_addr(RAMBlock *rb);
>  ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
>  ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
> +ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>  bool qemu_ram_is_shared(RAMBlock *rb);
>  bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
>  void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> index 73c0a3ee08..10855b52dd 100644
> --- a/stubs/ram-block.c
> +++ b/stubs/ram-block.c
> @@ -2,21 +2,6 @@
>  #include "exec/ramlist.h"
>  #include "exec/cpu-common.h"
> =20
> -void *qemu_ram_get_host_addr(RAMBlock *rb)
> -{
> -    return 0;
> -}
> -
> -ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
> -{
> -    return 0;
> -}
> -
> -ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
> -{
> -    return 0;
> -}

Maybe put into another patch?

Actually I'm thinking whether it would worth to do...  They're still
declared in include/exec/cpu-common.h, so logically who includes the
header but linked against stubs can still call this function.  So
keeping them there still make sense to me.

> -
>  void ram_block_notifier_add(RAMBlockNotifier *n)
>  {
>  }
> @@ -24,8 +9,3 @@ void ram_block_notifier_add(RAMBlockNotifier *n)
>  void ram_block_notifier_remove(RAMBlockNotifier *n)
>  {
>  }
> -
> -int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
> -{
> -    return 0;
> -}
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 813f7ec564..71e02e7f35 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -376,8 +376,13 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifi=
er *n,
>                                        void *host, size_t size)
>  {
>      QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
> +    int ret;
> +
>      trace_qemu_vfio_ram_block_added(s, host, size);
> -    qemu_vfio_dma_map(s, host, size, false, NULL);
> +    ret =3D qemu_vfio_dma_map(s, host, size, false, NULL);
> +    if (ret) {
> +        error_report("qemu_vfio_dma_map(%p, %zu) failed: %d", host, size=
, ret);
> +    }

Irrelevant change (another patch)?

>  }
> =20
>  static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
> @@ -390,33 +395,14 @@ static void qemu_vfio_ram_block_removed(RAMBlockNot=
ifier *n,
>      }
>  }
> =20
> -static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
> -{
> -    void *host_addr =3D qemu_ram_get_host_addr(rb);
> -    ram_addr_t length =3D qemu_ram_get_used_length(rb);
> -    int ret;
> -    QEMUVFIOState *s =3D opaque;
> -
> -    if (!host_addr) {
> -        return 0;
> -    }
> -    ret =3D qemu_vfio_dma_map(s, host_addr, length, false, NULL);
> -    if (ret) {
> -        fprintf(stderr, "qemu_vfio_init_ramblock: failed %p %" PRId64 "\=
n",
> -                host_addr, (uint64_t)length);
> -    }
> -    return 0;
> -}
> -
>  static void qemu_vfio_open_common(QEMUVFIOState *s)
>  {
>      qemu_mutex_init(&s->lock);
>      s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
>      s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed;
> -    ram_block_notifier_add(&s->ram_notifier);
>      s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
>      s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
> -    qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
> +    ram_block_notifier_add(&s->ram_notifier);

Pure question: this looks like a good improvement, however do you know
why HAX and SEV do not need to init ramblock?

Thanks,

>  }
> =20
>  /**
> --=20
> 2.24.1
>=20
>=20

--=20
Peter Xu


