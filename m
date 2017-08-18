Received: from eggs.gnu.org ([2001:4830:134:3::10]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diayL-0006JA-Ew
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 02:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diayI-0002id-C4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 02:41:33 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diayI-0002i2-6Q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 02:41:30 -0400
Received: by mail-wr0-f179.google.com with SMTP id y96so59134277wrc.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 23:41:30 -0700 (PDT)
References: <20170817141148.13111-1-famz@redhat.com>
	<dad88591-da0d-d9dd-ef0d-4153bbc68b85@redhat.com>
	<20170818033829.GA15392@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39e28f27-c45c-b2a2-bb46-16b65f9d04f8@redhat.com>
Date: Fri, 18 Aug 2017 08:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170818033829.GA15392@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 18/08/2017 05:38, Fam Zheng wrote:
> On Thu, 08/17 16:23, Paolo Bonzini wrote:
>>> +        if (scsi_sense_matches(r, SENSE_CODE(NO_MEDIUM))) {
>>> +            error = ENOMEDIUM;
>>> +        } else if (scsi_sense_matches(r, SENSE_CODE(TARGET_FAILURE))) {
>>> +            error = ENOMEM;
>>> +        } else if (scsi_sense_matches(r, SENSE_CODE(INVALID_FIELD))) {
>>> +            error = EINVAL;
>>> +        } else if (scsi_sense_matches(r, SENSE_CODE(SPACE_ALLOC_FAILED))) {
>>> +            error = ENOSPC;
>>> +        } else {
>>> +            error = EIO;
>>
>> Nice touch :) and in fact the ENOSPC case is needed for correctness.
>>
> 
> Offline you mentioned iscsi_translate_sense(). Makes sense to unify both. We can
> create a util/scsi.c to move it there.
> 
> About the error/non-error condition, is it enough to add a check "status ==
> CHECK_CONDITION"?

No, CHECK_CONDITION is for almost every error.

Of those in iscsi_translate_sense:

- DATA_PROTECTION should be an error

- COMMAND_ABORTED should be passed down

- of the various ILLEGAL_REQUEST cases, only ENOMEDIUM and ENOACCES
should stop.  LBA out of range should never happen (see
scsi_disk_dma_command).

- NOT_READY should also look at asc/ascq individually, like
ILLEGAL_REQUEST, see below

Of those in your list above, these are missing in iscsi_translate_sense:

- SPACE_ALLOC_FAILED (which should stop the VM)

- NOT_READY should also look at asc/ascq individually, like
ILLEGAL_REQUEST.  NO_MEDIUM is returning -EBUSY instead of -ENOMEDIUM.

Among other sense keys, MEDIUM_ERROR and HARDWARE_ERROR probably should
stop the VM.

Paolo
