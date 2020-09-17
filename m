Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34731C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7332222C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mwyv1Ipj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7332222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvcP-0003uW-7p
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIvTC-00068j-97; Thu, 17 Sep 2020 11:05:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIvT9-0001Pw-S4; Thu, 17 Sep 2020 11:05:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08HEu3GX168524; Thu, 17 Sep 2020 11:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8NSebJ6ejs+2jYXFr8RVjNEJi+RFzmzRl7KZU3lBgxc=;
 b=mwyv1IpjmQWqtDNo1VcRCnyY12/NXNUx0jv/syMEY4kHUeRuKoEQdtiSvV6QNzsRSTed
 40VJHEY3/s9MVFy3SN/On5HZj7qdhmn2IQBqV4ztL/4mmqTaiNQ8WnRi2juS8lXBCWdC
 S2KsMWdGqv9w41rDFDsVop0fiwQzvX+02U7eP9yT0tm+RE+fMlHE55u56hjmBQHNkmi7
 uW3kKIYErdvIEvlEmRC6Bk/7HMnI2Ar3ToFKvTc7o3lpR8m47LA+rHueNhgv2yqDGm5t
 z1Kvzt1/aJgu0fE5LtL6sYQKjketaE3QUJ9m4HupFk34sjTeAi9YqCIcwPrKSnwzQgHn 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33ma0er8en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 11:05:06 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HF0GHu179710;
 Thu, 17 Sep 2020 11:05:05 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33ma0er8e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 11:05:05 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HF2mcW012287;
 Thu, 17 Sep 2020 15:05:04 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 33k5v9hhqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 15:05:04 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08HF53Kj39715264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2020 15:05:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 161FE6E059;
 Thu, 17 Sep 2020 15:05:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE216E054;
 Thu, 17 Sep 2020 15:05:01 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2020 15:05:01 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] s390x/pci: Accomodate vfio DMA limiting
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <160035396423.8478.4968781368528580151@66eaa9a8a123>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <3855da1b-4cd8-a664-56b9-66dff4db9c26@linux.ibm.com>
Date: Thu, 17 Sep 2020 11:05:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160035396423.8478.4968781368528580151@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-17_10:2020-09-16,
 2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170113
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 10:21:03
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com,
 alex.williamson@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:46 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1600352445-21110-1-git-send-email-mjrosato@linux.ibm.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> 

Errors seem to be of the flavor

'N/A. Internal error while reading log file'
and
'No space left on device'

seems like a patchew disk issue rather than something with this patchset?

> 
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/1600352445-21110-1-git-send-email-mjrosato@linux.ibm.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


