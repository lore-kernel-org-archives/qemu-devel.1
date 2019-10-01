Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A5C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EC82190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="l14pRJ3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EC82190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEuJ-00085C-GE
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iFEtO-0007Qz-Gv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iFEtM-0002yV-71
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:56:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:30604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iFEtL-0002y0-U7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:56:24 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x919tK6R026465; Tue, 1 Oct 2019 02:56:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=EBdlYl89dwl97eg0XoZuFq3p5wF+fQEBrvqA5oZ5l5U=;
 b=l14pRJ3hsZZZxPd8GjZ6fyftcuB6UE3xp3uDD4RVxv6ccHi3y3wLH1ehDaEYHBJxYb41
 WvrWOG0nExwnwQ9paVMMcHSat3sQ3fXEdXZlRfOqG5qCSEFQEYG9Gd/zPmAK0eTs5uGr
 2j8+g7tucI3l2qy7ZmvOTYyNCV49lSQBfYiIDRU0IUvMT66AGnAPiRSi1b2Djg+WutUm
 at5gT3fTgXmG8SaPBUjricwcvdn8Rj578L8tGoofDNgfvN0bh0LkzwvDFodJgJfmYJ1m
 ahKMEBFwP/Ku1MjTpFH7U+VvoQ36MAVHmFhVpaSqHqWzAmQ6smpfCQOFx2Z2bpZv5kt4 ug== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va3utwuvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 02:56:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6CEZRTtbeX48hpS/d3MBHS5tJcO/49f916x7HYr44AOKE0W9hlPiFYdYxsX8iMmBYEsBBkI+7/CRSs3teBtpnym1or60U/Nqm36XIXUp6LkG9iCiTyd5zk6FfX1AEKAX0Nuh0BvakzL2opEtuu02euKesQsx9+FBQXkLoD5/WRSJKeeJ0t8+7/9mt1uRfxperOT8OlJhvhaLsgFDSaBIK9mdySOGzHJ4Jbch7xhjnas79iYBqFTuy6ZL6Cc/u+XY6w9C9Fx95N7BTEKN0dFypYu1QCVB43AIDONs/ebaFospromdIf0LQWzCyhj8lw8VbvZw/icyAj+9lbZUzOA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBdlYl89dwl97eg0XoZuFq3p5wF+fQEBrvqA5oZ5l5U=;
 b=Fv1s7M9VtaAIhdXnkEJFKfssNl4p/lMGG9Nn0n/lr7dP4dXT1RzPj1xxVwUOPxPfOkrESyKPLUce0BeS0exgwzCKYwha+wLGusdyizjtcLwduztP+GKOGs9xygbbIbzL8LQ92C5QTwtepmjrxgWT/qfh7zqrsEiYwfQDA/SP90dp2WSN3/pzPH7OGtG+p6Iyv5I8+WSm1wLCSc++4H9yeRVm0+EJwAmxlPEzWpKekT9SwNsiMVVquAa/hOgK3WHNxh7lAXO5oFm5amITPqp2PuMlXHzDn205jNTBCemjx1zezt/m0zG1MTbiqvQkUZ5LfoKHCyRxiUmohSu3nXyf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2237.namprd02.prod.outlook.com (10.168.244.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 09:56:17 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 09:56:17 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wAgAADW4CAAAYcgIAAB1MAgAAXoICAANnrgIAAGdoA
Date: Tue, 1 Oct 2019 09:56:17 +0000
Message-ID: <2248E813-102F-4E60-AF9B-A5A2F21C1687@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
 <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
 <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
 <20191001082345.GA2781@work-vm>
In-Reply-To: <20191001082345.GA2781@work-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9a1ab93-412f-4858-89c0-08d746559a93
x-ms-traffictypediagnostic: MWHPR02MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2237A73A501FFBE7BAC5C561D79D0@MWHPR02MB2237.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(71200400001)(76176011)(36756003)(26005)(53546011)(25786009)(6916009)(2906002)(6506007)(5660300002)(14454004)(186003)(256004)(14444005)(71190400001)(91956017)(54906003)(66556008)(66446008)(64756008)(76116006)(476003)(86362001)(6436002)(4326008)(6246003)(66476007)(66946007)(486006)(33656002)(2616005)(6512007)(305945005)(316002)(6486002)(8936002)(8676002)(81166006)(81156014)(3846002)(102836004)(7736002)(478600001)(66066001)(446003)(6116002)(99286004)(11346002)(229853002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2237;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pB7ptqDmZHU62WaiLWBTgoLbDw3W133EPhVuh5V2HYmmenwhccL0tfwebMJx5qATDcAyztWdcCPXVsaCIOx0troa9LjG9rTZSrKKGVKAi4NiqDaECITBqzcEckIzhk13vSPCFPWObAZmsF2krvqXtL2YqxtZhf4kYJqi3LMQhtdfBUdC5O3Rv8JVNhvsEFAwSh/ErN+YCzZciUP9cCoDU0gFhBQWw3KnPj66HKiw1edtOKKPv4zC0iWtTBy+CyQPI0U3WLLtiydLdfOmd/HO0p5JFdhhOtR84h9LE3KSa1GQCM19rXStoin6KdX2cHHPh/IcQBtVkKZRCu/R7rDi59mxFP/RRwtE2fpojuryV7xxZdt44hKSSWy1z+99UGJI56hcOoTJMVDdzHS8qNHELnxcSdLKDvpgeZ5m3G0ocIA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AECE58E907503241B0F1B793E0CB3946@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a1ab93-412f-4858-89c0-08d746559a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:56:17.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDc62HoBQ70D+6bKKWA77Br6O7pWYjV4E9AoXEHQwYDPYZs5mBkGae8N271rO7X1HNnM4If6nO0k9bEJkflOsb2/yebwLsIf9izSp4TxywE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_05:2019-10-01,2019-10-01 signatures=0
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 Aditya Ramesh <aramesh@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Oct 1, 2019, at 9:23 AM, Dr. David Alan Gilbert <dgilbert@redhat.com> =
wrote:
>=20
> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>=20
>>=20
>>> On Sep 30, 2019, at 6:59 PM, Dr. David Alan Gilbert <dgilbert@redhat.co=
m> wrote:
>>>=20
>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>=20
>>>>=20
>>>>> On Sep 30, 2019, at 6:11 PM, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
>>>>>=20
>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Sep 30, 2019, at 5:03 PM, Dr. David Alan Gilbert <dgilbert@redha=
t.com> wrote:
>>>>>>>=20
>>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>>>> Hi David,
>>>>>>>>=20
>>>>>>>>> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@red=
hat.com> wrote:
>>>>>>>>>=20
>>>>>>>>> * Felipe Franciosi (felipe@nutanix.com) wrote:
>>>>>>>>>> Heyall,
>>>>>>>>>>=20
>>>>>>>>>> We have a use case where a host should self-fence (and all VMs s=
hould
>>>>>>>>>> die) if it doesn't hear back from a heartbeat within a certain t=
ime
>>>>>>>>>> period. Lots of ideas were floated around where libvirt could ta=
ke
>>>>>>>>>> care of killing VMs or a separate service could do it. The conce=
rn
>>>>>>>>>> with those is that various failures could lead to _those_ servic=
es
>>>>>>>>>> being unavailable and the fencing wouldn't be enforced as it sho=
uld.
>>>>>>>>>>=20
>>>>>>>>>> Ultimately, it feels like Qemu should be responsible for this
>>>>>>>>>> heartbeat and exit (or execute a custom callback) on timeout.
>>>>>>>>>=20
>>>>>>>>> It doesn't feel doing it inside qemu would be any safer;  somethi=
ng
>>>>>>>>> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.
>>>>>>>>=20
>>>>>>>> The argument above is that we would have to rely on this external
>>>>>>>> service being functional. Consider the case where the host is
>>>>>>>> dysfunctional, with this service perhaps crashed and a corrupt
>>>>>>>> filesystem preventing it from restarting. The VMs would never die.
>>>>>>>=20
>>>>>>> Yeh that could fail.
>>>>>>>=20
>>>>>>>> It feels like a Qemu timer-driven heartbeat check and calls abort(=
) /
>>>>>>>> exit() would be more reliable. Thoughts?
>>>>>>>=20
>>>>>>> OK, yes; perhaps using a timer_create and telling it to send a fata=
l
>>>>>>> signal is pretty solid; it would take the kernel to do that once it=
's
>>>>>>> set.
>>>>>>=20
>>>>>> I'm confused about why the kernel needs to be involved. If this is a
>>>>>> timer off the Qemu main loop, it can just check on the heartbeat
>>>>>> condition (which should be customisable) and call abort() if that's
>>>>>> not satisfied. If you agree on that I'd like to talk about how that
>>>>>> check could be made customisable.
>>>>>=20
>>>>> There are times when the main loop can get blocked even though the CP=
U
>>>>> threads can be running and can in some configurations perform IO
>>>>> even without the main loop (I think!).
>>>>=20
>>>> Ah, that's a very good point. Indeed, you can perform IO in those
>>>> cases specially when using vhost devices.
>>>>=20
>>>>> By setting a timer in the kernel that sends a signal to qemu, the ker=
nel
>>>>> will send that signal however broken qemu is.
>>>>=20
>>>> Got you now. That's probably better. Do you reckon a signal is
>>>> preferable over SIGEV_THREAD?
>>>=20
>>> Not sure; probably the safest is getting the kernel to SIGKILL it - but
>>> that's a complete nightmare to debug - your process just goes *pop*
>>> with no apparent reason why.
>>> I've not used SIGEV_THREAD - it looks promising though.
>>=20
>> I'm worried that SIGEV_THREAD could be a bit heavyweight (if it fires
>> up a new thread each time). On the other hand, as you said, SIGKILL
>> makes it harder to debug.
>>=20
>> Also, asking the kernel to defer the SIGKILL (ie. updating the timer)
>> needs to come from Qemu itself (eg. a timer in the main loop,
>> something we already ruled unsuitable, or a qmp command which
>> constitutes an external dependency that we also ruled undesirable).
>=20
> OK, there's two reasons I think this isn't that bad/is good:
>   a) It's an external dependency - but if it fails the result is the
>      system fails, rather than the system keeps on running; so I think
>      that's the balance you were after; it's the opposite from
>      the external watchdog.

