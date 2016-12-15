Received: from eggs.gnu.org ([2001:4830:134:3::10]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHTil-0000s3-PE
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHTig-0000tp-Vg
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:57:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHTig-0000pk-Pa
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:57:02 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so5682420wme.2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 02:57:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1481796182-12670-1-git-send-email-vlad.lungu@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eee151e4-7cb6-eb26-a125-65757ec84e2e@redhat.com>
Date: Thu, 15 Dec 2016 11:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <1481796182-12670-1-git-send-email-vlad.lungu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, rth@twiddle.net



On 15/12/2016 11:03, Vlad Lungu wrote:
>  
>      if (initrd_filename) {
> -        char *next_initrd, not_last;
> +        char *next_initrd, not_last, tmpbuf[strlen(initrd_filename) + 1];
>  
>          mbs.offset_mods = mbs.mb_buf_size;
>  
> @@ -299,22 +299,24 @@ int load_multiboot(FWCfgState *fw_cfg,
>              next_initrd = (char *)get_opt_value(NULL, 0, initrd_filename);
>              not_last = *next_initrd;
>              *next_initrd = '\0';
> +            /* Unescape the filename + eventual arguments */
> +            get_opt_value(tmpbuf, strlen(initrd_filename) + 1, initrd_filename);

No need to call get_opt_value twice; you can call it once since you have
declared tmpbuf to hold the entire size of initrd_filename.

Also, the second argument of get_opt_value can be sizeof(tmpbuf) or
ARRAY_SIZE(tmpbuf), as you prefer.

Paolo
