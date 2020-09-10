Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B21C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5968E21941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BqbaHDuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5968E21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ21-0003hw-Aa
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ15-00022s-AT; Thu, 10 Sep 2020 05:37:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ11-0003Qu-6c; Thu, 10 Sep 2020 05:37:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A9Xbrl098990; Thu, 10 Sep 2020 05:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=mwGrLLPo1BZCFqaigaL+8xe0eKKdSk53E8eSw7ho/VY=;
 b=BqbaHDuJSJWUM1Lo5jqNEHK8BwBaDgVue3/1mZQXE9tBXoHu1tS4AA+WohwzwZ7iSFDY
 PP32EWt4AXoZQ1uGSOBwkC9UfTXXD/N7RTNSbQCdrWFgVTGfQ+vfqAvQKuqmRbvQjjha
 tDiRpiZXR6br6jauTM2RP6BVyc8eiYHIhHeK5/tl3NES/yiUg3t9J1+7nrLv0d9xLxIu
 KPe5yWnMNwafukUkq1NTEVFUiauOZ10Jqm1QTrA4nqca9L0u48eaAAhYYdz4Wlhq3KVR
 76qL3GzDVVcdIVuRbwx8kyTq4SVh65vS1ZIOtdpgVRCjx9cfjJe/4Nr6MGDnIADW9DzC aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fh2hh6d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9YEEk101488;
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fh2hh6ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9Vv6P030763;
 Thu, 10 Sep 2020 09:37:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 33d46n2p6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 09:37:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A9bAkC48562474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 09:37:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55B3E112064;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FDB2112062;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v5 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Date: Thu, 10 Sep 2020 05:36:47 -0400
Message-Id: <20200910093655.255774-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:37:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Janosch, Thomas, Conny: I've removed your r-b's from patch #3 since I
added some g_mallocs in place and I'd like to make sure things are
done properly there (explained in changelog, but let me know if further
explanation is necessary).

Janosch, please let me know if the changes to #3 are safe under PV.

Thanks.

Changelog:

    v5

    • removed sccb_verify_length function
        - will simply use the length check code that was in place before

    • introduced a macro for calculating required SCCB length
        - takes a struct and max # of cpus as args

    • work_sccb size is now dynamically allocated based on the length
      provided by the guest kernel, instead of always using a static
      4K size
        - as such, the SCCB will have to be read twice:
            - first time to retrieve the header
            - second time with proper size after space for work_sccb 
              is allocated

    v4
    
    • added r-b's and ack's (thanks, everyone!)

    • renamed boundary and length function

    • updated header sync to reflect a change discussed in the respective
        KVM patches

    • s/data_len/offset_cpu

    • added /* fallthrough */ comment in boundary check

    v3

    • Device IOCTLs removed
        - diag 318 info is now communicated via sync_regs

    • Reset code removed
        - this is now handled in KVM
        - diag318_info is stored within the CPU reset portion of the
            S390CPUState

    • Various cleanups for ELS preliminary patches

    v2

    • QEMU now handles the instruction call
        - as such, the "enable diag 318" IOCTL has been removed

    • patch #1 now changes the read scp/cpu info functions to
      retrieve the machine state once
        - as such, I have not added any ack's or r-bs since this
          patch differs from the previous version

    • patch #3 introduces a new "get_read_scp_info_data_len"
      function in order clean-up the variable data length assignment
      in patch #7
        - a comment above this function should help clarify what's
          going on to make things a bit easier to read

    • other misc clean ups and fixes
        - s/diag318/diag_318 in order to keep the naming scheme
          consistent with Linux and other diag-related code
        - s/byte_134/fac134 to align naming scheme with Linux

-----------------------------------------------------------------------

This patch series introduces two features for an s390 KVM quest:
    - Extended-Length SCCB (els) for the Read SCP/CPU Info SCLP 
        commands
    - DIAGNOSE 0x318 (diag_318) enabling / migration handling

The diag 318 feature depends on els and KVM support.

The els feature is handled entirely with QEMU, and does not require 
KVM support.

Both features are made available starting with the zEC12-full model.

These patches are introduced together for two main reasons:
    - els allows diag 318 to exist while retaining the original 248 
        VCPU max
    - diag 318 is presented to show how els is useful

Full els support is dependant on the Linux kernel, which must react
to the SCLP response code and set an appropriate-length SCCB. 

A user should take care when tuning the CPU model for a VM.
If a user defines a VM with els support and specifies 248 CPUs, but
the guest Linux kernel cannot react to the SCLP response code, then
the guest will crash immediately upon kernel startup.

Collin L. Walling (8):
  s390/sclp: get machine once during read scp/cpu info
  s390/sclp: rework sclp boundary checks
  s390/sclp: read sccb from mem based on provided length
  s390/sclp: check sccb len before filling in data
  s390/sclp: use cpu offset to locate cpu entries
  s390/sclp: add extended-length sccb support for kvm guest
  s390/kvm: header sync for diag318
  s390: guest support for diagnose 0x318

 hw/s390x/event-facility.c           |   2 +-
 hw/s390x/sclp.c                     | 145 ++++++++++++++++++++--------
 include/hw/s390x/sclp.h             |   6 +-
 linux-headers/asm-s390/kvm.h        |   7 +-
 linux-headers/linux/kvm.h           |   1 +
 target/s390x/cpu.h                  |   2 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.h.inc |   4 +
 target/s390x/cpu_models.c           |   1 +
 target/s390x/gen-features.c         |   2 +
 target/s390x/kvm.c                  |  39 ++++++++
 target/s390x/machine.c              |  17 ++++
 12 files changed, 183 insertions(+), 44 deletions(-)

-- 
2.26.2


