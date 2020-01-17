Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06701C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ECF2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDz8Fode"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ECF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isT4C-0004RM-Tu
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isT3Y-00040h-4V
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isT3V-0006yk-LF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:57:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36084
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isT3V-0006xw-3e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579273020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEEEisBZgM1xPIBpk4k385q/iZOpMRRF/bgJdG7+pYk=;
 b=MDz8FodeqzIAEmfGPY3YeRHOxIvC/8X6jsNGjA6xD8fVAKXnGVhJNontDHhB3B9EzqT388
 Mpu6qFTrNAMZOF62uEHXSxw8j/jDjSk0VIy4SXz3IliwtYu4LQQ59U7nehqwSZPaeLW5U1
 Wl0Xq/icfRd/ypdc261uIlkIobaKLH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-aULja-HLOsy--JFUd6PBEw-1; Fri, 17 Jan 2020 09:56:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC6A0107ACC7
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 14:56:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FFD310016EB;
 Fri, 17 Jan 2020 14:56:56 +0000 (UTC)
Date: Fri, 17 Jan 2020 14:56:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] multifd: Be consistente about using uint64_t
Message-ID: <20200117145654.GH3209@work-vm>
References: <20200117135639.14602-1-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200117135639.14602-1-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: aULja-HLOsy--JFUd6PBEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> We transmit ram_addr_t always as uint64_t.  Be consistent in its
> use (on 64bit system, it is always uint64_t problem is 32bits).
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

(Note typo in subject )

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 96feb4062c..f7482b1b35 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -803,7 +803,10 @@ static void multifd_send_fill_packet(MultiFDSendPara=
ms *p)
>      }
> =20
>      for (i =3D 0; i < p->pages->used; i++) {
> -        packet->offset[i] =3D cpu_to_be64(p->pages->offset[i]);
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp =3D p->pages->offset[i];
> +
> +        packet->offset[i] =3D cpu_to_be64(temp);
>      }
>  }
> =20
> @@ -877,10 +880,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>      }
> =20
>      for (i =3D 0; i < p->pages->used; i++) {
> -        ram_addr_t offset =3D be64_to_cpu(packet->offset[i]);
> +        uint64_t offset =3D be64_to_cpu(packet->offset[i]);
> =20
>          if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
> -            error_setg(errp, "multifd: offset too long " RAM_ADDR_FMT
> +            error_setg(errp, "multifd: offset too long %" PRId64
>                         " (max " RAM_ADDR_FMT ")",
>                         offset, block->max_length);
>              return -1;
> @@ -1236,7 +1239,7 @@ int multifd_save_setup(void)
>          p->id =3D i;
>          p->pages =3D multifd_pages_init(page_count);
>          p->packet_len =3D sizeof(MultiFDPacket_t)
> -                      + sizeof(ram_addr_t) * page_count;
> +                      + sizeof(uint64_t) * page_count;
>          p->packet =3D g_malloc0(p->packet_len);
>          p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
>          p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
> @@ -1447,7 +1450,7 @@ int multifd_load_setup(void)
>          p->id =3D i;
>          p->pages =3D multifd_pages_init(page_count);
>          p->packet_len =3D sizeof(MultiFDPacket_t)
> -                      + sizeof(ram_addr_t) * page_count;
> +                      + sizeof(uint64_t) * page_count;
>          p->packet =3D g_malloc0(p->packet_len);
>          p->name =3D g_strdup_printf("multifdrecv_%d", i);
>      }
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


