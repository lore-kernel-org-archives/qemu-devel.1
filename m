Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E16206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pdYlT5E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E16206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTggB-0000O3-Vo
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:58:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTgdd-0006Ei-FZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTgch-0001eu-MO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:56:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:14424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTgcg-0001SS-Vr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:55:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T6lmW6012810; Tue, 28 Apr 2020 23:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=cFTuwKdXukkqjzRBoSrZKTc9PEPgbyn/ZPG19TNiUCw=;
 b=pdYlT5E/qsf67CQilgKLvnp+FRIW3I+gd/pbJXnOz3yyfZBoNNXN95PwWXSzhYbwH1Aq
 6hX6sh+l13hSJVzZpA3CjtwoZPiG/jHkM1NO1ljK8KsrJA6wzMAVOXIKitogO1zf6pjT
 FmIDFgRPbYU8n9klsldL9uUCF7/vIVNtS051HhOt/wtZupmRbYSwwdGnLLIauWtda6nm
 Atiphwrk9Ywu/BOnpTxmKS2GIaK5IeOgAtMI4ysgTRmW3fUj5lP0QfSgvX4AThD/oNLx
 OHPqmkfksSSvFAU5NUzn4/71KTMFjCFImcwO1dGjQOFyqagTDNaT0o/BW+F/4vaSCTi6 Ow== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30nhn9nx96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 23:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czLPKnqwRY9TKnEJPgRb3i8l1TIcHhJQ1S9Ekqq5Byvd1OC3IDeefFIMO14zjWtPFvzbfJ7v1+HYNupUxarCuyDNEyhLgpmXJjNPhYLL/QuTs3VsQI4GNeEVlHbSU4z6D5mW0As9Kf8Esk9bnhgY5GAl9W30GKKdyMkyvVljzKFZhQOTnzArzf9hP4sDtc/TuAoVXb0OTofcQ8ruj2iXycJSURCcCa5+EJUt1MwHiNKnWlgtuful2abjWqFnJUFnoHJZMlnkW4bCSFC/85uQgEtdRViNxyFzIDbznZvT8swGNN2R4hVvWTqvAw0R5j6m2oE7tTR3I6yRDFykRuWj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFTuwKdXukkqjzRBoSrZKTc9PEPgbyn/ZPG19TNiUCw=;
 b=mpAQBWGcauXVlQmHFiyk1vT4nERJKTGSCUFvU3lWjZtlF9xOi16O/lD+T1/nm0uFjJF5mqCp0ZdGdn7wW3qeTiev2xWrhovEc5Hc1tmZxvA54pxlYtn77Py5mb3x9cYnJYI5UOvzd7CsL8JKjXCFIh9Rjn3iljQkSQMcHhEn8jK6WvyOdpkp1HkAOpyJ6NnLhFbG9J7/0vJQEV0dRVIput+8qM8TBhaVu8HHWjg73iHdSxT0NxK0wb6oS0VlNVaRJMI7V2rqbxxMlO5Y9ViXny6tXwedI+eYmrM9jHrAKbChrRgd/iftFv85iTSvVgE9tdstzryRchYTL3IOcJQURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 06:54:53 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 06:54:53 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgA
