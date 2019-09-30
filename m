Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76907C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F20224D7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uSziMUXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F20224D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1I8-0007Dn-Bo
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iF1H5-0006Kq-2g
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iF1H2-0003nO-IR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:23:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:39644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iF1H0-0003lb-Ow
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:23:56 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UJKRa7002896; Mon, 30 Sep 2019 12:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=NMtAM5n0PXKBEC50J7wRsT831icKWqWEHPm7V8NacyQ=;
 b=uSziMUXj+5OlFZGD1XT8HgIuAhY4yN+HOeIDD7H/G2u2cGWnPmQgc0aVJYPfD9UrBfZX
 6yxl7Ld3OGG4++PG5QHrvetOH9iMyALENkGe6i2iESJw+ycaKIm35GMDJF1zPmdKUE/U
 f9LSzlPt1qhe7douRYXcttvJVBzCHR4GGlFHXU2LE6PVNeyjeRYY+rajQA1TJMhJk3MU
 jp0X6sdDpkAYykccIpY76fKZKUBy9bXHLv1rgVJ/LaStN4V+CmxP0R5pEc20tGDrQtwd
 wmF7+XfxxMYnrPaws1xJR8TiREYN2EdQMTjR0/v4WoE9YvWHJgo8rgSyN7PRMVYHHejO RA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam01lp2056.outbound.protection.outlook.com [104.47.33.56])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va72xmcpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2019 12:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgakGku6lJj3NT1iXsvk54bYf5jUP/sAH/h9jctJXcML5lc96Y7x9a6xvg5EzJ9W+bsZAh7orNi2Mw+BTitVNAHSO3uNQudZKK0SXsPi/Rkktar6Iwm3WD0VsA94LKiko+x2Vmm0rrsF3D6nCG42ZyFrrKkDHs2FSQI6pxLP/uV4AP835pxwPwyW5BMiUeURyA7pisW0ptLGGTbbQXgXHwXCDUCkP4sYs2EZA9wS5YF8SQ+ePMuu7hlKYCoEQoeZ374sAkA7kgM7+F/wD0nQMTsRanRK7EgumN38DxaIgsz2xyinahQAi1ypvWvMgpB2e0Pq6OsPb1muo7dPo/xBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMtAM5n0PXKBEC50J7wRsT831icKWqWEHPm7V8NacyQ=;
 b=T50Aa0s2qm3oy5OyuzesQmYga9UXXvW3xKDvfaq7R5Hzy5iLA65YRqYj97yePrw+IPuLNWeiD7xLRkdKfeAd0w/ms/9hjNuo+ygdIxbx8tHnk1i//eLLODfMZnqW09AaRjEXWhY3Nxti5gx8IDER3zm6NO14a2Cm21Yov6GXItLx0W/ADRCTnuQfEfaq6ciAmf/13Au0sFIK4wrIMvp8E9u6YWbtJJF+HKIXpm/SbigovTGi40+cn+WyQKwr90H+KYTI3Pm4Vg6pS30ui8Gm3GWP7tjdYfJQdJXze7FfiJiO8w2Vh8sFWzhAsaJ4oEjtYP2mmwn2AoLZbdf5YY03/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2718.namprd02.prod.outlook.com (10.175.50.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 19:23:48 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 19:23:48 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wAgAADW4CAAAYcgIAAB1MAgAAXoIA=
