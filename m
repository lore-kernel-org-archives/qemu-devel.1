Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8GG-0006Ux-3A
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8GB-0003Se-5L
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:21:36 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec8GA-0003SK-Vf
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:21:31 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so21225014qtm.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:21:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
Date: Thu, 18 Jan 2018 08:21:27 -0300
MIME-Version: 1.0
In-Reply-To: <d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 01/18/2018 05:20 AM, Paolo Bonzini wrote:
> On 18/01/2018 03:52, Fam Zheng wrote:
>> Coverity doesn't like the ignored return value introduced in
>> 9d3b155186c278 (hw/block: Fix the return type), and other callers are
>> converted already in ceff3e1f01.
>>
>> This one was added lately in d9bcd6f7f23a and missed the train. Do it
>> now.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  hw/scsi/scsi-generic.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index ba70c0dc19..7414fe2d67 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -482,7 +482,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>>      int rc;
>>      int sg_version;
>>      struct sg_scsi_id scsiid;
>> -    Error *local_err = NULL;
>>  
>>      if (!s->conf.blk) {
>>          error_setg(errp, "drive property not set");
>> @@ -516,11 +515,9 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
>>          error_setg(errp, "SG_GET_SCSI_ID ioctl failed");
>>          return;
>>      }
>> -    blkconf_apply_backend_options(&s->conf,
>> -                                  blk_is_read_only(s->conf.blk),
>> -                                  true, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> +    if (!blkconf_apply_backend_options(&s->conf,
>> +                                       blk_is_read_only(s->conf.blk),
>> +                                       true, errp)) {
>>          return;
>>      }
>>  
>>
> 
> I'm not a fan of bool return types, in general (because "!" is often
> success while "< 0" is failure) and especially when there is an Error**;
> I disagree with commit 9d3b155186.  But the function is not in an area I
> maintain so I'm queuing this, thanks.

Do you prefer "if (local_err)" and "if (errp && *errp)" ?

I wondered once if a macro might improve this pattern but thought the
code would get more obscure.
