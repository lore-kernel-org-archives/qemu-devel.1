Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC807C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E48E206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E48E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClN1-0004xm-Mz
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jClMD-0004BZ-H7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jClMC-0005v4-AG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:32:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44096
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jClMC-0005tw-4Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:32:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DEUnF0072788
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 10:32:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqyhjbb66-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 10:32:11 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 14:32:09 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 14:32:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02DEV6MU6750656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:31:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E6B211C04A;
 Fri, 13 Mar 2020 14:32:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C922811C05E;
 Fri, 13 Mar 2020 14:32:04 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.5.97])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 14:32:04 +0000 (GMT)
Date: Fri, 13 Mar 2020 15:32:03 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 09/15] s390x: protvirt: Set guest IPL PSW
In-Reply-To: <10063e5d-7c4f-da0b-fe20-c8d94c958111@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-10-frankja@linux.ibm.com>
 <20200313135733.634c0008@p-imbrenda>
 <10063e5d-7c4f-da0b-fe20-c8d94c958111@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031314-0012-0000-0000-00000390815E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031314-0013-0000-0000-000021CD5721
Message-Id: <20200313153203.20625e2f@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_05:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130074
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 15:21:07 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/13/20 1:57 PM, Claudio Imbrenda wrote:
> > On Wed, 11 Mar 2020 09:21:45 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >   
> >> Handling of CPU reset and setting of the IPL psw from guest
> >> storage at offset 0 is done by a Ultravisor call. Let's only fetch
> >> it if necessary.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/cpu.c | 22 +++++++++++++---------
> >>  1 file changed, 13 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> >> index 84029f14814b4980..a48d39f139cdc1c4 100644
> >> --- a/target/s390x/cpu.c
> >> +++ b/target/s390x/cpu.c
> >> @@ -78,16 +78,20 @@ static bool s390_cpu_has_work(CPUState *cs)
> >>  static void s390_cpu_load_normal(CPUState *s)
> >>  {
> >>      S390CPU *cpu = S390_CPU(s);
> >> -    uint64_t spsw = ldq_phys(s->as, 0);
> >> -
> >> -    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> >> -    /*
> >> -     * Invert short psw indication, so SIE will report a
> >> specification
> >> -     * exception if it was not set.
> >> -     */
> >> -    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> >> -    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> >> +    uint64_t spsw;
> >>  
> >> +    if (!s390_is_pv()) {
> >> +        spsw = ldq_phys(s->as, 0);
> >> +        cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> >> +        /*
> >> +         * Invert short psw indication, so SIE will report a
> >> specification
> >> +         * exception if it was not set.
> >> +         */
> >> +        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> >> +        cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> >> +    } else {
> >> +        s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);
> >> +    }
> >>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> >>  }
> >>  #endif  
> > 
> > I don't understand why you set the state to S390_CPU_STATE_LOAD and
> > then immediately afterwards to S390_CPU_STATE_OPERATING, especially
> > considering that both do the same
> >   
> 
> Have a look at the specs, wee need to set the load state before
> setting the cpu to operating.
> 
> I can add a comment to make it clearer if you want.

once you have added the comment, you can also add:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


