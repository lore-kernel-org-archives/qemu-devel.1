Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C33C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D057F21841
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4SlNrPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D057F21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPArv-0000PF-Ul
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jPArM-0008Ov-3r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1jPArK-0006vg-Gc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:11:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1jPArK-0006uQ-AV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587067897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlcFC+ljyuAFGdaCw1XykvC9/rpUfvZadjaYHy1ZZaU=;
 b=X4SlNrPwOksRW5ESGBOvsO1a+BY03mIP9zNEab6uMoto/Z5GP1D/O1BzAo6GZVHX/btU8y
 d2vOc7VtpF/0jRAcj7Fj0K6PBjmObmoQYUrSAAB5NFwEEsZ0LrgybweTfdI54qsHuj/Lht
 NEoNYGrItb52ZhNoatwfNzkCNzUA5LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-rpOtxe7qO_2ePP4h_uGUGQ-1; Thu, 16 Apr 2020 16:10:28 -0400
X-MC-Unique: rpOtxe7qO_2ePP4h_uGUGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0174C1005513
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 20:10:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-15.rdu2.redhat.com [10.10.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97512C0DA8;
 Thu, 16 Apr 2020 20:10:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 1C9E5220537; Thu, 16 Apr 2020 16:10:22 -0400 (EDT)
Date: Thu, 16 Apr 2020 16:10:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200416201022.GD276932@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200416164907.244868-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> virtiofsd doesn't need of all Linux capabilities(7) available to root.  K=
eep a
> whitelisted set of capabilities that we require.  This improves security =
in
> case virtiofsd is compromised by making it hard for an attacker to gain f=
urther
> access to the system.

Hi Stefan,

Good to see this patch. We needed to limit capabilities to reduce attack
surface.

What tests have you run to make sure this current set of whitelisted
capabilities is good enough.

Vivek

>=20
> Stefan Hajnoczi (2):
>   virtiofsd: only retain file system capabilities
>   virtiofsd: drop all capabilities in the wait parent process
>=20
>  tools/virtiofsd/passthrough_ll.c | 51 ++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> --=20
> 2.25.1
>=20


