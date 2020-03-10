Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E49C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF5721927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y7pNvVdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF5721927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmvI-0003XF-LK
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 18:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBmuX-0002yi-R0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBmuW-0006b0-Sc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:59:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBmuW-0006Yi-Kt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:59:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALxEtl183464;
 Tue, 10 Mar 2020 21:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PA3G+SC0pBqsE+wkrrLfBkKaW03sNpOer3okhefah7g=;
 b=y7pNvVdu5h7KSxTzSH7yVNHgiTJtbDJt2v+KIYf9EZ32LpvaYimMjyKLost+LO/C0mBh
 PTWcav+jKqfazi4VZq8I89GzSe4m0ryqxiboItMsenzJHMGNPCm928J47UEJYmM0HjPP
 EOSo41DolWd8FhJljpIbxD2+dO4iIu3AD809szP8f6+JZQxMo7+WhiT+X9hAWA90njKa
 PcEG0qq95CfaCS0x3ffPQAM12wdxp9vOSQQvCxI1IM8/DoihOtF3XLv57dUtZfnP9Tv4
 FwOyC1y00u3YQ3lYJT6yWAhHDcTMdXyW2yICdaOYgWuJj8dozxA1qEC5O78eI8+HAlA4 XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yp9v63c5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:59:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ALwC6D193896;
 Tue, 10 Mar 2020 21:59:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2yp8puafv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 21:59:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ALxXig027782;
 Tue, 10 Mar 2020 21:59:33 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 14:59:33 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310133646-mutt-send-email-mst@kernel.org>
 <91053e38-8bd1-d316-acd0-561dfc016fd5@oracle.com>
 <20200310174604-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <e5b9ddc1-b0dc-6f95-50e3-5a4a5b8933a3@oracle.com>
Date: Tue, 10 Mar 2020 23:59:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310174604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100130
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


On 10/03/2020 23:49, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 11:34:00PM +0200, Liran Alon wrote:
>> On 10/03/2020 23:16, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
>>>> There is no license issue here. It's only definitions.
>>> So it seems that in your opinion
>>> - definition names in the interface do not need a license
>>> and
>>> - it is fair to reuse them without a license for the purpose
>>>     of making your compatible interface easier to use for
>>>     people familiar with the original
>>>
>>> Did I get that right?
>> I'm for sure not an expert on open source code licenses. You probably know
>> this area much more than I do.
>> But yes, this is what I would have thought. That it's not an issue to copy
>> the enum definition.
> I'm not a lawyer. I think attribution is important even for small
> things, and it was missing in v1. v2 has it but link would be better.  I
> also think respecting author's wishes is important, and a license gives
> a hint as to that.
>
Oh maybe I misunderstood you.
So you're saying I should just add a link to open-vm-tools git-repo for 
attribution?
Which author's wishes you refer to?

-Liran


