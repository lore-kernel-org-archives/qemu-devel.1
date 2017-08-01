Received: from eggs.gnu.org ([2001:4830:134:3::10]:39867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcYuf-0002VS-7F
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcYuc-0005C7-3w
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:16:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dcYub-00059W-Pu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:16:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v71FEs7J077176
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 11:16:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2urasfk2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 11:16:43 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 16:16:41 +0100
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
	<20170801075727.31335-3-bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 1 Aug 2017 17:16:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170801075727.31335-3-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5aba0805-2645-0075-edcb-e9d5b3643dd2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x/css: generate solicited crw
 for rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com



On 08/01/2017 09:57 AM, Dong Jia Shi wrote:
[..]
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1745,10 +1745,10 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
>      }
> 
>      /* We don't really use a channel path, so we're done here. */
> -    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT,
> +    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1,
>                    channel_subsys.max_cssid > 0 ? 1 : 0, chpid);
>      if (channel_subsys.max_cssid > 0) {
> -        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 0, real_cssid << 8);
> +        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1, 0, real_cssid << 8);
>      }
>      return 0;
>  }
> @@ -2028,7 +2028,8 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>      }
>  }
> 
> -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
> +void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
> +                   int chain, uint16_t rsid)

I think you could make the parameters solicited and chain bool (AFAIU
they are conceptually bool) for clearer semantic. If you go with that
you could also get rid of the superfluous ternary operator ( we have
stuff like some_cond ? 1 : 0 for the chain parameter in more than
one place.

Btw. I find bool flags easy to mix up and difficult to read. I have no better
idea how to write this (in C) though. I was considering throwing chain and
solicited together into a single flags parameter, but looking at the client code
it does not look like a good idea.

Besides the cosmetic considerations above LGTM
