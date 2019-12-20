Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0628C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFFB2467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxeZTd8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFFB2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiEfN-0008Mb-LZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iiEeh-0007te-Jq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iiEef-0007m6-57
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:33:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iiEee-0007dc-Rv
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576834382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKakzUbBIT6Y+ATD49SoJhJSobliKZTg5WV9xSMDUmY=;
 b=ZxeZTd8puw+PknEn/gdWoFYGNRbdijv474n8Xp7TGD4+s8txmoMjq9NEm2gAyIumnXXLKS
 9122uu3UPKObuNv6YodnX+5zfHh0r+YpKB5gKu8D+jUSm5RzDxgJOahENa/tbGw4MiuYkQ
 eSpA8TiuExITRHv51FNrmiL4VN8YKzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-fvqrbgJ7PW-AA26HBHI9tQ-1; Fri, 20 Dec 2019 04:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0A51883520;
 Fri, 20 Dec 2019 09:33:00 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B49647D9D9;
 Fri, 20 Dec 2019 09:32:59 +0000 (UTC)
Date: Fri, 20 Dec 2019 10:32:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2] iotests.py: Let wait_migration wait even more
Message-ID: <20191220093258.GB4019@dhcp-200-226.str.redhat.com>
References: <20191219183617.213637-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219183617.213637-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fvqrbgJ7PW-AA26HBHI9tQ-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.12.2019 um 19:36 hat Max Reitz geschrieben:
> The "migration completed" event may be sent (on the source, to be
> specific) before the migration is actually completed, so the VM runstate
> will still be "finish-migrate" instead of "postmigrate".  So ask the
> users of VM.wait_migration() to specify the final runstate they desire
> and then poll the VM until it has reached that state.  (This should be
> over very quickly, so busy polling is fine.)
>=20
> Without this patch, I see intermittent failures in the new iotest 280
> under high system load.  I have not yet seen such failures with other
> iotests that use VM.wait_migration() and query-status afterwards, but
> maybe they just occur even more rarely, or it is because they also wait
> on the destination VM to be running.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 13fd8b5cd2..0b62c42851 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -668,12 +668,16 @@ class VM(qtest.QEMUQtestMachine):
>              }
>          ]))
> =20
> -    def wait_migration(self):
> +    def wait_migration(self, expect_runstate):
>          while True:
>              event =3D self.event_wait('MIGRATION')
>              log(event, filters=3D[filter_qmp_event])
>              if event['data']['status'] =3D=3D 'completed':
>                  break
> +        # The event may occur in finish-migrate, so wait for the expecte=
d
> +        # post-migration runstate

That's a bit too specific now that you have expect_runstate.

> +        while self.qmp('query-status')['return']['status'] !=3D expect_r=
unstate:
> +            pass
> =20
>      def node_info(self, node_name):
>          nodes =3D self.qmp('query-named-block-nodes')

Tested-by: Kevin Wolf <kwolf@redhat.com>


