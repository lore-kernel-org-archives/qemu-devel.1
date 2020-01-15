Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E49C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F68622522
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1fMySZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F68622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irou6-0008H3-4v
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 15:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ironH-0002al-BV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ironG-0000zX-77
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:57:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ironG-0000yo-3d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579118253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ga/zxnifoy7tI0JOYQL5Efh/5BTTzKyT54cvNNrx7iU=;
 b=B1fMySZnygf7mQCjVTPlpf70R9BkrlYSMVjkjA89RtMsdWZHzEfVaTdAFofaLqv3C8Tp94
 O4y+qDLb3kYPFer1fvX/t86fNrcqfb+KMJJVfdfXp8gV55KnbwKcytJppXeF701kcB3+Ob
 nIllmbGu9pUi2LtJhLHgnhatRP8kADQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-3iW_gEMLMiWL4LFV-1kUGg-1; Wed, 15 Jan 2020 14:57:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4B48010C1;
 Wed, 15 Jan 2020 19:57:28 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7AC4675AF;
 Wed, 15 Jan 2020 19:57:26 +0000 (UTC)
Date: Wed, 15 Jan 2020 19:57:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***
Message-ID: <20200115195724.GL3811@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3iW_gEMLMiWL4LFV-1kUGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhimin Feng (fengzhimin1@huawei.com) wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>=20
> Currently there is a single channel for RDMA migration, this causes
> the problem that the network bandwidth is not fully utilized for
> 25Gigabit NIC. Inspired by the Multifd, we use two RDMA channels to
> send RAM pages, which we call MultiRDMA.
>=20
> We compare the migration performance of MultiRDMA with origin
> RDMA migration. The VM specifications for migration are as follows:
> - VM use 4k page;
> - the number of VCPU is 4;
> - the total memory is 16Gigabit;
> - use 'mempress' tool to pressurize VM(mempress 8000 500);
> - use 25Gigabit network card to migrate;
>=20
> For origin RDMA and MultiRDMA migration, the total migration times of
> VM are as follows:
> +++++++++++++++++++++++++++++++++++++++++++++++++
> |             | NOT rdma-pin-all | rdma-pin-all |
> +++++++++++++++++++++++++++++++++++++++++++++++++
> | origin RDMA |       18 s       |     23 s     |
> -------------------------------------------------
> |  MultiRDMA  |       13 s       |     18 s     |
> +++++++++++++++++++++++++++++++++++++++++++++++++

Very nice.

> For NOT rdma-pin-all migration, the multiRDMA can improve the
> total migration time by about 27.8%.
> For rdma-pin-all migration, the multiRDMA can improve the
> total migration time by about 21.7%.
>=20
> Test the multiRDMA migration like this:
> 'virsh migrate --live --rdma-parallel --migrateuri
> rdma://hostname domain qemu+tcp://hostname/system'

It will take me a while to finish the review; but another
general suggestion is add more trace_ calls; it will make it easier
to diagnose problems later.

Dave

>=20
> fengzhimin (12):
>   migration: Add multiRDMA capability support
>   migration: Export the 'migration_incoming_setup' function          =20
>              and add the 'migrate_use_rdma_pin_all' function
>   migration: Create the multi-rdma-channels parameter
>   migration/rdma: Create multiRDMA migration threads
>   migration/rdma: Create the multiRDMA channels
>   migration/rdma: Transmit initial package
>   migration/rdma: Be sure all channels are created
>   migration/rdma: register memory for multiRDMA channels
>   migration/rdma: Wait for all multiRDMA to complete registration
>   migration/rdma: use multiRDMA to send RAM block for rdma-pin-all mode
>   migration/rdma: use multiRDMA to send RAM block for NOT rdma-pin-all
>                   mode
>   migration/rdma: only register the virt-ram block for MultiRDMA
>=20
>  migration/migration.c |   55 +-
>  migration/migration.h |    6 +
>  migration/rdma.c      | 1320 +++++++++++++++++++++++++++++++++++++----
>  monitor/hmp-cmds.c    |    7 +
>  qapi/migration.json   |   27 +-
>  5 files changed, 1285 insertions(+), 130 deletions(-)
>=20
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


