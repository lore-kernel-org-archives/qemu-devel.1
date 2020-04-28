Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454DC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E4220575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uOaQIMEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E4220575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVSG-0003ay-9S
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jTVRJ-0002Op-K9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jTVRH-0008Rm-HG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jTVRG-0008RN-UX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SItQZY087917;
 Tue, 28 Apr 2020 18:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Np6cJns2fxd64mDpT7hXl77uKHuZ04a3jiK7qrjMnWw=;
 b=uOaQIMEoPKmhOZFAZRnTHU9o8RcXC8cupV5Q+LGt/ZDo1GtUCD3wyqM4zAt/xP6PS5YY
 bS5UqO3TI/QjbIK30jdx+BKBf8GHAH1FpJu3Vs6MlJMvuPOZEgtav4RiEjxMwqiZGiy8
 c+i8SJOXw03CCT+D/17cBOceCquIumsQV4b8rusDf3qlHYjgPKuAOchW4hz3uQyck8Dq
 R+RY4kD68AXInOR1zM+onWfdfPFtNEJfXrZyCIT4QIvbWtS7Us3s82knhO/JqaxhpzwC
 +NFM2k8KPVlSL+BontasCC9CpwFB1dftBnaOYz6Wp7My7O+KyRV3HQowjWajPdayZA6Q JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 30p2p077d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 18:58:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SIuft5157866;
 Tue, 28 Apr 2020 18:58:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 30mxpgqq61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2020 18:58:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SIwOvf030456;
 Tue, 28 Apr 2020 18:58:24 GMT
Received: from dhcp-10-39-193-143.vpn.oracle.com (/10.39.193.143)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Apr 2020 11:58:23 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH RESEND v6 08/36] multi-process: Add stub functions to
 facilitate build of multi-process
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200428162916.GC109767@stefanha-x1.localdomain>
Date: Tue, 28 Apr 2020 14:58:21 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDBFBA4D-9922-4D60-B761-A8199F09CC90@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <647fa5bf70dbea7d2b4e47d2084dea3a66385433.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424131230.GA190507@stefanha-x1.localdomain>
 <A0E83A03-3B01-4863-949A-F5DDC328A387@oracle.com>
 <20200428162916.GC109767@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=4
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=4 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280149
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:23:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 28, 2020, at 12:29 PM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Fri, Apr 24, 2020 at 09:47:56AM -0400, Jag Raman wrote:
>>> On Apr 24, 2020, at 9:12 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>>> On Wed, Apr 22, 2020 at 09:13:43PM -0700, elena.ufimtseva@oracle.com =
wrote:
>>>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>>>> index f884bb6180..f74c7e927b 100644
>>>> --- a/stubs/Makefile.objs
>>>> +++ b/stubs/Makefile.objs
>>>> @@ -20,6 +20,7 @@ stub-obj-y +=3D migr-blocker.o
>>>> stub-obj-y +=3D change-state-handler.o
>>>> stub-obj-y +=3D monitor.o
>>>> stub-obj-y +=3D monitor-core.o
>>>> +stub-obj-y +=3D get-fd.o
>>>> stub-obj-y +=3D notify-event.o
>>>> stub-obj-y +=3D qtest.o
>>>> stub-obj-y +=3D replay.o
>>>=20
>>> audio.c, vl-stub.c, and xen-mapcache.c are added by this patch but =
not
>>> added to Makefile.objs?  Can they be removed?
>>=20
>> Hey Stefan,
>>=20
>> Sorry it=E2=80=99s not clear. but these files are referenced in =
Makefile.target.
>=20
> Why is the Makefile.target change not in this patch?
>=20
> Please structure patch series as logical changes that can be reviewed
> sequentially.  Not only is it hard for reviewers to understand what is
> going on but it probably also breaks bisectability if patches contain
> incomplete changes.

Hi Stefan,

We grouped all the stubs into a separate patch for ease of review. If =
you=E2=80=99re finding
it hard to review this way, we=E2=80=99ll modify to ensure that the =
Makefile changes go along
with the stubs.

--
Jag

>=20
>>>=20
>>> This entire patch requires justification.  Stubs exist so that =
common
>>> code can be linked without optional features.
>>>=20
>>> For example, common code may call into kvm but that callback isn't
>>> relevant when building with kvm accelerator support (e.g. say =
qemu-nbd).
>>> That's where the stub function comes in.  It fulfills the dependency
>>> without dragging in the actual kvm accelerator code.
>>>=20
>>> Adding lots of stubs suggests you are building QEMU in a new way =
that
>>> wasn't done before (this is true and expected for this patch =
series).  I
>>> would like to understand the reason for these stubs though.  For
>>> example, why do you need to stub audio?
>>=20
>> These stub functions are only used by the remote process, and not by
>> QEMU itself.
>>=20
>> Our goal is to ensure that the remote process is building the =
smallest
>> set of files necessary and these stub functions are necessary to meet
>> that goal.
>>=20
>> For example, the remote process needs to build some of the functions
>> defined in =E2=80=9Chw/core/qdev-properties-system.c=E2=80=9D. =
However, this file
>> depends on audio.c (references audio_state_by_name()), which is not
>> needed for the remote process. The alternative to stub functions =
would
>> be to compile audio.c into the remote process, but that was not =
necessary
>> in our judgement. When the project started out, we spent a lot of =
time
>> figuring out which functions/files are necessary for the remote =
process, and
>> we stubbed out the ones which are needed to resolve dependency during
>> compilation, but not needed for functionality.
>>=20
>> audio.c is just an example of tens of other places where we needed to
>> make similar judgements.
>>=20
>> Would you prefer if we moved these stub functions into a separate
>> library (instead of stub-obj-y) which is only linked by the remote =
process?
>=20
> It's too bad that none of these judgements were documented.  As a
> reviewer I have no idea what the justification for each individual =
stub
> was.
>=20
> Some stubs are unavoidable but they also indicate that the code is
> tightly coupled where maybe it can be split up.  The
> qdev-properties-system.c example you mentioned sounds like something
> that should be broken up into multiple files.  Then stubs wouldn't be
> necessary.
>=20
> That said, adding stubs doesn't place a great burden on anyone and I
> think they can be merged.


