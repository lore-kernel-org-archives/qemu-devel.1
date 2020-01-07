Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D37207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU7E/zmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D37207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooET-0006Ju-6x
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ionBC-0000Xu-Q8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ionBB-0005uT-Ju
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ionBB-0005u7-FR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXl5nLieXUNFLTNrZ9wtqrytEZk7SEGtYVrCcijrF/s=;
 b=MU7E/zmPG545wVpcLY6iICnjJUlW6bQADrdrQjhduLL1vz671xnHUyChtP3aeOMTIcrgUV
 OFc6ttxYp2tmfWec/ZLXdFe/mAWadDX0YYlwl5AQL8ocmk43rC2fI/ii5qjBMo7tzWhQ50
 S0ud1nB/TRrn6um1PZwkuMKpbnXeino=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-4hkS1CuNOKKZywRwwdhgGw-1; Tue, 07 Jan 2020 06:37:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFC4107ACC7
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:37:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26E1086C44;
 Tue,  7 Jan 2020 11:37:37 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:37:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 079/104] virtiofsd: fix memory leak on lo.source
Message-ID: <20200107113734.GT3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-80-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-80-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4hkS1CuNOKKZywRwwdhgGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:39PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Liu Bo <bo.liu@linux.alibaba.com>
>=20
> valgrind reported that lo.source is leaked on quiting, but it was defined
> as (const char*) as it may point to a const string "/".
>=20
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 33092de65a..45cf466178 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2529,9 +2529,8 @@ int main(int argc, char *argv[])
>              fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
>              exit(1);
>          }
> -
>      } else {
> -        lo.source =3D "/";
> +        lo.source =3D strdup("/");
>      }
>      lo.root.is_symlink =3D false;
>      if (!lo.timeout_set) {
> @@ -2610,5 +2609,7 @@ err_out1:
>          close(lo.root.fd);
>      }
> =20
> +    free((char *)lo.source);

Can we not change the 'lo_data' struct so that source is not const
and thus avoid free'ing a const field ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


