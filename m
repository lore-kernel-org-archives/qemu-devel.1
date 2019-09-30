Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B7C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED62224A0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0l0cK4fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED62224A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEzYu-0003pQ-DX
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iEzXp-0003MY-Tr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iEzXn-0005yp-Th
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:33:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:5572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iEzXn-0005xY-K3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:33:07 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UHUmjY022730; Mon, 30 Sep 2019 10:33:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=g+NyFdJqNc6HCI69qbgyVk3Xvr1dLpxu+FXynbDKzKk=;
 b=0l0cK4fvLe1yXfDaavZd43vu6TViW/3RtOtqDLtpW65UbigQHjrOqFLS9wwiutITa4Ev
 DVt8ILizIjMyV5+SrEEN9jLwiAXJp39BY2gPjXvgjjCTqDL2JRmBgDw55YK7BVDhdoXd
 BY6lVF+ojcRWatvCMY1JtmZHEXriIKw+hDx+kYzPEO8flAjI7x8Gme824KRwj1c4gxll
 qf6RON52RAra809YzoOqC1tdoIOBR9npO58dGbIme9i9LtaRnzPdjmdTn5cv4bCVO/Yj
 kB1rqa8c2yzOWxC63895pG4pQzP3lr1l+AQq3O+cGETT3NhQk8DDhE0yBaTjsAC7AEVM Bw== 
Received: from nam05-by2-obe.outbound.protection.outlook.com
 (mail-by2nam05lp2050.outbound.protection.outlook.com [104.47.50.50])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va72xm55p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2019 10:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMXqGp7Bo2BXQqdxymC9h7zyrycnsPqQeqTe9CTKchfbCkrw1LLrySoDEht8bA2CjUHP2nPlSrzJXTGIQIRU9MZXS8UVFBf8Cu9T9olOLFFgF7EnCJ67qwqkXcx/tfmgqQuKt/uhsUNSGG7xS2clyJc9ge1b2qckJX68j0jjDYwdRv1ZtJHAypbKmkIzTurHz6Qyc2SELY7/oBLJwx4+l3Qdfg4PbhEIiv+f7TCu1w42+BCzYY5/KYHKzIESwJkA1I2213pidN3Jj1fot32gMOpeeGBDPjLyLVJIlEgeXwAFu4N90McttL534hanAFs0IBumlKgaACgqsbbPClWM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+NyFdJqNc6HCI69qbgyVk3Xvr1dLpxu+FXynbDKzKk=;
 b=EaeqM//MirXVwhZfvsvjaxMtHSQG1JeCmtp/N0yChYMABUF4LfZIWKMdmb/QxF83/FpiL/XRiAT6Tg16OLsofOy7zDcdm+jXJk3pkayLic6QvOLfVXa37hAGCz7GgTPkSw+Pll+XoqCjGdCLUWn/PBraGqtajXAQowyJQjEsCxbMDGTW/GS3HjUxGwD+mwQCnHkzos0SQ28To+yZIURSxxKrUkrDsdFqym5ndJwPw/GwF0egXOJC+mRSpR5aChU5mjl1zKc3NnKRMBmdHqHKG9elTGEfVFx4wiSH0ifnAOam8+8EMiMxuBt9JoyEMa7tB9Ml7my7r23BhdcYzVW2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3214.namprd02.prod.outlook.com (10.164.133.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 17:33:02 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 17:33:02 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wAgAADW4CAAAYcgA==
