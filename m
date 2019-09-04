Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A161CC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFB521881
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WIOsIEe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFB521881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5YC2-00075o-JO
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5YAk-0006TG-NO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5YAi-0000IV-Rf
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:30:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5YAi-0000GM-K4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:30:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84GTNmP094999;
 Wed, 4 Sep 2019 16:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=u0tlfT+ts86C9zZeJ3wauBmhS9hH7sc599MPoUAR9rk=;
 b=WIOsIEe1XeaeebizToUJEuv/2GhIILdnIot/sDxTcaXGaJXjEzszc8paOXgBHKVcc6Mn
 sdWyiGT718erK0MfuOWDzotFukHfoYT66eeSpggfzslSpJeUvPrNcTgSZz6nO6v9gnQi
 Sts4fEJSHh9rVikRO4WXCesAUPcdScs39FWTKrqWhQ4lW0R3U9P1Hpq1DR2gckL6hZVB
 dTneecQvg4mTOfCkpCQHjgPSziXiIxjpLOzRlMijQlUcZwAN6iJ8wxOFi7XKtl7RGaK2
 t6q4H0n3dFJJLvCMlAR8JfBbQutY+RoQ6+ZIKFlUpcVb1m7YcsVzceJN8hDYMsyE6rTP lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2utgt9r0js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 16:30:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84GSb09157855;
 Wed, 4 Sep 2019 16:30:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2usu5220mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 16:30:02 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x84GTxbg018970;
 Wed, 4 Sep 2019 16:30:00 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Sep 2019 09:29:59 -0700
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <20190904091817.GE19582@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <a891c113-d3c2-3e59-b54c-89f1dfa6c201@oracle.com>
Date: Wed, 4 Sep 2019 12:29:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190904091817.GE19582@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040163
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x84GTNmP094999
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC v3 PATCH 00/45] Initial support of
 multi-process qemu
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/2019 5:18 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 03, 2019 at 04:37:26PM -0400, Jagannathan Raman wrote:
>> Started with the presentation in October 2017 made by Marc-Andre (Red =
Hat)
>> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum =
2018,
>> the multi-process project is now a prototype and presented in this pat=
chset.
>>
>> This first series enables the emulation of lsi53c895a in a separate pr=
ocess.
>>
>> We posted the Proof Of Concept patches [2] before the BoF session in 2=
018.
>> Subsequently, we posted RFC v1 [3] & RFC v2 [4] of this series.
>>
>> Thanks to the v1 & v2 review, we were able to incorporate the feedback=
 into
>> our goals.
>>
>> In the summer of 2019, we participated in a conference with folks at R=
edHat,
>> who provided us with feedback to improve the design of this project.
>>
>> We want to present version 3 of this series which incorporates the fee=
dback
>> we received for v2 & the enhancements suggested in the conference. Fol=
lowing
>> are the improvements made in this series:
>=20
> This patch series fails to apply to git master when I attempt and confi=
rmed
> by patchew's failed attempt too
>=20
>    https://patchew.org/QEMU/cover.1567534653.git.jag.raman@oracle.com/
>=20
> Can you do one of the following
>=20
>   - Tell us what git hash it was based on instead of master

Hi Daniel,

These patches are based on the latest release, v4.1.0. They are on top
of the following git hash:
9e06029aea3 Update version for v4.1.0 release

> or
>   - provide a pointer to a publically accessible git repo with it appli=
ed

They are also publicly available from the following gitub repo.:
https://github.com/oracle/qemu.git  [branch multi-process-qemu-v0.3]

Thanks!
--
Jag

> or
>   - Repost with based on current git master
>=20
> Regards,
> Daniel
>=20

