Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D02C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D977722314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfHM0+tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D977722314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itc22-0006Tq-43
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itc1L-00060e-Kr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itc1J-0003Ud-GW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:43:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itc1J-0003U9-8V
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579545808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dd/otG+dUd/2jAp52H+gJzDWJMCct73QvfJJZlVf6JQ=;
 b=NfHM0+tA/LBWBCRYYlaS41Ut4O34Q/vvSDkwu42zmncW1yNesxkmDrKWTNVlB58KBfhu8R
 zP0PpmU9BZCDBdfY6AHGLHOFepEa3Phurj0x5Yrk+0VSjKTIbsQTY4wf+po/AfaLhfIgAl
 1wJf6GVNZTQ2ux+3oOw9pymx0wWXcBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164--YMJauNPPDiVd-N--fWz6g-1; Mon, 20 Jan 2020 13:43:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2E14107ACC7;
 Mon, 20 Jan 2020 18:43:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58BE160BF7;
 Mon, 20 Jan 2020 18:43:22 +0000 (UTC)
Date: Mon, 20 Jan 2020 18:43:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float
 conversion caught by clang
Message-ID: <20200120184319.GS2827@work-vm>
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com>
 <87zhgoi93z.fsf@trasno.org> <87r220qa5p.fsf@dusky.pond.sub.org>
 <874kwygxxt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874kwygxxt.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -YMJauNPPDiVd-N--fWz6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Juan Quintela <quintela@redhat.com> writes:
> >
> >> Markus Armbruster <armbru@redhat.com> wrote:
> >>> From: Fangrui Song <i@maskray.me>
> >>>
> >>> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
> >>> @value to 0..INT64_MAX:
> >>>
> >>>     qemu/migration/migration.c:2038:24: error: implicit conversion fr=
om 'long' to 'double' changes value from 9223372036854775807 to 92233720368=
54775808 [-Werror,-Wimplicit-int-float-conversion]
> >>>
> >>> The warning will be enabled by default in clang 10. It is not
> >>> available for clang <=3D 9.
> >>>
> >>> The clamp is actually useless; @value is checked to be within
> >>> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
> >>>
> >>> While there, make the conversion from double to int64_t explicit.
> >>>
> >>> Signed-off-by: Fangrui Song <i@maskray.me>
> >>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>> [Patch split, commit message improved]
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>
> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >>
> >> Should I get this through migration tree, or are you going to pull it?
> >
> > Plase take this patch through the migration tree.
>=20
> Ping...

This looks like it went in in today's migration pull.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


