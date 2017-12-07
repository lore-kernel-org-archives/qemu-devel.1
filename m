Received: from eggs.gnu.org ([2001:4830:134:3::10]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMvRm-0006kK-Og
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMvRj-0001Sf-Jt
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:38:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMvRj-0001QT-Bq
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:38:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB7CZN8X007163
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 07:38:29 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eq4mt3ntg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 07:38:28 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Dec 2017 12:38:26 -0000
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
	<e2e2ae84-e04a-df4f-50bb-328768a5464e@redhat.com>
	<20171207125901.47be0af1.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 7 Dec 2017 13:38:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171207125901.47be0af1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <87df13b9-c494-c8b4-49cf-b7ef4640d05a@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 12/07/2017 12:59 PM, Cornelia Huck wrote:
> On Thu, 7 Dec 2017 07:33:19 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 08.11.2017 17:54, Halil Pasic wrote:
> 
>>> +static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode)
>>> +{
>>> +    switch (op_mode) {
>>> +    case OP_MODE_FIB:
>>> +        return ccw_testdev_ccw_cb_mode_fib;
>>> +    case OP_MODE_NOP:
>>> +    default:
>>> +        return ccw_testdev_ccw_cb_mode_nop;  
>>
>> Do we really want to use "nop" for unknown modes? Or should there rather
>> be a ccw_testdev_ccw_cb_mode_error instead, too?
> 
> I like the idea of an error mode.

What would be the benefit of the error mode? The idea is that
the tester in the guest has a certain set of tests implemented
each requiring certain behavior from the device. This behavior
is represented by the mode.

If the device does not support the mode, the set of tests can't
be executed meaningfully. The only option is either ignore them
(and preferably report them as ignored), or fail them (not soo
good in my opinion).

The in guest tester should simply iterate over it test sets
and try to select the mode the test set (or suite in other
terminology) requires. If selecting the mode fails, than
means you are working with an old ccw-testdev.

> 
> Related: Should the device have a mechanism to report the supported
> modes?
> 

I don't see the value. See above. I think the set mode operation
reporting failure is sufficient.

But if you have something in mind, please do tell. I'm open.

>>
>>> +    }
>>> +}
> 
> (...)
> 
>>> +/* TODO This is the out-of-band variant. We may want to get rid of it */  
>>
>> I agree, this should rather go away in the final version.
> 
> I'm not sure that the in-band variant with its magic buffer value is
> superior to this version using a dedicated hypercall.
> 

I have a similar todo comment for the in-band variant. It is basically
up to us to decide which one do we want to keep. It's been a while since
I've looked at this, but AFAIR the out-of-band appears cleaner.

>>
>>> +static int set_mode_diag(const uint64_t *args)
>>> +{
>>> +    uint64_t subch_id = args[0];
>>> +    uint64_t op_mode = args[1];
>>> +    SubchDev *sch;
>>> +    CcwTestDevDevice *dev;
>>> +    int cssid, ssid, schid, m;
>>> +
>>> +    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
>>> +        return -EINVAL;
>>> +    }
>>> +    sch = css_find_subch(m, cssid, ssid, schid);
>>> +    if (!sch || !css_subch_visible(sch)) {
>>> +        return -EINVAL;
>>> +    }
>>> +    dev = CCW_TESTDEV(sch->driver_data);
>>> +    if (dev->op_mode_locked) {
>>> +        return op_mode == dev->op_mode ? 0 : -EINVAL;
>>> +    }
>>> +    dev->op_mode = op_mode;
>>> +    sch->ccw_cb = get_ccw_cb(dev->op_mode);
>>> +    return 0;
> 
