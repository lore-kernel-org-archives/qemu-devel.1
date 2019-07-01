Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0812FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D222064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iUIULe3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D222064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxiw-0007fD-TO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hhxTm-000216-Kb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hhxTk-0006rV-Nl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:40:26 -0400
Received: from mail-eopbgr800113.outbound.protection.outlook.com
 ([40.107.80.113]:15342 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hhxTi-0006nG-O6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EaGWXoYt13vqRsaH/QHy3z983X/zDkLrMmSai6J3UE=;
 b=iUIULe3PbZd67KfBgiYP3I1B3jCgBvKI8d2zGb+tBPq4pCmR2OiYIo8w3gQfOiGVIyssFJsB72XSKRZngR3i6bL1U6Jt6g+aU6G059KdC1ilTXvrMjqDLkZFSgCOENZeD5JmpYnP8+6Qi9eHfq860/wA/QwUI1KBBaHU/h/BzbM=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB3801.prod.exchangelabs.com (20.176.65.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 14:40:16 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:40:16 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument memory
 accesses
Thread-Index: AQHVIt11hLjmFwnAA0W4zaK1l+4xhaaxRysAgAAcDgCAAA0TAIAAML6AgARO/oA=
Date: Mon, 1 Jul 2019 14:40:15 +0000
Message-ID: <20190701144009.GA5002@quinoa.localdomain>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
 <87mui1ab4j.fsf@zen.linaroharston>
 <20190628175756.GC26345@quinoa.localdomain>
 <87lfxla0vs.fsf@zen.linaroharston>
In-Reply-To: <87lfxla0vs.fsf@zen.linaroharston>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:910:4f::22) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 759b2a43-b814-43a7-f01d-08d6fe3207cf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB3801; 
x-ms-traffictypediagnostic: DM6PR01MB3801:
x-microsoft-antispam-prvs: <DM6PR01MB38012955110D0836F171C7F98AF90@DM6PR01MB3801.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(199004)(189003)(66946007)(99286004)(73956011)(102836004)(76176011)(8676002)(305945005)(6916009)(6116002)(316002)(54906003)(52116002)(7736002)(81156014)(66446008)(486006)(14454004)(14444005)(256004)(6506007)(81166006)(71190400001)(71200400001)(86362001)(8936002)(64756008)(66476007)(66556008)(3846002)(11346002)(476003)(386003)(5660300002)(446003)(186003)(6246003)(478600001)(6436002)(53936002)(229853002)(26005)(66066001)(6512007)(9686003)(68736007)(25786009)(4326008)(66574012)(33656002)(1076003)(2906002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB3801;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XaayUuRwVrklML0cgxNEtJxooaCIBAfq0US65WOr+jJDHynSq6kNQeVK5v3lgPB8uivwEs9CiNADJHjz778dsM7A1VLccfvopoMmTdD3WO8NHf526gvOMauhUuxVYvW1nLL7m3CDf8UgSPdj3ApTMvV/phcu0B6rokbQtTTZwiSKDV1ZYDhbUgFnDpkVEZCOYJW1ZqKcSC/XSl94W3UPUEFH4KqcDfBPkGAK3rIdt8u82Z6hSDLPwl7DHC4PzEpIiIMZFB+8YBofhN81VIjO4jdRt91tJqa9SsMx2fXA/w3HHvlLabjyKxW58iVgQabWVsN4I9LCnZM4WtoSdOfgEsOY7HokCKC9Kfq5jcNxUv2wkZSRzJ2Y6nTZhCHXvRnn6huZMQbN4KQlfKT4PGcXVok7dslk8DvKYNLsovm0KLc=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D1D2686308D46E4CB864A1DA1EF3A598@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b2a43-b814-43a7-f01d-08d6fe3207cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:40:15.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3801
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.113
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 28 21:52, Alex Benn=E9e wrote:
> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
> > To make sure I understand - you're implying that one such query will
> > return the PA from the guest's perspective, right?
>=20
> Yes - although it will be two queries:
>=20
>   struct qemu_plugin_hwaddr *hw =3D qemu_plugin_get_hwaddr(info, vaddr);
>=20
> This does the actual lookup and stores enough information for the
> further queries.
>=20
>   uint64_t pa =3D qemu_plugin_hwaddr_to_raddr(hw);
>=20
> will return the physical address (assuming it's a RAM reference and not
> some IO location).

Sounds good, as long as we have a good way to either prevent or cleanly
detect the failure mode for the IO accesses.

> > In terms of our use case - we use QEMU to drive studies to help us
> > design the next generation of processors. As you can imagine, having th=
e
> > right physical addresses is important for some aspects of that. We're
> > currently using a version of Pavel Dovgalyuk's earlier plugin patchset
> > with some of our own patches/fixes on top, but it would obviously make
> > our lives easier to work together to get this sort of infrastructure
> > upstream!
>=20
> Was this:
>=20
>  Date: Tue, 05 Jun 2018 13:39:15 +0300
>  Message-ID: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPa=
d-T60>
>  Subject: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation pro=
totype

Yes, that looks like the one.

> What patches did you add on top?

We added:
- plugin support for linux-user mode (I sent that one upstream, I think)
- memory tracing support and a VA->PA conversion helper
- a way for a plugin to request getting a callback just before QEMU
  exits to clean up any internal state
- a way for a plugin to reset any instrumentation decisions made in the
  past (essentially calls `tb_flush(cpu);` under the covers). We found
  this critical for plugins which undergo state changes during the
  course of their execution (i.e. watch for event X, then go into a more
  detailed profiling mode until you see event Y)
- instrumentation at the TB granularity (in addition to the existing
  instruction-level support)
- the ability for a plugin to trigger a checkpoint to be taken

-Aaron