Right. I like where you are coming from. And I think a mix of these
may be the best way forwards. I'll elaborate on it below.

>=20
>   b) You need some external system anyway to tell QEMU when it's
>      OK - what's your definitino of a failed system?

The feature is targeted at providing a self-fencing mechanism for
Qemu. If a host is unreachable for whatever reason (eg. sshd down, ovs
died, oomkiller took services out, physical network failure), it
should guarantee that VMs won't be running after a certain amount of
time. To your point, if this external software doesn't come in and
touch the file, that's because it can't reach the host or it wants the
host to self-fence. The qualifying Qemus should therefore be
considered dead after a "deadline" period (since the last time the
control file was touched).

>=20
>> What if, when self-fencing is enabled, Qemu kicks off a new thread
>> from the start which does nothing but periodically wake up, verify the
>> heartbeat condition and log()+abort() if required? (Then we wouldn't
>> need the kernel timer.)
>=20
> I'd make that thread bump the kernel timer along.

I think combining the thread's logic with the kernel timer makes the
whole thing a lot more solid. See below.

>=20
>>>=20
>>>> I'm still wondering how to make this customisable so that different
>>>> types of heartbeat could be implemented (preferably without creating
>>>> external dependencies per discussion above). Thoughts welcome.
>>>=20
>>> Yes, you need something to enable it, and some safe way to retrigger
>>> the timer.  A qmp command marked as 'oob' might be the right way -
>>> another qm command can't block it.
>>=20
>> This qmp approach is slightly different than the external dependency
>> that itself kills Qemu; if it doesn't run, then Qemu dies because the
>> kernel timer is not updated. But this is also a heavyweight approach.
>> We are talking about a service that needs to frequently connect to all
>> running VMs on a host to reset the timer.
>>=20
>> But it does allow for the customisable heartbeat: the logic behind
>> what triggers the command is completely flexible.
>>=20
>> Thinking about this idea of a separate Qemu thread, one thing that
>> came to mind is this:
>>=20
>> qemu -fence heartbeat=3D/path/to/file,deadline=3D60[,recheck=3D5]
>>=20
>> Qemu could fire up a thread that stat()s <file> (every <recheck>
>> seconds or on a default interval) and log()+abort() the whole process
>> if the last modification time of the file is older than <deadline>. If
>> <file> goes away (ie. stat() gives ENOENT), then it either fences
>> immediately or ignores it, not sure which is more sensible.
>>=20
>> Thoughts?
>=20
> As above; I'm OK with using a file with that; but I'd make that thread
> bump the kernel timer along; if that thread gets stuck somehow the
> kernel still nukes your process.


