Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CAA20735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXxsBVou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CAA20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZ0j-0006Ga-OU
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZ04-0005UQ-O7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:11:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVZ03-0007qu-RE
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588590662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZjGnMCiHmJYbjiJ/fe3Il00znteutgPvYBgPWceCqQ=;
 b=GXxsBVouxCs+WTTXW2pKO7p6rsVnLgrbHEjw5VVPOueGtx2eg6lWhNf/3sskhBc8XMVI3X
 mHsSybJNroRfHZQ5CDzyZhY4gXnfLsZTmKzJKou8RdxWGI46RxFHRkCp0ib2DImxIuY9TQ
 ephzrQVSSp8Q4PDTEEkN1m9b/JmmfVg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-LR-vcZDYOAqhN5Q4c46vhA-1; Mon, 04 May 2020 07:11:01 -0400
X-MC-Unique: LR-vcZDYOAqhN5Q4c46vhA-1
Received: by mail-wr1-f71.google.com with SMTP id e5so10529294wrs.23
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qQR7JIyV7xdFWnZQx7qSyec0iQUn4M2fJvZ9LIIPelc=;
 b=XN0Nips1Y2VkrOFFq9ww3BUDjLmiv6RtSHoVXmhIgp1Z1IW97EIsR1T6PsPkuZ6B5V
 +kHRfvGla3H0MU/7QVYq4UFdhqaXEyXq4kPkmM4EDayEeb6B/tkru3/XH1e0Jddl9rSc
 d3aQJwllRBZ7aoPqWCOUZ3iyBX02ttOd00fefUkY9ZRgzh/VLsgD4NYRm0nnPWEVntxm
 sPBvy6FiKnTUzMCZd0njLeiMNGjeuz/t05zY1gKKD5juSdOR+8lNwzwWIHg72y51lO1A
 Q4b3VXGLHZ0tC8xXpnv3f6O/yQzy+AuEvcWlCUx6cfSXPEj1cDfoOVK68iVbfe4vJUR9
 btlg==
X-Gm-Message-State: AGi0PuafoAmuJzD1EZFKf8F+Cvs6G3N42DcCsrfUMfia5KLgylieMjsJ
 AaXPHq/eHpbtqaX7rirb1fHrgMvWcdhKEgjsFSLChU6IIwNxdxSYGU1KTvw1DdMqqZD6TnHHCQp
 zDiciqgBcxvyb7Po=
X-Received: by 2002:a05:600c:2314:: with SMTP id
 20mr13774328wmo.35.1588590659936; 
 Mon, 04 May 2020 04:10:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLzOGUsLmObtbo2iIGFSluIEqJEw/N2Dr6GclKSIOqtgd0gDPnrrI228MbyoOS6uDELqCPPbw==
X-Received: by 2002:a05:600c:2314:: with SMTP id
 20mr13774305wmo.35.1588590659738; 
 Mon, 04 May 2020 04:10:59 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 b85sm12922636wmb.21.2020.05.04.04.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:10:58 -0700 (PDT)
Date: Mon, 4 May 2020 07:10:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
Message-ID: <20200504071046-mutt-send-email-mst@kernel.org>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <158748197516.25490.13137194821077838492@39012742ff91>
 <20200504055608-mutt-send-email-mst@kernel.org>
 <CAFEAcA_VGtbjpVTb1VE1XCT43JODjkW8o1zSsVmzO3fg1+fr+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VGtbjpVTb1VE1XCT43JODjkW8o1zSsVmzO3fg1+fr+w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 prime.zeng@hisilicon.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 11:06:48AM +0100, Peter Maydell wrote:
> On Mon, 4 May 2020 at 10:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> > > ./scripts/checkpatch.pl --mailback base..
>=20
> > > 2/7 Checking commit 5554e78b18ea (nvdimm: Use configurable ACPI IO ba=
se and size)
> > > ERROR: Do not add expected files together with tests, follow instruct=
ions in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-a=
llowed-diff.h and hw/acpi/nvdimm.c found
> >
> > This beats me. Where did we get
> > tests/qtest/bios-tables-test-allowed-diff.h from?
> > It's a different patch, isn't it?
>=20
> Ah, this is a bug in the checkfilename() function -- it uses
> some globals $acpi_testexpected and $acpi_nontestexpected, but
> there is no code to reset these when checkpatch starts checking
> a new patch. So if you only check one patch in a checkpatch run
> (eg by just passing it a single patch file) then it will work, but if
> a single checkpatch execution is checking several commits
> (eg in the way patchew runs it to check the whole series of
> git commits at once, or if you pass it several patch files) then
> it will give wrong results for the second and later patches.
> I think the variables need to be reset at the top of 'sub process()'.
>=20
> thanks
> -- PMM

Good point. Will fix.


