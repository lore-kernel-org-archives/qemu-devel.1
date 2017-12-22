Received: from eggs.gnu.org ([2001:4830:134:3::10]:60755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eSPDC-0003If-RS
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eSPD8-0001Es-QF
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:14 -0500
Received: from mail-db5eur01hn0233.outbound.protection.outlook.com
	([104.47.2.233]:20611
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eSPD8-0001Do-3l
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:10 -0500
Date: Fri, 22 Dec 2017 18:25:53 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171222152552.GC2347@rkaganb.sw.ru>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<1513790098-9815-33-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513790098-9815-33-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 32/46] scsi: provide general-purpose
 functions to manage sense data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Dec 20, 2017 at 06:14:44PM +0100, Paolo Bonzini wrote:
> @@ -274,52 +319,21 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
>  int scsi_convert_sense(uint8_t *in_buf, int in_len,
>                         uint8_t *buf, int len, bool fixed)
>  {
> -    bool fixed_in;
>      SCSISense sense;
> -    if (!fixed && len < 8) {
> -        return 0;
> -    }
> -
> -    if (in_len == 0) {
> -        sense.key = NO_SENSE;
> -        sense.asc = 0;
> -        sense.ascq = 0;
> -    } else {
> -        fixed_in = (in_buf[0] & 2) == 0;
> -
> -        if (fixed == fixed_in) {
> -            memcpy(buf, in_buf, MIN(len, in_len));
> -            return MIN(len, in_len);
> -        }
> +    bool fixed_in;
>  
> -        if (fixed_in) {
> -            sense.key = in_buf[2];
> -            sense.asc = in_buf[12];
> -            sense.ascq = in_buf[13];
> -        } else {
> -            sense.key = in_buf[1];
> -            sense.asc = in_buf[2];
> -            sense.ascq = in_buf[3];
> -        }
> +    fixed_in = (in_buf[0] & 2) == 0;
> +    if (in_len && fixed == fixed_in) {
> +        memcpy(buf, in_buf, MIN(len, in_len));
> +        return MIN(len, in_len);

This reliably segfaults with any scsi disk because
scsi_disk_emulate_command passes in_buf=NULL here:

    case REQUEST_SENSE:
        /* Just return "NO SENSE".  */
        buflen = scsi_convert_sense(NULL, 0, outbuf, r->buflen,
                                    (req->cmd.buf[1] & 1) == 0);

Roman.
