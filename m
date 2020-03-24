Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD24C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF37E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awaZomRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF37E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnYM-0003Kz-1Q
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGnXd-0002fm-Eb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGnXc-0006zG-Dc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:40:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGnXc-0006yz-A9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqmX2cppPJPNb1vjz+eeMjOuJCrnm9QqTBVAPlWZIUM=;
 b=awaZomRWf79ZZFpFsKDXfdKVCf5/LC4DRWerOZut19GEPd7jkv9WjBEm9nAek2KzyfBgx0
 USfdop96lSHlWrdSiIpPXsIJF5N8BLi7tLaixbL8T8jCVCvnONdoDmHd2d3RE1hyIFNB6g
 Vn9di8aWxVkKWwK6ypjVutAAZtjJhoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-qxmsC6ZzN6iVnuxRmonDdg-1; Tue, 24 Mar 2020 13:40:37 -0400
X-MC-Unique: qxmsC6ZzN6iVnuxRmonDdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8C7D800D53;
 Tue, 24 Mar 2020 17:40:36 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AC5319C6A;
 Tue, 24 Mar 2020 17:40:34 +0000 (UTC)
Date: Tue, 24 Mar 2020 17:40:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] hmp-cmd: fix a missing_break warning
Message-ID: <20200324174032.GA17043@work-vm>
References: <20200318071620.59748-1-pannengyuan@huawei.com>
 <1a0d020b-3fe6-3575-1c2f-1af4a79cf080@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1a0d020b-3fe6-3575-1c2f-1af4a79cf080@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: euler.robot@huawei.com, zhukeqian1@huawei.com, qemu-devel@nongnu.org,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pan Nengyuan (pannengyuan@huawei.com) wrote:
> Correcting zhang hailiang's email.

Queued

> On 3/18/2020 3:16 PM, Pan Nengyuan wrote:
> > This fix coverity issues 94417686:
> >     1260        break;
> >     CID 94417686: (MISSING_BREAK)
> >     1261. unterminated_case: The case for value "MIGRATION_PARAMETER_TH=
ROTTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
> >     1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
> >     1262        p->has_throttle_trigger_threshold =3D true;
> >     1263        visit_type_int(v, param, &p->throttle_trigger_threshold=
, &err);
> >     1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
> >=20
> > Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> > ---
> > Cc: zhukeqian1@huawei.com
> > ---
> >  monitor/hmp-cmds.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 58724031ea..c882c9f3cc 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
> >      case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
> >          p->has_throttle_trigger_threshold =3D true;
> >          visit_type_int(v, param, &p->throttle_trigger_threshold, &err)=
;
> > +        break;
> >      case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
> >          p->has_cpu_throttle_initial =3D true;
> >          visit_type_int(v, param, &p->cpu_throttle_initial, &err);
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


