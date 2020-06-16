Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3798D2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="p5BZv2qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3798D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAon-0005YE-FR
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jlAlh-0001iO-4R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:32:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:2374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jlAlf-00057V-4r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:32:44 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05GCVnwa027831; Tue, 16 Jun 2020 05:32:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=6BRWjfSQXKSSGMjWEhiRdyQJ8URU/bnSkWmIiiP179M=;
 b=p5BZv2qIgTzYGEYdjiJNSwPY6NXdnggwpqeCx4paQnausXNmQ+B2re+2YLksJHWots4s
 Gp12heD0IkbLvy6Cci2wvjTtGur9xZrXCmJzbMJl1AG1ZVo/2Te0Nim9/1TDO7NV/DIR
 ITW9vYLvCk2NkdS3qMbJwhOl6sPXFvuHdznGa+imNFqkTzd18K0xNAXV812YDMeNkMkG
 DfiQaAHCVnQEfxqMSmWEaqyK8006mVRoIRYXLjzjzABzeCqNh1RXCu65Qfr/7/KiDdop
 DgHQnX1BIyjqhYWFbPWK/BwYqWUbQ2a9yXDIztr+LPK+Xt57ByPmH3i/UjWg8+oBQ/FW +g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0b-002c1b01.pphosted.com with ESMTP id 31n0535pfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 05:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/S+hFPCpX0P9N6BhYt6QhyP2pRokdCfdXe5xaErw8EUdlyvoesJyOslxAyc2IraEgMWp7XbLFbEAR+ItNzHQuw32aE9bjDoeALkIw14/DsF201bLZl8R1qkPqoJ4KOIWab3ywTgfM3kSoF34so+fyJ1BRbbfyHKDwe5+V56uE9p629VjQG3QEsc+jVFmjrIvFUKE2SC2E9KUVJCGCeePtiqDB79qngZZsfgPmoDzwOdmj3mCdKEZCzMcpQFFibaSqZEdJ97YX99nS69m7FwVKz9AZH+FNGjD3dCeX0bB1xPIJyruxK3Zl3VUGukAJjYE0XdxZmHtiRUdk5AsA77Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BRWjfSQXKSSGMjWEhiRdyQJ8URU/bnSkWmIiiP179M=;
 b=WdYMSuohbib5nJ5Fb/dldrlsiePX87Yy0ZInQP31xjWmAH+4JllcFAvJrmvVSNS1OEX7M4MLecu7kwsDdjxMgzyb0dEh/juFfb5U1ZIPWyqSesFVFK0GTHaCuq+I4eoLiDHzH/DgxSdhFC5GzpaGKLgjg7G2R/pKAFygUhoBN0Hv07aSg+o1tTZfQWGvb5583s+efuFWMzbpPvWKH1mIhOE6xRFjhK9Rk14HYRNvdKLYr0qt/gISg/vJxe1oYQPhfFKp0TJtygFSc+qYf7ylx+uPpeqWNt/LP0gAJFSy0OI8H012ZBCl+tuLYRDfXd945IHKevqLhol5KIeHOJYS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5726.namprd02.prod.outlook.com (2603:10b6:208:117::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 12:32:21 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 12:32:21 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Topic: [PATCH V2] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Index: AQHWPyzD7ib4h0/yQkCsyuImnO1oVKjbLNGAgAAJHoA=
Date: Tue, 16 Jun 2020 12:32:21 +0000
Message-ID: <3D5E800F-73FE-48C1-9222-E7FA82DDB1A9@nutanix.com>
References: <1591796451-49987-1-git-send-email-ani.sinha@nutanix.com>
 <20200616135927.4f2ef312@redhat.com>
In-Reply-To: <20200616135927.4f2ef312@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c67010f9-21e5-42a4-e4e8-08d811f150d1
x-ms-traffictypediagnostic: MN2PR02MB5726:
x-microsoft-antispam-prvs: <MN2PR02MB5726279A62C16316ABB1893AF19D0@MN2PR02MB5726.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebb0BH/mb9TfuVf0Do8fjGCcivo+HlOS28DC87BHLhOC/M71p+lbs7YCa8hrZxTHxDw9KEP+r+LqJeA+RuqdpXaZ5lfPkFpfTKL/mZKzWAZeJKOCUrV7HpX+rrHjFm5ExUi6oBb5VbMk2Qh+7UnVUFZWWJeYKaUdkVB8nvy7JjBsHRlC2r7qCQq9E/COE9AVCfjIEpuFXkYhkM/LbE/iaAMcBWeXPDqF1JpyzhTNNWa2qyR/4z3liReDXGZ+pIMXm5WVEYKdBogkqdIfQb66bP/4b6VF9h2FzB4b4Z66cEsrtklL5uDNIafYdXyENW0bPaXJasa9iZQyz3wTgWusJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(86362001)(44832011)(66946007)(4326008)(8676002)(6506007)(26005)(8936002)(6916009)(186003)(33656002)(64756008)(53546011)(66556008)(66446008)(76116006)(36756003)(2616005)(66476007)(5660300002)(54906003)(6512007)(316002)(71200400001)(2906002)(6486002)(91956017)(558084003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hP3uCRejLfB2jNslPoir2PMoXSpE44A3JYh6R2/ohi2y+9AcU0KLj9hCa1iJRX8V+h8xr3j9ccX8welX8WHPhY3xybOhoEmZWBnEcRFgPl5FP/JPHaO8B7toqsNZk5NthJXHQmTGc1m17e8Kx20KDmY+6wo9QnenMzsqWuMTsc0h1SXrl0SpA3vajsKqjZPXnx8hsTUDZH9rqdQY1SGmaKfIkzW53AAyqIIZtSu+lLEmPWetJiELZIzB0Dkysmi2iJv4vGd/Hdf9W8JHZoWNQG3soeWmDI5MmLJWq2H1K0bVENNFkxSg8/K2EV1fZzKa78o+KSmaDXmntr+q+2cNrniwRbBabt7G2CaVjOqVbUggkV7V/DJMoeFXQPKiCWReu7GhR3lSUOO9maSQWX2TQWsc8la5vcyplojxkLTB+yjF/pnc/ZhwArlY8Uwdw8Js/eN69oTZEEo8Bshs6NexUpu2+jQvH2ery41+U/PP+Exv7vMuvP+MC5IyibFEm//P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <54D834122483E94193394C10AD05E0EA@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67010f9-21e5-42a4-e4e8-08d811f150d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 12:32:21.2489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSGvOhpOqPo0Km8h0Ca6+4Kujr7Tqol0y58jD8VRnfXC3GSCqetTVhPF2fC70ZycrYh6bOHhSRUc90ClvzeXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5726
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-16_04:2020-06-16,
 2020-06-16 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 08:32:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 16, 2020, at 5:29 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>> Change-Id: I2a6ab47e80fa2bc9504ce88e063d710efaceb842
> what is this id, prehaps drop it?

Sent V3 with this dropped.

Ani


