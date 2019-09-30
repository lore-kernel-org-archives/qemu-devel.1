Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC80C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72F520815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CiCLEeo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72F520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEz2H-0005C7-Tg
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iEz12-0004JX-By
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iEz10-0007si-8f
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:59:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:47082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iEz0z-0007ou-V2
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:59:14 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UGx2Hs018076; Mon, 30 Sep 2019 09:59:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=mxwsyKvroOL2+eecWfBmrIhQ6SEAI8rxNPWWULD1fHY=;
 b=CiCLEeo9WnOc//wN1j0s7u1lymyhv5NkAL/nVGSMMyCqG2vVKGJjXxA0TNcifColqCml
 g/1uTiCgG9JMgunMbwpg1zzvxuxJG24H5cPpOkQMzn/1OleKtFPs6wP9sN9LmA2HRssx
 4dS3OvnuwzF3M3dFROdaDrXgyNum2Mu0xFZ1d9rlDgwvrbZvjLqVBPMDHt1PvMM0g9Hw
 UONnIyWdcV6Z3RAlya6RhFCXMHBItMnH8b0eAjxvWLzgKSVJwt/ZtjNJPByl22aRoeoQ
 gs5p0Jv2jUKqxTg7dSYl9JHGQkN6oonAtq+a25o+BNXdmHja1lAAcdvIefFH3vldji0P YA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va3e8m8wu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2019 09:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2enRYjRrPepAJLe0UG7SWVqqRmnqU45QJfhFfx0j6eKhBiykWLj+BNDamR/eIR8ZjC0Pz7ratoLpLsp+qrBpzm8oPyuTRX3ugaUB49Uy8FmIOPq1yVpxePr6Mq9BJSeyB35BdZR6pULXfDKJ1HDlh+S/Hf+geiKM3k7lN3c3W0RECEYOHFvAYULvx83KP5Z1US9h753mUVEbQume9bgLVuIlWxQ+AJhIT9iaU1ZCxQovp1bswYd1c4nVf2bkbpYS/c9OsgbZXZq28YNUkILO/+e8pMUNaCQE+4BERYfnlGy3Xp7B1FvnRCSkNkg+9Uu2W8LQ0kgubjBIbuUcNt+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxwsyKvroOL2+eecWfBmrIhQ6SEAI8rxNPWWULD1fHY=;
 b=D/rK+zxMxpjjTC8rs+LchNYa1fwlcWREd8FL8xK8S/DHW6sHrngrozEbmMXsbqsd3QMoa19iTLKk6yvuA8SELbHGqpL2twETuvsCrb4sYpu/wFJEFtlehUFQuybsqu/QuWbsiRLfiv08+qG+0Wfb9IHBt/w2K3eV1pqB3zUSSWBIK0uzfe8ZvX7iH2e0yQKkSSDmY3f5jrrFVcrLc9mw7QAjQS3Wb+4G9QwP54SUB94MpwrkHrqpFz27TfKEPgz7chQTs0NfkG1P8IfvIdZWITcQZgyIMoJPgBW24yOBTP1m0lw+j08IF4m3H1KzZ3gXWZXJ1VLK91msvyKsTpQKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3278.namprd02.prod.outlook.com (10.164.187.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 16:59:09 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 16:59:09 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wA
Date: Mon, 30 Sep 2019 16:59:09 +0000
Message-ID: <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
In-Reply-To: <20190930160316.GH2759@work-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13ea5ecb-dda6-4a11-11be-08d745c7831c
x-ms-traffictypediagnostic: MWHPR02MB3278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3278CF5EE1DE0B4B53F6F558D7820@MWHPR02MB3278.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(66066001)(36756003)(71200400001)(8676002)(86362001)(6506007)(53546011)(14454004)(76176011)(102836004)(81156014)(5660300002)(81166006)(2616005)(476003)(2906002)(305945005)(66446008)(64756008)(76116006)(91956017)(66946007)(66556008)(6116002)(66476007)(3846002)(486006)(4326008)(478600001)(446003)(11346002)(71190400001)(7736002)(54906003)(186003)(6246003)(6512007)(316002)(25786009)(229853002)(33656002)(256004)(107886003)(99286004)(8936002)(6486002)(6436002)(6916009)(26005)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3278;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7vZSTPJLYSoANm8CDg/mxnEBRdhu0cSJkWw5jNrZXPDv4tNHuF1bC9ztndwLguNLvA9dSN71daGJcyQso4lg6FgVc29KOTMIi9IWEJrHQHvDP2Pqg80Pr0rgbn7JXDEgCEcm4GOUYbW4eRDIrY4V9qRcrKU55Vi/SFXDBl4lS6l4uAyTgzVL4DXrvqoO21/wBKAHX6K+ADkbRMHJURxRzjLv9fMWnzA1n6pzlFSTXhhWxwAKCREyyWshubW7s8459jbU6mU1K5T7Z13us1JqDbvRySChunJ9G6lV4uycRBFADMNhJwgydvmXBMVJ+trv7fIBJJM7LRaBY5ZlV+9K7/M8DlN1kvI55vxwlbQj9C5NhbRzf1rKSoThu5OA2bYUfLkHyL2ZXl+6KGjBe7IULMfx+nnYRKY1j37uJ9M7Os=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF6A27D4A164794881C67003CB6203F6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ea5ecb-dda6-4a11-11be-08d745c7831c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 16:59:09.4358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szCoXfDjaQ/I6hjHY5/t7H5A1oOe1Y3IafQGwI9FViqN7qpgFEEs03oXPLwArKJwjIs1Z9Prm5qDiJiFz9Ls8CKvKMHSeSiCkcNE5tGIv8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3278
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_10:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Aditya Ramesh <aramesh@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
>=20
> * Felipe Franciosi (felipe@nutanix.com) wrote:
>> Hi David,
>>=20
>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.co=
m> wrote:
>>>=20
>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>> Heyall,
>>>>=20
>>>> We have a use case where a host should self-fence (and all VMs should
>>>> die) if it doesn't hear back from a heartbeat within a certain time
>>>> period. Lots of ideas were floated around where libvirt could take
>>>> care of killing VMs or a separate service could do it. The concern
>>>> with those is that various failures could lead to _those_ services
>>>> being unavailable and the fencing wouldn't be enforced as it should.
>>>>=20
>>>> Ultimately, it feels like Qemu should be responsible for this
>>>> heartbeat and exit (or execute a custom callback) on timeout.
>>>=20
>>> It doesn't feel doing it inside qemu would be any safer;  something
>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
>>=20
>> The argument above is that we would have to rely on this external
>> service being functional. Consider the case where the host is
>> dysfunctional, with this service perhaps crashed and a corrupt
>> filesystem preventing it from restarting. The VMs would never die.
>=20
> Yeh that could fail.
>=20
>> It feels like a Qemu timer-driven heartbeat check and calls abort() /
>> exit() would be more reliable. Thoughts?
>=20
> OK, yes; perhaps using a timer_create and telling it to send a fatal
> signal is pretty solid; it would take the kernel to do that once it's
> set.

I'm confused about why the kernel needs to be involved. If this is a
timer off the Qemu main loop, it can just check on the heartbeat
condition (which should be customisable) and call abort() if that's
not satisfied. If you agree on that I'd like to talk about how that
check could be made customisable.

>=20
> IMHO the safer way is to kick the host off the network by reprogramming
> switches; so even if the qemu is actually alive it can't get anywhere.
>=20
> Dave

Naturally some off-host STONITH is preferable, but that's not always
available. A self-fencing mechanism right at the heart of the emulator
can do the job without external hardware dependencies.

Cheers,
Felipe

>=20
>=20
>> Felipe
>>=20
>>>=20
>>>> Does something already exist for this purpose which could be used?
>>>> Would a generic Qemu-fencing infrastructure be something of interest?
>>> Dave
>>>=20
>>>=20
>>>> Cheers,
>>>> F.
>>>>=20
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