Awesome. So check this out:

qemu -fence heartbeat=3D/path/to/file,deadline=3D60[,recheck=3D5][,harddead=
line=3D61]

We can default <harddeadline> to <deadline+1> and enforce that:
-  <deadline> is a multiple of <recheck>.
- <harddeadline> is bigger than <deadline>

When <deadline> expires, we can log() + abort(), but if <harddeadline>
expires, we can rest assured the kernel will come around and SIGKILL
Qemu. If there's demand for it, this can later be enhanced by adding
more parameters which set the fence thread scheduling priority, &c.

If that sounds ok I'll send an RFC as soon as I get a chance and we
can take it from there.

F.

>=20
> Dave
>=20
>> F.
>>=20
>>>=20
>>> Dave
>>>=20
>>>=20
>>>> F.
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> IMHO the safer way is to kick the host off the network by reprogram=
ming
>>>>>>> switches; so even if the qemu is actually alive it can't get anywhe=
re.
>>>>>>>=20
>>>>>>> Dave
>>>>>>=20
>>>>>> Naturally some off-host STONITH is preferable, but that's not always
>>>>>> available. A self-fencing mechanism right at the heart of the emulat=
or
>>>>>> can do the job without external hardware dependencies.
>>>>>=20
>>>>> Dave
>>>>>=20
>>>>>> Cheers,
>>>>>> Felipe
>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>> Felipe
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> Does something already exist for this purpose which could be use=
d?
>>>>>>>>>> Would a generic Qemu-fencing infrastructure be something of inte=
rest?
>>>>>>>>> Dave
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> Cheers,
>>>>>>>>>> F.
>>>>>>>>>>=20
>>>>>>>>> --
>>>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
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


