Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D50C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A2C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4FT5mQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A2C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXhu-0005u7-6q
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVXgI-0004Et-Lx
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVXgH-0003iK-Q9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dX7pyjGG1bJhzdWUvtt+aOn1HRKqQEIlsG74zemzzb8=;
 b=F4FT5mQX0ULJbR6FD16+NjQ5em+lGGapzEY+JD+VJYT8pfe0tO/rWS5nZSSAaKXYLsmmvz
 Q4KiVFEOhAZ17IOjmX0+YJOqFPYu0Zs2OFm64QqCaJCmtocU7m4kMGIar/ZxpQfERxdwXp
 zQZKkFOtpVV2kTJH9XdKMFuvuxUbjjo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-QOSRY-HCOsuKecPPN_zKaw-1; Mon, 04 May 2020 05:46:31 -0400
X-MC-Unique: QOSRY-HCOsuKecPPN_zKaw-1
Received: by mail-wm1-f69.google.com with SMTP id b203so3212446wmd.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T+pWPjECyB0tBu10pP0AVCD/WE7tR/PWJFyjiPlZNog=;
 b=HK53P6dly2mkddOzUFJcDekAe1vfNfaux41IN5wX+spWLWx+42RvRkQjtSj3Hg8212
 CTrwrs9NE7I4sygWUaUaTZv4nx67x0O+iT8niFLh9GSebCZqA6TbMjlBi8Ptmgo356/4
 2KQE/Dxbck3oIAnfvfdkLgmnznchMySttTAWsfW7j7aPV2RNhzAxTQesVVyklMcbiKlb
 oJniw+EwrkE+JEl7zCk2DftnvT0mgxPFOXgmA0hQPAGQJHdc9b5hcCBa+nBdfVc26ota
 whNFjc8gXy/rPbBY+8lNt9gSgPBRndBwT2kRZVY/TiluzuwwaXbnTTKxQeU2v8u9lMhy
 7NmA==
X-Gm-Message-State: AGi0PuaiFigE490/au2NuOEOjU65gVJEFuBovbzKfiVHEkQpg3HzwoyY
 rYPi/OuzLYNCBM/McLxPKZlqd5/RzHwTxpR+l3dTidQVEBssCuxr6PJzLnhVT64ODt592Gs1dBL
 mgfF8t1nb695Nocc=
X-Received: by 2002:a1c:154:: with SMTP id 81mr13557567wmb.48.1588585590590;
 Mon, 04 May 2020 02:46:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIw0vFzsf1Yj0erT5nl2nEAEbm/uFVN5rsdLhUvU2VH+9DSgoI5Vbyfw9x0vwFZ93V3qWexZA==
X-Received: by 2002:a1c:154:: with SMTP id 81mr13557545wmb.48.1588585590360;
 Mon, 04 May 2020 02:46:30 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h188sm14103963wme.8.2020.05.04.02.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:46:29 -0700 (PDT)
Date: Mon, 4 May 2020 05:46:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
Message-ID: <20200504054547-mutt-send-email-mst@kernel.org>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <20200504011252-mutt-send-email-mst@kernel.org>
 <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 prime.zeng@hisilicon.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 10:29:18AM +0100, Peter Maydell wrote:
> On Mon, 4 May 2020 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 21, 2020 at 01:59:27PM +0100, Shameer Kolothum wrote:
> > > This series adds NVDIMM support to arm/virt platform.
> > > The series reuses some of the patches posted by Eric
> > > in his earlier attempt here[1].
> > >
> > > This series previously had few fixes to qemu in general
> > > which were discovered while adding nvdimm support to arm/virt.
> > > Those were sent out seperately[2] and are now part of Qemu.
> >
> >
> > Mostly ACPI stuff so I can merge it if I get an ack for ARM side.
>=20
> Happy for you to take it; all the arm-specific bits have
> been reviewed by various people (thanks!) so here's my
>=20
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> I notice that checkpatch complains a lot about
>=20
> ERROR: Do not add expected files together with tests, follow
> instructions in tests/qtest/bios-tables-test.c: both
> tests/qtest/bios-tables-test-allowed-diff.h and
> tests/qtest/bios-tables-test.c found
>=20
> Does that need fixing, or is the checkpatch test wrong?
>=20
> thanks
> -- PMM


Hmm I don't see a patch in this series that changes both
tests/qtest/bios-tables-test-allowed-diff.h and
tests/qtest/bios-tables-test.c. Do you?

--=20
MST


