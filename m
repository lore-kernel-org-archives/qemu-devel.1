Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7996C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280A206CB
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3JdMzjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280A206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqxP-0000NR-UZ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kPqv7-0007TR-Ba; Tue, 06 Oct 2020 13:38:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kPqv5-0007xj-Ee; Tue, 06 Oct 2020 13:38:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 096HWTnA102630; Tue, 6 Oct 2020 13:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yetm3O9T97JOXDDqZxQ5H5pUsa4oUP9tp3Y6sM5yu1Q=;
 b=V3JdMzjC2w4t6EZo2zWnvhPebekmW1DovAp0bXSZJFH1GxTWi2nBrUKnTIaHNu5byHFX
 FAkTMArO5U4nrHdxtxuLlGlh1cJ1Li3d76atWTa/1WEy762fAy3vLSB036ApOTi4hK52
 aFg2BdzHE7R57AKJRFBim+YlZaOsAB49OGyObWUSaF4dPs2QuyADlyKP0oHr3/8mymwM
 etEh1r4XczQ9PO/JT0DxS2nPuM1x7Lbdlc5UqlOm2PvOenQtZwN/X0RVnfPEI1TDBefM
 VFTGvO8Yd00XgygBmj9Gv4uN3tG7EcFyxD2nV42Jf2MQaUD4K8Dz9q6W0ml9EUUFIhzm UA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 340uwfacn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 13:38:33 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 096HZWTc127389;
 Tue, 6 Oct 2020 13:38:32 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 340uwfacmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 13:38:32 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 096HbXbS004717;
 Tue, 6 Oct 2020 17:38:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 33xgx9fegc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 17:38:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 096HcU9T41812412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2020 17:38:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9B34112069;
 Tue,  6 Oct 2020 17:38:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C64112062;
 Tue,  6 Oct 2020 17:38:28 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.60.106])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2020 17:38:28 +0000 (GMT)
Subject: Re: [PATCH v2 1/9] s390x/pci: Move header files to include/hw/s390x
To: Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>
References: <1601669191-6731-1-git-send-email-mjrosato@linux.ibm.com>
 <1601669191-6731-2-git-send-email-mjrosato@linux.ibm.com>
 <20201006173259.1ec36597.cohuck@redhat.com>
 <e9f6c3e1-9341-b0d0-9fb2-b34ebd19bcba@linux.ibm.com>
 <1c118c1d-8c9b-9b7b-d1ec-2080aaa1c1a3@twiddle.net>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <b715826d-dcfb-8ed3-7050-d09904d6ed40@linux.ibm.com>
Date: Tue, 6 Oct 2020 13:38:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1c118c1d-8c9b-9b7b-d1ec-2080aaa1c1a3@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-06_09:2020-10-06,
 2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060108
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 11:46:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 1:33 PM, Richard Henderson wrote:
> On 10/6/20 11:43 AM, Matthew Rosato wrote:
>>> Looks good, but...
>>>
>>> <meta>Is there any way to coax out a more reviewable version of this
>>> via git mv?</meta>
>>>
>>
>> I tried git mv, but a diff between the old patch and the new patch looks the
>> same (other than the fact that I squashed the MAINTAINERS hit in)
> 
> git format-patch --find-renames[=<pct>]
> 
> Though I'm surprised it's not doing that by default.
> 
> r~
> 

Huh, neat.  That looks alot better, gives something that looks like:

diff --git a/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
similarity index 100%
rename from hw/s390x/s390-pci-bus.h
rename to include/hw/s390x/s390-pci-bus.h
diff --git a/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
similarity index 100%
rename from hw/s390x/s390-pci-inst.h
rename to include/hw/s390x/s390-pci-inst.h

Thanks!


