Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091FFC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C22206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj+3jPIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C22206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGqJ-0003iq-UI
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWGp2-0002JZ-FR
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:58:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWGp1-0007mJ-Ge
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588759113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTQ2zZbAUkCiQOtJoMzyx7tooV4XfYYcQpIyI7xQuwY=;
 b=Qj+3jPIFvgdnYnCVv/bG1s3AI0hx8ANXERT1Keeew1ck0US03uqd8tLcG2FYNEYF+/MXzU
 +HsUOjQcplgzUBmfgkCkHibtl8DdxY9l8CRu1wYC1M47/nB2SNapcb5jBjHTsErxtjD2br
 jwzqbB07IWQFDuC0elz897FAtFI/WhE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-gcE6y0UPPTO8NzdNyRgKdg-1; Wed, 06 May 2020 05:58:30 -0400
X-MC-Unique: gcE6y0UPPTO8NzdNyRgKdg-1
Received: by mail-wm1-f70.google.com with SMTP id h22so947048wml.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 02:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NRlhaJxOsTWvjcE0SIFi7KX4jHXlWQZ1YFHZy35Rr+8=;
 b=hw3dkibN6v0CTQyLnI6viBR6NOAVMXyTYmgL+OM7/3csP+yBCV1366Acem4C/B9R/m
 qzU6B0dhA9WJXbh1ZXrZX0N/lvM+L9O2tfMvsF+NG/UZi8OzBtm02fOsVSEpqwVKd8gY
 8UypK6bnZMWzAdzcWc4ho7jdl4Y4tNfdh42Gc/V9tMyZDYmrQwJc9k78cuGt8PhMdrSO
 QjjNeUmp75F10wEnSINmu3Uopw2wZSoDEpjg9oAn/T+iKJgX8mMUuXgoaVk9hSnZHpNK
 du27HF1XLeP5ee4FoKlDmcNo5WWxjARi1GfFUEMGqiR7RjxloM+RndN0PW8mpV+230NF
 zX5A==
X-Gm-Message-State: AGi0PuacbsxIQApste1Bjv/cqHxyNYG1jSoQN0oTYakAKOdjV3qoSKcQ
 Zk0TvwMJMkwGHc2Z1tP5x7YqcgzKhCTnzlMdz38UHgKMvMYw0JvnTxXkUSbcT/FrmQVld789dtM
 1aEXJ9Rc1f/AadDc=
X-Received: by 2002:a5d:6503:: with SMTP id x3mr9535745wru.153.1588759109100; 
 Wed, 06 May 2020 02:58:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypIuZhE5ugb09uApb7phZKVP0GeTHFMimDAGiI9mzeA9EYskTccXK9w0MytX/YsXKv87w3TJYg==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr9535716wru.153.1588759108917; 
 Wed, 06 May 2020 02:58:28 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id 1sm2298804wmi.0.2020.05.06.02.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 02:58:28 -0700 (PDT)
Date: Wed, 6 May 2020 05:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v2 1/3] acpi: Move build_tpm2() in the generic part
Message-ID: <20200506055747-mutt-send-email-mst@kernel.org>
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-2-eric.auger@redhat.com>
 <20200506063314.4qvnyfonjixcknuj@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200506063314.4qvnyfonjixcknuj@kamzik.brq.redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, gshan@redhat.com, shannon.zhaosl@gmail.com,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, imammedo@redhat.com, eric.auger.pro@gmail.com,
 lersek@redhat.com, ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 08:33:14AM +0200, Andrew Jones wrote:
> I realize this function is just getting moved, but maybe it should get
> converted to the build_append* API while being moved?

I'd rather refactoring was done in a separate patch -
easier to review.

--=20
MST


