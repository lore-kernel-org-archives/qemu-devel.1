Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84735C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C16520767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="omzJNX4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C16520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTIC-00051p-Fo
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDTHa-0004Fa-AF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:58:38 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDTHY-0006JP-Ce
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=rMKPqmmyoT+UjGKT0K2QvEyp2LAvX5DxsK8MNiMajJQ=; b=omzJNX4+nGw3ihgCv80qYZ/gew
 BaLYyt9w8UV0T/4GJzwelzREVVSKVeOUEgRDLdtCOYHP0m1NewO4AfDuCJzfngQU/IsAHAvHXn5Ft
 dYpoEMg4AW5+xvqnBKTymtzxxcWpHtO79GY5DuYwdThFyzaTi+7pEDVnuozqvz0HbO3IqklIwOq2M
 8CdOq65Eivj14SmOQuwXB0AorZzQTLQnN2t1A3rHLspmoJkxwwMRRtbURYCaUXv2PPeJty7P0RVZh
 pDOaQ+Be3pySVE1OpOThK/REoxTAIoaSpW59nu/qvFQ1ZuuXmx1uJs+RCxF63uiTix9R3UbUv1Kxu
 hyySRfEQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Eric Van Hensbergen <ericvh@gmail.com>
Cc: Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Date: Wed, 02 Sep 2020 15:58:32 +0200
Message-ID: <1810650.YBehO7z9uk@silver>
In-Reply-To: <20200902153934.5a2d7f86@bahia.lan>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <399764553.t4N7NBxW8t@silver> <20200902153934.5a2d7f86@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 07:41:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

Hi Eric,

do you remember any specific reason why the default 'msize' for the Linux=20
kernel's 9P client was chosen such low as 8 kiB? (see QEMU discussion below=
).

Best regards,
Christian Schoenebeck

On Mittwoch, 2. September 2020 15:39:34 CEST Greg Kurz wrote:
> On Wed, 02 Sep 2020 14:52:33 +0200
>=20
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Mittwoch, 2. September 2020 14:25:47 CEST Daniel P. Berrang=E9 wrote:
> > > On Wed, Sep 02, 2020 at 01:22:49PM +0200, Christian Schoenebeck wrote:
> > > > It is essential to choose a reasonable high value for 'msize' to av=
oid
> > > > severe degraded file I/O performance. This parameter has to be chos=
en
> > > > on client/guest side, and a Linux client defaults to an 'msize' of
> > > > only
> > > > 8192 if the user did not explicitly specify a value for 'msize'.
> > > >=20
> > > > Unfortunately many users are not aware that they should specify an
> > > > appropriate value for 'msize' to avoid severe performance issues, so
> > > > log a performance warning on host side in that case to make it more
> > > > clear.
> > >=20
> > > What is a more reasonable "msize" value to pick instead of 8k ?
> > > ie at what msize is I/O not several degraded ?
> >=20
> > A good value depends on the file I/O potential of the underlying storage
> > on
> > host side, and then you still would need to trade off between performan=
ce
> > profit and additional RAM costs, i.e. with growing msize (RAM occupatio=
n),
> > performance still increases, but performance delta will shrink
> > continuously.
> >=20
> > So in practice you might e.g. choose anything between 10MiB ... >100MiB
> > for a SATA spindle disk storage, and a much higher value for anything
> > PCIe based flash storage. So a user probably should benchmark and decide
> > what's reasonable for the intended use case.
> >=20
> > > If there a reason that Linux can't pick a better default ?
> >=20
> > I was not involved when that default value was picked on Linux side, so=
 I
> > don't know why exactly this value (8192) had been chosen as default
> > 'msize'
> > years ago.
>=20
> The original size back in 2005 was 9000:
>=20
> [greg@bahia kernel-linus]$ git show 9e82cf6a802a7 | grep 9000
> +	v9ses->maxdata =3D 9000;
> +	if (v9ses->maxdata !=3D 9000)
>=20
> which was later converted to 8192.
>=20
> I couldn't find any hint on why such a small size was chosen.
>=20
> Maybe you can try to contact 9pfs father ?
>=20
> Eric Van Hensbergen <ericvh@gmail.com>
>=20
> > It certainly (sh/c)ould be higher, as it is already close to the
> > theoreticaly minimum msize of 4096. However how should a Linux guest
> > automatically pick a reasonable msize if it does not have any knowlege =
of
> > host's storage features?
> >=20
> > But even if this will be addressed on Linux kernel side, I still think
> > users of old kernels should be made aware of this issue, as it is not
> > obvious to the user.
>=20
> I tend to agree. Until linux decides of a better default, we should only
> warn the user if they decide to go below the current one.
>=20
> Cheers,
>=20
> --
> Greg
>=20
> > Best regards,
> > Christian Schoenebeck




