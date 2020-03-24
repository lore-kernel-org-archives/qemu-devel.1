Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5409120714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdD7k0eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpQs-0007AL-Ho
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGpQ6-0006fz-5p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGpQ5-00010j-7U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:41:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGpQ5-00010a-3T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585078860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N91IBJ0JRTdFYBM7U+8ufguVS/Id+MlH1tvP31JV1WM=;
 b=bdD7k0eUmygCzeTHhTVdMQ4RHO4Xk5uEWNpM/MHIZjtm2Dh23U1/R4UpnU0m+vXGQtRocA
 C5kq3X2JOKybPDD/mDmL+3z3marD1OWq5/xPOW4CeOuwRr44xKyAexuhvTFcPacMlgvBaO
 sKItlDw3P5CsYqpehrgsrJc/obz8sRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Dx0pdq68NJm0SdEwyhVtpw-1; Tue, 24 Mar 2020 15:40:58 -0400
X-MC-Unique: Dx0pdq68NJm0SdEwyhVtpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78771107ACC9;
 Tue, 24 Mar 2020 19:40:57 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29DCC94B24;
 Tue, 24 Mar 2020 19:40:51 +0000 (UTC)
Date: Tue, 24 Mar 2020 19:40:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 4/6] migration/colo: fix use after free of local_err
Message-ID: <20200324194049.GF2645@work-vm>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200324153630.11882-5-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> local_err is used again in secondary_vm_do_failover() after
> replication_stop_all(), so we must zero it. Otherwise try to set
> non-NULL local_err will crash.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I'll queue this

> ---
>  migration/colo.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index 44942c4e23..a54ac84f41 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -93,6 +93,7 @@ static void secondary_vm_do_failover(void)
>      replication_stop_all(true, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
> +        local_err =3D NULL;
>      }
> =20
>      /* Notify all filters of all NIC to do checkpoint */
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


