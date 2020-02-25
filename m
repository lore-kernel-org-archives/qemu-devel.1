Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F05C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C38721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6Wcm3k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C38721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XiJ-0000lV-H6
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6Xh6-0000Hs-59
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6Xh0-0006bw-Fu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:44:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6Xh0-0006Yo-CJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582627432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJNGlFtilK4sxCN/wrs8Na51miZY5LLNszVACxhEGmA=;
 b=P6Wcm3k6PSWsmE+UgoCA4xKultLkRkIOsCimmNQiE4yATCwJZJrOef/PMTMwnxH6cbzh6u
 r0arys1HnseHJ4ljz/lnNuOwo5Bo91/Nt/NUavqavoMIw/2XM0laEffMCEyVEnM5/bf2aK
 OElaQ+C8G6iBqwYjNHvoda52+cSPkOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-t-UKqhK4NI2kdFCzKPOuAg-1; Tue, 25 Feb 2020 05:43:45 -0500
X-MC-Unique: t-UKqhK4NI2kdFCzKPOuAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF835107ACC4;
 Tue, 25 Feb 2020 10:43:43 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B15B5C1D6;
 Tue, 25 Feb 2020 10:43:42 +0000 (UTC)
Date: Tue, 25 Feb 2020 10:43:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] slirp: samba, set 'server min protocol' to NT1
Message-ID: <20200225104338.GC1148628@redhat.com>
References: <20200225102758.21074-1-jslaby@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20200225102758.21074-1-jslaby@suse.cz>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 11:27:58AM +0100, Jiri Slaby wrote:
> Samba changed the default of server min protocol from LANMAN1 (very old
> protocol) to SMB2_02 (only Vista and newer) in commit 840b8501b436
> (docs-xml: change "server min protocol" to SMB2_02).
>=20
> WXP guests cannot use the samba shares since then as it uses a protocol
> newer than LANMAN1, but older than SMB2_02: NT1 protocol. So set 'server
> min protocol' in the samba config used in qemu to NT1. This restores
> support for WinNT and newer (WXP including).
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  net/slirp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index c4334ee876c7..b3bc4a2bded7 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -887,6 +887,7 @@ static int slirp_smb(SlirpState* s, const char *expor=
ted_dir,
>              "printing =3D bsd\n"
>              "disable spoolss =3D yes\n"
>              "usershare max shares =3D 0\n"
> +            "server min protocol =3D NT1\n"
>              "[qemu]\n"
>              "path=3D%s\n"
>              "read only=3Dno\n"

IIUC, the older protocol version has a number of downsides, both security
and performance related, which is why Samba has removed it from the
default config.  Do we really want to revert this defaults change that
Samba maintainers made, in order to cope with a guest OS which was
end-of-life 11 years ago ? It feels questionable to me.

Maybe QEMU's command line needs to include an option to set the min
protocol version, so that we don't need to hardcode this obsolete protocol
version in the source.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


