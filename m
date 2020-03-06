Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94388C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561D1208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/fmQyRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561D1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGIQ-0000Kg-Jm
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jAGHn-0007yu-OE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jAGHm-0001GB-SA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jAGHm-0001E7-ON
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583513837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pChu2GnEgMDhjgpyOqGMQMcjQu2zYKxImpbm+2xwVfg=;
 b=B/fmQyRNwt+2PTL0sZ9FffPifX9eyGdeAg9BEXsqtUm+yQE8Bhl1NzvP7csVySVp8qBeO3
 V5cLe1xeC6sE5V3um24H0V6kQL9ohGjcNKChcfZ+TQ3SzBdTmxf64AfkwmUM++7kgTITpC
 e9UQy/Co2nekOKNgGfQnWaQwwpZgfsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-UejEUT-8PcuVaLJSgGfygw-1; Fri, 06 Mar 2020 11:57:16 -0500
X-MC-Unique: UejEUT-8PcuVaLJSgGfygw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64C4107B26F;
 Fri,  6 Mar 2020 16:57:14 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE50960C63;
 Fri,  6 Mar 2020 16:57:07 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:57:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 11/13] migration/multifd: Print used_length of memory
 block
Message-ID: <20200306165705.GH3033@work-vm>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-12-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226155304.60219-12-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> We actually want to print the used_length, against which we check.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b3e8ae9bcc..dd9e88c5f1 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -222,7 +222,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)
>          if (offset > (block->used_length - qemu_target_page_size())) {
>              error_setg(errp, "multifd: offset too long %" PRIu64
>                         " (max " RAM_ADDR_FMT ")",
> -                       offset, block->max_length);
> +                       offset, block->used_length);
>              return -1;
>          }
>          p->pages->iov[i].iov_base =3D block->host + offset;
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


