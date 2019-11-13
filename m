Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B700EC33CA4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8A72388D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQSd/t8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8A72388D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUv9m-0004nP-P4
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUv8o-0004Ep-NC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUv8n-0000Ec-6Z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:05:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUv8m-0000ES-UC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:05:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFxHhO184540;
 Wed, 13 Nov 2019 16:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6JcNT36og4QgKqc4dAnHnCmnzctDyvNZpyy1UsLdnDA=;
 b=dQSd/t8VJn6PFzcLtC/+crRNdieNkVa9qufNAsvGxPLV0eViJfzrGJHo5rICH8QY3kBK
 rt/grjuDEc90kWTU+R7WTO8ywIfb8k+MyNMe7aPcc05Q7R65JFtE4OSZgiLYUsMthAG5
 DNIvLGxnmjYy5T2R4WTuzNYVK/OngViqBYW+K9IcisSCnAoSte0pYh1hjbtGoMX73ked
 ztI9UQCMYd1RdYh1H2EAFPJTxOivpBtrvLY+QwSaGuimGrTI4WCgWxrB8rNf5TAqxOlq
 rS5mUTwPVjOYiWZbBWq6AuKY/21txlIvogoO5Ct5j2nv18UEAtIH0WRjTDmHbY2Cwt/W WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2w5mvtwgdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:05:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFwv49059290;
 Wed, 13 Nov 2019 16:05:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2w8g17r108-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:05:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADG4xUb022092;
 Wed, 13 Nov 2019 16:04:59 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:04:59 -0800
Subject: Re: [RFC v4 PATCH 02/49] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <e821aa9bccb49bf68c94e3d49b105c420dde9981.1571905346.git.jag.raman@oracle.com>
 <20191113153006.GA563983@stefanha-x1.localdomain>
 <fd30b4ee-1f92-82a8-42a6-871b0a9e23b1@oracle.com>
 <20191113155125.GI2445240@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <89ec048f-6db1-a52d-49de-c758f8408eb0@oracle.com>
Date: Wed, 13 Nov 2019 11:04:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113155125.GI2445240@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 xADFxHhO184540
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 ross.lagerwall@citrix.com, ehabkost@redhat.com, john.g.johnson@oracle.com,
 mst@redhat.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org,
 armbru@redhat.com, quintela@redhat.com, liran.alon@oracle.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 kwolf@redhat.com, marcandre.lureau@gmail.com, mreitz@redhat.com,
 kanth.ghatraju@oracle.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 10:51 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 13, 2019 at 10:38:06AM -0500, Jag Raman wrote:
>>
>>
>> On 11/13/2019 10:30 AM, Stefan Hajnoczi wrote:
>>> On Thu, Oct 24, 2019 at 05:08:43AM -0400, Jagannathan Raman wrote:
>>>> qemu_thread_cancel() added to destroy a given running thread.
>>>> This will be needed in the following patches.
>>>>
>>>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>> ---
>>>>    include/qemu/thread.h    |  1 +
>>>>    util/qemu-thread-posix.c | 10 ++++++++++
>>>>    2 files changed, 11 insertions(+)
>>>
>>> Is this still needed?  I thought previous discussion concluded that
>>> thread cancellation is hard to get right and it's not actually used b=
y
>>> this series?
>>
>> Hi Stefan,
>>
>> This is used in PATCH 41/49.
>=20
> I don't believe the cancellation usage in that patch is safe :-)

Thanks for the feedback, we will address that.

May I please ask why it is not safe? Any clarification will help us to
find a better alternative.

Thank you very much!
--
Jag

>=20
> Regards,
> Daniel
>=20

