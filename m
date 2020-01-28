Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44FC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 07:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7912173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 07:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ejXeXJNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwLbo-0006C0-Gd
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 02:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iwLaC-0005Gg-EQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 02:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iwLaB-0007Yl-AO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 02:46:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iwLa2-0007II-Ev; Tue, 28 Jan 2020 02:46:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S7XWTu137188;
 Tue, 28 Jan 2020 07:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2019-08-05;
 bh=X438L84DasH+Sc/PilMQMTWr6Ph3ja4xJ64yUf9v4lI=;
 b=ejXeXJNkQ2tQEXSZCdMyl07NkfvBGkzjlExma6KGeE0jbGyjQp/A2geOmi8NwoPsClGn
 jAMfaK975e3BadFEYbpGgTBnTwfqUtAWf02EbC6SWa3/LukQUAPNiDTx6V654ON+pzgM
 Msk+i/7ZzTrW9ZmlnqmOjBovs4sAyIAjPQxZ8+DMdpsuaugxYG12RzZJ0hRdWMaoomy+
 WsO0WaiO0zzUIRuTghr/WfmXcvVTQZMR9vyuBW7CTonq2UvmixwzQGD4BTDvJ4/aUSJe
 10WJyN5G7dpbFxHfREL53ledYPlO/Ok9txbYfUWhTZCueGDfGkbvvKU9OhlBo1HsuMk3 RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2xrdmqc9jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 07:46:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S7XcJp130901;
 Tue, 28 Jan 2020 07:46:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2xry4w35jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 07:46:29 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00S7kSqu010093;
 Tue, 28 Jan 2020 07:46:28 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jan 2020 23:46:28 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 0f3efdcd;
 Tue, 28 Jan 2020 07:46:26 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
In-Reply-To: <a689f9d9-a4b1-9201-1847-02a5afc255fd@redhat.com>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-2-david.edmondson@oracle.com>
 <a689f9d9-a4b1-9201-1847-02a5afc255fd@redhat.com>
X-HGTTG: gag-halfrunt
From: David Edmondson <david.edmondson@oracle.com>
Date: Tue, 28 Jan 2020 07:46:26 +0000
Message-ID: <cuno8uo9g6l.fsf@gag-halfrunt.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
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

Eric Blake <eblake@redhat.com> writes:

> On 1/24/20 4:34 AM, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>> 
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>> 
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>   qemu-img-cmds.hx |  4 ++--
>>   qemu-img.c       | 25 ++++++++++++++++++++++---
>>   qemu-img.texi    |  4 ++++
>>   3 files changed, 28 insertions(+), 5 deletions(-)
>
> I'm working up a patch series that tries to auto-set this flag without 
> user interaction where possible (for example, if lseek(fd, 0, SEEK_DATA) 
> returns EOF, or if fstat() reports 0 blocks allocated, or if qcow2 sees 
> no L2 tables allocated, or a proposed extension to NBD passes on the 
> same...).  I may rebase my series on top of your patch and tweak things 
> in yours accordingly.
>
> But as it stands, the idea makes sense to me; even if we add ways for 
> some images to efficiently report initial state (and our existing 
> bdrv_has_zero_init() is NOT such a method), there are enough other 
> scenarios where the knob will be the only way to let qemu-img know the 
> intent.

Having qemu-img figure things out on its own is obviously desirable, but
I agree that there are enough cases where this won't be possible and,
given the resulting performance improvement, it will still be useful to
allow the caller to force things.

>> +        case OPTION_TARGET_IS_ZERO:
>> +            /*
>> +             * The user asserting that the target is blank has the
>> +             * same effect as the target driver supporting zero
>> +             * initialisation.
>
> Hmm. A git grep shows that 'initialization' has 200 hits, 
> 'initialisation' has only 29. But I think it's a US vs. UK thing, so I 
> don't care which spelling you use.

Yes, it's British English spelling. It was unconscious - I'll switch if
there is an existing policy.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks.

If the conversion of the documentation to rST is imminent then I'll wait
for that before submitting a followup with corresponding changes applied
to the new docs.

dme.
-- 
I'd come on over but I haven't got a raincoat.