Date: Wed, 29 Apr 2020 06:54:52 +0000
Message-ID: <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429025200-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f72b933f-726b-4063-1e4b-08d7ec0a380f
x-ms-traffictypediagnostic: MN2PR02MB5904:
x-microsoft-antispam-prvs: <MN2PR02MB59046A4CAAAC1197A2B93A62F1AD0@MN2PR02MB5904.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(346002)(396003)(376002)(39850400004)(86362001)(71200400001)(44832011)(5660300002)(36756003)(478600001)(2616005)(2906002)(7416002)(33656002)(8676002)(6916009)(316002)(64756008)(186003)(4326008)(26005)(6486002)(6512007)(91956017)(66556008)(6506007)(66946007)(66476007)(53546011)(54906003)(8936002)(66446008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F6+tCJX8KpWjoApbtCfWG61fMZxbUFx5HfSWExEsurSMq8UaT50aNLV2a3DRP+mnbVe3U0M3MutHwNNFnwgngZQA18Ha7662FHGu5J2872PQIJUxcG3rH/bzveP5Jh53Tdq/N/gO1JL0zjttdP7aJ99GwxS7qKSrszr9t20OcZjzss7EadiJrwLaSq3W8iEKs2oLpDK+0fxTdS0Xf+ktRu8ixCaQt7omypmKUU3mf0k0RlyjU1IJT7bDpGIyDJQ4JWt7OgDRzSvSC+85jVxs67EWgEccZgkdgxPXq+RloVyy/L85A7MZLbQ5RpCA0KH0ZYAwRWS6clG8p2ZMCT+0nkjzXcN/7OhTuaiid2l07ZeZMV7F250VsGBqZF/zb5NiW16jLRIjvgG/uze73ATG2n5mxUpY29tgGNwv51SLtuU1A0Gf6StHdPUMPABvLu4o
x-ms-exchange-antispam-messagedata: e1RDhif46Lm2seczaEVWTNMJV6RsJ1UXDg7YKpn/UGFXO9A7LfvgaJkiQHdyHc2nN2AHCAQk7HiBIR07W0USF4BMuf7dAtNkJlTMtxE6v9OLIGOWlMtb8p2k7fsozxzOZpRbJWt9ImXLcQb+HyjK5aWUqW8kmWDPl6CKzpNNgXoB+sJMVJSavKdyeKPH/NtnW25/j+NoTYUoBvagl1udAryg2jefwjW+bDx/q3znz9hsycSdp/33mKOA8fRbeglnvl6m3VHr5g/a2zzOxUvL23wU5vufKozYVfewJsigngkOHDYIDSg0BdWDaxNFlplfINzTs+C/xQKQ+LIPJ9rORn80IcZAZAYky0fCwQKg3bH8aDcVfdnwybePcVmD90UT6Fj2A4K95/H+ngOz9ZAiZkxrhjyf5gBOgafywI5Ey4O2sDpo9NMZHq8ZEQrsbC3L23nfaMDhyAzw668mnbxHDYTj5eCheMJxJnFpVSDtS82sFdPDV3NrXyc2RwvjT2C5IefYHO1m9AWf2UdbDotMQDX0CdrSNOFmtRVETmA9Yvxg+QdXBOnPEZgJr8QAGfwa7LN4iw8eRP6vlZyH0Dtf20CAmKbOfRdal9IWany0g39CLrBnCeVAi4c61FRdqa85qkvleKVKXrabDzdcQl2MOvJ8Sn5Z2029yaTEO/LhCIWjVyeZ4+Rn4/B6n738zw1eAUj2firNXSsCc2KFFzIU3uSFF2itBlp/IoLeoFCaorIrxTtamYE+UYEx+KebhFuDSFvYVKgbYz9c8SVsrWEdWtRcMBnLDMU9843525UfcJs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BD354879E88A824C8DA69FD950B20292@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72b933f-726b-4063-1e4b-08d7ec0a380f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 06:54:52.9458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sXzP36JbQ6Y1ygFZ1uPXHtI3oDKdHGQyo0MoQnQB4nGk5K8HcxiUQwNpg65S1vO7oT8khM5ysi8DW4V+3b5zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_02:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:00:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.151.68
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 29, 2020, at 12:22 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Apr 29, 2020 at 06:11:20AM +0000, Ani Sinha wrote:
>>=20
>>=20
>>> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>>>=20
>>> o if there's a need to disable
>>> just one of these, commit log needs to do a better job documenting the
>>> usecase.
>>=20
>> The use case is simple. With this feature admins will be able to do what=
 they were forced to do from Windows driver level but now at the bus level.=
 Hence,=20
>> (a) They need not have access to the guest VM to change or update window=
s driver registry settings. They can enable the same setting from admin man=
agement console without any access to VM.
>> (b) It is more robust. No need to mess with driver settings. Incorrect s=
ettings can brick guest OS. Also no guest specific knowhow required.
>> (c) It is more scalable since a single cluster wide setting can be used =
for all VM power ons and the management plane can take care of the rest aut=
omatically. No need to access individual VMs to enforce this.
>> (d) I am told that the driver level solution does not persist across a r=
eboot.=20
>>=20
>> Ani
>=20
> Looks like disabling both plug and unplug would also address these needs.

No the driver level solution does not prevent hot plugging of devices but b=
locks just hot unplugging. The solution I am proposing tries to do the same=
 but from the bus/hypervisor level.


> --=20
> MST
>=20


