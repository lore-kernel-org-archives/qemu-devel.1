Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85120C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA10620848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ivkS2bD5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Glw56rM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA10620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfoV-0006cX-4z
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSfeg-0006TS-GW; Wed, 14 Oct 2020 08:13:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSfec-0003cv-6N; Wed, 14 Oct 2020 08:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602677594; x=1634213594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kL2Q/18ATYzvm20AjDhrel2WMIlShiE8lPWRrKt1iso=;
 b=ivkS2bD5LfCMFk4Qoi2mpR0+5+udOlsQQlWztOFDcTc0rH0BRzwT7yXc
 j32nUY2ZT8HgJWTX3UgCAZCFstQ+mayV8CYd68/3RL9hdwgR2WB1zfRP7
 L6H41XFxJYmNH45NN0OsGFlbcpiN0bFP8nXoxiRF0jmuAVzQe8cZasKe8
 //iQBRFKsIE9zccY0iH7EevvrtD0lwzXrQhvpqTfuAFS9RpClPZw+0L/s
 8OVKjW2XlNORk5tXB6Yo0PMkAg+kZVuSXJG5wNGNF0WB5PK9pRW9IkWPI
 NegyGNrsqqFJKJs+2QcCAesw7lYhfaNno62FDLVbToPJZko08YKnZFnJk g==;
IronPort-SDR: 5Uqv+GAEZVnUqWaZwYpnsBgPWVoSKWWyTKZppFs9DPa/8wSYPYhZvwrWuux+i0U6vtheJ/ehjz
 BE4Ou/tp99D3yFJLK0by6qeutEdsG0K/wgBb8+N7SLO3eSRZerku3tJqSiXGJFqFAsHvjdOqwl
 NHM4qjDBtEuiGFsMjIpa2lAjPRfNtUiSomRWIiPO19h97tMOcfFxH0ejIjSnWIa8TxO2WrGsiU
 vDSu8gxzUd6nVEqsZgPsN9rHmMCVccev9VUMM71vOHWJbiCfrXdHgb8rvF/Rstz5WyL8uMxPwV
 jSY=
