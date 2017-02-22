Received: from eggs.gnu.org ([2001:4830:134:3::10]:43935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgYBp-0005Vh-Lp
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cgYBm-0001vR-GT
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:46:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cgYBm-0001ug-6V
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:46:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MEiPJo019851
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 09:46:39 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rq82w2x3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 09:46:39 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 14:46:33 -0000
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-4-pasic@linux.vnet.ibm.com>
	<20170217194237.GA20911@work-vm>
	<56bb4f43-9dc7-83d5-7cb9-d3e8036675e6@linux.vnet.ibm.com>
	<20170221122207.GF2377@work-vm>
	<6b39cefc-16b2-4a77-9efc-400a73fff88d@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 15:46:24 +0100
MIME-Version: 1.0
In-Reply-To: <6b39cefc-16b2-4a77-9efc-400a73fff88d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <cf982e58-41f2-1f25-2c75-94fc1a8b80c0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/vmstate: fix array of ptr
 with nullptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 02/21/2017 01:55 PM, Halil Pasic wrote:
>> It's OK to add an error_report as needed; in particular I try and avoid
>> assert's on the save path where possible, since the user apparently
>> has a happy running VM, so even if the migration code has an error in it
>> I'd rather the user didn't lose their VM.  The load path it's OK to
>> add the asserts since they've not got a working VM yet.
>>
>> Dave
>>
> You are right, distinguishing between save and load paths makes a lot
> of sense. So on the load path I will use asserts, and on the save path,
> that is
> 
> static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>                         VMStateField *field, QJSON *vmdesc)
> 
> {
> 
> here, I could do:
> -    assert(pv == NULL);
> +    if (pv != NULL) {
> +        error_report("put_nullptr must be called with pv == NULL");
> +        return -EINVAL; 
> +    }
>     qemu_put_byte(f, VMS_NULLPTR_MARKER);
>     return 0;
> }
> 
> And of course, I will fix ignoring the return value too. Would that be
> satisfactory? If not, please complain.
> 
> By the way, I could also omit the check on pv, and ignore pv altogether.
> A call to put_nullptr means we encountered a nullptr and the check
> is just for catching buggy client code -- what might be an overkill
> in this case.
> 
> Thank you very much. FYI I intend to send out the next version tomorrow.
> 
> Regards,
> Halil
> 
> 
> 

Just realized two things:
1. vmstate_save_state does not have a return value and does not handle
such. So I won't fail the migration from put_nullptr.
2. Since we have no rule on NDEBUG, I think  I should not rely on assert doing
anything. So where important for correctness I will do return value and
error_report. 
