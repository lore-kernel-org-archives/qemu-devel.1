Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772AEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCBB20719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNMage4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCBB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQYS-0004Vv-Ep
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGQXm-0003rZ-SM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGQXl-00034S-Cl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:07:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGQXl-000348-8l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584983236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/GNtnYzpcdInh4HKoiPcTDYvGRKsdOFSM+QjXdaJyk=;
 b=MNMage4mCxsXV8xggdMrFuVaQJrfy+OFsQEgB/kim6jaguYRcMvR6KpMkDCCQCBY0f78rw
 xBRkCD2iQvGeiyj3bL5uu3KAWZzE52GAMayx7gUAi1iecuBPAbarab/8don3nOEBPxdtkj
 3m6Ubo11EY4M/3vuVwuZA1UW3WcPAOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-KAhxuRG0OPuRseD-ZUZDFw-1; Mon, 23 Mar 2020 13:07:14 -0400
X-MC-Unique: KAhxuRG0OPuRseD-ZUZDFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1B68018B5;
 Mon, 23 Mar 2020 17:07:13 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 707F592D2F;
 Mon, 23 Mar 2020 17:07:12 +0000 (UTC)
Date: Mon, 23 Mar 2020 18:07:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: aio-context question
Message-ID: <20200323170710.GC8049@linux.fritz.box>
References: <1577640273.5.1584605618249@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1577640273.5.1584605618249@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.03.2020 um 09:13 hat Dietmar Maurer geschrieben:
> I just saw commit 30dd65f307b647eef8156c4a33bd007823ef85cb, and noticed t=
hat=20
> a similar pattern in drive_backup_prepare() and blockdev_backup_prepare()=
.
>=20
> The calls to bdrv_try_set_aio_context() seems useless, because we already=
 do
> that later in backup_job_create/brdv_attach.
>=20
> But I am not 100%& sure?

I'm aware that this is a common pattern (and I thought it was more than
just two additional places), but we would have to check for each place
individually whether it can be removed.

If it doesn't have any effect because it just does what will be done
later anyway, it can be removed, but that doesn't buy us much.

If it results in preventing some case (like the one fixed by 30dd65f3),
we need to check whether this case is actually safe. If it is safe, we
can remove the lines and get a new feature from it.

In both cases, I think a test case should be written together with the
removal of the code. And if we find out that it's unsafe, we should even
more write a test case that makes sure that the operation fails.

Kevin