X-IronPort-AV: E=Sophos;i="5.77,374,1596470400"; d="scan'208";a="259657377"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 20:13:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogJ89MkOS1TPaLNuePztzOzdkRwQ5LLIFuG3nRHYTsOWlLij5Ps9//DoN8aYbP6GpJIi+oZ4f30awEXegDvJNloGxRDE3QS0q58SQDrBqor6rV2ukunLFDwzo1sucN07zahiNIn2s0o9uV/817qlCMI2jaQY/OAzjOiaJqcuqk0vZPd487cYx1pTP3oslF002QhwV91aoUbAu8kTbSo5h/fckAiiYgyKzm3pcDriacjt2rfyi3Rw2k+p9OdSHe4+uXMPaREULCLBT5tXFNhWwtrStQApqqBCgJLYOUnqwrrri7hFKk1uc7tZOCVkZ2DQpjyiCSDvjGQpE4eTdWnX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVCcWOTIcSnUloI1uCOWFVtw6Px0oECMAThatEFhWQ4=;
 b=I212Pw+fcMkSIiAg0g0sNQXx35B4JvOukYN+ziOUZ2UnI3hGu90Yk7EkNJUuq+sQFDUEALaga0NXOGyEIzBIoL30CiTziI1QbwnIhISoEmcFkg78HSD8lLwBRx0wg09qiCxrVkrqeb3qeC2SdUMfJvCeghfk3YC95evRP9eHobCCVl+/VgHuJpablU4AeaNuRw9okxoMumNkLBQGgHRK6Z+2nzJMou9Xwcr0+EpPrEzP+vzJoWMS7yqQhazm5f9Rj688Qw31usglY6Y70C3BjEq1Wx+vsrGXDq4ROvZ/oVbfL9na4LqOg3/F5XJs1jKQs4u8GRbMXGl8GPB+WLXP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVCcWOTIcSnUloI1uCOWFVtw6Px0oECMAThatEFhWQ4=;
 b=Glw56rM9aSPfX+ZEC23a/WM15aqOg5sobZnP+aXqNhcdQXprVeB1vwOj/G1vWJHbAVP7SCmTeSbVc+6IgpXSGQXPqUVYsPKl6bE9p3SfdwKev0tQ+fyR8+BLgT0MUVzHDCcNXOwHDInRNJgRf8UJECARHXf+pbSmjtIC2ZniUCA=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB6794.namprd04.prod.outlook.com (2603:10b6:5:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 12:13:06 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 12:13:06 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Thread-Topic: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Thread-Index: AQHWoam+n7xOZLub6EyNx4/dDd0V8qmWRLgAgAC+sYA=
Date: Wed, 14 Oct 2020 12:13:06 +0000
Message-ID: <20201014121305.GB122299@localhost.localdomain>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-2-dmitry.fomichev@wdc.com>
 <20201014005034.GA1264232@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20201014005034.GA1264232@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c4644fe-64d5-4fb7-6903-08d8703a8205
x-ms-traffictypediagnostic: DM6PR04MB6794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB67947BD155A42DFA7B0A7582F2050@DM6PR04MB6794.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DAGzOU7XsKD+s+Bblw/JeUjYWIlsU7+7YfUVsTr76WPQl1Yvz4/pCGDUKY/NeWYz0RHKnqybpZA2leilBAyjli1lmJ/jF1K1A+klfjp6MbE1lblouiedNo2uHDLL9jwax5bLGxJe28T/hunq2Eds2yIvTBLIrOBV7zEzYzu8c/cyJo2Vdd1bzxZjAOYpteTdHQBQDt409+A2UEA+kiTapNUa74Y7IlOv893CFh8kCTtjBdh9+QnaPP5GXOsjmG69tGTuWt0BHaIaGt9xgd+U4OAerrTUa3ZKlDkYwhduM39A1S55JZPijXr3N5/nrO8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(316002)(5660300002)(8936002)(6486002)(6512007)(9686003)(8676002)(4326008)(86362001)(6506007)(478600001)(2906002)(66446008)(66556008)(76116006)(66476007)(91956017)(64756008)(54906003)(186003)(1076003)(33656002)(6916009)(71200400001)(83380400001)(66946007)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XXE5o+e2PvcUL4zU6DQ/1ssc+kY0xVoHs2mj1WVEcqqSCmX1XyvsGGoxdpvs8iLAzK9UDoXkwfw9gy0BxFf+0aycd7LXSXA2eGi9yTcSPf8HoH9rnJ9oFLVbpMYCuDLf5aKIP9KAtahZITjp+A/sB+93Ww3em7gVmdNGV4DPpG+GKD+Rc9IEsQDWo1a0nM6Yb5Q/Bh9AClx3ZROSO/oj4ly8BkVscs3CGE6Fl9Xgzf3ib/cRdTVjz3nzrdRqkLXUxRUnb8LunEghn1hzp/jUdpyUkUvBrZCbGMhsK7gbCN9RoFNJITSrEh6CPU1Xolvga/EDgGc8sQDAa9/bx9bhgtY1t1ZbRQm4izrL98RXMagT26jOuXdnBaM2Zaug5hk7cz7XQvBpusnb4AR3JbsFo8IAWTYvYCF0Lg7phWqu6mOLl1owxIHr+VCLOnxbDFDUB9k6QnquRXAmrW794qpZFR4Ym0dPRgnkWRh49Svr+cdTZMdhSuozvoVhc6q3pmyWsIcBAEAjd6QjRA290uSYL23F6KV417LG0PAadTkk9mNZHmx/kziYButphcxupkcMVDLDA1wy+Qlmz0y3lyTMGtvHp+VOo+nyV9JDvWeNJGC0gYd2PG73jVo5ZXopFh77Ijm90JxakBAmrLSKj3m4kQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <31D6FA223CC57443A25AACF39A9176D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4644fe-64d5-4fb7-6903-08d8703a8205
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 12:13:06.4082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgAc7WW3mskE25i7TVS+B2gkzy3D0QM3Ch3UQXa+NRuoeB5LjhFFtPdvssVM16sGytc9XMdAqydjVZQTJJ0Syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6794
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
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 05:50:34PM -0700, Keith Busch wrote:
> On Wed, Oct 14, 2020 at 06:42:02AM +0900, Dmitry Fomichev wrote:
> > +{
> > +    NvmeEffectsLog log =3D {};
> > +    uint32_t *dst_acs =3D log.acs, *dst_iocs =3D log.iocs;
> > +    uint32_t trans_len;
> > +    int i;
> > +
> > +    trace_pci_nvme_cmd_supp_and_effects_log_read();
> > +
> > +    if (off >=3D sizeof(log)) {
> > +        trace_pci_nvme_err_invalid_effects_log_offset(off);
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    for (i =3D 0; i < 256; i++) {
> > +        dst_acs[i] =3D nvme_cse_acs[i];
> > +    }
> > +
> > +    for (i =3D 0; i < 256; i++) {
> > +        dst_iocs[i] =3D nvme_cse_iocs_nvm[i];
> > +    }
>=20
> You're just copying the array, so let's do it like this:
>=20
>     memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
>     memcpy(log.iocs, nvme_cse_iocs_nvm, sizeof(nvme_cse_iocs_nvm));
>=20
> I think you also need to check
>=20
>     if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY)
>=20
> before copying iocs.

So it seems Dmitry actually does this in the Namespace Types patch:


@@ -1051,10 +1054,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest=
 *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode=
));

