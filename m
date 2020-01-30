Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B35CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59393206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvUPzou3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59393206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixClv-0000PB-8B
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ixCjK-0006sB-TF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ixCjJ-0006OE-KX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:31:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ixCjJ-0006L1-FR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580401902;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JB9ldd1TbM97bscB88eIEyMKF4rBCSiTIs2gH1McC7E=;
 b=DvUPzou3YcmSGwgJowBZnyXup8fI7VYVRy2wOBZfHxmpWVKhWPUd6wW5ct4mnPPi31XF6Z
 3eC4x+Yg2bcJhESsvaGOHGpZqKQlgeE7U5suBFnY9VVFPohGzlkPGeeCjnubbH5+GYC1WA
 0FZrYvmbic9++9pqryDLErS6mM3UJAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-UqznFZHLMkqGvqCrkVeDyw-1; Thu, 30 Jan 2020 11:31:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20A21851FC2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:31:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8118687B38;
 Thu, 30 Jan 2020 16:31:23 +0000 (UTC)
Date: Thu, 30 Jan 2020 16:31:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2] git: Make submodule check only needed modules
Message-ID: <20200130163120.GR1891831@redhat.com>
References: <20200130162810.14503-1-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200130162810.14503-1-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UqznFZHLMkqGvqCrkVeDyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 05:28:10PM +0100, Juan Quintela wrote:
> If one is compiling more than one tree from the same source, it is
> possible that they need different submodules.  Change the check to see
> that all modules that we are interested in are updated, discarding the
> ones that we don't care about.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> v1->v2:
> patchw insists in not using tabs
> ---
>  scripts/git-submodule.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 98ca0f2737..65ed877aef 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -59,10 +59,14 @@ status)
>      fi
> =20
>      test -f "$substat" || exit 1
> -    CURSTATUS=3D$($GIT submodule status $modules)
> -    OLDSTATUS=3D$(cat $substat)
> -    test "$CURSTATUS" =3D "$OLDSTATUS"
> -    exit $?
> +    for module in $modules; do
> +        CURSTATUS=3D$($GIT submodule status $module)
> +        OLDSTATUS=3D$(cat $substat | grep $module)
> +        if test "$CURSTATUS" !=3D "$OLDSTATUS"; then
> +            exit 1
> +        fi
> +    done
> +    exit 0
>      ;;
>  update)
>      if test -z "$maybe_modules"

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


