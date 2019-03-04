Received: from eggs.gnu.org ([209.51.188.92]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0kVD-0004jP-1v
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0kVC-0003jE-DA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:07:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h0kVC-0003ij-3a
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:07:18 -0500
References: <20190217113717.7077-1-svens@stackframe.org>
	<20190304082446.GB4629@t470p.stackframe.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d949916-ef17-e0c7-dea9-c94c230462ca@redhat.com>
Date: Mon, 4 Mar 2019 11:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190304082446.GB4629@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] lsi: check if SIGP bit is already set in
 Wait reselect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>

On 04/03/19 09:24, Sven Schnelle wrote:
> Hi List,
> 
> is this patch going to be accepted?

Yes, I have queued it now.

Paolo

> 
> Thanks
> Sven
> 
> On Sun, Feb 17, 2019 at 12:37:17PM +0100, Sven Schnelle wrote:
>> If SIGP is set, the 'Wait for Reselection' command should jump
>> immediately to the address stored in the second DWORD of the
>> instruction. This fixes spurious hangs in the HP-UX 11.11
>> installer when the SIGP bit gets set by the kernel before the
>> 'Wait for Reselection' command is executed by SCRIPTS.
>>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> Tested-by: Helge Deller <deller@gmx.de>
>> ---
>>  hw/scsi/lsi53c895a.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
>> index 8ba07f8756..bcff859bac 100644
>> --- a/hw/scsi/lsi53c895a.c
>> +++ b/hw/scsi/lsi53c895a.c
>> @@ -1297,8 +1297,10 @@ again:
>>                  }
>>                  break;
>>              case 2: /* Wait Reselect */
>> -                if (!lsi_irq_on_rsl(s)) {
>> -                    lsi_wait_reselect(s);
>> +                if (s->istat0 & LSI_ISTAT0_SIGP) {
>> +                    s->dsp = s->dnad;
>> +                } else if (!lsi_irq_on_rsl(s)) {
>> +                        lsi_wait_reselect(s);
>>                  }
>>                  break;
>>              case 3: /* Set */
>> -- 
>> 2.20.1
>>
>>
