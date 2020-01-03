Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68037C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356AE217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhQNT/LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356AE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQBJ-0005eY-CC
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inQAd-0005DA-CF
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inQAc-0002RF-Ba
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:51:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inQAc-0002N0-5r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578070289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXdh3uNUqknRALPsA2bt+AbLsrerrLhMPi+AOx+CPXc=;
 b=dhQNT/LXeyE5HM/ziFc2wSyGViWtgcsc9l8H6eHFxhyOdMgktwvlVhYSbsZ6fXL8OS3V5h
 OWkwlHU2sY3aBTOxr7bOESogm7DAr06oV4U3Z/Byn4THGZVdwF9F/nyjNuLn8BzD1pVkm+
 YyLbEPokZY9x3sppwyAgPYsn52pw4HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Flu7OyCaMHiF2R9nKLBzVg-1; Fri, 03 Jan 2020 11:51:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8222018FE860
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 16:51:25 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A75F660BF7;
 Fri,  3 Jan 2020 16:51:23 +0000 (UTC)
Date: Fri, 3 Jan 2020 16:51:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Message-ID: <20200103165121.GM3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-2-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Flu7OyCaMHiF2R9nKLBzVg-1
X-Mimecast-Spam-Score: 0
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
> We can scale much better with 16, so we can scale to higher numbers.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 354ad072fa..e7f707e033 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -86,7 +86,7 @@
> =20
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
> -#define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> +#define DEFAULT_MIGRATE_MULTIFD_CHANNELS 16

OK, I suspect the management apps will set it anyway; some could be a
bit surprised chewing 16 cores/threads of CPU in some cases.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


