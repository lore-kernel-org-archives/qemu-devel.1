Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03357C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E81214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6yOedNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E81214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9OWj-0000iI-Ok
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 02:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9OVy-0000De-G9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9OVw-0004q1-K5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:32:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9OVu-0004hv-4K
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583307135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwlwPO40pSSwJwTZBhTR948h4MnTg3qFyu+Yf3cPgBs=;
 b=Z6yOedNhxNHzpkSi/j7q20pjkMcKlG9t6vLasDzJ1DDRcbH0jTaTjAEB79evaMcg/JJsI+
 P8Ws1BfZNOIOo+vraxlM+yOMgUtg53u8EGyEEx8BA45uCWUJThM4gPFncg8L5ObWKV7IBU
 s4vHATREwku3AsQdTinlum5SUUes/WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-6iJEpIy5OTqHDZklee4_zQ-1; Wed, 04 Mar 2020 02:32:13 -0500
X-MC-Unique: 6iJEpIy5OTqHDZklee4_zQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BE3DBA5;
 Wed,  4 Mar 2020 07:32:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F43360C84;
 Wed,  4 Mar 2020 07:32:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EFE511386A6; Wed,  4 Mar 2020 08:32:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] qapi: Use super() now we have Python 3
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-4-armbru@redhat.com>
Date: Wed, 04 Mar 2020 08:32:10 +0100
In-Reply-To: <20200227144531.24309-4-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 27 Feb 2020 15:45:30 +0100")
Message-ID: <877e00r2x1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: mdroth@linux.vnet.ibm.com, jsnow@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index c8bcfe2c49..e132442c04 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
[...]
> @@ -614,7 +614,7 @@ class QAPISchemaObjectTypeVariant(QAPISchemaObjectTyp=
eMember):
>      role =3D 'branch'
> =20
>      def __init__(self, name, info, typ, ifcond=3DNone):
> -        QAPISchemaObjectTypeMember.__init__(self, name, info, typ,
> +        super().__init__(name, info, typ,
>                                              False, ifcond)

pycodestyle-3 gripes:

    scripts/qapi/schema.py:618:45: E127 continuation line over-indented for=
 visual indent

Will fix.

[...]


