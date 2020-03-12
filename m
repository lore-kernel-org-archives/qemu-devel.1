Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF0C0044D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4E20739
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GQ0F//gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4E20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCCiH-0001Ii-Ba
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 21:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCChd-0000sz-Os
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCChc-0007iR-B2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:32:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCChc-0007bY-08
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:32:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C1Vvis074987;
 Thu, 12 Mar 2020 01:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fCh2SA6FaQ3jpBDSh01p5tzzAvQBcm99kEKQ8uX8zIQ=;
 b=GQ0F//gbRghk40BhrP8c79XGmWbO0nNEBxGvsI4hFgTEanldyWYGIble+6L0olzJzapz
 6UW4Di0F3o/VIoo1ti9ZGbGWK6rS/saSHpiJp/NoD4MIjrFZuKkdFpz9rk2KX+JkrPcL
 hvbg7QYFyV0aYqzcJ4OCFBxsJZpTHvkmbjn0MPB7aAqVOEAcbkPWa1gYw5UuWvhj8b5P
 h1tONdtW0xRziSM5pZ2FUshYm4z1MAelCeacSTEuAbJtgIfoU1WwwXwh4QccTDIrNQPa
 3OTCdOoo5NxOgHUadV5SE7lsrZTzwQZ7XC8n7ysj1HsEr/WbRGoM0wVXOF5ziKVTDR6X xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v69yfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 01:31:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C1RkA6072986;
 Thu, 12 Mar 2020 01:31:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8p5cusu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 01:31:57 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02C1VtdM011252;
 Thu, 12 Mar 2020 01:31:55 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 11 Mar 2020 18:31:55 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <158395315920.8804.12475968769225149761@39012742ff91>
 <ebb59967-ebd3-374a-a2a6-1f374e4768ad@oracle.com>
 <20200311162321-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <f746828c-0a15-2613-a6bf-300750be1be5@oracle.com>
Date: Thu, 12 Mar 2020 03:31:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311162321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120003
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 elad.gabay@oracle.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/03/2020 22:24, Michael S. Tsirkin wrote:
> Notice the process as documented in ./tests/qtest/bios-tables-test.c
>
Thanks for explicitly pointing me to that process.

I have followed the process described there (Both steps 1-3 and steps 4-7).

On step (6), I have noted that many existing ACPI tables don't have 
expected binaries for all the execution-matrix.
E.g. tests/data/acpi/pc/APIC.{bridge, ipmikcs, memhp, numamem} are all 
missing.
Similar missing files exists for FACP, FACS, HPET and MCFG.

I should add for WAET the expected binaries for all the execution-matrix 
right?
Is it just an existing issue that for the existing tables some of the 
expected binaries are missing? But the tests seems to pass.
Can you clarify this for me?

Thanks,
-Liran



