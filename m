Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A72C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA3820702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENODQFQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA3820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8Vi-0001bn-Vj
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Uv-00013F-VS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Ut-000675-RB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:00:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix8Ur-00060u-Tm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580385630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vy7u4q8TR2GGJyzKwVBCUpKv0DoP8t5DqGXYDBRGGYw=;
 b=ENODQFQUiUmy2E0uJEkWD0i5TwucIiz5HvJ/1TJfqzmgI1IshyGNyHAHWKzti5rNO9qQgj
 ZujRGb+Oj8XKLyFuI1ywAEv5G+JnbVGhK2EKMw1SUyLK4xO6zHb2t2fSYoDkQsEgb9d1r9
 +Gx86s+Y4ydolNs+sjeeJQiJG/LcQaQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-6qec5vt6NeqS9Bp3mE4duQ-1; Thu, 30 Jan 2020 07:00:26 -0500
Received: by mail-wm1-f70.google.com with SMTP id q125so420446wme.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 04:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PdXaGxr33UPSeEOHnRK6scKFehznpwVs8y8hfQVkGXo=;
 b=gNXqDyCeJxfdw3Eyoy2VjUuq6XcQTU23xpP2wwEMbQnzfUSH5B6/380ceb3tUs8E4B
 sV9g0MFDRVzyrgXSkJzor+T2Idh7YCmXoEZgIvIv8StgEzbrL04gWlGj9KorPvdAQ24g
 3DI+wIWd7VTwlwE0K7CkWyO821eavKWdXp40l0PzdVv9Dmc9DTVQwDVRQLigMDaVC4Vy
 GLlaPq+yNm/UcacVUfiPovXSrgzVIY+o6Onrz9pJErL3kIKrVC/AAuuQiqzAseKc43aH
 yAxZXSoE9+g+3x18nJX5Ps4gBWrfeOTaIfm+xal28syYP5EkQcCZQr+q6R6vZo8TQ0dh
 kxzw==
X-Gm-Message-State: APjAAAWQO9v1bfh9h7FNAbZk1nBJb/ZNFCSvCfGjoHWrYVWLSDsmnHZT
 9l1UIxlE3++ZDMhcMyydB2VxeQKPtntSz+LXlW94c5QwgN9Cbni49ogB5FhhR7m86oFjM8RWWEn
 cp15vFCJbuQVCXFA=
X-Received: by 2002:adf:dc86:: with SMTP id r6mr5219738wrj.68.1580385624818;
 Thu, 30 Jan 2020 04:00:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqygMETwCUYB1S4kAngxqSPkczt7NWlqpLIOzeyjKgWYfItGHpG2RzoTj577/Eq3YyhYsHTVcA==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr5219672wrj.68.1580385624261;
 Thu, 30 Jan 2020 04:00:24 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id d23sm7092160wra.30.2020.01.30.04.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:00:23 -0800 (PST)
Date: Thu, 30 Jan 2020 13:00:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 4/6] travis.yml: install rpm2cpio for acceptance tests
Message-ID: <20200130120020.zawcwbrvqncjgynj@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-5-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-5-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: 6qec5vt6NeqS9Bp3mE4duQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, wainersm@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 04:36:32PM +0000, Liam Merwick wrote:
> The extract_from_rpm() method added for the PVH acceptance tests needs
> rpm2cpio to extract a vmlinux binary from an RPM.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/.travis.yml b/.travis.yml
> index 1ae645e9fcec..3d8c2a38e679 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -278,6 +278,7 @@ matrix:
>              - python3-pil
>              - python3-pip
>              - python3.5-venv
> +            - rpm2cpio
>              - tesseract-ocr
>              - tesseract-ocr-eng
> =20
> --=20
> 1.8.3.1
>=20


