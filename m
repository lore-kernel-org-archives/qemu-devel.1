Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F1C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221532468D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fDRRNwpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221532468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcqJ-0006WI-By
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBcpI-0005xs-BV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBcpH-0004FH-3l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:13:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBcpG-0004BN-7g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:13:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABCRQB181729;
 Tue, 10 Mar 2020 11:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TnMoi9mBqiIDFwqDBxCZr2bIk8ju6Vw9swk+kTioevQ=;
 b=fDRRNwpr8lYUyawJr5znTETE4TTkHvtrI4XrJLrsD2DjE8aWCqVjU2bgQoHN6xNdoDQB
 X461cXnAXtJnEOx40eMB+SqwHhZJrKrF2kljaZXV8ejZwXhkWdlGosZkWTT0Y3ygvSOd
 o39Quw3vIlmXniNU5Eyxw6B5C+oHlJoH0XdkJ636zZjApB+w9QWyMzO4A3gk/GsSXkcy
 dxa5Byn2YHpnuQrWQXYGDbWcZiJ4TkjvJfN8rDrD5gwB3jyfddfXan0OHOQPSTwv6hvv
 FUuyACACsnbxSqIQHgFL5TxcXiNyys2VHL7HigVdzTnluyolqx55kA2cSFWyyvJmVBKq bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ym3jqmwd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:13:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABC5nf046662;
 Tue, 10 Mar 2020 11:13:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8pr0vta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:13:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ABDO4T010849;
 Tue, 10 Mar 2020 11:13:24 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 04:13:24 -0700
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310053305-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
Date: Tue, 10 Mar 2020 13:13:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310053305-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 11:34, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
>> This is VMware documented functionallity that some guests rely on.
>> Returns the BIOS UUID of the current virtual machine.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> So this at least seems guest-visible.
>
> So I suspect you need to add properties to
> disable this for old machine types, to avoid
> breaking compatibility with live-migration.

It is indeed guest visible.
In theory, you are right that for every guest-visible change, we should 
make sure to expose it to only new machine-types.

However, in this case, I feel it just unnecessary over-complicates the code.
I don't see how a guest which previously failed to use this command, 
will fail because after Live-Migration it could succeed.

If you insist, I will add such functionality. In that case, do you think 
a single flag will suffice for the addition of all new commands
(i.e. "commands-version" that it's number specifies set of commands to 
expose), or you want to have a per-command flag?

-Liran


