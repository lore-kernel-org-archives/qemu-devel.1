Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA2C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8AA20645
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loNNSPg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8AA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajlc-0002t0-Ru
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jag.raman@oracle.com>) id 1hajBS-0001qA-9A
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1hajBP-00007D-RF
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:59:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1hajBO-00005a-OC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:59:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFs8m5163239;
 Tue, 11 Jun 2019 15:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YoogmoUyaoB/UsJ0FEvsHUW2wCpbM4vtCoDMagyVq94=;
 b=loNNSPg7ZevxsvmlV2Ej0OwJxr8rH25Egz2i+bmiTuHUIqm47seJrqfRKgKRnGJl4AUi
 Q7RZMGn8nmjIsjPbS6wMN1g3tkQLKRddkNgBccqckrFLp53m6y1fMNjGchYqT8J7xgVH
 15RDuB+qkzZQH9iUx77QRkaVU6zVtxnr0rdtDWOBm1vPHIKiAIrj4vcMp6CxLXBztqAL
 YEg1d8qRdQNvg8IAmEQ35fCWQmKX8HRB5c+wwb1ZPW+map8C8X0k8UJxk2Q/N3UTLlFg
 9GfYcr0VxfKikgBl07CpmNhIy+7vdqctCbH+9UcWSv2vNBDj4mCNTUr6CwRfv5HeqlWV jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 2t02hepanu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 15:59:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFw9mq179125;
 Tue, 11 Jun 2019 15:59:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2t0p9rcg2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 15:59:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BFxPdb010460;
 Tue, 11 Jun 2019 15:59:25 GMT
Received: from [10.11.108.55] (/10.11.108.55)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Jun 2019 08:59:24 -0700
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, quintela@redhat.com
References: <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
 <20190308095036.GC12318@stefanha-x1.localdomain>
 <20190326080822.GC21018@stefanha-x1.localdomain>
 <e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
 <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
 <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
 <20190425154421.GG17806@stefanha-x1.localdomain>
 <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
 <20190523111130.GF26632@stefanha-x1.localdomain>
 <20190528151820.GA4545@heatpipe>
 <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <371e9f92-0441-9a11-c568-6536c2c2b467@oracle.com>
Date: Tue, 11 Jun 2019 11:59:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
 konrad.wilk@oracle.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 ross.lagerwall@citrix.com, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kanth.ghatraju@oracle.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/30/2019 4:54 PM, Elena Ufimtseva wrote:
> On Tue, May 28, 2019 at 08:18:20AM -0700, Elena Ufimtseva wrote:
>> On Thu, May 23, 2019 at 12:11:30PM +0100, Stefan Hajnoczi wrote:
>>> Hi Jag and Elena,
>>> Do you think a call would help to move discussion along more quickly?
>>>
>>
>> Hi Stefan,
>>
>> We would like to join this call.
>> And thank you inviting us!
>>
>> Elena
>>> We could use the next KVM Community Call on June 4th to discuss
>>> remaining concerns and the next steps:
>>> https://calendar.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
>>>
>>> I also hope to include other core QEMU developers.  As you know, I'm
>>> skeptical, but it could be just me and I don't want to block you
>>> unnecessarily if others are more enthusiastic about this approach.
>>>
> 
> Hi Stefan
> 
> A few questions we have are about the call.
> What is the format of the call usually? Should we provide some kind of the project outline for 5 minutes?
> We are planning to address some of the concerns you have voiced in regards to amount of changes, usability,
> security and performance. I assume there will be other questions as well. Is there any time limit per topic?
> 
> And would you mind sharing the call details with us?
> 
> Thanks!
> Elena
>>
>>
>>> Stefan

Hi Stefan,

We would like to add multi-process QEMU to the agenda for any of the
upcoming KVM community calls. Do you know how we could go about doing
this?

Could you kindly share the contact details of the organizer for this
meeting?

Thank you very much!
--
Jag

>>
>>

