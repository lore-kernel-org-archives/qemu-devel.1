Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF18C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1DD2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZQUawZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1DD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwNg-0007Wr-U6
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuwMx-0006r4-S4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuwMw-00057v-OL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuwMw-00056P-K3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579862358;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzwOxQ0YetL2nkFOGH0j8PrGQhM5k+5KlQojPyVn/Pc=;
 b=CZQUawZTSxd0C2Ws0NkAr4O1w3jHXN+PaWm3vW2VNhaD9tyHgsQoOdwWij6ujrz/5n40NG
 Red0wnXYKv4AWMGP6aaa5kUBj+xxOZcTziD8wLedNK4+x7lv9t00IUIkRzwLhRMkEs7nC/
 +2/g5u9XV//JABCIEG0lUzkXxTgboTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-quvBKfy5NV-k3buE2byETg-1; Fri, 24 Jan 2020 05:39:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E1C1083E80
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:39:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA265DA8C;
 Fri, 24 Jan 2020 10:39:10 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:39:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 01/21] migration-test: Use g_free() instead of free()
Message-ID: <20200124103907.GC824327@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-2-quintela@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: quvBKfy5NV-k3buE2byETg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:58:11PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 26e2e77289..b6a74a05ce 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1291,7 +1291,7 @@ static void test_multifd_tcp(void)
>      wait_for_serial("dest_serial");
>      wait_for_migration_complete(from);
>      test_migrate_end(from, to, true);
> -    free(uri);
> +    g_free(uri);

Not an objection to this patch, just a general FYI.

Our min glib guarantees that g_malloc/g_free are always using the
system allocator. So using free() is not a correctness problem
these days.

In general I'd suggest eliminating both free() and g_free(), and instead
annotating the variable decl for automatic free. eg

  g_autofree char *uri =3D NULL;


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


