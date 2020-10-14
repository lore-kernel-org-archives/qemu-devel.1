Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E31120848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QQohonKY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o8YiBQgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfZy-0000sP-FQ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSfRI-0007mX-Fh; Wed, 14 Oct 2020 07:59:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSfRE-0001J3-Oh; Wed, 14 Oct 2020 07:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602676764; x=1634212764;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9UYvk82uYAec1XM8DD5uGWUPVPAN9IrtEcPfrKdS5KU=;
 b=QQohonKYVitv2GA8aF1nKCDFlS6RPuS7S5ZEzD9a4HH16CVfb8jGjprx
 5q+zGTqam8VI9nV6RBfELEGXcGzlEQaCf/c8UXO4Yf8MV76/B8H6wVxJC
 Ub2ty7URhS5CbJxgWPxjz2nRkBW9gxBLUc6Jf6r2hK3HXFtX8rWSCb0Iz
 kBRi8mDyVVRyk2d999luVK8DKqty9KXd8opsOug3a9MjKWmhhudvGBN/X
 Uh7vbaJljD3fBLecR0GqnauUisTmFFitXXkraY3QevNlRSh6cu0AR1ibK
 8uOrWJfVFLURExhdC0J4WAQaKYMFn8VdG5whZO2/CZZ5D1tQrZ6yM5kuG A==;
IronPort-SDR: RUCHIz9ve8IWo1+XI8d9YH1E9PDlNIz7QgzEc2j5DIJngFuxBSwtDl5wEidOlIs9yE7DR9RwKS
 ydo2gjtGjT1w6GDClfNciGOoCuhQ9Pm876xICuB5VqXvmCEkphrA+R3GcVikvy62f6N5G0oVkV
 iV+soCC8CDeeo1sNshe1FTPgD38l8HxKsX49qQ/mOKzISEbTdiSjsJek8QW2Bzcn1PRiVLaI2A
 bWvBLcTT8IOVzKH6ai/gGDOQbYuFjyzowxTT1D8lnwtBBop6qRiBqCVuNMj2l+d8gTDTYFGa8H
 v5w=
