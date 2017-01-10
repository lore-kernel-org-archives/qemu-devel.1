Received: from eggs.gnu.org ([2001:4830:134:3::10]:53600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cQvWK-0001nd-Fm
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cQvWF-0002br-Hc
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:27:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cQvWF-0002bT-B9
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:27:15 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0ACOROV119016
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 07:27:14 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vwk9n05y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 07:27:13 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 10 Jan 2017 05:27:13 -0700
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
	<1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 10 Jan 2017 13:27:04 +0100
MIME-Version: 1.0
In-Reply-To: <1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: weidong.huang@huawei.com, claudio.fontana@huawei.com, mst@redhat.com, luonengjun@huawei.com, hanweidong@huawei.com, xuquan8@huawei.com, wanzongshun@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, longpeng2@huawei.com, arei.gonglei@hotmail.com, davem@davemloft.net, wu.wubin@huawei.com, herbert@gondor.apana.org.au

On 12/15/2016 03:03 AM, Gonglei wrote:
[...]
> +
> +static struct crypto_alg virtio_crypto_algs[] = { {
> +	.cra_name = "cbc(aes)",
> +	.cra_driver_name = "virtio_crypto_aes_cbc",
> +	.cra_priority = 501,


This is still higher than the hardware-accelerators (like intel aesni or the
s390 cpacf functions or the arm hw). aesni and s390/cpacf are supported by the
hardware virtualization and available to the guests. I do not see a way how virtio
crypto can be faster than that (in the end it might be cpacf/aesni + overhead)
instead it will very likely be slower.
So we should use a number that is higher than software implementations but
lower than the hw ones.

Just grepping around, the software ones seem be be around 100 and the hardware 
ones around 200-400. So why was 150 not enough?

Christian
