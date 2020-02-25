Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE6C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BD8218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BD8218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Oi0-0002DH-Ui
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j6OhT-0001o4-RF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j6OhS-000730-LD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:07:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2501 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j6OhS-0006yw-B3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:07:50 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 3B976465FEF7CA622B4D;
 Tue, 25 Feb 2020 09:07:44 +0800 (CST)
Received: from dggeme706-chm.china.huawei.com (10.1.199.102) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 09:07:44 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 09:07:43 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 09:07:43 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH V2 7/8] COLO: Migrate dirty pages during the gap of
 checkpointing
Thread-Topic: [PATCH V2 7/8] COLO: Migrate dirty pages during the gap of
 checkpointing
Thread-Index: AQHV6t9QEJvH3LTaGEODTAOJsf/S46gp74mAgAEp0vA=
Date: Tue, 25 Feb 2020 01:07:43 +0000
Message-ID: <fa49beefefd842289f57d603bee4ab51@huawei.com>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-8-zhang.zhanghailiang@huawei.com>
 <6b161824-9765-5c7c-39a0-580b0c65879c@redhat.com>
In-Reply-To: <6b161824-9765-5c7c-39a0-580b0c65879c@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.214.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
Cc: "danielcho@qnap.com" <danielcho@qnap.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Eric Blake [mailto:eblake@redhat.com]
> Sent: Monday, February 24, 2020 11:19 PM
> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>;
> qemu-devel@nongnu.org
> Cc: danielcho@qnap.com; dgilbert@redhat.com; quintela@redhat.com
> Subject: Re: [PATCH V2 7/8] COLO: Migrate dirty pages during the gap of
> checkpointing
>=20
> On 2/24/20 12:54 AM, zhanghailiang wrote:
> > We can migrate some dirty pages during the gap of checkpointing,
> > by this way, we can reduce the amount of ram migrated during
> checkpointing.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > ---
>=20
> > +++ b/qapi/migration.json
> > @@ -977,12 +977,14 @@
> >   #
> >   # @vmstate-loaded: VM's state has been loaded by SVM.
> >   #
> > +# @migrate-ram-background: Send some dirty pages during the gap of
> COLO checkpoint
>=20
> Missing a '(since 5.0)' tag.
>=20

OK, will add this in next version, I forgot to modify it in this version wh=
ich you reminded
In previous version. :(

> > +#
> >   # Since: 2.8
> >   ##
> >   { 'enum': 'COLOMessage',
> >     'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-rep=
ly',
> >               'vmstate-send', 'vmstate-size', 'vmstate-received',
> > -            'vmstate-loaded' ] }
> > +            'vmstate-loaded', 'migrate-ram-background' ] }
> >
> >   ##
> >   # @COLOMode:
> >
>=20
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org