X-IronPort-AV: E=Sophos;i="5.77,374,1596470400"; d="scan'208";a="259655522"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 19:59:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqkRnxC/EYtJL4Nilny5HvivOIJRRKqzGbUeKn+MIW5Wfu91Q+TFD7Tnnl92K3ytPFfJaiw3itPvT+EMaraDtwwup3NYlDbGqjotfdAP+gxFI3LGXygYu2h8XNJkhcgi88n2h4WxlTm/5VHX8CtfQs69YsUdgKzvwcw1Ii8hr4uJHeNAbCkyajOAMulwtfY5wjN8/qGMUzNcwDFzVSHWY2kQ/fsXdliJOV82zBihRN/yyB3b5wqp/TnQZZeqfK5Q4eg2DZMV5sHnMtR6HjDf0DtQvlRdsWcjqpM80CCyRnj/QwW6ekuLl5ggHNHYf5OBs2HCmxflrumOJgpSwNrUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12lC+yjbeZhNmf7kw8GcT3+iB4HSNDunbaHTxqEWNao=;
 b=kf7dUYwb1lI4gc4HwKcufSQPgqznpDuxPcAYvvzc9J6aW5JtPla5IZDj7WWOYRSJKinJ2VknSNdOXpCAN0//5z3jXqaWfQFVMfYcVDVQIQX1rTKbFEDoRJJ/PoeA3yLC9id478JE00MmvD3YNwdg2v2XGMC6lEQc8gRSENriFKTzxdAjudaz/30qOhv+fOB21KYDGvYsrExK3J0g/iMcVD08Hl3WScGtHZvREG6LxXvQWSO4+oo/3La7xtr25q1XFgz+xRAquyUqyxKz5SMRtWniOEhDP4OYIWlkJNhIwD8YnPx3SCv+diiaEOiUxRz515ztdPxC+rdPeTz1xNLOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12lC+yjbeZhNmf7kw8GcT3+iB4HSNDunbaHTxqEWNao=;
 b=o8YiBQgNV+D0g8WfQPTaHEUA2cAU8BdJEccWenOnH2R57/q11D4g/6f1FXWTfIN8l5lZvk4LyZPvaGze37rEINgWDh/loV4DhUtTuZ3AFqPP65Z64ZYBh8Qww3BiGLDDOr/iNEe751wfh2LsSAgw/R7FQ8d0D33Pxlv63BLM7Vo=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB5482.namprd04.prod.outlook.com (2603:10b6:5:124::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 11:59:05 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 11:59:05 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWoanCpouRtT9m1k2z4pqIfNzC+qmW/36A
Date: Wed, 14 Oct 2020 11:59:04 +0000
Message-ID: <20201014115903.GA122299@localhost.localdomain>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-6-dmitry.fomichev@wdc.com>
In-Reply-To: <20201013214212.2152-6-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6915f5f4-ed47-41bd-4ed1-08d870388cde
x-ms-traffictypediagnostic: DM6PR04MB5482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5482F72C77D007EC711BC3D7F2050@DM6PR04MB5482.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VOAF5f6p9P7Id/JpGDmk+RkvJEH5ON670StPMaFeb1oCDFQiWyiZKf8RCpCVvy3iZsqGwYRHqlzqEdrfsg5bVrRAOUa+lY7GRR3Yss1EqnBQsdliEUPXCZNrJtkngQb3DiQb2HroJFiW1Tzqz2GX1GZcBBr2XGOJbZbhTIwtgOFvPP5Or8cl9bBwV+CwpSft2VrbiJCo+mtLr3dEh4oB6Qrt8gdPlOVkJNtuILO1Wg7IfB9qZHDwj+CwfQRYeejL6h2OUiETxjSFKt5mHfPRHymYgRV7jP2CFhPpdSvC4hPq10sg2VxB5FQlTH7enP73UQWdzTsCugXTur2vS11zA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(8676002)(83380400001)(71200400001)(6512007)(1076003)(26005)(6862004)(6486002)(6506007)(9686003)(33656002)(66946007)(4326008)(8936002)(186003)(478600001)(76116006)(5660300002)(66556008)(54906003)(91956017)(66446008)(66476007)(86362001)(6636002)(64756008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ApS0V+hhYRuxd0tqIqKF43fFSujrHihnVpIhzftiu0o81VUOmMa+cOeD0MODl76AuXSdoSvjBX6/bX9+LhdgW6VB1PqEMwm1Sz0x7b9rwUMM+WkqfLz0NYKEhNtTnJl2AqKFcZD3u2Gs+aof2iuBEAPYImrPVJgiMVoRE0XbnLi0wWaZlAB2FDA8F1x0E0cXMKNSoAfUmV79See0sFxvynYEn57sE71NPjWedKkvFcM0AbzAZpluxWLQDCa/1TtS+HW2/0F7s8+6W3EeF82W9rg6edgSSg+MZDsL8Sbw5OVsHXMQvO3tSKhE5FZ+kZvFGldTLeJBsbreJ/TEBBQewUjUeyt12umruxTwwmkpUVG73DcWxkqxrXC7t3kN9GHkqhutK8G6g5wPmRmwfkeU6uZGTbqXUEV+0FWpEkCM6vSVn9tcV0wlee/mXY+s/NoN39HbMb04UswBnx2Czf3boNgYZit54bitAIzx6e21h42bWJF0t+GthduyndrQDLUfWnCmt3VBfbtqlaUg+FczOJha2hKVDmOLZDEAILCXSYZbVNuvW0OS6h7mU9m8vc7pJuf1B7vk0VNaQgIsuDcwsWoMn/HZTt5ZnXm7T/K6zhzvO14O0prBlbTHDsgZM1EBBsBdCYCgiv6fjYTCqtThOg==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4B8996387F7A344FA223D3378F866453@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6915f5f4-ed47-41bd-4ed1-08d870388cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 11:59:05.6114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCwXMnsacslSycGXud6zifSeHy0iPg9oLGUHCxchuDyUyIc/ny6mHi1jA0u10N3ADn72l/m2ko4i+l3pxIqegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5482
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5492a5ee4=Niklas.Cassel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:59:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 06:42:06AM +0900, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> Define trace events where needed in newly introduced code.
>=20
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> Subsequent commits in this series add ZDE support and checks for
> active and open zone limits.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

(snip)

> @@ -2260,6 +3155,11 @@ static void nvme_select_ns_iocs(NvmeCtrl *n)
>                  ns->iocs =3D nvme_cse_iocs_nvm;
>              }
>              break;
> +        case NVME_CSI_ZONED:
> +            if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_CSI) {
> +                ns->iocs =3D nvme_cse_iocs_zoned;
> +            }
> +            break;
>          }
>      }
>  }

Who knows how this whole command set mess is supposed to work,
since e.g. the Key Value Command Set assigns opcodes for new commands
(Delete, Exist) with a opcode values (0x10,0x14) smaller than the
current highest opcode value (0x15) in the NVM Command Set,
while those opcodes (0x10,0x14) are reserved in the NVM Command Set.

At least for Zoned Command Set, they defined the new commands
(Zone Mgmt Send, Zone Mgmt Recv) to opcode values (0x79,0x7a)
that are higher than the current highest opcode value in the
NVM Command Set.

So since we know that the Zoned Command Set is a strict superset of
the NVM Command Set, I guess it might be nice to do something like:

case NVME_CSI_ZONED:
    if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_CSI) {
        ns->iocs =3D nvme_cse_iocs_zoned;
    } else if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_NVM) {
        ns->iocs =3D nvme_cse_iocs_nvm;
    }
    break;


Since I assume that the spec people intended reads/writes
to a ZNS namespace to still be possible when CC_CSS =3D=3D NVM,
but who knows?


Kind regards,
Niklas=

