Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5FA2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjifQywX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5FA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCLZJ-00056H-8T
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCLYf-0004XW-B1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCLYe-0006El-1Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:59:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCLYd-0006EO-U9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584010759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQnCXBhb7cPzuIhGglpdu/rD6GIQQwpPVBxjr8+Rib4=;
 b=fjifQywXJnKXASKZHPL+AcUPEjk5wxEWLMQzs3R7rqHs2IFjZVZURB+F8tWuuAfojEvB8h
 YVKr9Su9zreFoTEuov9M3PHS2EV+o5xCMfgB2HuZdkcrP3B6Mu5xQqRQba7G/fkiCYNKFb
 iWPPahiYnax/UYu+n3uqZ+0MgF9dSEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-0jwGvHjZPZ6DMErcMsRNhA-1; Thu, 12 Mar 2020 06:59:17 -0400
X-MC-Unique: 0jwGvHjZPZ6DMErcMsRNhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81EDB107ACC7;
 Thu, 12 Mar 2020 10:59:16 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A64705C1C3;
 Thu, 12 Mar 2020 10:59:15 +0000 (UTC)
Date: Thu, 12 Mar 2020 10:59:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2] configure: Improve zstd test
Message-ID: <20200312105913.GA7741@work-vm>
References: <20200310111431.173151-1-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310111431.173151-1-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> There were one error on the test (missing an s for --exists).
> But we really need a recent zstd (1.4.0).
> Thanks to Michal Privoznik to provide the right vension.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>

Queued for migration

> ---
>  configure | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index cbf864bff1..f5454bd603 100755
> --- a/configure
> +++ b/configure
> @@ -2475,7 +2475,8 @@ fi
>  # zstd check
> =20
>  if test "$zstd" !=3D "no" ; then
> -    if $pkg_config --exist libzstd ; then
> +    libzstd_minver=3D"1.4.0"
> +    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>          LIBS=3D"$zstd_libs $LIBS"
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


