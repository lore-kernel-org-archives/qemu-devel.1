Received: from eggs.gnu.org ([209.51.188.92]:53971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLZXv-0004iE-Pa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLZXt-0005Gk-V3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hLZXt-0005BN-Fj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:40:09 -0400
References: <20190430131946.26628-1-brogers@suse.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4361ed56-ff32-7f89-4e1a-173898e8081a@redhat.com>
Date: Tue, 30 Apr 2019 16:40:05 -0400
MIME-Version: 1.0
In-Reply-To: <20190430131946.26628-1-brogers@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: handle invalid cdb length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com



On 4/30/19 9:19 AM, Bruce Rogers wrote:
> While investigating link-time-optimization, the compiler flagged this
> case of not handling the error return from scsi_cdb_length(). Handle
> this error case with a trace report.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/scsi/scsi-disk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e7e865ab3b..8fbf7512e5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
>      int len = scsi_cdb_length(buf);
>      char *line_buffer, *p;
>  
> +    if (len < 0) {
> +        trace_scsi_disk_new_request(lun, tag, "bad cdb length");

This is going to print:

"Command: lun=%d tag=0x%x data=bad cdb length"

which is maybe not the best. I'd rather print something more direct, but
it's probably better than actually rolling forward with len = -1.

Then again, this should literally never happen, because scsi_req_new is
parsing the cdb object and already rejecting such cases.

Can you satisfy the compiler by asserting that it is greater than zero?
It ought to be provably true.

--js

> +        return;
> +    }
>      line_buffer = g_malloc(len * 5 + 1);
>  
>      for (i = 0, p = line_buffer; i < len; i++) {
> 
