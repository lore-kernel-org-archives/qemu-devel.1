Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F3C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D46224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QGxeBW0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D46224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2cJ-0005Yv-6B
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iF2Da-0007kg-RR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iF2DY-0007bl-N9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:24:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:63928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iF2DY-0007ZS-Cq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:24:24 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UKAYLj030462; Mon, 30 Sep 2019 13:24:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=fbkR9JwKMR+QfkWH4Hn8TaV4+bjzZsbxEzUnYXtknrw=;
 b=QGxeBW0x1AiuSPwwK49Qd7R9o5YnwkSQORs1i4j29l5zQ0VZtb5QSOSMnSPn/xQPvv3n
 1/nWNSCXQTL2NAJ6iU9H0qEIGk3OIZGzx7TuSg27SVRw1xWaLAg6AnMQ+kFJrbNmXTas
 IgnwvnpjZSxK0E/+d+jnZfBqRyFlnw1NF0CmcLhzEfxDdnPJ8mcruJnRVE/hxfnbYR8E
 qehXjdfVpPYaCFLFAK7dPAEC3tKGZpwfAGQ52QuT8v1tye0LZMiSQz+UiBFCxlmrllYD
 9eZ0p+E1LelCeTq+BiMsGO+DPzRn2xI4nafLjB+k0wRd62He/lwMYQgWuJVm7Hpc3OEN qw== 
