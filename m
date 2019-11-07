Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BDFC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EAA207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7kLwSgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EAA207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSi8V-0004uj-PE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSi6l-0004GW-4x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSi6i-00027E-8E
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:45:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSi6i-00026t-4p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573134351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MC2fGewAljd1Dyc2J/WBNHXpv0lXKd0mEj/MsSX8GCw=;
 b=X7kLwSgbsuGi5tVsHybOMSLgX8Wqu0qkrOZcf04MsCFlOvvWXpeQtuQzuxCAcrd8+EC++l
 2dJ7mMEx44QicVnErHdr1w62IAcOjktjT+uv9KLZRNsns7DVInWZ9GhhX+tLLOQpBpUYwP
 Wqd6nhF4m+zlc8S2B07vTm1SyBkLjpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5HJX8UVTO7uE0kvqcaJKMw-1; Thu, 07 Nov 2019 08:45:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE3E1800C61;
 Thu,  7 Nov 2019 13:45:46 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 659A55DA70;
 Thu,  7 Nov 2019 13:45:46 +0000 (UTC)
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
To: Kevin Wolf <kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
 <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
 <20191107083335.GA5007@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b5f9a8d8-c548-db26-13a0-0494baf9dc30@redhat.com>
Date: Thu, 7 Nov 2019 07:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107083335.GA5007@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5HJX8UVTO7uE0kvqcaJKMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 2:33 AM, Kevin Wolf wrote:

>=20
> As a replacement nbd-server-add, I envisioned adding something like a
> block-export-add, which would work the way that --export already does.
> It would also come with query-block-exports and block-export-del, and it
> wouldn't contain only NBD devices, but also vhost-user, FUSE, etc.
> exports.
>=20
> Now I'm wondering if the same would make sense for nbd-server-start.
> Maybe an API change would even allow us to start multiple NBD servers
> (e.g. listening on different IP addresses or using different tls-creds).

We want that (the ability to run multiple parallel NBD servers) anyway,=20
to allow parallel incremental backups from different points in time to=20
different clients.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


