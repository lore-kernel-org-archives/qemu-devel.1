Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BAF2074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZtiMVGzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BAF2074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsxO-000375-3r
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCswo-0002ci-C0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCswm-0007ev-OJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:38:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCswm-0007aJ-FG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:38:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMMwPO119523;
 Fri, 13 Mar 2020 22:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SfwxFvw71tjHNU8EioorOOPNY0SktXD1xy9CfHcbRxA=;
 b=ZtiMVGzPmc7AVJkjfqA8tod9zqI03G426Z+z4UFB7+4201JKbZucF5winTQ+2QluoaGS
 LaodkpuWRqN/i/rlvyAj96DQlU+2wBvSqstlVo9/XyJVI/mxP1QadsNMNnJ1cDahlrS4
 cJZWY/i6sf75H6nvYgivAZZEJW72MmMQ5oqOLg/+EGYK2p2MuSoLJm5x62WBQ/oizJtw
 3pEBdkoXMJuiV4N8HkTRsDskKfMhKga9+zQ3LAha5ew9TpmuWZTQLAXA5Qy6gZQ5c2iB
 sJA3at0nTkmuK1MBtX4AgjcNdyXyYRFsH4x7K3cCkB9ZXnZfW1cbxvGiNIQIb0VgZX7t Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yrf9g0tt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:38:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DMMBEs082670;
 Fri, 13 Mar 2020 22:38:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yreujp438-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 22:38:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DMcNVH026713;
 Fri, 13 Mar 2020 22:38:23 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 15:38:23 -0700
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
 <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
Date: Sat, 14 Mar 2020 00:38:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=987 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130099
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02DMMwPO119523
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 21:57, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/12/20 5:54 PM, Liran Alon wrote:
>> No functional change. This is mere refactoring.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
>> =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>> =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
>> =C2=A0 include/hw/i386/vmport.h | 16 ++++++++++++++++
>
> What about moving it to hw/i386/vmport.h (no under include/)?
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>
Can you explain the logic that separates between hw/i386/*.h to=20
include/hw/i386/*.h?
If it makes sense, sure I will move it. I just don't know what is the=20
convention here.

-Liran


