Received: from eggs.gnu.org ([2001:4830:134:3::10]:49909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e549V-0006c3-Pi
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e549Q-00070Q-NL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:17:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e549Q-000706-Dn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:17:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J6GhcK101587
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:17:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpgn2gfte-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:17:47 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 02:17:46 -0400
Date: Thu, 19 Oct 2017 14:17:40 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-7-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017140453.51099-7-pasic@linux.vnet.ibm.com>
Message-Id: <20171019061740.GE4612@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x: refactor error handling for
 HSCH handler
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

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 16:04:52 +0200]:

> Simplify the error handling of the HSCH.  Let the code detecting the
> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 18 +++++-------------
>  include/hw/s390x/css.h |  2 +-
>  target/s390x/ioinst.c  | 23 ++++-------------------
>  3 files changed, 10 insertions(+), 33 deletions(-)
> 
[...]

> @@ -87,24 +85,11 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
>      }
>      trace_ioinst_sch_id("hsch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_hsch(sch);
> -    }
> -    switch (ret) {
> -    case -ENODEV:
> -        cc = 3;
> -        break;
> -    case -EBUSY:
> -        cc = 2;
> -        break;
> -    case 0:
> -        cc = 0;
> -        break;
> -    default:
> -        cc = 1;
> -        break;
> +    if (!sch || !css_subch_visible(sch)) {
> +        setcc(cpu, 3);
Ditto.

> +        return;
>      }
> -    setcc(cpu, cc);
> +    setcc(cpu, css_do_hsch(sch));
>  }
> 
>  static int ioinst_schib_valid(SCHIB *schib)
> -- 
> 2.13.5
> 

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