-    if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_ADMIN_ONLY) {
-        return NVME_INVALID_OPCODE | NVME_DNR;
-    }
-
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
@@ -1333,8 +1332,10 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32=
_t buf_len,
         dst_acs[i] =3D nvme_cse_acs[i];
     }

-    for (i =3D 0; i < 256; i++) {
-        dst_iocs[i] =3D nvme_cse_iocs_nvm[i];
+    if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY) {
+        for (i =3D 0; i < 256; i++) {
+            dst_iocs[i] =3D nvme_cse_iocs_nvm[i];
+        }
     }


Which later in the ZNS patch is changed to:

@@ -1335,13 +2178,31 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint3=
2_t buf_len,
         return NVME_INVALID_FIELD | NVME_DNR;
     }

+    switch (NVME_CC_CSS(n->bar.cc)) {
+    case NVME_CC_CSS_NVM:
+        src_iocs =3D nvme_cse_iocs_nvm;
+        break;
+    case NVME_CC_CSS_CSI:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            src_iocs =3D nvme_cse_iocs_nvm;
+            break;
+        case NVME_CSI_ZONED:
+            src_iocs =3D nvme_cse_iocs_zoned;
+            break;
+        }
+        /* fall through */
+    case NVME_CC_CSS_ADMIN_ONLY:
+        break;
+    }
+
     for (i =3D 0; i < 256; i++) {
         dst_acs[i] =3D nvme_cse_acs[i];
     }

-    if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY) {
+    if (src_iocs) {
         for (i =3D 0; i < 256; i++) {
-            dst_iocs[i] =3D nvme_cse_iocs_nvm[i];
+            dst_iocs[i] =3D src_iocs[i];
         }
     }


Perhaps the nvme_io_cmd() if-statement removal from the NS types patch +
the switch from the ZNS patch (with out the NVME_CSI_ZONED) could be moved
to this patch instead?

The middle version of adding "+    if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_=
CSS_ADMIN_ONLY) {"
can then be dropped from the NS types patch, since it is not part of the fi=
nal code anyway.


Kind regards,
Niklas=

