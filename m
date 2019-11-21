Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4459C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE882070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erDhH06y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE882070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoC4-00009k-BA
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXo9d-0006Zl-EC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXo9c-00031b-3u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:13:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXo9a-0002yV-JX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574349232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ja0gY3duPuAMR6zlPdmll9IblZM5GZ+m+/qfDSjMHfA=;
 b=erDhH06yy+o0twh7jX/gYirJw7Jug3UQgtWRxz6q93AVz2Duwj4N6PP1StDiPhgKKTx5yG
 +F5dO6g5gJayEj3pxfm5l5vaNSnGxMJLWrl05zI+5mG/07PuwYmDLtF4uiM53siriwYlDn
 klUvG25AVSX/6wQuescqpOEpAcrvQz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-20MmndEbPNOhynpMjHBh0A-1; Thu, 21 Nov 2019 10:13:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CCDB10054E3;
 Thu, 21 Nov 2019 15:13:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68DD4692B7;
 Thu, 21 Nov 2019 15:13:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE8591138606; Thu, 21 Nov 2019 16:13:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/14] qapi: Allow optional discriminators
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-5-mreitz@redhat.com>
Date: Thu, 21 Nov 2019 16:13:47 +0100
In-Reply-To: <20190624173935.25747-5-mreitz@redhat.com> (Max Reitz's message
 of "Mon, 24 Jun 2019 19:39:24 +0200")
Message-ID: <87a78pb6tw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 20MmndEbPNOhynpMjHBh0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> Optional discriminators are fine, as long as there is a default value.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  scripts/qapi/common.py | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 8c57d0c67a..203623795b 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1052,11 +1052,21 @@ def check_union(expr, info):
>          base_members =3D find_base_members(base)
>          assert base_members is not None
> =20
> -        # The value of member 'discriminator' must name a non-optional
> -        # member of the base struct.
> +        # The value of member 'discriminator' must name a member of
> +        # the base struct.  (Optional members are allowed, but the
> +        # discriminator name must not start with '*', so keep
> +        # allow_optional=3DFalse.)
>          check_name(info, "Discriminator of flat union '%s'" % name,
>                     discriminator)
> +
>          discriminator_value =3D base_members.get(discriminator)
> +        if not discriminator_value:
> +            discriminator_value =3D base_members.get('*' + discriminator=
)
> +            if discriminator_value and 'default' not in discriminator_va=
lue:
> +                raise QAPISemError(info,
> +                    "Optional discriminator '%s' has no default value" %
> +                    discriminator)
> +
>          if not discriminator_value:
>              raise QAPISemError(info,
>                                 "Discriminator '%s' is not a member of ba=
se "

Needs test coverage and doc update.

Oh, looks like later patches provide.  Please consider squashing.  Doc
updates and tests often make code changes easier to understand.


