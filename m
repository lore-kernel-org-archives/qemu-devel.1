Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC1C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0EA2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORc6DBHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0EA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRSP-0007YD-AM
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSRQp-0005gM-90
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSRQo-0006Kf-6t
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSRQo-0006KK-2v
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VnHW6pXlMn61e0IoWFY7qzftbK9TsDVsaoNkIdED0o=;
 b=ORc6DBHHkMKuGaqczcuCwvfjROsknLLK5N2jt2u601RCkZzwSzTdl5X73cb0g122ZJCH7E
 Ff7GK0ohnD9hGTU6jX0ZV0VH82468SiOBQQFXJbiiNd/GEvD/gC0q6fcRVg9bWb5XQR7Nr
 heIoDGJkj+n8mMvrqFxpn5vrLs9A5mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iQiSKFb9O5WGkrB0-wmePA-1; Wed, 06 Nov 2019 14:57:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA490107ACC3;
 Wed,  6 Nov 2019 19:57:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75BE4600D3;
 Wed,  6 Nov 2019 19:57:24 +0000 (UTC)
Date: Wed, 6 Nov 2019 19:57:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/6] migration/postcopy: wait for decompress thread in
 precopy
Message-ID: <20191106195722.GI2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iQiSKFb9O5WGkrB0-wmePA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Compress is not supported with postcopy, it is safe to wait for
> decompress thread just in precopy.
>=20
> This is a preparation for later patch.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

OK, since your last patch does this for postcopy.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 7938a643d9..f59e3fe197 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4375,6 +4375,7 @@ static int ram_load_precopy(QEMUFile *f)
>          }
>      }
> =20
> +    ret |=3D wait_for_decompress_done();
>      return ret;
>  }
> =20
> @@ -4406,8 +4407,6 @@ static int ram_load(QEMUFile *f, void *opaque, int =
version_id)
>          } else {
>              ret =3D ram_load_precopy(f);
>          }
> -
> -        ret |=3D wait_for_decompress_done();
>      }
>      trace_ram_load_complete(ret, seq_iter);
> =20
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


