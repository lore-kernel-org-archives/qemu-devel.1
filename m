Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A972067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bbQ0n+0v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q4NFtqGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A972067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq0Nk-0001hC-Pi
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=442b205b5=Dmitry.Fomichev@wdc.com>)
 id 1jq0Ms-0000vS-At; Mon, 29 Jun 2020 16:27:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=442b205b5=Dmitry.Fomichev@wdc.com>)
 id 1jq0Mn-0003F6-Rt; Mon, 29 Jun 2020 16:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593462422; x=1624998422;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SD8yR9OCqSawVP6y6E/UNOoczSzuUav/XRWUnRnnB0I=;
 b=bbQ0n+0vFfJ1BQxZrDhrsFX3lVqY3VQQi7HOJbwHwEVGXHBIrcF0Z9+m
 jpe9pIcphDPQQZFJ4UNExS7gw6sC5i73dnEuZ04H7MiJqZ7L9ScNgKu5W
 a6vun1b+Ym9UA++Ysa3Mm8CiPsxT4f1S8QKobjtyMyGSBOe6rf+S4wo8W
 U5kR9vZj6ptbkPCaLwvUEiosICd699QQMHOFU66uYB+9SPLhldHs6GVs7
 kcTNpwyaOlebjoHeZjf3WkGGT8CSW21p2Rv4wTx31uCPPsAo0PB5xBcrw
 FI73qwNTEO6+gfDCtlO+0cPL0oxl5wyslC7AjOBV4bcJ0jFgibzIIl+/K w==;
IronPort-SDR: aunredOLvpDDp8Na6Oka0nkrtlc8/Xo6/fYiWTU6cdy0Q/T8KDHn7GqzsToaLbj0DPJmXf+Zta
 1nK5nUBptKvAUBkknyZsbi2QBAtWm7eQx43EEsEzyPpdJDhiNrxRv0re7bQ0x0nz6JvoScsVv4
 BX1ZSzan/n6WseOIGdlmqVA5OnsVDB2aHlIkr9K1kSMNiItz2eCvpnZhtGcT3fp3di+4y9PeZ/
 +fTe3NDCoQIJCoyuHNym2dMWDW2krTs/JQz1fwbvyM77edojNB/1SQbq6j4nMwkwYqoRFLBg+X
 ZbU=
