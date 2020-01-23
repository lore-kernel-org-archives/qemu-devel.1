Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF66C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776B921D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiITT9l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776B921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiS1-0006YW-I7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufgC-0007d6-UZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufgB-0001U1-Gf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:50:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufgB-0001Tv-DG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hm6TkjRlvG+oYmc60Fh2YtXl2SEIRp9CSW3qNx8m6CA=;
 b=SiITT9l4ZfZoaShFl1fkAYC8or9efCg/d6VkYTilBbV+oUcPwMpD6UO/lOrQSeZUsOvW0w
 7fTSOsmNlOphhx/pvYc2GVkTvE3wOOUjIS6tYFP8waD/iQhoD0FwAdIXslqT+xuzgFOSRa
 WBe7Oc+pe1Br4BhxtEThMwY2Bm1p/QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-dHkSDmZYNe6rqNu5KYZEZw-1; Thu, 23 Jan 2020 11:50:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07FA800C7A
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:49:59 +0000 (UTC)
Received: from work-vm (ovpn-116-110.ams2.redhat.com [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5A5828993;
 Thu, 23 Jan 2020 16:49:58 +0000 (UTC)
Date: Thu, 23 Jan 2020 16:49:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v4 6/6] migration: Don't send data if we have stopped
Message-ID: <20200123164956.GE2732@work-vm>
References: <20200122111517.33223-1-quintela@redhat.com>
 <20200122111517.33223-7-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122111517.33223-7-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dHkSDmZYNe6rqNu5KYZEZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> If we do a cancel, we got out without one error, but we can't do the
> rest of the output as in a normal situation.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

OK.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index f95d656c26..3fd7fdffcf 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3524,7 +3524,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>      ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> =20
>  out:
> -    if (ret >=3D 0) {
> +    if (ret >=3D 0
> +        && migration_is_setup_or_active(migrate_get_current()->state)) {
>          multifd_send_sync_main(rs);
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>          qemu_fflush(f);
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


