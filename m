Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD4C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6B920809
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Okj2d4pU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TYaW/SlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6B920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN3Ek-0005DY-4q
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 20:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=533302fc3=Damien.LeMoal@wdc.com>)
 id 1kN22q-0002yI-EV; Mon, 28 Sep 2020 18:54:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=533302fc3=Damien.LeMoal@wdc.com>)
 id 1kN22n-0003te-CH; Mon, 28 Sep 2020 18:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601333696; x=1632869696;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=l2L6EVCHrZv2jkCT4MEgFdgscDxwlGuKkodfM9BIQXk=;
 b=Okj2d4pUlkss7QnIRyHLPTkRQOqV3BSHWfRpuGe1KXKiRrOrxCf9Sise
 JptDe7Cr6O3CIdVl4s2cIcCwZWVmoMKg7+X/a+guqT9ca8OC/UBEA8vpD
 DQfteCdMl5ZdStJ1LkeBDACMRyvo2eC8EmG+PkKlDZAG+4cbEOAPLmHEb
 W4nEjkoDUdXKWAoszgp7V2rcWVhFrOongxeHFnI6zYj35Wo8NcZw5j7IL
 gb2hi/fEuZeLT1T/Y5vZj5ylPJta1gewo+XeRI2oo1XPxcpl039AO4pOh
 LgmKScMlM5No8EHyR16a1X054KzK2q86F76SZukT7GzXyyRDGZUEZbqRK w==;
IronPort-SDR: lX0FLbkJDoX7n5W25AFFyQ1FFncvVUcC8vUGkrfHk01/xN3kRtmycAsViWjAEe5and1T3wg9iT
 iLKuiQAKiTgGSa7ih4UIcLa8Vr5W6DKJnvGkBDvGHqIWVl+ybhJspFDYKeYivTaBXCCoUaIjBS
 7DB5AbMy5aKYj7qLvGe6LaFIj5sMOHYPeKs4nyrej4rD0qgl0T2dplDbI/+l/oEwOdXuqJ3byK
 iOG2FSmZXWwZdPbTkVqV4rNgT0Cwiyx8nXb/6JAQKE/B+h75WInuAcMzbmhifymiDk/AMK62j0
 zrQ=
