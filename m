Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AEF206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhYLoWH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AEF206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGoH-0008Dw-CE
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihGmq-0005xI-NU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihGmp-0003SU-KT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:37:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihGmp-0003Qb-Fy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vngugwHib7hOwEtRrUIaOtDx9aRZsX2TJgvv7rVQPA=;
 b=OhYLoWH+Vd/Dx4LJmWpJ7WV5IjzBRoypICBGJ5Uifg0k5FJtsqtRxOC3Rky0n/bFnN7VID
 4MuTosdBCDeIyPq+Yq++O7wr8LEiaZVACeV8XbaAjEpLNEzzAnUak8ViAmPIrL5NN1yE/G
 5V9Y/UOcU2b06soVKEbjqzQR7nV9COs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-FTYo5Hq0O9q99eUcAYrq6w-1; Tue, 17 Dec 2019 12:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDCDF800D50
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 17:37:28 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A49960C63;
 Tue, 17 Dec 2019 17:37:24 +0000 (UTC)
Date: Tue, 17 Dec 2019 17:37:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 10/14] monitor/hmp: Explicit we ignore a QEMUChrEvent
 in IOEventHandler
Message-ID: <20191217173722.GD2780@work-vm>
References: <20191217163808.20068-1-philmd@redhat.com>
 <20191217163808.20068-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191217163808.20068-11-philmd@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FTYo5Hq0O9q99eUcAYrq6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit when frontends ignore some events, to silent GCC the
> following warnings:
>=20
>     CC      monitor/hmp.o
>   monitor/hmp.c: In function =E2=80=98monitor_event=E2=80=99:
>   monitor/hmp.c:1330:5: error: enumeration value =E2=80=98CHR_EVENT_BREAK=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
>    1330 |     switch (event) {
>         |     ^~~~~~
>   cc1: all warnings being treated as errors
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  for HMP

Note that the use of 'default' will make life more unpredictable
if you ever come to add a new event type.

Dave


> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> ---
>  monitor/hmp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 8942e28933..d84238c120 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1371,6 +1371,10 @@ static void monitor_event(void *opaque, int event)
>          mon_refcount--;
>          monitor_fdsets_cleanup();
>          break;
> +
> +    default:
> +        /* Ignore */
> +        break;
>      }
>  }
> =20
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


