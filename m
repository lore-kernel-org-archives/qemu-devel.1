Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF566C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8C321D79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Byx9uy9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8C321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdHA-00069W-S3
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 03:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iSdEl-0005I5-Jc
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iSdEh-0005wx-K0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:33:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iSdEg-0005a6-28
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573115624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDwhWfvkV3CIaJUOmmg/oElLzqUPhmqdo6hoxJ1PIjg=;
 b=Byx9uy9sZF19t0W4gxIiZBrg3YCg9t+wNfcKr4U0jmyMEoPVwizFuvPcnUK43GTVAn71CS
 OwqtQTgvawrLE/lrJ/6KWGtjGDRSkQzbyHeNlW5w6gLvcryAJgRw5B72fWaZk+wzWqicK/
 PlNjNYO2RyS/N2UU1VOgyerMra+tu5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-R0QH5845NfK6B4EzlgUbDQ-1; Thu, 07 Nov 2019 03:33:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E20800C61;
 Thu,  7 Nov 2019 08:33:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A217127099;
 Thu,  7 Nov 2019 08:33:36 +0000 (UTC)
Date: Thu, 7 Nov 2019 09:33:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
Message-ID: <20191107083335.GA5007@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
 <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: R0QH5845NfK6B4EzlgUbDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

Am 06.11.2019 um 20:25 hat Eric Blake geschrieben:
> On 11/6/19 6:51 AM, Max Reitz wrote:
> > On 17.10.19 15:01, Kevin Wolf wrote:
> > > Add a --nbd-server option to qemu-storage-daemon to start the built-i=
n
> > > NBD server right away. It maps the arguments for nbd-server-start to =
the
> > > command line.
> >=20
> > Well, it doesn=E2=80=99t quite, because nbd-server-start takes a
> > SocketAddressLegacy, and this takes a SocketAddress.
> >=20
> > On one hand I can understand why you would do it differently (especiall=
y
> > for command-line options), but on the other I find it a bit problematic
> > to have --nbd-server be slightly different from nbd-server-start when
> > both are intended to be the same.
> >=20
> > My biggest problem though lies in the duplication in the QAPI schema.
> > If NbdServerOptions.addr were a SocketAddressLegacy, we could let
> > nbd-server-start=E2=80=99s options just be of type NbdServerOptions and=
 thus get
> > rid of the duplication.
>=20
> I would love to somehow deprecate the use of SocketAddressLegacy and get =
QMP
> nbd-server-start to accept SocketAddress instead.  Maybe it could be done=
 by
> adding a new nbd-server-begin command in 5.0 with a saner wire layout, an=
d
> deprecating nbd-server-start at that time; by the 5.2 release, we could t=
hen
> drop nbd-server-start.  But we're too late for 4.2.

As a replacement nbd-server-add, I envisioned adding something like a
block-export-add, which would work the way that --export already does.
It would also come with query-block-exports and block-export-del, and it
wouldn't contain only NBD devices, but also vhost-user, FUSE, etc.
exports.

Now I'm wondering if the same would make sense for nbd-server-start.
Maybe an API change would even allow us to start multiple NBD servers
(e.g. listening on different IP addresses or using different tls-creds).

Kevin


