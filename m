Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D468DC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB14320409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 16:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB14320409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijmmO-0002rw-Ol
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 11:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ijmln-0002Ks-Id
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 11:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ijmlm-0002II-I8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 11:10:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ijmlj-0002GZ-W0; Tue, 24 Dec 2019 11:10:48 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBOG7jjT002920; Tue, 24 Dec 2019 11:10:40 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x1fwxm5j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Dec 2019 11:10:40 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBOG5Ie3028663;
 Tue, 24 Dec 2019 16:10:39 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma05wdc.us.ibm.com with ESMTP id 2x1b16kq5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Dec 2019 16:10:39 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBOGAcuU47972786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2019 16:10:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8858FBE051;
 Tue, 24 Dec 2019 16:10:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A12D4BE054;
 Tue, 24 Dec 2019 16:10:37 +0000 (GMT)
Received: from localhost (unknown [9.85.135.127])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 24 Dec 2019 16:10:37 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
In-Reply-To: <20191224051904.GK38380@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem> <875zi6fwqy.fsf@linux.ibm.com>
 <20191224051904.GK38380@umbus.modem>
Date: Tue, 24 Dec 2019 13:10:34 -0300
Message-ID: <8736d9g0w5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-24_04:2019-12-24,2019-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=748
 phishscore=0 suspectscore=1 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912240140
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

>> It looks like the hflags MSR_LE is being updated correctly with TCG. But
>> with KVM we only touch it on system_reset
>
> Ah.. right.  I think to fix that we'd want an hreg_compute_hflags() at
> the end of sucking the state out of KVM.
>

Hm.. The hflags is a TCG thing that does not get used with KVM at all,
except for that one bit in the monitor disas function. I'd rather keep
it completely out of kvm_enabled code.

Couldn't we perhaps make it conditional on the acceleration type?
Using kvm_enabled() or some ifdef.

Thanks

>> (and possibly h_cede? I don't
>> know if it is QEMU who handles it).
>
> It's KVM.  If we used the qemu one it would add an awful lot of
> latency to cedes.
>> 
>> So I would let hflags be.
>> 
>> 
>> ... Actually, I don't really know the purpose of hflags. It comes from:
>> 
>>   commit 3f3373166227b13e762e20d2fb51eadfa6a2d653
>>   Author: Fabrice Bellard <fabrice@bellard.org>
>>   Date:   Wed Aug 20 23:02:09 2003 +0000
>>   
>>       pop ss, mov ss, x and sti disable irqs for the next instruction -
>>       began dispatch optimization by adding new x86 cpu 'hidden' flags
>>       
>>       
>>       git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@372 c046a42c-6fe2-441c-8c8c-71466251a162
>> 
>> Could any one clarify that?
>
> Not really.  It's really, really old, in the cruft bits of TCG I don't
> much understand.

