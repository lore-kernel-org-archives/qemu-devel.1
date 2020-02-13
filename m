Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E5C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8FF20656
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2sJTt1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8FF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JLj-0002LB-0l
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2JHt-00055j-Hp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2JHq-0005NV-An
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:32:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2JHo-0005Jy-R3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581618747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2dq2sDQKaes2NJMHKytFc7JDtl6P/6WPIxQC3HiBB4=;
 b=M2sJTt1EfQd+nSluTrtzihHVMnUxSu3Hs63RHjNrbq7STL+dwfF7UQ49j/f5y8tTqUzPMh
 R54ySeAAFkcRoDJwG57rNI0YAzMRFN/pJ/oseiJ5CgikuRMt4touQhWTajKSPyWktbeHa8
 sNtdin9BmQtN7zHA6bUZMh8J2p2DETM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-WnydYuzaPJiM3Zcyql729Q-1; Thu, 13 Feb 2020 13:32:25 -0500
Received: by mail-qk1-f198.google.com with SMTP id e11so4308853qkl.8
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zhU07noiHXIkOuC62gVwsnQrgzc3V+PmfYfBWBGiXGQ=;
 b=lKzAMDFUoUm8l4F5//v0xIqtgPC8tLbxlunpPH8qH4ec+OmSJKmQxfDMoF/tO/kB2a
 L/BlmFfWu4USiwHITt/JrAMXW/j2Gl6Lfv7UvedX2LgCUVn2HzN8wJVNkoo9tkS/47J6
 IwiqwUjnvpajaao3e47d3+Qvf8T6S38S3wO0LnJXnLME/wTFlbRAmbDBmACWkyYTiSnv
 qyj1I4x8iVdVOJoEt9lGFD3E2oPkLT7dsWkSdJEZEnj+DR1wJRxolywQrdCj6FeL8QMe
 xZAgx5QBSNOW6VWXwjhbqhFjHeoMCU4MAZPab3kmNQARnd1nIrqcZkGctIXBuebgcxkY
 tbtw==
X-Gm-Message-State: APjAAAWoQRBPEnIHImIGaVAfggiJLDUHfqtL2skZdRVGgT5XYxooyBAY
 naDRWYVPhUQ9NHBUojneZZa9ztBsLPFXKVB6IUdh1IZmnAkNdeAcXCcLJuoRRL1W0M/RN6oBTdi
 RryUwE2FISG51SWY=
X-Received: by 2002:a05:6214:450:: with SMTP id
 cc16mr25191703qvb.175.1581618745080; 
 Thu, 13 Feb 2020 10:32:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRTOha5YvXIUuWyzEsjxk3+xgT0aIPIaoAgr5lH83QeIKfdc1q8k53laviqA5hNcnFEGUviQ==
X-Received: by 2002:a05:6214:450:: with SMTP id
 cc16mr25191668qvb.175.1581618744702; 
 Thu, 13 Feb 2020 10:32:24 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id x28sm1693677qkx.104.2020.02.13.10.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 10:32:23 -0800 (PST)
Date: Thu, 13 Feb 2020 13:32:21 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200213183221.GD1103216@xz-x1>
References: <20200213172016.196609-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213172016.196609-1-david@redhat.com>
X-MC-Unique: WnydYuzaPJiM3Zcyql729Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 06:20:16PM +0100, David Hildenbrand wrote:
> Resizing while migrating is dangerous and does not work as expected.
> The whole migration code works on the usable_length of ram blocks and doe=
s
> not expect this to change at random points in time.
>=20
> Precopy: The ram block size must not change on the source, after
> ram_save_setup(), so as long as the guest is still running on the source.
>=20
> Postcopy: The ram block size must not change on the target, after
> synchronizing the RAM block list (ram_load_precopy()).
>=20
> AFAIKS, resizing can be trigger *after* (but not during) a reset in
> ACPI code by the guest
> - hw/arm/virt-acpi-build.c:acpi_ram_update()
> - hw/i386/acpi-build.c:acpi_ram_update()

What can be the pre-condition of triggering this after reset?  I'm
thinking whether QEMU can be aware of this "resizing can happen"
condition, then we could simply stop the migration from happening even
before the resizing happens.  Thanks,

--=20
Peter Xu


