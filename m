Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f47SU-0004sM-DX
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f47SP-0003A7-DC
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:09:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43594
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f47SP-00039Q-7H
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:09:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35Fx1tS107724
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 12:09:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5nhg5dsf-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 12:09:45 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 10:09:45 -0600
References: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
	<9bb77420-4a76-6a1b-3542-4205fcc8334b@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 13:09:39 -0300
MIME-Version: 1.0
In-Reply-To: <9bb77420-4a76-6a1b-3542-4205fcc8334b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <f5297ff7-81aa-c2ac-9573-2b10ec7412a7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 04/05/2018 12:56 PM, Paolo Bonzini wrote:
> On 27/03/2018 23:14, Daniel Henrique Barboza wrote:
>>           /* We get here only for BYTCHK == 0x01 and only for scsi-block.
>>            * As far as DMA is concerned, we can treat it the same as a write;
>>            * scsi_block_do_sgio will send VERIFY commands.
>> +         *
>> +         * For scsi versions 2 and older, the BYTCHK isn't related
>> +         * to VRPROTECT (in fact, there is no VRPROTECT). Skip
>> +         * this check in these versions.
>>            */
>> -        if (r->req.cmd.buf[1] & 0xe0) {
>> +        if ((r->req.cmd.buf[1] & 0xe0) && (s->qdev.scsi_version > 2)) {
>>               goto illegal_request;
>>           }
> This also has to check for "s->qdev.scsi_version != -1" so that the
> behavior of emulated SCSI isn't changed (they claim SPC-3).  I made this
> change and queued the patch.

Good catch.


Daniel

>
> Paolo
>
