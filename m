Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB291C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AE82051A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG7UIRKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AE82051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia6tv-000321-JJ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 18:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ia6s8-0002WU-4N
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ia6s5-000525-Aq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:37:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ia6s5-0004zo-5V
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574897840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lowE3yJPYbIIN4FgswaBDNr6yrBoIbn6qUAc3n4ICFo=;
 b=cG7UIRKPwTfYqZrpwXq9d/2LwdT3c2UxDY3iJfhwTtcVu57HieyMlZNVZ0AF3kNDAmRhS2
 VpCpk/OwPI0m9bFrP9MIJbaVEIg7WDTNJQeiDrVX6I+4QTtFIpMPriFqN5rlsjoXpRLZol
 CcqDKDtUnfDYFt34jjisoa7NNrUr3k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-_8vvLFbpPnGMG8JNIldvwQ-1; Wed, 27 Nov 2019 18:37:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0138180380E
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 23:37:17 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 405C6600C8;
 Wed, 27 Nov 2019 23:37:14 +0000 (UTC)
Date: Wed, 27 Nov 2019 20:37:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/2] analyze-migration.py: fix find() type error
Message-ID: <20191127233713.GY4438@habkost.net>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127101038.327080-2-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _8vvLFbpPnGMG8JNIldvwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 02:10:37PM +0400, Marc-Andr=E9 Lureau wrote:
> Traceback (most recent call last):
>   File "../scripts/analyze-migration.py", line 611, in <module>
>     dump.read(desc_only =3D True)
>   File "../scripts/analyze-migration.py", line 513, in read
>     self.load_vmsd_json(file)
>   File "../scripts/analyze-migration.py", line 556, in load_vmsd_json
>     vmsd_json =3D file.read_migration_debug_json()
>   File "../scripts/analyze-migration.py", line 89, in read_migration_debu=
g_json
>     nulpos =3D data.rfind("\0")
> TypeError: argument should be integer or bytes-like object, not 'str'
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks!  I'm queueing this, but I'm hoping we don't have a -rc4
and 4.2.0 gets released next week.

--=20
Eduardo


