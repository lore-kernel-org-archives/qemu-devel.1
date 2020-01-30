Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF69206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqOrFxVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF69206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix85C-0007WP-31
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix81C-000305-T5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix81B-0008AF-Gy
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:29:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix81A-00086D-Vj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580383789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqXZf2ztUMPB3wtCyO35GWFqJbN8IzjzSmoBh49g5GU=;
 b=TqOrFxVwJsJJwE+LSuNfEKz6eLhPDA6z+oLVnWWQoEM1ZRzhmZUS0uSWw3zicbZJTa10Om
 K2H+NOYqFJp00MXhI3F+nFaMJfwytoYivTdMIm/+9U4gnvgmE9MVZD2wGGt6WJWa6ScCkh
 hluyuYQScy4pml1E39aRz5dwNfP24gQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-u1KHiuSrOxy-loxyeUI-5Q-1; Thu, 30 Jan 2020 06:29:46 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so1279900wmi.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HbN0n3tMANoi5xaL4C59R8YBgKidmAPrlno7Ce4gnXI=;
 b=gPZJBQZ2zDD4oRb7xbwJfku/A+xoQxuBLDQctZ69Fkx3Jsha1EmwaW+7Yt+APKqyD2
 Py5tgzywR1mVkwAC1lFofDoyE4hbfeI3Gy2AzyainheX/ormOwfmHokt+rnft7qLbOQH
 ly3Yq3ykZrgoJc9UHR0NxV7aBRl3hz9EcHJPinF0ZpszWMYmAJGWdzJqHjX35KDO7KXZ
 8FV9a2v4zrEOyPXU54dGpXLdxrZPGvi7QF53YLQCrI+B1xsHpL727RDfrznef0XNIB/0
 zVUe42Ztqv1QEmSN3tM2p2cuQ4A+gYohyhBCqnvhjBWaeQFQUbNHqQi8Fm1eLoTi9EZ0
 DqJg==
X-Gm-Message-State: APjAAAWn/IhIXuAi3Km+HspQf8c4BYEC3Ce/dIYOW6H+W6CmYwWg8Q0t
 GhmZCZ9DZcchZwvtUDLE7Kugl4/6+LEn6WZ5Kwe9TTe0d5YAz4L06GYus+GzjwhgL2/un51qRdf
 vKRi0FIIA2+0pv20=
X-Received: by 2002:a1c:a381:: with SMTP id m123mr5078293wme.158.1580383784685; 
 Thu, 30 Jan 2020 03:29:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyImVKBN2j/5tHNYJMWuyrTE7WzpdJvCQ3CztblwPxPxV2o+zqCo2/ELUW0PqewuH7j3jY6A==
X-Received: by 2002:a1c:a381:: with SMTP id m123mr5078266wme.158.1580383784432; 
 Thu, 30 Jan 2020 03:29:44 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id m3sm7075269wrs.53.2020.01.30.03.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:29:43 -0800 (PST)
Date: Thu, 30 Jan 2020 12:29:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 3/6] tests/boot_linux_console: fix extract_from_deb()
 comment
Message-ID: <20200130112941.6eqfd75ri7icvxzl@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-4-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: u1KHiuSrOxy-loxyeUI-5Q-1
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, wainersm@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 04:36:31PM +0000, Liam Merwick wrote:
> The second param in extract_from_deb() is 'path' not 'file'
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  tests/acceptance/boot_linux_console.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8daf6461ffac..43bc928b03a2 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -40,7 +40,7 @@ class BootLinuxConsole(Test):
>          Extracts a file from a deb package into the test workdir
> =20
>          :param deb: path to the deb archive
> -        :param file: path within the deb archive of the file to be extra=
cted
> +        :param path: path within the deb archive of the file to be extra=
cted
>          :returns: path of the extracted file
>          """
>          cwd =3D os.getcwd()
> --=20
> 1.8.3.1
>=20

--=20


