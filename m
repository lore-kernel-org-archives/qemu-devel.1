Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D9C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2078221D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2078221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXLX-0002HY-1e
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iDX09-0003Ti-Si
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iDX06-0004ef-48
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:52:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:25899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iDX05-0004YK-Or
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:52:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 09:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="194191186"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga006.jf.intel.com with ESMTP; 26 Sep 2019 09:52:09 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:52:09 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:52:09 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.113]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 00:52:07 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 1/4] block/replication.c: Ignore requests after failover
Thread-Topic: [PATCH v5 1/4] block/replication.c: Ignore requests after
 failover
Thread-Index: AQHVa/qeM+BhAbzxcU6qcOTU5H+r9ac+Os1g
Date: Thu, 26 Sep 2019 16:52:06 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780627E5F0@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <5305f30b0f798adfc3883bbcebbfc5030661dbe9.1568574478.git.lukasstraub2@web.de>
In-Reply-To: <5305f30b0f798adfc3883bbcebbfc5030661dbe9.1568574478.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmI4MmUzOTQtNTBiYy00MjgzLWEwODUtMDliY2QyNWY3OThmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK0xWVEZBUVVxakxkQmpPTjlEM0ljOXFsMk02cTdLOVEyWjVha1Z6TmkrXC9GcWxXZW0zZ0M5NitaOGpZeGh3b2cifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, September 16, 2019 3:20 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: [PATCH v5 1/4] block/replication.c: Ignore requests after failov=
er
>=20
> After failover the Secondary side of replication shouldn't change state,
> because it now functions as our primary disk.
>=20
> In replication_start, replication_do_checkpoint, replication_stop, ignore=
 the
> request if current state is BLOCK_REPLICATION_DONE (sucessful failover) o=
r
> BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging
> active and hidden images into the base image).
>=20

It looks good for me, and this patch works well in COLO continuous backup s=
tatus in my tests.
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

But I think this patch still need reviewed by Xie Changlong  or  Kevin Wolf=
.

Thanks
Zhang Chen

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/replication.c b/block/replication.c index
> 3d4dedddfc..97cc65c0cf 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -454,6 +454,17 @@ static void replication_start(ReplicationState *rs,
> ReplicationMode mode,
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>=20
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary is promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->stage !=3D BLOCK_REPLICATION_NONE) {
>          error_setg(errp, "Block replication is running or done");
>          aio_context_release(aio_context); @@ -529,8 +540,7 @@ static voi=
d
> replication_start(ReplicationState *rs, ReplicationMode mode,
>                     "Block device is in use by internal backup job");
>=20
>          top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
> -        if (!top_bs || !bdrv_is_root_node(top_bs) ||
> -            !check_top_bs(top_bs, bs)) {
> +        if (!top_bs || !check_top_bs(top_bs, bs)) {
>              error_setg(errp, "No top_bs or it is invalid");
>              reopen_backing_file(bs, false, NULL);
>              aio_context_release(aio_context); @@ -577,6 +587,17 @@ stati=
c void
> replication_do_checkpoint(ReplicationState *rs, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>=20
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary was promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
>          secondary_do_checkpoint(s, errp);
>      }
> @@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState *r=
s,
> Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>=20
> -    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> +    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
>          error_setg(errp, "Block replication is not running");
>          aio_context_release(aio_context);
>          return;
> @@ -635,6 +656,17 @@ static void replication_stop(ReplicationState *rs,
> bool failover, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>=20
> +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> +        /*
> +         * This case happens when a secondary was promoted to primary.
> +         * Ignore the request because the secondary side of replication
> +         * doesn't have to do anything anymore.
> +         */
> +        aio_context_release(aio_context);
> +        return;
> +    }
> +
>      if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
>          error_setg(errp, "Block replication is not running");
>          aio_context_release(aio_context);
> --
> 2.20.1