X-IronPort-AV: E=Sophos;i="5.77,315,1596470400"; d="scan'208";a="251887945"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 06:54:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/2gjw27QNrOAMNkClRKVAzGHxnActeVSntndcMpOD679AuCeHd4Ce64y3hsjf3/JSH0M5jIN0EthjZTcuF6zm7LER92Ty6/ouUnP8IK72Wr11mm8m7FszhWuv4ggtfcCSRvb0N8+7xY06JuReuBpDejtmpS8wQA0rO6JMeTFLjp8w629rcqG1YzPUQZ/96TOD0CO0vsy5JIYv/VtHbSovFaIKqZXR32MGFfkT+Zn50RqPOctBYZaDAiDc7kJB8WTMsicfjO9zviHCRf2wrVEaP/mwdPxgWxFlY0qHkek3/IySZZDPpo2UYa3NTlfbQ5oJ6Dv/NGRW0+LX29rCgG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2L6EVCHrZv2jkCT4MEgFdgscDxwlGuKkodfM9BIQXk=;
 b=NercDL2+EYtPz0zUTZ1mEFzGt0VEq4DiRB5Y8XNFagnpBHcjxyYVfA4vD73B2AsYabO1oH3rqdkQWw+9dfPNH3LRXEipqFDKD/aVwZ0XMc7UIpoL64oZvK18+awNbh3CEsmoVo7eX8e2n+oNr6DZSNOkRoOHuNHx/fPQzkA2xveZykKXAvslgz3s/iwm/wefTRNuE6Y08RbG44O1HCXncXoFgJGXqrcHupH0xdptiBV+4/LmtGyIbrtyNEpAgwP7btbyciQwtvbcNB8y9FaYzeCi7Em0XUxAdEwpjTnGBF3TtXUsra/eNM4Dvj1tmv6KQ0qdCVr1ewRzgDyBE2YUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2L6EVCHrZv2jkCT4MEgFdgscDxwlGuKkodfM9BIQXk=;
 b=TYaW/SlTcWuQIazHlmQzAWphymVwGAMHFVEQSTbMCWFHREtltCBgaYpoTOZvtpy4zAqdd4I3x94vdj/4CBWowpo2NiL82h/D1VyTSVj4YNFqoEvfHlZ1WnBEBPWJV4MPozTkPOo4RUysef+4tXFdeX05Db+qPAL4tWAYHI64ZZo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1175.namprd04.prod.outlook.com (2603:10b6:903:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 22:54:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 22:54:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJ45Zpdtg6HEGtgy8M47fl9g==
Date: Mon, 28 Sep 2020 22:54:46 +0000
Message-ID: <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa2927c7-7738-4cd6-7e7e-08d864017f6d
x-ms-traffictypediagnostic: CY4PR04MB1175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1175C18669E090E302A6920EE7350@CY4PR04MB1175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzFzrQ6cES3CNZT4ttYg3CH/AXMrhWt35np2kxeHy/ZpqRTDn7dJfyKlnXiGpagJMjo/y7KcvYzpfDjanBvZwYapyQBGyICJnRLD47/WSZPekwhfNixU48yczrPRu06/N75quMzyfhwh/d5CbEQmNgLWc/PRVP+8lDuFtM/dGiFxSxW0S6mcY/aJkOjbBRfgPZgmnkihRMmpDVP3rDUY35VOKIzc9OKeMALYox0OoY/yXzZBbrvROGqYmCduBupuoOr+ZNZJUZVSUM5woFM8iL4SE16xv5ffhbozR23Mmt5qMTsU3DzVJ3T8SCdj3D4JUKPQ+XuMV6HxghsihuRjnq/TvT3C5+0qhwJuWXYuiant9Xq5RrNTahlQHF33Ocwr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(110136005)(64756008)(316002)(5660300002)(4326008)(8676002)(52536014)(478600001)(66476007)(9686003)(33656002)(66446008)(71200400001)(66556008)(8936002)(186003)(53546011)(7696005)(2906002)(6506007)(66946007)(76116006)(91956017)(55016002)(83380400001)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: D6glXdls4qBquMba+6sKdy1Op1Xoht8wYmQVMqtsDJ6XnCBDsOSwj3nrd/UEBAZgsfJKLqBqtH4zxUOxuB5XqW1+GPIfo3J08ATBLM7wf+cB+oAwr7fz7nv1MAbFaXI70k064WRe2Vf9GfTvy4RbOc/s/pk+UT/bQtFDEtD/vOlk9uTUkL4qSQSzAQagG40lwBOl1RMd5PZVZT0+UQeJUJ494ooy1TSK/sTEqy/Fplogru8tvaEXTvod9OiMwmUsXd+Z+v/rEcFiNNV2R1Hz9Cdkv4GmGa/mt5Y+HmPM3Qi+SMgj59uP1zfH0exR4uGVcTa+a4inAI95pWkpjs1qMznl27/jq71bAFWg/FW/OV3SC5HNbsv2XTkxMq78gshth+enTp1nU58VtAKulq0fX6Dazh+ypTQUao7Fbj0q7huPyhoxaLjaf5ReFVIf5IIKFmecxKdIQEOC4vq6Aaokt2bwP99k9hxdnpv2dhH9308+usr/xuNd0gb/GJoQxaq5S/3eB+XXynBw9nTdv1e7gkYhdR3zSAKa3befjxFmJNEkzya4xlgAUL2QnxV8eJsqEdVS4FQJbCEDWMKtJiJ7beiakZ+/wFm07ZyfUyP11XXvRkwkCW47KsoAVQDJe0MA3lslOhiF5O0mCFUJJkWzgYVSRzwJ4YX+zDP2MyF9USq7wmsOGokfoF3zO8nwcE6ZyElSho+Ywr8fetNTDcUSnw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2927c7-7738-4cd6-7e7e-08d864017f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 22:54:46.6693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW/t/cwFvJoJIc5TCVQHVA5BkaQnncvirqV8XWmmSmXWKjUrgZS48mSTpS3qxv+w5ZY9puKVgvOzohsI0keTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1175
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=533302fc3=Damien.LeMoal@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 18:54:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2020 20:10:29 -0400
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/09/29 6:25, Keith Busch wrote:=0A=
> On Mon, Sep 28, 2020 at 08:36:48AM +0200, Klaus Jensen wrote:=0A=
>> On Sep 28 02:33, Dmitry Fomichev wrote:=0A=
>>> You are making it sound like the entire WDC series relies on this appro=
ach.=0A=
>>> Actually, the persistency is introduced in the second to last patch in =
the=0A=
>>> series and it only adds a couple of lines of code in the i/o path to ma=
rk=0A=
>>> zones dirty. This is possible because of using mmap() and I find the wa=
y=0A=
>>> it is done to be quite elegant, not ugly :)=0A=
>>>=0A=
>>=0A=
>> No, I understand that your implementation works fine without=0A=
>> persistance, but persistance is key. That is why my series adds it in=0A=
>> the first patch. Without persistence it is just a toy. And the QEMU=0A=
>> device is not just an "NVMe-version" of null_blk.=0A=
> =0A=
> I really think we should be a bit more cautious of commiting to an=0A=
> on-disk format for the persistent state. Both this and Klaus' persistent=
=0A=
> state feels a bit ad-hoc, and with all the other knobs provided, it=0A=
> looks too easy to have out-of-sync states, or just not being able to=0A=
> boot at all if a qemu versions have different on-disk formats.=0A=
> =0A=
> Is anyone really considering zone emulation for production level stuff=0A=
> anyway? I can't imagine a real scenario where you'd want put yourself=0A=
> through that: you are just giving yourself all the downsides of a zoned=
=0A=
> block device and none of the benefits. AFAIK, this is provided as a=0A=
> development vehicle, closer to a "toy".=0A=
> =0A=
> I think we should consider trimming this down to a more minimal set that=
=0A=
> we *do* agree on and commit for inclusion ASAP. We can iterate all the=0A=
> bells & whistles and flush out the meta data's data marshalling scheme=0A=
> for persistence later.=0A=
=0A=
+1 on this. Removing the persistence also removes the debate on endianess. =
With=0A=
that out of the way, it should be straightforward to get agreement on a ser=
ies=0A=
that can be merged quickly to get developers started with testing ZNS softw=
are=0A=
with QEMU. That is the most important goal here. 5.9 is around the corner, =
we=0A=
need something for people to get started with ZNS quickly.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

