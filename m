Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE54C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD7222B48
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAi59vi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD7222B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Y2z-00034S-8X
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 12:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9Y2O-0002XX-2d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9Y2M-0005p7-VM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:42:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9Y2M-0005op-Rd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583343746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CDaMOul+qCp31zR1dor2G1jGyCvnMHJhLOgNAhpqIg=;
 b=bAi59vi0rV3oQVzLSr1diFrgsOde+mLmo5vDmvoh1b8etsz1KypMbVJ+pjnqWcvuscyR+3
 tYbbwmNIoBSCh5sQ05OS4AdZbUlG2cSFY8agXTlWkEE+X8AZPDhscJo2/rxwk2zg0IkHi8
 GjR0JbYKNWc+zzpXky7PMrD7MlTyh98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-8jPz1fe3NLG7tLemm__fVw-1; Wed, 04 Mar 2020 12:42:22 -0500
X-MC-Unique: 8jPz1fe3NLG7tLemm__fVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCDD801A0E;
 Wed,  4 Mar 2020 17:42:21 +0000 (UTC)
Received: from work-vm (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D568F341;
 Wed,  4 Mar 2020 17:42:19 +0000 (UTC)
Date: Wed, 4 Mar 2020 17:42:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] configure: Fix pkg_config --exists parameter
Message-ID: <20200304174217.GI4104@work-vm>
References: <20200304174120.11970-1-liran.alon@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200304174120.11970-1-liran.alon@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, Bhavesh Davda <bhavesh.davda@oracle.com>,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
> pkg_config parameter should be "--exists", not "--exist".
> This is probably a typo.
>=20
> Fixes: 3a67848134d0 ("configure: Enable test and libs for zstd")
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

That's the same as 20200303124925.28079-1-dplotnikov@virtuozzo.com from
Denis yesterday.

Dave

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 50c4d96e2a8c..280f3654f786 100755
> --- a/configure
> +++ b/configure
> @@ -2464,7 +2464,7 @@ fi
>  # zstd check
> =20
>  if test "$zstd" !=3D "no" ; then
> -    if $pkg_config --exist libzstd ; then
> +    if $pkg_config --exists libzstd ; then
>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>          LIBS=3D"$zstd_libs $LIBS"
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