Date: Mon, 30 Sep 2019 19:23:47 +0000
Message-ID: <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
In-Reply-To: <20190930175914.GM2759@work-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87665c35-2f2f-48ef-244f-08d745dbb7e2
x-ms-traffictypediagnostic: MWHPR02MB2718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB271891D97856BFF172530F33D7820@MWHPR02MB2718.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6506007)(2906002)(107886003)(486006)(66946007)(5660300002)(76116006)(91956017)(33656002)(14454004)(186003)(53546011)(6246003)(6486002)(6436002)(25786009)(229853002)(478600001)(14444005)(256004)(6512007)(102836004)(26005)(11346002)(446003)(2616005)(476003)(4326008)(71200400001)(71190400001)(99286004)(76176011)(66446008)(66556008)(86362001)(316002)(54906003)(305945005)(66066001)(6116002)(7736002)(64756008)(66476007)(36756003)(81166006)(81156014)(8936002)(8676002)(6916009)(3846002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2718;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9j93ZBzmW5cu6q05Cf0EIPjNgqBWp2WkmQ3jAvAnu/im0oIfEvz5z7J9lB0JPnb/n32k5KD/PDUiPfXFZ5oElFvHY/buIS8HxwAnqROAhhh53CWLZVh9vybPJP164GGO8r7b6VuEq8Q8wFNZjUQpdx+XIg67L+PC0pk23Vew5K+NQy7xZbHjsDfa6lCs0BuzG+zGvd6YvONf9TFLkjfQG4ieo9kherN6aJ0+lZc0EvY0u4WEnKzRuyJBM2YtDU5DRdy7d+wAWPeW4yal870OGSnjdccUelwVCUxF3Tsr3ceD4KGETWtvzsww/W84GPhkSp+SxW1tYeyHwaMuD1zZ3Ig5QjTDIHhklZlEYn9D/vtLq60aey4ucn2dDmK8Hyh7bvH9RXBTkzcodqHRbMxWWRFB38nKVRR5o/9bzFbGI1I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A5B14CB8BEC7248938900C27E5610FB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87665c35-2f2f-48ef-244f-08d745dbb7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 19:23:47.9820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NhnoDlJyXls+cO+CWZ8mt34+dAQe+WKR9g2Cg+sq9RoilHNJCeQb7YvMdyR09zlypX6RAQHFbo5VwEzsXyRGudV1OLRXqrwidKfzOJoMo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2718
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
Cc: Aditya Ramesh <aramesh@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 30, 2019, at 6:59 PM, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
>=20
> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>=20
>>=20
>>> On Sep 30, 2019, at 6:11 PM, Dr. David Alan Gilbert <dgilbert@redhat.co=
m> wrote:
>>>=20
>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>=20
>>>>=20
>>>>> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
>>>>>=20
>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>> Hi David,
>>>>>>=20
>>>>>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redha=
t.com> wrote:
>>>>>>>=20
>>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>>>> Heyall,
>>>>>>>>=20
>>>>>>>> We have a use case where a host should self-fence (and all VMs sho=
uld
>>>>>>>> die) if it doesn't hear back from a heartbeat within a certain tim=
e
>>>>>>>> period. Lots of ideas were floated around where libvirt could take
>>>>>>>> care of killing VMs or a separate service could do it. The concern
>>>>>>>> with those is that various failures could lead to _those_ services
>>>>>>>> being unavailable and the fencing wouldn't be enforced as it shoul=
d.
>>>>>>>>=20
>>>>>>>> Ultimately, it feels like Qemu should be responsible for this
>>>>>>>> heartbeat and exit (or execute a custom callback) on timeout.
>>>>>>>=20
>>>>>>> It doesn't feel doing it inside qemu would be any safer;  something
>>>>>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
>>>>>>=20
>>>>>> The argument above is that we would have to rely on this external
>>>>>> service being functional. Consider the case where the host is
>>>>>> dysfunctional, with this service perhaps crashed and a corrupt
>>>>>> filesystem preventing it from restarting. The VMs would never die.
>>>>>=20
>>>>> Yeh that could fail.
>>>>>=20
>>>>>> It feels like a Qemu timer-driven heartbeat check and calls abort() =
/
>>>>>> exit() would be more reliable. Thoughts?
>>>>>=20
>>>>> OK, yes; perhaps using a timer_create and telling it to send a fatal
>>>>> signal is pretty solid; it would take the kernel to do that once it's
>>>>> set.
>>>>=20
>>>> I'm confused about why the kernel needs to be involved. If this is a
>>>> timer off the Qemu main loop, it can just check on the heartbeat
>>>> condition (which should be customisable) and call abort() if that's
>>>> not satisfied. If you agree on that I'd like to talk about how that
>>>> check could be made customisable.
>>>=20
>>> There are times when the main loop can get blocked even though the CPU
>>> threads can be running and can in some configurations perform IO
>>> even without the main loop (I think!).
>>=20
>> Ah, that's a very good point. Indeed, you can perform IO in those
>> cases specially when using vhost devices.
>>=20
>>> By setting a timer in the kernel that sends a signal to qemu, the kerne=
l
>>> will send that signal however broken qemu is.
>>=20
>> Got you now. That's probably better. Do you reckon a signal is
>> preferable over SIGEV_THREAD?
>=20
> Not sure; probably the safest is getting the kernel to SIGKILL it - but
> that's a complete nightmare to debug - your process just goes *pop*
> with no apparent reason why.
> I've not used SIGEV_THREAD - it looks promising though.

I'm worried that SIGEV_THREAD could be a bit heavyweight (if it fires
up a new thread each time). On the other hand, as you said, SIGKILL
makes it harder to debug.

