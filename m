Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064DC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC292073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6whyGGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC292073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53qG-0006T4-Kp
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j53pc-0005gy-0X
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j53pa-00058u-RA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:38:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j53pa-00053w-N3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582274321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBAct6Z9OiV68TaWEqvLLVbwoKPlKy80g5pl+xUlkSE=;
 b=Q6whyGGxPK4GBJsi/6pPAd+/7FE6V4fcbtHTx7K/7878WoiXOOJ6K1kVp3Nk6624d3ubsw
 UVdTKeVbxH8EKSzdavkG7kp1BvZ2Fz9tTMl2kRaiNGiENXySRkxOzFfnWur+4MStcYFnMG
 /fA6vbWcmiMgpJnh/yt6KC/8bf8ERmU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-lGmBYPt8Oeuhut8M2ODqJQ-1; Fri, 21 Feb 2020 03:38:39 -0500
X-MC-Unique: lGmBYPt8Oeuhut8M2ODqJQ-1
Received: by mail-wr1-f70.google.com with SMTP id d7so709159wrx.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 00:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H9vErtnKYlYy6wFbuRMHoCpDJR+/+RmgsfPlLs55K8I=;
 b=mzRgOXa2EIxxmtd3sjN11VkHQMko8S3TX7tzwWQu42zdPH8G6JVgjS9FW1cTVWa9/R
 H5OSQ2gZmxnrBbvG0M4p6kyx8DTaTRsW+Kqxj7smWctaJENP5a8yyrBcMkuwEKsQCI2X
 Wv3ly81qsOpvem5NHjZT02YVjFgeSQHtvV/rxXHSSzMo2pzNllhBmDx5f7R+7C73T9nM
 uadx9RUDhH44OdZ7AfT8sfz1Aosd/WCDCMFxLSZDI5Ze/EA+pBJYJz+ZLFgvU1ISXnAh
 cGpg9ua2FDUOL25LRS00gXAAQjd7+vLVU0TZyFjO2wTbyA51oVT1QJM6PQZ88VQFKTOf
 a2dA==
X-Gm-Message-State: APjAAAUhj0i249WmnclBZsR5sRy7H5Oe5Ehqpt0QWTNC/Lwo+08/X/U1
 0812MWngUI+mQs9AmngBG3wlCTMs2lDjuVD31frQCZ4BOo7KYg0QHinvZIgI00+pJaob0DAMecP
 ZDAi6F/KJj7pUZww=
X-Received: by 2002:adf:f401:: with SMTP id g1mr46449544wro.129.1582274318596; 
 Fri, 21 Feb 2020 00:38:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFigIyMxkF6U99YhEsl22THDxvi64Ti9uHBBPsqvCKlRnEC/kh00SSqjEAjxmiHPh1N/qE+Q==
X-Received: by 2002:adf:f401:: with SMTP id g1mr46449519wro.129.1582274318340; 
 Fri, 21 Feb 2020 00:38:38 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id q14sm3144766wrj.81.2020.02.21.00.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 00:38:37 -0800 (PST)
Date: Fri, 21 Feb 2020 09:38:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] maint: Include top-level *.rst files early in git diff
Message-ID: <20200221083835.qielytbcsymbolrw@steredhat>
References: <20200220162214.3474280-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200220162214.3474280-1-eblake@redhat.com>
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 10:22:13AM -0600, Eric Blake wrote:
> We are converting more doc files to *.rst rather than *.texi.  Most
> doc files are already listed early in diffs due to our catchall
> docs/*, but a few top-level files get missed by that glob.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Both *.texi and *.rst entries make sense while we are still converting
> things, but we'll need a followup to drop *.texi when the conversion
> is complete...
>=20
>  scripts/git.orderfile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index 1f747b583a9e..abd8a67a2b4e 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -11,6 +11,7 @@
>=20
>  # Documentation
>  docs/*
> +*.rst
>  *.texi
>=20
>  # build system

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


