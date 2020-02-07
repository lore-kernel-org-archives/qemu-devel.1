Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10D2C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2180214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/HOxcdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2180214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j08e9-0005AB-QC
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 13:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j08dG-0004j1-UJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j08dE-00025B-H7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:45:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j08dE-00024D-2W
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581101135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6qKirTVNKKvLspqCnb5uXNCVHQZ1cShno6UU8+b6Mc=;
 b=h/HOxcdE18u1C4Rhy6Uap9gofvAYplzgWFskOGC1feQURjyOxPdE0sT18YRAQFj9PBfwH8
 18hOFD/GuFdSQK8iUklnf5beYuPgJIRzPfQBK1hPj3JVWNweMHpplq/MQmBfLqupF/B9oJ
 lGq/J6z/DPEsHm2OogMhY7WxLipv3ZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-LadF0Eg4M5aiea0z6bmWIQ-1; Fri, 07 Feb 2020 13:45:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CFF9DB60
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 18:45:32 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7759D1001B0B;
 Fri,  7 Feb 2020 18:45:30 +0000 (UTC)
Date: Fri, 7 Feb 2020 18:45:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 3/8] multifd: Make no compression operations into its
 own structure
Message-ID: <20200207184528.GR3302@work-vm>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-4-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129115655.10414-4-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LadF0Eg4M5aiea0z6bmWIQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> It will be used later.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

> diff --git a/migration/multifd.h b/migration/multifd.h
> index d8b0205977..c7fea4914c 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -25,6 +25,10 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, r=
am_addr_t offset);
> =20
>  #define MULTIFD_FLAG_SYNC (1 << 0)
> =20
> +/* We reserve 3 bits for METHODS */
> +#define MULTIFD_FLAG_METHOD_MASK (7 << 1)
> +#define MULTIFD_FLAG_NOCOMP (1 << 1)
> +

Doesn't the 'NOCOMP' value have to be 0 for it to not break
compatibility with existing multifd?

Dave

>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> =20
> @@ -96,6 +100,8 @@ typedef struct {
>      uint64_t num_pages;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* used for compression methods */
> +    void *data;
>  }  MultiFDSendParams;
> =20
>  typedef struct {
> @@ -133,7 +139,26 @@ typedef struct {
>      uint64_t num_pages;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* used for de-compression methods */
> +    void *data;
>  } MultiFDRecvParams;
> =20
> +typedef struct {
> +    /* Setup for sending side */
> +    int (*send_setup)(MultiFDSendParams *p, Error **errp);
> +    /* Cleanup for sending side */
> +    void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
> +    /* Prepare the send packet */
> +    int (*send_prepare)(MultiFDSendParams *p, uint32_t used, Error **err=
p);
> +    /* Write the send packet */
> +    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **errp)=
;
> +    /* Setup for receiving side */
> +    int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
> +    /* Cleanup for receiving side */
> +    void (*recv_cleanup)(MultiFDRecvParams *p);
> +    /* Read all pages */
> +    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp)=
;
> +} MultiFDMethods;
> +
>  #endif
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..73a141bb60 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -43,6 +43,7 @@
>  #include "page_cache.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-events-migration.h"
>  #include "qapi/qmp/qerror.h"
>  #include "trace.h"
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


