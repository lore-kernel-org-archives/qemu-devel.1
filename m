Received: from eggs.gnu.org ([2001:4830:134:3::10]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e546d-0005d0-OS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e546Y-0005gP-Mn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e546Y-0005gD-Gm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:14:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J6DeUW046028
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:14:50 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpne4kak8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:14:50 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 02:14:49 -0400
Date: Thu, 19 Oct 2017 14:14:45 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017140453.51099-6-pasic@linux.vnet.ibm.com>
Message-Id: <20171019061445.GD4612@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x: refactor error handling for
 CSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 16:04:51 +0200]:

> Simplify the error handling of the cSCH.  Let the code detecting the
> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
[...]

> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 4ad07e9181..fd659e77a5 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -60,8 +60,6 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
>  {
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
> -    int ret = -ENODEV;
> -    int cc;
> 
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
>          program_interrupt(&cpu->env, PGM_OPERAND, 4);
> @@ -69,15 +67,11 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
>      }
>      trace_ioinst_sch_id("csch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_csch(sch);
> -    }
> -    if (ret == -ENODEV) {
> -        cc = 3;
> -    } else {
> -        cc = 0;
> +    if (!sch || !css_subch_visible(sch)) {
> +        setcc(cpu, 3);
Same question here.

> +        return;
>      }
> -    setcc(cpu, cc);
> +    setcc(cpu, css_do_csch(sch));
>  }
> 
>  void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
> -- 
> 2.13.5
> 

If we agree to replace 3 with IOINST_CC_NOT_OPERATIONAL, maybe Conny
could fix it. Or we can do that in a following cleanup patch?

W/ or w/o the fix, for now:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
