Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862DC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0A020770
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Dsju+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0A020770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWwF-0006xf-6f
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEWuU-00065P-TY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEWuT-0000l4-RF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEWuT-0000jC-NF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584531053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IekQwGrBEmd6Ih3yyyq3JR8VfSF8aM7iE/DXURjBJDg=;
 b=K3Dsju+/BMuxs2dnAWW5KMVfkHcHODOYyxPwpIfA3yR4+l/Mn/GV0hS5cTB8H9YD6g/pBO
 Dsjztdsh50QB+2haA8F/TKTVoaYO7WxVxdJR16gAfIzPRMtWAJQEgOlDKMgvj5FK0MAVan
 adVqneYFZiZ3eNoteKF88ls6UDHdmF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-ZjVXjdDUN2WNluMkOAGxpw-1; Wed, 18 Mar 2020 07:30:49 -0400
X-MC-Unique: ZjVXjdDUN2WNluMkOAGxpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D421800D53;
 Wed, 18 Mar 2020 11:30:48 +0000 (UTC)
Received: from work-vm (ovpn-115-3.ams2.redhat.com [10.36.115.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D72AB7E301;
 Wed, 18 Mar 2020 11:30:46 +0000 (UTC)
Date: Wed, 18 Mar 2020 11:30:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] hmp-cmd: fix a missing_break warning
Message-ID: <20200318113044.GH2850@work-vm>
References: <20200318071620.59748-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200318071620.59748-1-pannengyuan@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: zhanghailiang@huawei.com, zhukeqian1@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pan Nengyuan (pannengyuan@huawei.com) wrote:
> This fix coverity issues 94417686:
>     1260        break;
>     CID 94417686: (MISSING_BREAK)
>     1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THRO=
TTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
>     1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>     1262        p->has_throttle_trigger_threshold =3D true;
>     1263        visit_type_int(v, param, &p->throttle_trigger_threshold, =
&err);
>     1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>=20
> Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: zhukeqian1@huawei.com
> ---
>  monitor/hmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..c882c9f3cc 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
>      case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>          p->has_throttle_trigger_threshold =3D true;
>          visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
> +        break;

Thanks!

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>          p->has_cpu_throttle_initial =3D true;
>          visit_type_int(v, param, &p->cpu_throttle_initial, &err);
> --=20
> 2.21.0.windows.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


