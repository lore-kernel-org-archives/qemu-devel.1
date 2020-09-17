Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACE42087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="IJTbp8Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACE42087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIshY-0002d2-73
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kIsgV-0001hD-Cu
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:06:43 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kIsgT-0001WB-6V
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=lpDs5ndcla7kARbzQpLHTUruuOvr/hxUdCSnIvShhmI=; b=IJTbp8MiUmbflQ+sAYtLj1jS0T
 Ho/nxCFhKeJv5bh6Hq8OsoCz2+mRlLaCLPskKwVZv/IQbzkMY6S+DEQnONNW9H3+7RjHxnwalT5zj
 81YrsEW17vXulHV5PboM6Y3MBGIts6k6Qvc7L9MwgBykmQzgWmcvjqv0kmwRzqChW7ocqwNQhDIou
 xLcGnnwVPMGyd15z2yNVlDDrpFNBezQuO5fqBT4SgM0Vg14pHkKyvcua7n22N0r5OGXypDoUNio4x
 aZtwusBEQVzJT+hxS0THi2t+vk5ggH7HPal8lQh73k4Ic+Ks74IFWG294jMFU4mN2M3p8sGiomtba
 /uO43KnQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>
Subject: Re: QEMU policy for real file tests
Date: Thu, 17 Sep 2020 14:06:33 +0200
Message-ID: <2029663.ApTj1TM13Z@silver>
In-Reply-To: <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
References: <1836935.RIYQIvKipu@silver> <20200917093756.GC1568038@redhat.com>
 <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 17. September 2020 11:55:00 CEST Thomas Huth wrote:
> On 17/09/2020 11.37, Daniel P. Berrang=E9 wrote:
> > On Thu, Sep 17, 2020 at 10:26:36AM +0100, Alex Benn=E9e wrote:
> >> Christian Schoenebeck <qemu_oss@crudebyte.com> writes:
> >>> Hi,
> >>>=20
> >>> is there a QEMU policy for test cases that create/write/read/delete r=
eal
> >>> files and directories? E.g. should they be situated at a certain
> >>> location and is any measure of sandboxing required?
> >>=20
> >> I don't think we have a hard and fast policy. It also depends on what
> >> you are doing the test in - but ideally you should use a secure mktempd
> >> (that can't clash) and clean-up after you are finished. This is a bit
> >> easier in python than shell I think.
> >=20
> > mktempd will end up on /tmp usually which can be tmpfs and size limited,
> > so be mindful of the size of files you create. Don't assume you can
> > create multi-GB sized files !  Creating a temp dir underneath the build
> > dir (effectively CWD of the test) is a reasonable alternative.
>=20
> Another thing to consider: If you want to create Unix sockets in your
> tests, make sure that the file name does not get too long, since there
> are limits on certain systems - i.e. socket files should be created in a
> /tmp subdirectory, indeed.
>=20
>  Thomas

These answers already cover everything I need right now. Thanks!

=46inal question: if at some later point one large file needs to be created=
 for=20
some test case, is there some approximate size limit to stay below for not=
=20
causing issues with free CI cloud services?

Best regards,
Christian Schoenebeck



