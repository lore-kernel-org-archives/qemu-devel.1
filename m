Received: from eggs.gnu.org ([2001:4830:134:3::10]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOSjd-0000lj-1s
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOSjY-00008S-5b
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOSjX-000082-VP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:18:48 -0500
References: <AOAA8gA7ALBQysnC4XRVtKo3.3.1483437512378.Hmail.zhangqian@sangfor.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a92db0b-1fb6-289a-25b0-d0e23f855c7b@redhat.com>
Date: Tue, 3 Jan 2017 18:18:44 +0100
MIME-Version: 1.0
In-Reply-To: <AOAA8gA7ALBQysnC4XRVtKo3.3.1483437512378.Hmail.zhangqian@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: fix crash on VERIFY command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Qian <zhangqian@sangfor.com.cn>
Cc: qemu-devel@nongnu.org



On 03/01/2017 10:58, Zhang Qian wrote:
> 
> At 2017-01-03 17:38:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>>On 03/01/2017 09:12, Zhang Qian wrote:
>>> yes, you are right.
>>> The scenarios of problem is
>>> a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
>>> scsi_block_is_passthrough returns false and finally scsi-block uses
>>> scsi_disk_dma_command for
>>> VERIFY. So the mode is set to SCSI_XFER_NONE.
>>> In scsi_req_continue, scsi_read_data function is called.
>>
>>Uhm, is the fix simply
>>
>>diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>>index bdd1e5f..c080888 100644
>>--- a/hw/scsi/scsi-disk.c
>>+++ b/hw/scsi/scsi-disk.c
>>@@ -2701,7 +2701,7 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
>>          * for the number of logical blocks specified in the length
>>          * field).  For other modes, do not use scatter/gather operation.
>>          */
>>-        if ((buf[1] & 6) != 2) {
>>+        if ((buf[1] & 6) == 2) {
>>             return false;
>>         }
>>         break;
>>
>>then?
> I verified your patch, it is ok.
> 
> but why not use (buf[1] & 2) == 2 ?

Isn't BYTCHK bits 1 and 2?

Paolo
