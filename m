Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52185C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F65920828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VjUqA331"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F65920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tSS-0003Nb-8z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5tQt-000211-Uh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5tQs-0003SQ-BB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:12:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5tQs-0003Rq-2Y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:12:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FBGNf087130;
 Thu, 5 Sep 2019 15:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=S88RVXkmQh7twM2v2yKPnBQvxhLHE7oU3lVqOEsk+OQ=;
 b=VjUqA331+qbeFqV32FwqAq8bG3WIEC9SmDgZEGCnTSWEmIWPPYY7hGLSUgOwUjZpKuzv
 r1BkMQ4MEZo60n4XEF3Hjf/OjEfoNerHlXTAYNWMUvvjRVeAqiMg8N8JIOGg4TcrRnVX
 XpSsbiYKX/wZauW7PakbenrRz+5LZMn/padZsROVN4SOiG0aW5T50A0XcDTNQe3uQCU9
 ImwCbZ3fhmcy0Y/YofhfWNafqWxPJ9DAr8gyARp0y72tq92WgOEwmrJcJ4IZzzgep6aM
 P9iMWkpMMMxplZMXpJYkh0fWzi1cfmwty6C/jV2yd4q8efXkPP78TOI1DGNWRkjLTovh 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2uu4rgr105-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:12:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85ElfSA070157;
 Thu, 5 Sep 2019 15:10:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2uthq1ub9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:10:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85FA9ES016072;
 Thu, 5 Sep 2019 15:10:09 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:10:08 -0700
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <32b6764ce960a792b6f523d615ff160ef7d3d12e.1567534653.git.jag.raman@oracle.com>
 <20190904091118.GD19582@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <b41f4073-6164-93dc-c154-3f84ff3852e4@oracle.com>
Date: Thu, 5 Sep 2019 11:10:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190904091118.GD19582@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 x85FBGNf087130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [RFC v3 PATCH 02/45] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
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



On 9/4/2019 5:11 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 03, 2019 at 04:37:28PM -0400, Jagannathan Raman wrote:
>> qemu_thread_cancel() added to destroy a given running thread.
>> This will be needed in the following patches.
>=20
> I don't see anything in the following patches that actually uses
> this new function.
>=20
> That is good though, because it is incredibly difficult to
> correctly use pthread_cancel() in such a way that you correctly
> release all memory and other resources (file descriptors) owned
> by the thread being cancelled.
>=20
> So this looks like it can thankfully be dropped.

Thanks Daniel. Will drop this in the next revision.
--
Jag

>=20
>>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>>   include/qemu/thread.h    |  1 +
>>   util/qemu-thread-posix.c | 10 ++++++++++
>>   2 files changed, 11 insertions(+)
>=20
> Regards,
> Daniel
>=20