Received: from nam03-co1-obe.outbound.protection.outlook.com
 (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va3e8mq0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2019 13:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtBtnSQDvXHGwoFjogVmIMV4XwaOzB4JppDjZDVk3tHMuuJu7/TAQtRhjdpirhKNY92CKKu9tDVivmKufQw1kzDqGCLTT0l1WE3Xy95os7r8PiBvnpxbV6aZAmRNQd2e87DHXdWAIAZK6VQg01uWJCwuE54+rUz7dOL5eINbv7b7VmxScrk+6cTv8QhQ67DxrntQm7Xzgj9mK9ffyvXmWCsruUDW05y8avZrgUQ5uc8xrcVpiZAzcNG2Zh0Y+SqJsE5wkXDfYcw0QB3UhX0pihHaHSECWWFU+i8rA1/8XOE19a9QkwoKbcbGmZze6aBLUCr/VIXzyn9/hzfnIfOD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbkR9JwKMR+QfkWH4Hn8TaV4+bjzZsbxEzUnYXtknrw=;
 b=j/JiB1mRJ6agvU6DHh+rb1tHR8NDrBBm8+nUNJyc7WucobAmirCBghmYLEh3dRwotRPkTY7xgW2C+Jm43n2lkp5ZkZhzlhWGMW6uOYdkDqPbjo4GmOTKjDqjwDsK9GiLaiMo/TGaGohSxu3ysYL3Mh03AULiv/kyOJ5JNi/u4wFRK51FfhxewAVdICgTdfhNt2yKeADEnBA9My/6WL+hZnTqlK58YqJ0rpPLzPJ3eX+loN2OMkz9KWurls3eqslMTjQ2ft2IZcaXm8LEUWrb0SodKdXEK/Rjup2uaEH7L6qPgpOKeB0Be2MPsgB5Z9LNR5VmWDSk5d0MFrxLrL5yqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2382.namprd02.prod.outlook.com (10.168.243.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 20:24:17 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 20:24:17 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wAgAADW4CAAAYcgIAAB1MAgAAdlwCAAArvAA==
Date: Mon, 30 Sep 2019 20:24:17 +0000
Message-ID: <4E3C4C6F-C6D2-473E-9D8D-F724EE37366A@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <8f83a36d-e88a-bbe9-a0e1-cbfc6278c063@ubuntu.com>
In-Reply-To: <8f83a36d-e88a-bbe9-a0e1-cbfc6278c063@ubuntu.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21dfa103-04c9-4e2e-e615-08d745e42b43
x-ms-traffictypediagnostic: MWHPR02MB2382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB23825C4995EBEFE23B77CFA7D7820@MWHPR02MB2382.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(54906003)(4326008)(186003)(66446008)(26005)(64756008)(478600001)(6246003)(71190400001)(71200400001)(8936002)(5660300002)(305945005)(2906002)(316002)(81156014)(8676002)(36756003)(561944003)(81166006)(53546011)(6506007)(102836004)(91956017)(33656002)(66476007)(66946007)(7736002)(76116006)(66556008)(76176011)(14454004)(66066001)(25786009)(229853002)(3846002)(6116002)(476003)(11346002)(6436002)(256004)(14444005)(2616005)(99286004)(6512007)(486006)(86362001)(446003)(6486002)(6916009)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2382;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdXZmW2ePlAeFYBpKtEhpwBctn+gNxeLQXaYu/U+wqRAKCVudrVruHWWv4U7NwT9/tYm3LST/Qv2QgeFRN9Xj8NrpY5oU/OjLzfl4HntVtoc55XFA1/a/DP0PDLh6d/+a3icvKKhJbYJN16kp2xmmN3+1JniZipL6Owtnrl0NQMpUV5E0I/7XEUePZ3Jp5FddqVz6bSBj+mz1ZwDlNInbaEg/SrOETvo3IK6qoiZfS4ONsQTZSyoqs+OKcvWz3PCcKdDE+vkMl3pbcKRtPGscpfAn9+gryGyIkgRjQ+ejG8rH1A6aPO1S2RlNpCXzQdQi/gNUNMQiNMfHwnO6Oc9elzZ/2CleHOje7JD1skqgbPQf5bXfFNgRqpVsG1OpP6dGToD0VFGmYaibhvcXMvMG+OuVvYYqbqq92R5CsBJsr0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0640F9EDDCE5374BAC55FB766954CD1A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dfa103-04c9-4e2e-e615-08d745e42b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 20:24:17.4825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZSoOK/mN4UqlGR76ZTRWyzS6owLa6ZLU+nZaypJYR572k1LXVUJg5+prp0PVF5htWU3y9sGNy8Jq29v2Cd3aoHhs685NMUh4xAaYh8blFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2382
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_11:2019-09-30,2019-09-30 signatures=0
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
Cc: Aditya Ramesh <aramesh@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 30, 2019, at 8:45 PM, Rafael David Tinoco <rafaeldtinoco@ubuntu.co=
m> wrote:
>=20
>=20
>>>> There are times when the main loop can get blocked even though the CPU
>>>> threads can be running and can in some configurations perform IO
>>>> even without the main loop (I think!).
>>> Ah, that's a very good point. Indeed, you can perform IO in those
>>> cases specially when using vhost devices.
>>>=20
>>>> By setting a timer in the kernel that sends a signal to qemu, the kern=
el
>>>> will send that signal however broken qemu is.
>>> Got you now. That's probably better. Do you reckon a signal is
>>> preferable over SIGEV_THREAD?
>> Not sure; probably the safest is getting the kernel to SIGKILL it - but
>> that's a complete nightmare to debug - your process just goes *pop*
>> with no apparent reason why.
>> I've not used SIGEV_THREAD - it looks promising though.
>=20
> Sorry to "enter" the discussion, but, in "real" HW, its not by accident
> that watchdog devices timeout generates a NMI to CPUs, causing the
> kernel to handle the interrupt - and panic (or to take other action set
> by specific watchdog drivers that re-implements the default ones).

Not sure what you mean by "sorry"... thanks for joining. :)

> Can't you simple "inject" a NMI in all guest vCPUs BEFORE you take any
> action in QEMU itself? Just like the virtual watchdog device would do,
> from inside the guest (/dev/watchdog), but capable of being updated by
> outside, in this case of yours (if I understood correctly).

It's unclear to me how this relates to this use case, perhaps that's
not clear. The idea is that on various cloud deployments, a host could
be temporarily unavailable. Imagine that a network cable snapped. A
management layer could then restart the unreachable VMs elsewhere (as
part of High Availability offerings), but it needs to ensure that
disconnected host is not just going to come back from the dead with
older incarnations of the VMs running. (Imagine that someone replaced
the broken network cable.) That would result in lots of issues from
colliding IP addresses to different writers on shared storage leading
to data corruption.

The ask is for a mechanism to fence the host, essentially causing all
(or selected) VMs on that host to die. There are several mechanisms
for that, mostly requiring some sort of HW support (eg. STONITH).
Those are often focused on cases where the host requires manual
intervention to recover or at least a reset.

I'm looking to implement a mechanism for self-fencing, which doesn't
require external hardware and cover most failure scenarios (from
partially/totally broken hosts to simply a temporary network failure).
In several cases rebooting the host is unnecessary; just ensuring the
VMs are down is enough. That's almost always true on temporary network
unavailability (eg. split network).

> Possibly you would have to have a dedicated loop for this "watchdog
> device" (AIO threads ?) not to compete with existing coroutines/BH Tasks
> and their jittering on your "realtime watchdog needs".

Only when this feature is needed (which isn't the case for most
people), there would be an extra thread (according to the latest
proposal) which is mostly idle. It would wake up every few seconds and
stat() a file, which is a very lightweight operation. That would not
measurably impact/jitter other work.

> Regarding remaining existing I/OS for the guest's devices in question
> (vhost/vhost-user etc), would be just like a real host where the "bus"
> received commands, but sender died right after...

I hope the above clarifies the idea.

Cheers,
F.=

