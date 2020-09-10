Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A137C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1498420720
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ssxf637F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1498420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGPQ-0000pk-Nk
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGGOp-0000NS-7q; Thu, 10 Sep 2020 02:49:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGGOn-0008Um-9r; Thu, 10 Sep 2020 02:49:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A6WDU8136888; Thu, 10 Sep 2020 02:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4flH+59B9rXswW007sUV3hJucoOMSr4fU7+pzF533S8=;
 b=Ssxf637FMZlt9932t8aGCg9O8rgNfOn9hfo19iklvBC93+zFs1/jU2Mp20lRN4qBJpYO
 vhSKdinbHSIWuM8L6yIgRZg5SPFiVPLKlN49Q1diSZ0irpvSSHuueslwWUgPVDlreJ+h
 HDpHkxRMktv8Pb/mivu1TcookeZn1UP+j8AZqPrzK+Vt34A+hir/dJtBHEdcBFzoNkW0
 0YDmZ93xYgYc6HYztSks0r+Z2wQIRm84Gu7cIccJdJMI5V2MAIpYPkDyky75ivBAAVfH
 cakONQ5HlkKnZay5W3QgnD6VZeUfWZnb2Gn1XyiQoVlTiLpeQybBi63N6SmWYGrmOcQ0 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fesv8q0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 02:49:35 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A6cd7P155870;
 Thu, 10 Sep 2020 02:49:34 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fesv8q0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 02:49:34 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A6lhbb023224;
 Thu, 10 Sep 2020 06:49:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 33c2a95b1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 06:49:34 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A6nXU313828676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 06:49:33 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6023112063;
 Thu, 10 Sep 2020 06:49:33 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66270112061;
 Thu, 10 Sep 2020 06:49:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Sep 2020 06:49:33 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
To: Cornelia Huck <cohuck@redhat.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <b1d68acf-881f-be0f-c1ac-d32b8bfc859d@linux.ibm.com>
 <20200715180409.451d217e.cohuck@redhat.com>
 <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
 <20200716140214.3fdc7590.cohuck@redhat.com>
 <42dde86f-2f12-3b89-0c35-74d69fa3d449@de.ibm.com>
 <20200909104623.57664738.cohuck@redhat.com>
 <20200909114351.1f91f330.cohuck@redhat.com>
 <22005476-9a22-f3b1-4c92-fff9fbb2e11d@linux.ibm.com>
 <20200910083842.4eed4821.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <6d8656a1-b68b-1858-a460-0262c4e0ba35@linux.ibm.com>
Date: Thu, 10 Sep 2020 02:49:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910083842.4eed4821.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:49:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 2:38 AM, Cornelia Huck wrote:
> On Wed, 9 Sep 2020 14:13:55 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Has this been merged yet? There is one patch that I neglected to include
>> in this series (I didn't realize it until now) that properly sets the
>> SCCB size in QEMU based on the length provided by the kernel (right now,
>> these patches allocate a static 4K size for the SCCB struct, which
>> causes a segfault).
>>
>> I can post my set with the fix as v5, or I can wait and post the fix as
>> a bandaid if the patches are already in.
>>
> 
> It's queued on s390-next right now, I can still update it.
> 
> Is that really an extra patch, or something that can be merged into the
> series? If the latter, I'd prefer a v5, if the former, I'd just queue
> that patch on top.
> 
> 

I'll post a v5. Thanks!

-- 
Regards,
Collin

Stay safe and stay healthy

