Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C1FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126B5222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBmoKdu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inR5y-000691-4g
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inR5A-0005SX-Nv
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inR57-0004gd-0U
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:49:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inR54-0004bw-NB
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578073789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZ1sNPS+58hlXZPpa7AB5kYgfnN+jFvbUzp+9/RD1uM=;
 b=QBmoKdu2CFOUeUFMGS9O6YHqCX76Nly9vjwVbT0n9Ha+h28UTNoscuqkeoHAv1Hm/E2+rr
 KGIKpOWDGUqH/FL42s68G2H6GOkRwgorI3RS+i5f5UTjFSZI8ZtnA6AwuxPLlYgJTKho9z
 BaQi+8XbupA5uoDQp4I94jd+IDnNqPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-GbzEKnbTPca1o9qfkmO7LA-1; Fri, 03 Jan 2020 12:49:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C26B100550E
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 17:49:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B8137D961;
 Fri,  3 Jan 2020 17:49:43 +0000 (UTC)
Date: Fri, 3 Jan 2020 17:49:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Message-ID: <20200103174940.GX2753983@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-2-quintela@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GbzEKnbTPca1o9qfkmO7LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
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

I think this can break compatibility for migration between new and
old QEMU. Consider a deployment has enabled multifd, but not given
an explicit number of channels, and now try to start the migration.

In the method multifd_recv_initial_packet() there is a check

    if (msg.id > migrate_multifd_channels()) {
        error_setg(errp, "multifd: received channel version %d "
                   "expected %d", msg.version, MULTIFD_VERSION);
        return -1;
    }

which will fail if migrating from new QEMU to old QEMU because
migrate_multifd_channels() will be 2 for old QEMU and new
QEMU will be trying to open 16 channels.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


