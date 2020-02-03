Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B7C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29D32080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqfqtqx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29D32080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34507 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUOM-0001xU-W5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 00:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyUNG-00012U-1d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyUNF-0007CG-1A
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:34:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyUNE-0007AQ-Tx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580708056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcFJJCjQo0TOdLh1o4wwrPlObe/GNGk4kz+QgrOhKIc=;
 b=cqfqtqx3zh8m+mfzgvKILnSyANInDR6petuHvV6RQZt2UFviqQT15maKyBMs0EnX/74TuS
 g5SPf9D0bzxI5tH620HiNdukGBrZSlUU1MP8WGSof7hmt0FsvNgDcl4hfliaKM0i3TPp2z
 IcYfpAKVZk6SEZSJc4Q8T8JCo+v3K3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-aD_FY7RuPwaFZAvczhM6MQ-1; Mon, 03 Feb 2020 00:34:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id l1so2588393wrt.4
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 21:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GAKCQPHXWz2VKhrbZjv/2cs5ACvknu78Y17OHJ87Gxo=;
 b=Covu6E1bySMZqv6bYrPJuDxdVtXlf57p8DUTdzJGKu7D+xLZNOQOhrFf5LXoT/+Pf3
 Ykd991yYerrRCv9IW2eiPbVsXf7w3aKCwhc8A/KXQ32huVm3sVxC1aSj/zI4qL33gPEz
 CGEKYd03Cdd+6KpJ7sSuUqbD7fLsNpCJBNFFO02KQ7gIiG0gQyZt7co/9qG/dt1Bkq90
 MXXUOjVM7ZFRql4WPxWZUhId3DswvgXflJKgKGM8No7nuOnaocDg6xpxHZkw6vXRCNBM
 1DNCVskcSYSDnxxzvt6OkAfRqxsHkvzj2+f+52bLdpcEhxMbDR2XF0LOlCzoSyiRjA8v
 0fZg==
X-Gm-Message-State: APjAAAWPqkglmib1wpvtUf8pJEJN/jfpUq0Wp5jLJ//P/N2Z/N586Inw
 40t3qpRLyXVO4BKsiveRzDoKHJBbPyI7RSou0phY68aeAsRZDFcNSpb+FI48yEG9/tYSV0OhSyc
 Lg0klvqvBadRzY80=
X-Received: by 2002:a05:600c:d6:: with SMTP id
 u22mr26927931wmm.77.1580708046980; 
 Sun, 02 Feb 2020 21:34:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBQo+ynhyu19JoLgJntGjoGo77IQ9Y48uGiNwUdjKdSWwmZkpZKEok8NYp4hltZlKjsX60Xw==
X-Received: by 2002:a05:600c:d6:: with SMTP id
 u22mr26927910wmm.77.1580708046831; 
 Sun, 02 Feb 2020 21:34:06 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id m9sm5021390wrx.55.2020.02.02.21.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 21:34:06 -0800 (PST)
Date: Mon, 3 Feb 2020 00:33:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 1/7] bios-tables-test: prepare to change ARM virt ACPI
 DSDT
Message-ID: <20200203003349-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203001505.52573-2-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-2-guoheyi@huawei.com>
X-MC-Unique: aD_FY7RuPwaFZAvczhM6MQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 08:14:59AM +0800, Heyi Guo wrote:
> We are going to change ARM virt ACPI DSDT table, which will cause make
> check to fail, so temporarily add related golden masters to ignore
> list.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..32a401ae35 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,4 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/virt/DSDT",
> +"tests/data/acpi/virt/DSDT.memhp",
> +"tests/data/acpi/virt/DSDT.numamem",
> --=20
> 2.19.1


