Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E56ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4542521835
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JdudXCvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1PV-0006Uh-QL
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Tianyu.Lan@microsoft.com>) id 1iK1IX-00009e-61
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Tianyu.Lan@microsoft.com>) id 1iK1IV-0000w6-DU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:26:08 -0400
Received: from mail-eopbgr1310107.outbound.protection.outlook.com
 ([40.107.131.107]:64064 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Tianyu.Lan@microsoft.com>)
 id 1iK1IU-0000uV-UB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q23XmHqFqZpK4ubFNFwTZKAj2T8FKZxNlesPT1HMW/VAu2Zz0+dscNlXQLkMkKovJQClnk+cIzpYPxkqEaO80utm5KPvPA/aEPa03FNVfG8mpCBLHlYwKcnJ51pYtnkF68pnie1PZ6dgWBlDiAcJ/awIW46dw2fkLBISnb4zmQZhRawGEIrnCa7mgGtp4zpI6xtlr8vRXe+cIcB8oHD9KnmPHnS9bfoxzjdNbc3yBvG7m1l1/XTB1YYWuMDdZfoaGJqK1sQBph9egpHdwqzBi7NbOCY5TXcYsrl9IYz0VWS4Fui4VYCmaDZC+iHpgh6RC22Bue4SxnBtb5897qc4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnuyZLq6XAOnG7RthxXE5XnKoDZRSZkCMIVMRPRxzLM=;
 b=MUQUsGm/2y69YgUUPomvnve8IkvUFumlcnEqK/7o1S8yVWoOnV1NKuNUuIte5P2ZLbx9Xxzm4htuJvi/7QMpVcN09FS1GKp/irvmoy41XfyFmIgIGHpOPXk9DNTgUs0nYAphStMLem7J+U0C07oMV8wE3Ys1wiWaRQth3HWDHrhrH5Eoa/YY2kdiUOcWAcfF986iFjqDeP87UqZIMyLzFy2/2kjb0KBLGbPmjD938o06a7WBcmNO99a652shE+5OIhDaTDblck8dmE0hOcfpcwgxRm6AUm1ofbWgnYfJ162ERVwamBOyq9wlA9javYuWTwDOoBfTtS+FBHQZs8CqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnuyZLq6XAOnG7RthxXE5XnKoDZRSZkCMIVMRPRxzLM=;
 b=JdudXCvDDxgfaeeNuYCh2Ty3WbySV6wHfs6cHf5KOGCrrmNJ3r9LHVBVVHM0EzvBCmuysPkb50LoIs4OABO+Dz72MxSC0pmiIeDp96LhrQ8TMyQl8HBr2CHw3KmrQzEYqtWthK8c2HtZz22sDj/WxvY9ek9Ygh/o/BhJcIdNcIo=
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM (52.132.240.14) by
 KL1P15301MB0278.APCP153.PROD.OUTLOOK.COM (52.132.240.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.3; Mon, 14 Oct 2019 14:26:02 +0000
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318]) by KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318%6]) with mapi id 15.20.2367.014; Mon, 14 Oct 2019
 14:26:02 +0000
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
To: Cornelia Huck <cohuck@redhat.com>
CC: vkuznets <vkuznets@redhat.com>, "lantianyu1986@gmail.com"
 <lantianyu1986@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Roman
 Kagan <rkagan@virtuozzo.com>
Subject: RE: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Topic: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Index: AQHVgK8HkSJ/Ajtt/E6pHX3BH3x3w6dYROIAgAHM/1KAABjagIAABs9Q
Date: Mon, 14 Oct 2019 14:26:01 +0000
Message-ID: <KL1P15301MB02619B5B1EB5BB1E83881F8292900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
 <87r23h58th.fsf@vitty.brq.redhat.com>
 <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
 <20191014154825.7eb5017d.cohuck@redhat.com>
In-Reply-To: <20191014154825.7eb5017d.cohuck@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-14T14:25:58.9876832Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e1190ff-2cb9-4d6c-92c2-9bf4003561ae;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e25e57b-93b2-4b63-65e8-08d750b270de
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: KL1P15301MB0278:|KL1P15301MB0278:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KL1P15301MB027820A8949E6C07534B751C92900@KL1P15301MB0278.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(11346002)(229853002)(9686003)(446003)(476003)(305945005)(74316002)(7416002)(55016002)(6436002)(66066001)(54906003)(2906002)(26005)(33656002)(3846002)(10090500001)(53546011)(6506007)(486006)(186003)(6116002)(102836004)(76176011)(7696005)(8936002)(5660300002)(14444005)(52536014)(316002)(86362001)(6916009)(256004)(81166006)(81156014)(8676002)(8990500004)(66946007)(66476007)(71200400001)(14454004)(6246003)(66556008)(64756008)(478600001)(71190400001)(76116006)(66446008)(7736002)(99286004)(4326008)(22452003)(25786009)(10290500003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0278;
 H:KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06djXRVZ09XoOk6H9bDUw3VlEsgygzckXN+sueKn3rUVFemy3VKI1seGw2HYQu5Uzud6gpfop77Vl8Cm7Qa/R9e0fAq+zPLBB2Vn2K5vLhTwLm/l02NXiUgqn/DdTn4ueP3I6dVZK3a1cJOHrJcFJ+z6CvSgizGCpzqq2YXaVFU6rTtr47UFgjw720c4tS6abou70Qe1pAB681jJk6DqRdWx2FYoLYeihNy8NurKebR51dJrOaN9IW/eYXzM+poIis+DbmId5GvcXacRd6SyCPJSTNJyzjpslcb+qnfEFvtq5gOC31zljZO91HRFlZsYVi4I9cbaw3eIlG+u4GaBk9esGpNf0PTAVrM+7TbDfMs8y9oDyTYfBhjbwyVlsO08WmkIx2u7mt11nnUvix2hGm5xe5PAogIpUm8r3FMrGF4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e25e57b-93b2-4b63-65e8-08d750b270de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 14:26:02.0011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dav6m7GaCXXusB7lyIyn8PTSl8Cc7ffjdSX0XulY8mQt2vIbA3s39fkJs/PRKzxLQHmpbNetiWAxRlaqeo8EDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0278
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.131.107
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

On Mon, Oct 14, 2019 at 9:48 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 14 Oct 2019 13:29:12 +0000
> Tianyu Lan <Tianyu.Lan@microsoft.com> wrote:
>
> > > > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > > > index 18892d6541..923fb33a01 100644
> > > > --- a/linux-headers/linux/kvm.h
> > > > +++ b/linux-headers/linux/kvm.h
> > > > @@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
> > > > =A0#define KVM_CAP_ARM_SVE 170
> > > > =A0#define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
> > > > =A0#define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> > > > +#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174=20
> > >
> > > I was once told that scripts/update-linux-headers.sh script is suppos=
ed
> > > to be used instead of cherry-picking stuff you need (adn this would b=
e a
> > > separate patch - update linux headers to smth).
> > >=20
> >
> > Thanks for suggestion. I just try the update-linux-headers.sh and there=
 are a lot
> > of changes which are not related with my patch. I also include these
> > changes in my patch, right?
>
> The important part is that you split out the headers update as a
> separate patch.
>
> If this change is already included in the upstream kernel, just do a
> complete update via the script (mentioning the base you did the update
> against.) If not, include a placeholder patch that can be replaced by a
> real update when applying.

OK. This change has been upstreamed and I will send complete update patch. =
Thanks.

--=20
Best regards
Tianyu Lan

