Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CDC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5898D208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1171-00088y-Js
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 23:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1j116I-0007Ig-5l
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1j116G-0001Di-Vg
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:55:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43634
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1j116G-0001Ch-RJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:55:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01A4tCp7111339
 for <qemu-devel@nongnu.org>; Sun, 9 Feb 2020 23:55:12 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u19q6uq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 23:55:12 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Mon, 10 Feb 2020 04:55:07 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Feb 2020 04:55:03 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01A4t2D122806668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2020 04:55:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADF254C059;
 Mon, 10 Feb 2020 04:55:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3702C4C040;
 Mon, 10 Feb 2020 04:55:01 +0000 (GMT)
Received: from [9.199.196.67] (unknown [9.199.196.67])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 10 Feb 2020 04:55:00 +0000 (GMT)
Subject: Re: [PATCH v5 3/4] spapr: Add NVDIMM device support
To: David Gibson <david@gibson.dropbear.id.au>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
 <158038488675.16440.7063690858146740608.stgit@lep8c.aus.stglabs.ibm.com>
 <20200204035900.GB60221@umbus.fritz.box>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Mon, 10 Feb 2020 10:25:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200204035900.GB60221@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20021004-0020-0000-0000-000003A8A648
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021004-0021-0000-0000-000022007F37
Message-Id: <10eb3414-c87b-1666-c36b-23e5e191412f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-09_08:2020-02-07,
 2020-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=867 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100039
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, sbhat@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 02/04/2020 09:29 AM, David Gibson wrote:
> On Thu, Jan 30, 2020 at 05:48:15AM -0600, Shivaprasad G Bhat wrote:
>> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
>> device interface in QEMU to support virtual NVDIMM devices for Power.
>> Create the required DT entries for the device (some entries have
>> dummy values right now).
>>
>> The patch creates the required DT node and sends a hotplug
>> interrupt to the guest. Guest is expected to undertake the normal
>> DR resource add path in response and start issuing PAPR SCM hcalls.
>>
>> +                       " must be a multiple of %" PRIu64 "MB",
>> +                       SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
>> +            return;
>> +        }
>> +
>> +        uuidstr = object_property_get_str(OBJECT(dimm), NVDIMM_UUID_PROP, NULL);
>> +        qemu_uuid_parse(uuidstr, &uuid);
> Uh.. couldn't we just look at nvdimm->uuid, rather than getting the
> string property and parsing it again?

Addressing all except this one as discussed. Posting the next version in 
a while.

Thanks,
Shivaprasad


