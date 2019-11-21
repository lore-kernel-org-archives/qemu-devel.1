Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40AEC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7F520672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQqHGBtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7F520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsGl-00034Z-LX
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iXsFk-0001Aa-MH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iXsFh-00063U-Qb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:36:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iXsFh-00062X-Jj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574364986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iL1TG/zj76IYWi3pJKS6bRFvKC7N44kQqANqjWFQEgU=;
 b=VQqHGBtXKy5dAcd0IHL4wVPVmKKKHv2ijDqPxOwr3xI0b9/SdYSk++At7ogpe/Zj5NUgaU
 z9ZMkdTDMCk3t9rIfzfgMxmTrtLkjpR557XYy9nNSp8GyqNFAaguE0kzihgiO63g1lHvil
 YHFmvdnsAdfxyBLQnAh3BSzioXIU9iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-j9M5EbGgMv-w71pr3ciZpg-1; Thu, 21 Nov 2019 14:36:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0168D4E80
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 19:36:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5E1860BCC
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 19:36:23 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 96FFF1809563;
 Thu, 21 Nov 2019 19:36:23 +0000 (UTC)
Date: Thu, 21 Nov 2019 14:36:23 -0500 (EST)
From: Cleber Rosa <crosa@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <76600245.13392416.1574364983414.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191121185303.51685-1-dgilbert@redhat.com>
References: <20191121185303.51685-1-dgilbert@redhat.com>
Subject: Re: [PATCH] vmstate-static-checker: Fix for current python
MIME-Version: 1.0
X-Originating-IP: [10.10.125.0, 10.4.195.23]
Thread-Topic: vmstate-static-checker: Fix for current python
Thread-Index: l3dpKIFcxv6sIw86hZvLd/Uqg50VzQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: j9M5EbGgMv-w71pr3ciZpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
> To: qemu-devel@nongnu.org, quintela@redhat.com, ehabkost@redhat.com, cros=
a@redhat.com
> Sent: Thursday, November 21, 2019 1:53:03 PM
> Subject: [PATCH] vmstate-static-checker: Fix for current python
>=20
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Python 3.7.5 on f31 doesn't seem to like the old type=3Dfile syntax
> on argparse.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  scripts/vmstate-static-checker.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/vmstate-static-checker.py
> b/scripts/vmstate-static-checker.py
> index 21dbdccf3e..9f912dd870 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -379,9 +379,11 @@ def main():
>      help_text =3D "Parse JSON-formatted vmstate dumps from QEMU in files=
 SRC
>      and DEST.  Checks whether migration from SRC to DEST QEMU versions
>      would break based on the VMSTATE information contained within the JS=
ON
>      outputs.  The JSON output is created from a QEMU invocation with the
>      -dump-vmstate parameter and a filename argument to it.  Other
>      parameters to QEMU do not matter, except the -M (machine type)
>      parameter."
> =20
>      parser =3D argparse.ArgumentParser(description=3Dhelp_text)
> -    parser.add_argument('-s', '--src', type=3Dfile, required=3DTrue,
> +    parser.add_argument('-s', '--src', type=3Dargparse.FileType('r'),
> +                        required=3DTrue,

Actually, as far back as Python 3.4 (maybe even earlier) `file` is not a
valid built-in function anymore.

>                          help=3D'json dump from src qemu')
> -    parser.add_argument('-d', '--dest', type=3Dfile, required=3DTrue,
> +    parser.add_argument('-d', '--dest', type=3Dargparse.FileType('r'),
> +                        required=3DTrue,
>                          help=3D'json dump from dest qemu')
>      parser.add_argument('--reverse', required=3DFalse, default=3DFalse,
>                          action=3D'store_true',
> --
> 2.23.0
>=20
>=20
>=20

And I agree that this is 4.2 material.

Reviewed-by: Cleber Rosa <crosa@redhat.com>


