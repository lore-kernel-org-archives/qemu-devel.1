Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC53C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF148206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ewz6r7Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF148206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvKg-0000v1-2y
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUvJB-0008T0-EZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUvJ9-0004B9-Qh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:15:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUvJ9-0004AN-2E
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:15:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGERDk004458;
 Wed, 13 Nov 2019 16:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=er8MOkPV/Ynl6hc7d1xXkF9ZBWl9J81+v32s/NC6i74=;
 b=ewz6r7PvkP4bhoSFbj/7ExceXRdevJns0b+vhW6+YDuGe1ZPHb0Gcx0UV7J9jwtGecpE
 nvaqyI5rBwyMsImc9V5yZf8oyhQzjyO1nYe/3DnpMGXjSVEEDuhIVcSLjJyBfNE7Bsnp
 N+btlKzme7GD3LAmq/STXRhyzBpf5zyvDGitn2dLKsDnRfha3lAKnAZufgd98uFUYNwK
 Sv6LojMbQ5RfkjhM4lsH1B3QVDtOCBpEOPZGU0shSkD/fAFwxU8C3Glq1IyxA8Vlrql8
 MCuK6CT60vck57L/sVQHFgPvDxUQRAmi6/dqr9G9mOazZdXDxMm5Tfz8IacF7OjioxAC Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w5mvtwk46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:15:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFxDFL151857;
 Wed, 13 Nov 2019 16:15:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2w7vbd4nf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:15:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADGFhnM002317;
 Wed, 13 Nov 2019 16:15:43 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:15:43 -0800
Subject: Re: [RFC v4 PATCH 33/49] multi-process: perform device reset in the
 remote process
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <7579c5df98f9c09933685209395aa4a0e0ceb857.1571905346.git.jag.raman@oracle.com>
 <20191111161951.GH402228@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <7e278409-5631-e5d9-8e01-bcb56aa359c3@oracle.com>
Date: Wed, 13 Nov 2019 11:15:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191111161951.GH402228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 definitions=main-1911130145
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
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, rth@twiddle.net, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mst@redhat.com, kraxel@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 dgilbert@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/11/2019 11:19 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:09:14AM -0400, Jagannathan Raman wrote:
>> +void proxy_device_reset(DeviceState *dev)
>> +{
>> +    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
>> +    MPQemuMsg msg;
>> +
>> +    memset(&msg, 0, sizeof(MPQemuMsg));
>> +
>> +    msg.bytestream = 0;
>> +    msg.size = sizeof(msg.data1);
>> +    msg.cmd = DEVICE_RESET;
>> +
>> +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
>> +}
> 
> Device reset must wait for the remote process to finish reset, otherwise
> the remote device could still be running after proxy_device_reset()
> returns from sending the message.

Thanks for feedback. We will wait for the reset to complete.

--
Jag

> 
> Stefan
> 

