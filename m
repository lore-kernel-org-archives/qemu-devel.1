Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B09C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E122087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/MiL/My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E122087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isR2s-00070O-7E
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isR22-0006Xx-1z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isR1y-0007HG-7r
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:47:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isR1y-0007FH-2u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579265236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgYg++R7Yygnoy+yXR16YE4+XU6R+TF6MQvfEnWo4Lc=;
 b=H/MiL/My49jKoadzu4xhl4oKteDV74yV3mxPSAUvoVRD1EoYEHltxgPZblBwj+VYlrIM2O
 R1rDo9g4LFt+GN8xAcyVP2pXRoe7sAXAWQJng5Qpo7tIutLB38ylUdTk0NX7ExZF+V/Br9
 FOKzhH4FeOSfgLq/QPqbwVdyt768e9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-pFqwD3QxON2k1w6mONgicQ-1; Fri, 17 Jan 2020 07:47:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A507800D53
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 12:47:13 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C777B5E1AD;
 Fri, 17 Jan 2020 12:47:09 +0000 (UTC)
Date: Fri, 17 Jan 2020 12:47:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] Fix hyperv synic on vhost
Message-ID: <20200117124707.GG3209@work-vm>
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <157922066484.433.7316108748419062411@197193fa8d23>
MIME-Version: 1.0
In-Reply-To: <157922066484.433.7316108748419062411@197193fa8d23>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pFqwD3QxON2k1w6mONgicQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, jasowang@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20200116202414.157959-1-dgilbert@re=
dhat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Message-id: 20200116202414.157959-1-dgilbert@redhat.com
> Type: series
> Subject: [PATCH v3 0/2] Fix hyperv synic on vhost
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20200116202414.157959-1-dgilbert@redhat.com =
-> patchew/20200116202414.157959-1-dgilbert@redhat.com
> Switched to a new branch 'test'
> f7aeff2 vhost: Only align sections for vhost-user
> 5bb467f vhost: Add names to section rounded warning
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/2 Checking commit 5bb467f4ac3b (vhost: Add names to section rounded war=
ning)
> 2/2 Checking commit f7aeff24a99a (vhost: Only align sections for vhost-us=
er)
> ERROR: trailing whitespace
> #45: FILE: hw/virtio/vhost.c:554:
> +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
 $
>=20
> WARNING: line over 80 characters
> #60: FILE: hw/virtio/vhost.c:569:
> +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gp=
a, mrs_size,
>=20
> total: 1 errors, 1 warnings, 43 lines checked

Oops, minor whitespace; easy to fix if people actually like this fix.

Dave

> Patch 2/2 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200116202414.157959-1-dgilbert@redhat.com/testi=
ng.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


