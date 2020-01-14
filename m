Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6061CC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BBB2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBL0TyiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBB2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irL2P-0002Vw-3U
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irKuL-0007z1-Mr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irKuG-0003Of-M7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:02:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irKuG-0003OH-9A
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579003367;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fICgQi0YSLusFw0Y46W5rHFcSAaW001LL0e6Aaps9t4=;
 b=QBL0TyiXBi70KXT3OlfhD9KN2H0L41y/aFilog1WzPxG1S6ns9HYmzPKrXVlvyGc7k6+xN
 +ftb9kRFV+Lg/MXbxTrsPvOB2BZh5GtOqLMdApDuin+/5mD1BE7xr/1BlSnJ7Rn/G5X9Yz
 5vzK6tTnLYYGU3YWBh4QSN/UHA4sDOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-UkBMVN4SOEmNejWJYfasIQ-1; Tue, 14 Jan 2020 07:02:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AD8108AD2F;
 Tue, 14 Jan 2020 12:02:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4376609E;
 Tue, 14 Jan 2020 12:02:36 +0000 (UTC)
Date: Tue, 14 Jan 2020 12:02:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL 30/30] multifd: Allocate uint64_t instead of ram_addr_t
Message-ID: <20200114120234.GM4071034@redhat.com>
References: <20200114113926.3556-1-quintela@redhat.com>
 <20200114113926.3556-31-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114113926.3556-31-quintela@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UkBMVN4SOEmNejWJYfasIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 12:39:26PM +0100, Juan Quintela wrote:
> We receive that value over the network, and ram_addr_t depends of
> architecture.  Just make enough space for 64bit.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index d0940387d1..ba6e0eea15 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1267,7 +1267,7 @@ int multifd_save_setup(void)
>          p->id =3D i;
>          p->pages =3D multifd_pages_init(page_count);
>          p->packet_len =3D sizeof(MultiFDPacket_t)
> -                      + sizeof(ram_addr_t) * page_count;
> +                      + sizeof(uint64_t) * page_count;
>          p->packet =3D g_malloc0(p->packet_len);
>          p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
>          p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

but I think this ought to be patch 2 in the series, otherwise the
multifd test case that's introduced at the start of this series
will likely fail when doing git bisect.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


