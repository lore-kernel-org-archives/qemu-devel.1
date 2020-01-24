Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEAC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067AF208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrOiuxUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067AF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvUk-0006Ro-6F
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuvUD-00060P-0B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuvUC-00045W-1z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:42:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuvUB-00044t-Ub
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02onWBHK2DCMmttZBaDoZU9p55DUYzNzySv0jgunzg8=;
 b=KrOiuxUv0h7XTtta+d1QpnZtpz3xYi30zzQNe3gXUxlctdl8hLx90sd2uwWNnk5BsgegaE
 /0H2AQUF0WMjPgh/9+W/SSBEqJYa2RDjRJXU0HsjQFaCPW2O0WY4f0kXXCXvCh9xb0R4IF
 CZRI9UnQ1YzJLrk9sbEFFbNWCcgLYiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-djUxVPJePjKR9AjzINAeGA-1; Fri, 24 Jan 2020 04:42:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E1D9800D4E
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:42:40 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91E8C289A2;
 Fri, 24 Jan 2020 09:42:38 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:42:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 06/21] migration: Don't send data if we have stopped
Message-ID: <20200124094236.GD2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-7-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-7-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: djUxVPJePjKR9AjzINAeGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> If we do a cancel, we got out without one error, but we can't do the
> rest of the output as in a normal situation.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I think it's the sync that's the main problem being avoided here rather
than actually the problem of sending the data.

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