Also, asking the kernel to defer the SIGKILL (ie. updating the timer)
needs to come from Qemu itself (eg. a timer in the main loop,
something we already ruled unsuitable, or a qmp command which
constitutes an external dependency that we also ruled undesirable).

What if, when self-fencing is enabled, Qemu kicks off a new thread
from the start which does nothing but periodically wake up, verify the
heartbeat condition and log()+abort() if required? (Then we wouldn't
need the kernel timer.)

>=20
>> I'm still wondering how to make this customisable so that different
>> types of heartbeat could be implemented (preferably without creating
>> external dependencies per discussion above). Thoughts welcome.
>=20
> Yes, you need something to enable it, and some safe way to retrigger
> the timer.  A qmp command marked as 'oob' might be the right way -
> another qm command can't block it.

This qmp approach is slightly different than the external dependency
that itself kills Qemu; if it doesn't run, then Qemu dies because the
kernel timer is not updated. But this is also a heavyweight approach.
We are talking about a service that needs to frequently connect to all
running VMs on a host to reset the timer.

But it does allow for the customisable heartbeat: the logic behind
what triggers the command is completely flexible.

Thinking about this idea of a separate Qemu thread, one thing that
came to mind is this:

qemu -fence heartbeat=3D/path/to/file,deadline=3D60[,recheck=3D5]

Qemu could fire up a thread that stat()s <file> (every <recheck>
seconds or on a default interval) and log()+abort() the whole process
if the last modification time of the file is older than <deadline>. If
<file> goes away (ie. stat() gives ENOENT), then it either fences
immediately or ignores it, not sure which is more sensible.

Thoughts?

F.

>=20
> Dave
>=20
>=20
>> F.
>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>> IMHO the safer way is to kick the host off the network by reprogrammi=
ng
>>>>> switches; so even if the qemu is actually alive it can't get anywhere=
.
>>>>>=20
>>>>> Dave
>>>>=20
>>>> Naturally some off-host STONITH is preferable, but that's not always
>>>> available. A self-fencing mechanism right at the heart of the emulator
>>>> can do the job without external hardware dependencies.
>>>=20
>>> Dave
>>>=20
>>>> Cheers,
>>>> Felipe
>>>>=20
>>>>>=20
>>>>>=20
>>>>>> Felipe
>>>>>>=20
>>>>>>>=20
>>>>>>>> Does something already exist for this purpose which could be used?
>>>>>>>> Would a generic Qemu-fencing infrastructure be something of intere=
st?
>>>>>>> Dave
>>>>>>>=20
>>>>>>>=20
>>>>>>>> Cheers,
>>>>>>>> F.
>>>>>>>>=20
>>>>>>> --
>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>>=20
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>=20
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


