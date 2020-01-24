Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048CB20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVZ2AA+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048CB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvPp-0001pC-5c
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuvP6-0000gx-P9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuvP5-0003FI-Rj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:37:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuvP5-0003F2-OS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqfGQ6cA7/GdKlq3IAsk5GL0emva4g+XaCZuMpKLYhc=;
 b=WVZ2AA+Ii4hrwLalH9Lxbma6swCuPZNh2JRK5youub0F+t8YAjgHp/YaFh+2d47d2qXugk
 0+QyPUWLaGEiG28pcNitWbwY136Dsdom3F6l9XxcizX/YE7YA6+Wfi+zYImLeJSk6LvNVq
 45paruR8wUj2NmPuxwOw+eTL8Gj3nUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-yF6kOtOIN_GzWUX3kb1f-g-1; Fri, 24 Jan 2020 04:37:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94BD1801E6C
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:37:24 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B98928CCDE;
 Fri, 24 Jan 2020 09:37:22 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:37:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 01/21] migration-test: Use g_free() instead of free()
Message-ID: <20200124093720.GB2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-2-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: yF6kOtOIN_GzWUX3kb1f-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
>  }
> =20
>  int main(int argc, char **argv)
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


