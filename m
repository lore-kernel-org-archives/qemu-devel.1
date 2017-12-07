Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMvSQ-00072B-Gp
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMvSN-0001q5-EL
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:39:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMvSN-0001pI-5c
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:39:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB7CcpXl130239
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 07:39:12 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eq3sqx6bt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 07:39:09 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Dec 2017 12:35:41 -0000
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 7 Dec 2017 13:35:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171108165422.46267-2-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b9819897-b51f-f920-20ba-a843b05e39b5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 11/08/2017 05:54 PM, Halil Pasic wrote:
> +/* TODO This is the out-of-band variant. We may want to get rid of it */
> +static int set_mode_diag(const uint64_t *args)
> +{
> +    uint64_t subch_id = args[0];
> +    uint64_t op_mode = args[1];
> +    SubchDev *sch;
> +    CcwTestDevDevice *dev;
> +    int cssid, ssid, schid, m;
> +
> +    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
> +        return -EINVAL;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (!sch || !css_subch_visible(sch)) {
> +        return -EINVAL;
> +    }
> +    dev = CCW_TESTDEV(sch->driver_data);
> +    if (dev->op_mode_locked) {
> +        return op_mode == dev->op_mode ? 0 : -EINVAL;
> +    }

Should probably do validation on op_mode here.

> +    dev->op_mode = op_mode;
> +    sch->ccw_cb = get_ccw_cb(dev->op_mode);
> +    return 0;
> +}
> +