X-IronPort-AV: E=Sophos;i="5.75,295,1589212800"; d="scan'208";a="145534643"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 04:26:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRiMsdxLBkyiPOjS9/42r7uJDLW6ZIO1b8PTBjbBRg/XgyAaK3UebNXSOc4HvJnMXl5NayJOH0f6cFuzHI4mJ7IeArdXvBkRAL1FWI+7TjYfTNiHfXNhYaCfEf1nyKe8epuzF46xfFlQen1NdCEkVsrwuSbjzLAYoz4gBbooXQhmF9ZnLElI20PSjm/op6D+bQBB+6tf+cZNn/lFOlkhaAshVBYOrcdP6cEZTYYmO1aLHJX50pW9E5J8KjAY93n9qmB9e2kUXRaYtLfkAG+ow+IiCXqo15avm0HvyT+dUCs7i1mhttpDnaQJ2Easxes7St+5cnerPPiS72Tqy24HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQy7Hg5AZH1vyuNG7OWy+5jKSnrX/NaQrynDMshAS5c=;
 b=em7tWDFrwp51F4rWr5tj2j0GqmH+3uN9wAELDPl9VrCf9xwyGyFMZ9CtfNHb+zRoN3ZDAAfspD4i7HBwCtfT3C2H/FZMSyzwT6JxlkF90ZkOOw8HxNhHi0VtNRHwPO0YHPXszpdvAEVA1ROOXSQJfJHlqPrf2tuPElyGWWh5embb6gafxGNVCq1QxUc7Fp9QQjOGRHySUfcqb+zItd5AQH6b5ZUw1IOJ6vALEgrZBCy3vShAgdfEu5fjxWSpNKKZ4udtkJ8+tF5pwJjraR6JxAxVy7bZrz7CYJ/DZGxDnt9u9+KOMzJ7htJcz95eyXtBCvrfaMggYvcwSlqMZGq+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQy7Hg5AZH1vyuNG7OWy+5jKSnrX/NaQrynDMshAS5c=;
 b=Q4NFtqGgcqcwb3c+sSROMyqJBkm4KlXC5m6wWJX23azTjNkNWYoqWzAB/T4eIMOEABvkhtgGgAUHL+9eoH4wgb/b9PeSYsk8PMBV6h1gG/YX1jJZ0QdBzB3CwAlw6tq2UJqsbK9UaUuVdWiIqNyAtNBNSVFtxPuL7Gbq66yEAnI=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5855.namprd04.prod.outlook.com (2603:10b6:208:a4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 20:26:54 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 20:26:54 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Maxim Levitsky
 <mlevitsky@redhat.com>
Subject: RE: [PATCH v2 00/18] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v2 00/18] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWRO8WT74ezOFjPkWbhIlJMWxhXqjwG0/g
Date: Mon, 29 Jun 2020 20:26:54 +0000
Message-ID: <MN2PR04MB595137BF71AB14CBBDDAA0B9E16E0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1e260d2-1ff7-4d0c-a1cb-08d81c6ac386
x-ms-traffictypediagnostic: MN2PR04MB5855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58558342EC56C7929CC078AEE16E0@MN2PR04MB5855.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjktHfXd0yqn8nkdRsiZt12UUme4EJhJnWLDkB7LMQ4sv3F6QQJriaiqUCyagEIaa1Ee2kf23LxCqEauD1ANlemq9pyOj7/9CjTTOAWEgJd8cGNTMc2k5gAt1IgDeqX8c9FRRBlDgUgOIZaksJV3i2RfrWEWEtv0ggHNEffoYTR0PW3yLCj4K7n51Iyk88KI1T4kzMdM9Bu4o7c3+bNAekbmHOjjqUJdzwe8IhYzAvSY0vZNfJH21MZmToZiYDgB6EgB7WqFGNgxLVjOcEtwv5ZNGvAv02xCwc8Nfl0uLLk+DlFMUTEQxWl7DMg5lvp8XWf9w5f/J40d5ftQ0giaB62h9fc3Hl5/9QDtbCct8OZtjwp/sVDkmfzILArFNl3k0qqvIrY0eag8g+13pzWUr5MGZf4LkI06xpvTFvF0/Wz5J3tR9jABGGPLbUNT6lJVoo8C0m8V7py2WEJaL7a9vuIilGJU5HcrycDpQl53rgs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(64756008)(66446008)(66556008)(66946007)(66476007)(33656002)(76116006)(316002)(186003)(8676002)(55016002)(83380400001)(52536014)(5660300002)(54906003)(2906002)(86362001)(110136005)(9686003)(8936002)(6506007)(4326008)(966005)(53546011)(26005)(71200400001)(7696005)(478600001)(15398625002)(43620500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0CNFRle0Dl1cWps5Xpsk7++Kp8C80gFGDW0NQGfY3EZzUZJE3j14avQqLiNfurx4LrG78ryXKBd3ccjDrdhSzbAXlQroLcQDraoDLxL0Hg1CfAGArykyrUHPVQ3ToD7ykd1XQE02ObbY/zOtYrO1tN03zusGYMfciTnZS6wDzLc2u+SO6KK08MVA2LTvsXMWXDTCbodQ211wUIU4PBrrR8nfYT8XOD5qn/FfID3XqasvmNgdFje99rDm021yBJVAA/zn9UC0c1SScljY+AmPXNU8AxU019sU6AkyvXaNOIX/+4yXiqHkx3RYNOVMTCsfFZ4Hd0m08SIaQaacvirCJy2i8ZD+p0e7Mn1li6U+UqmbykYlneHnpJmr2vXiaD+Uh2PmdiAiVmz8CokWImhZItG+dZn6zdUdfL66k4A8w0EYd9hI5cUwxObe9yDYG2yqVTPftFsbjQZ0MNpFwqayYJg0OVt8i89zKD5joEJyDpM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e260d2-1ff7-4d0c-a1cb-08d81c6ac386
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 20:26:54.3008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8tjqVOaBHu+T4HOJZ4heNtLxAxDHgQE0yfNLL/rFl1lp5Qe5fAB9AGHoyMIE5YB0rAzQo97bhWl1+mgxAVOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5855
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=442b205b5=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 16:26:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bump... Any feedback on this series?

> -----Original Message-----
> From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Sent: Wednesday, June 17, 2020 5:34 PM
> To: Kevin Wolf <kwolf@redhat.com>; Keith Busch <kbusch@kernel.org>;
> Philippe Mathieu-Daud=E9 <philmd@redhat.com>; Maxim Levitsky
> <mlevitsky@redhat.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; Matias Bjorling
> <Matias.Bjorling@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> Niklas Cassel <Niklas.Cassel@wdc.com>; Dmitry Fomichev
> <Dmitry.Fomichev@wdc.com>
> Subject: [PATCH v2 00/18] hw/block/nvme: Support Namespace Types and
> Zoned Namespace Command Set
>=20
> v2: rebased on top of block-next/block branch
>=20
> Zoned Namespace (ZNS) Command Set is a newly introduced command set
> published by the NVM Express, Inc. organization as TP 4053. The main
> design goals of ZNS are to provide hardware designers the means to
> reduce NVMe controller complexity and to allow achieving a better I/O
> latency and throughput. SSDs that implement this interface are
> commonly known as ZNS SSDs.
>=20
> This command set is implementing a zoned storage model, similarly to
> ZAC/ZBC. As such, there is already support in Linux, allowing one to
> perform the majority of tasks needed for managing ZNS SSDs.
>=20
> The Zoned Namespace Command Set relies on another TP, known as
> Namespace Types (NVMe TP 4056), which introduces support for having
> multiple command sets per namespace.
>=20
> Both ZNS and Namespace Types specifications can be downloaded by
> visiting the following link -
>=20
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-
> TPs.zip
>=20
> This patch series adds Namespace Types support and zoned namespace
> emulation capability to the existing NVMe PCI driver.
>=20
> The patchset is organized as follows -
>=20
> The first several patches are preparatory and are added to allow for
> an easier review of the subsequent commits. The group of patches that
> follows adds NS Types support with only NVM Command Set being
> available. Finally, the last group of commits makes definitions and
> adds new code to support Zoned Namespace Command Set.
>=20
> Based-on: <20200609205944.3549240-1-eblake@redhat.com>
>=20
> Ajay Joshi (1):
>   hw/block/nvme: Define 64 bit cqe.result
>=20
> Dmitry Fomichev (15):
>   hw/block/nvme: Move NvmeRequest has_sg field to a bit flag
>   hw/block/nvme: Clean up unused AER definitions
>   hw/block/nvme: Add Commands Supported and Effects log
>   hw/block/nvme: Define trace events related to NS Types
>   hw/block/nvme: Make Zoned NS Command Set definitions
>   hw/block/nvme: Define Zoned NS Command Set trace events
>   hw/block/nvme: Support Zoned Namespace Command Set
>   hw/block/nvme: Introduce max active and open zone limits
>   hw/block/nvme: Simulate Zone Active excursions
>   hw/block/nvme: Set Finish/Reset Zone Recommended attributes
>   hw/block/nvme: Generate zone AENs
>   hw/block/nvme: Support Zone Descriptor Extensions
>   hw/block/nvme: Add injection of Offline/Read-Only zones
>   hw/block/nvme: Use zone metadata file for persistence
>   hw/block/nvme: Document zoned parameters in usage text
>=20
> Niklas Cassel (2):
>   hw/block/nvme: Introduce the Namespace Types definitions
>   hw/block/nvme: Add support for Namespace Types
>=20
>  block/nvme.c          |    2 +-
>  block/trace-events    |    2 +-
>  hw/block/nvme.c       | 2316
> ++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |  228 +++-
>  hw/block/trace-events |   56 +
>  include/block/nvme.h  |  282 ++++-
>  6 files changed, 2820 insertions(+), 66 deletions(-)
>=20
> --
> 2.21.0


