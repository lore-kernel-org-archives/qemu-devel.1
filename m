Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47FX-0002A1-U6
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47FU-0005Mb-ST
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:56:32 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f47FU-0005MH-KC
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:56:28 -0400
Received: by mail-wr0-x229.google.com with SMTP id y55so29253647wry.3
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:56:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bb77420-4a76-6a1b-3542-4205fcc8334b@redhat.com>
Date: Thu, 5 Apr 2018 17:56:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 27/03/2018 23:14, Daniel Henrique Barboza wrote:
>          /* We get here only for BYTCHK == 0x01 and only for scsi-block.
>           * As far as DMA is concerned, we can treat it the same as a write;
>           * scsi_block_do_sgio will send VERIFY commands.
> +         *
> +         * For scsi versions 2 and older, the BYTCHK isn't related
> +         * to VRPROTECT (in fact, there is no VRPROTECT). Skip
> +         * this check in these versions.
>           */
> -        if (r->req.cmd.buf[1] & 0xe0) {
> +        if ((r->req.cmd.buf[1] & 0xe0) && (s->qdev.scsi_version > 2)) {
>              goto illegal_request;
>          }

This also has to check for "s->qdev.scsi_version != -1" so that the
behavior of emulated SCSI isn't changed (they claim SPC-3).  I made this
change and queued the patch.

Paolo
