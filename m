Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CAFC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 21:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05CC206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 21:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuY9Q981"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05CC206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYbgW-00015D-JM
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kYbf3-0008M0-1D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 17:10:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8730
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kYbf0-000561-FO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 17:10:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09UL2njm094143; Fri, 30 Oct 2020 17:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=HA5ZDURwlVWqh6GonVeflT9iBajrGOuU1s3Y0+7k7i8=;
 b=CuY9Q981+PxD0MvtBdBXzx7u2+xuQ9aCOvT3uPxg6lHSvicsSV3qMD3YmA4AgZQ1y/Zw
 g735MYaBD4W0uujEwIf0MZAMuOcHIpftosF/WS4fjWnQZwz1EVnksUOMGGKXSxyzcejf
 QooBJZcTQ/ZRtOs/r1J1eTZIInQIDFmN3QgQWU/EoOiYf34kbvPtYVwd4DeElwBJQUa+
 ECOAz4M7kPuhF56mn8Vp9u65f0k69joLUF1ppGTd6sPiWTyp95qSSh8hT3ggFL2Ahbf0
 UYDjIqPjHDAOlz+e3CAaAOCUwomkKedp2LfKQijHU+9EtlHPWDBXeC6VeFg3sS7jUIt9 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34gkkcnb37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 17:10:06 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09UL2xeZ095426;
 Fri, 30 Oct 2020 17:10:06 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34gkkcnb31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 17:10:06 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09UL6ndk001964;
 Fri, 30 Oct 2020 21:10:05 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03wdc.us.ibm.com with ESMTP id 34ernr30jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 21:10:05 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09UL9sHe2490910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 21:09:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D0A0C605B;
 Fri, 30 Oct 2020 21:10:02 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DE6EC6059;
 Fri, 30 Oct 2020 21:10:02 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2020 21:10:02 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 30 Oct 2020 17:10:02 -0400
From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: RFC: Fast Migration for SEV and SEV-ES - blueprint and proof of
 concept
In-Reply-To: <20201030200202.GA19776@work-vm>
References: <8b824c44-6a51-c3a7-6596-921dc47fea39@linux.ibm.com>
 <20201030200202.GA19776@work-vm>
Message-ID: <5bec748d1e6ec171ef0d226c361edde5@linux.vnet.ibm.com>
X-Sender: tobin@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-30_10:2020-10-30,
 2020-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=tobin@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 13:38:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: ashish.kalra@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 jon.grimm@amd.com, tobin@ibm.com, qemu-devel@nongnu.org,
 dovmurik@linux.vnet.ibm.com, Dov.Murik1@il.ibm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-30 16:02, Dr. David Alan Gilbert wrote:
> * Tobin Feldman-Fitzthum (tobin@linux.ibm.com) wrote:
>> Hello,
>> 
>> Dov Murik, James Bottomley, Hubertus Franke, and I have been working 
>> on a
>> plan for fast live migration with SEV and SEV-ES. We just posted an 
>> RFC
>> about it to the edk2 list. It includes a proof-of-concept for what we 
>> feel
>> to be the most difficult part of fast live migration with SEV-ES.
>> 
>> https://edk2.groups.io/g/devel/topic/77875297
>> 
>> This was posted to the edk2 list because OVMF is one of the main 
>> components
>> of our approach to live migration. With SEV/SEV-ES the hypervisor 
>> generally
>> does not have access to guest memory/CPU state. We propose a Migration
>> Handler in OVMF that runs inside the guest and assists the hypervisor 
>> with
>> migration. One major challenge to this approach is that for SEV-ES 
>> this
>> Migration Handler must be able to set the CPU state of the target to 
>> the CPU
>> state of the source while the target is running. Our demo shows that 
>> this is
>> feasible.
>> 
>> While OVMF is a major component of our approach, QEMU obviously has a 
>> huge
>> part to play as well. We want to start thinking about the best way to
>> support fast live migration for SEV and for encrypted VMs in general. 
>> A
>> handful of issues are starting to come into focus. For instance, the 
>> target
>> VM needs to be started before we begin receiving pages from the source 
>> VM.
> 
> That might not be that hard to fudge; we already start the VM in
> postcopy mode before we have all of RAM; now in that we have to do 
> stuff
> to protect the RAM because we expect the guest to access it; in this
> case you possibly don't need to.
> 
I'll need to think a bit about this. The basic setup is that we want the
VM to boot into OVMF and initialize the Migration Handler. Then QEMU 
will start
receiving encrypted pages and passing them into OVMF via some shared 
address.
The Migration Handler will decrypt the pages and put them into place,
overwriting everything around it. The Migration Handler will be a 
runtime
driver so it should avoid overwriting itself.

>> We will also need to start an extra vCPU for the Migration Handler to 
>> run
>> on. We are currently working on a demo of end-to-end live migration 
>> for SEV
>> (non-ES) VMs that should help crystallize these issues. It should be 
>> on the
>> list around the end of the year. For now, check out our other post, 
>> which
>> has a lot more information and let me know if you have any thoughts.
> 
> I don't think I understood why you'd want to map the VMSA, or why it
> would be encrypted in such a way it was useful to you.
> 
We map the VMSA into the guest because it gives us an easy way to
securely send the CPU state to the target.

Each time there is a VMExit, the CPU state of the guest
is stored in the VMSA. Although the VMSA is encrypted with the guest's 
key,
it usually isn't mapped into the guest. During migration we securely
transfer guest memory from source to destination (the Migration Handler
on source and target share a key which they use to encrypt/decrypt the
pages). If we tweak the NPT to add the VMSA to the guest, the VMSA will 
be
sent along with the all the other pages.

There are some details with the timing. We'll need to force a VMExit 
once
we get convergence and re-send the VMSA page to make sure it's up to 
date.
Once the target has all the pages, the Migration Handler can just read 
the
CPU state from some known address.

-Tobin

> Dave
> 
> 
>> -Tobin
>> 