Date: Mon, 30 Sep 2019 17:33:02 +0000
Message-ID: <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
In-Reply-To: <20190930171109.GL2759@work-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e27ec0b9-e9cf-488f-be3c-08d745cc3ead
x-ms-traffictypediagnostic: MWHPR02MB3214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB32140F155492BA95636D8D6DD7820@MWHPR02MB3214.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(6436002)(6512007)(229853002)(14454004)(316002)(5660300002)(25786009)(478600001)(54906003)(6916009)(6486002)(99286004)(2906002)(7736002)(53546011)(186003)(76176011)(11346002)(3846002)(6116002)(71190400001)(256004)(14444005)(107886003)(4326008)(6246003)(8676002)(71200400001)(305945005)(26005)(476003)(486006)(91956017)(446003)(66476007)(66946007)(2616005)(86362001)(33656002)(102836004)(66066001)(36756003)(81166006)(81156014)(64756008)(66446008)(8936002)(66556008)(76116006)(6506007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3214;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UmUnt3M1w2zTAqsvWIpvQc3GcFuMVu2ijdztI3w6+PcoqE0q3SzsxIEmP78s9L9lBLfknTUUzML9k7/8Ckyc874sqXF1FHE2RsiNMRSEHfvmn9yuDnbzP/hKrZbmMzmd1ylQicuCXGn83yTG5RbyaX8YoHy9Rmgc/RVBipUhOXhS6ChySocmNcU97IKnJC4TPz5NiH10FSGQl/ZQfhrjLbClopPbK8AeBTar3Qa1SWsJGaLUy8IHLt+uwPpbIdna5du3FAdp+t6zUi6rwHkidVduPdy1Ky+oW7wkenBH/82E0YNMVVUd7xUYjUtmXnijrOOloz/dICjpEeXbFB1bwuYcStHmKhEIGgxn+UlEBPBsuSHQgKeEJNTbw5g6ZKHXojQgJ2QAIuOWLjvUyw/ojttDIKMqDps+mIkaJGprgX4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <114B52AE12E1644C9CA6C9FF69222F5F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27ec0b9-e9cf-488f-be3c-08d745cc3ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 17:33:02.2173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kx8ZJAxQSsqjZbwI355Flrw/hTIHh4gKn/s2nGQGAnzFP66QA13bHdRXXElvBtimyFZjiLvG3XRI4rpCgHOZqzbv5/6Ziu+oftRNk9xD9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3214
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



> On Sep 30, 2019, at 6:11 PM, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
>=20
> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>=20
>>=20
>>> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.co=
m> wrote:
>>>=20
>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>> Hi David,
>>>>=20
>>>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
>>>>>=20
>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>> Heyall,
>>>>>>=20
>>>>>> We have a use case where a host should self-fence (and all VMs shoul=
d
>>>>>> die) if it doesn't hear back from a heartbeat within a certain time
>>>>>> period. Lots of ideas were floated around where libvirt could take
>>>>>> care of killing VMs or a separate service could do it. The concern
>>>>>> with those is that various failures could lead to _those_ services
>>>>>> being unavailable and the fencing wouldn't be enforced as it should.
>>>>>>=20
>>>>>> Ultimately, it feels like Qemu should be responsible for this
>>>>>> heartbeat and exit (or execute a custom callback) on timeout.
>>>>>=20
>>>>> It doesn't feel doing it inside qemu would be any safer;  something
>>>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
>>>>=20
>>>> The argument above is that we would have to rely on this external
>>>> service being functional. Consider the case where the host is
>>>> dysfunctional, with this service perhaps crashed and a corrupt
>>>> filesystem preventing it from restarting. The VMs would never die.
>>>=20
>>> Yeh that could fail.
>>>=20
>>>> It feels like a Qemu timer-driven heartbeat check and calls abort() /
>>>> exit() would be more reliable. Thoughts?
>>>=20
>>> OK, yes; perhaps using a timer_create and telling it to send a fatal
>>> signal is pretty solid; it would take the kernel to do that once it's
>>> set.
>>=20
>> I'm confused about why the kernel needs to be involved. If this is a
>> timer off the Qemu main loop, it can just check on the heartbeat
>> condition (which should be customisable) and call abort() if that's
>> not satisfied. If you agree on that I'd like to talk about how that
>> check could be made customisable.
>=20
> There are times when the main loop can get blocked even though the CPU
> threads can be running and can in some configurations perform IO
> even without the main loop (I think!).

Ah, that's a very good point. Indeed, you can perform IO in those
cases specially when using vhost devices.

> By setting a timer in the kernel that sends a signal to qemu, the kernel
> will send that signal however broken qemu is.

Got you now. That's probably better. Do you reckon a signal is
preferable over SIGEV_THREAD?

I'm still wondering how to make this customisable so that different
types of heartbeat could be implemented (preferably without creating
external dependencies per discussion above). Thoughts welcome.

F.

>=20
>>=20
>>>=20
>>> IMHO the safer way is to kick the host off the network by reprogramming
>>> switches; so even if the qemu is actually alive it can't get anywhere.
>>>=20
>>> Dave
>>=20
>> Naturally some off-host STONITH is preferable, but that's not always
>> available. A self-fencing mechanism right at the heart of the emulator
>> can do the job without external hardware dependencies.
>=20
> Dave
>=20
>> Cheers,
>> Felipe
>>=20
>>>=20
>>>=20
>>>> Felipe
>>>>=20
>>>>>=20
>>>>>> Does something already exist for this purpose which could be used?
>>>>>> Would a generic Qemu-fencing infrastructure be something of interest=
?
>>>>> Dave
>>>>>=20
>>>>>=20
>>>>>> Cheers,
>>>>>> F.
>>>>>>=20
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>=20
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


