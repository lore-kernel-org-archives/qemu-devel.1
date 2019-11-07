Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D930C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDAC214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNiXXl5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDAC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjhi-0001VB-ST
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iSjh5-0000xx-8n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iSjh3-0006WR-Q5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:27:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53699
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iSjh3-0006VY-MR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573140448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2etL3NQisxwPmo5q+cFPWA34xaes92Qd3hGdgtTgPI=;
 b=RNiXXl5ZmJSQ/rRkiWfDFDq91FId46DRdUknUZCuyvITz8jY6kj7EdAQnEVYg1I9WGwboV
 Lar2iw0OnS5mizizqZWqHcwCmzZsoEC9Qfd2/THgpRi61Bj3aOsX713q9VqxOiimdwZY4k
 3bNkhYJuYgI9rr9/n456vZELzgXo47w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-pMVvjHARMreT9WCjICx7Ew-1; Thu, 07 Nov 2019 10:27:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 919DC107ACC3;
 Thu,  7 Nov 2019 15:27:25 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5E35600D3;
 Thu,  7 Nov 2019 15:27:23 +0000 (UTC)
Date: Thu, 7 Nov 2019 16:27:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
Message-ID: <20191107152722.GD5007@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
 <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
 <20191107083335.GA5007@linux.fritz.box>
 <b5f9a8d8-c548-db26-13a0-0494baf9dc30@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b5f9a8d8-c548-db26-13a0-0494baf9dc30@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pMVvjHARMreT9WCjICx7Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.11.2019 um 14:45 hat Eric Blake geschrieben:
> On 11/7/19 2:33 AM, Kevin Wolf wrote:
> > As a replacement nbd-server-add, I envisioned adding something like a
> > block-export-add, which would work the way that --export already does.
> > It would also come with query-block-exports and block-export-del, and i=
t
> > wouldn't contain only NBD devices, but also vhost-user, FUSE, etc.
> > exports.
> >=20
> > Now I'm wondering if the same would make sense for nbd-server-start.
> > Maybe an API change would even allow us to start multiple NBD servers
> > (e.g. listening on different IP addresses or using different tls-creds)=
.
>=20
> We want that (the ability to run multiple parallel NBD servers) anyway, t=
o
> allow parallel incremental backups from different points in time to
> different clients.

Can't you already have multiple exports on a single NBD server for
multiple clients today? Or do you need a different server configuration
for each client?

Kevin


