Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BB4C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646562075B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646562075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijVNQ-0006GS-IW
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 16:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maxiwell@linux.ibm.com>) id 1ijVMi-0005kB-4R
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maxiwell@linux.ibm.com>) id 1ijVMg-0004XK-QW
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:35:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
 id 1ijVMd-0004Tm-Vg; Mon, 23 Dec 2019 16:35:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBNLTW07075491; Mon, 23 Dec 2019 16:35:37 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x1gta305u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 16:35:37 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBNLZP6J028324;
 Mon, 23 Dec 2019 21:35:36 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 2x1b16dfkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 21:35:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBNLZYqT57082122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2019 21:35:35 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA6A5C6055;
 Mon, 23 Dec 2019 21:35:34 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5036AC6057;
 Mon, 23 Dec 2019 21:35:33 +0000 (GMT)
Received: from maxibm (unknown [9.85.171.240])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Dec 2019 21:35:32 +0000 (GMT)
Date: Mon, 23 Dec 2019 18:35:30 -0300
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
Message-ID: <20191223213530.m4thca35liyjlsln@maxibm>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223063043.GH38380@umbus.modem>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_09:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230186
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 23, 2019 at 05:30:43PM +1100, David Gibson wrote:
> On Thu, Dec 19, 2019 at 01:38:54PM -0300, Maxiwell S. Garcia wrote:
> > The env->hflags is computed in ppc_cpu_reset(), using the MSR register
> > as input. But at the point ppc_disas_set_info() is called the MSR_LE bit
> > in env->hflags doesn't contain the same information that env->msr.
> > 
> > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> 
> I think the change is ok as far as it goes but,
> 
> a) the commit message should expand on what the practical effect of
> this is.  Looking, I think the only thing this affects is DEBUG_DISAS
> output (i.e. very rarely) which is worth noting.

Ok, I will do that. I got this bug using the 'x/i' command on QEMU
monitor with a LE guest.

> 
> b) AFAICT this is the *only* thing that looks for the LE bit in
> hflags. Given that, and the fact that it would be wrong in most cases,
> we should remove it from hflags entirely along with this change.
> 

I was changing the code to remove this LE bit from hflags and I found the
function 'helper_store_hid0_601()' in misc_helper.c, which manipulates the
'hflags'. The commit 056401eae6 says:

"Implement PowerPC 601 HID0 register, needed for little-endian mode support.
As a consequence, we need to merge hflags coming from MSR with other ones.
Use little-endian mode from hflags instead of MSR during code translation."

So, is the 'hflags' necessary here? Can we use MSR instead of hflags to
change the endianness in this function?

Thank you

> > ---
> >  target/ppc/translate_init.inc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> > index d33d65dff7..a0b384da9e 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -10830,7 +10830,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
> >      PowerPCCPU *cpu = POWERPC_CPU(cs);
> >      CPUPPCState *env = &cpu->env;
> >  
> > -    if ((env->hflags >> MSR_LE) & 1) {
> > +    if (msr_le) {
> >          info->endian = BFD_ENDIAN_LITTLE;
> >      }
> >      info->mach = env->bfd_mach;
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



