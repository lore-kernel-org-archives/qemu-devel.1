Received: from eggs.gnu.org ([2001:4830:134:3::10]:55893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8r3F-0007aw-Ss
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d8r3C-0007EM-1n
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:53 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:35474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1d8r3B-0007EC-TY
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:34:49 -0400
Received: by mail-qt0-x235.google.com with SMTP id v27so9337620qtg.2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 09:34:49 -0700 (PDT)
Date: Thu, 11 May 2017 12:34:47 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170511163447.GA7785@morn.lan>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com

On Thu, May 11, 2017 at 05:32:47PM +0200, Paolo Bonzini wrote:
> On 11/05/2017 16:53, Kevin O'Connor wrote:
> > On Thu, May 11, 2017 at 01:35:28PM +0200, Paolo Bonzini wrote:
> >> Ignore env->a20_mask when running in system management mode.
> > 
> > Thanks Paolo.  I don't think this patch will help SeaBIOS though.  The
> > SeaBIOS SMM handler doesn't do much - it doesn't even access ram above
> > 1MiB.  See SeaBIOS' code in src/fw/smm.c:handle_smi().
> > 
> > Instead, the SeaBIOS code does a cpu state backup/restore to switch
> > into 32bit mode.  I thought the A20 state would be part of that cpu
> > backup/restore.  However, looking at the Intel SDM docs now, it's not
> > really clear to me how the processor "inhibits" A20 when in SMM mode -
> > does it save/restore that state on SMI/RSM or does it have special
> > logic to ignore A20 while in SMM mode?
> 
> There isn't any documented place for A20 in the state save map (I checked
> AMD's BIOS/Kernel Developer Guide which is pretty comprehensive), so I
> think the latter is more plausible.  What I'm doing in this patch is
> ignoring A20 while in SMM mode.

Okay.

> Then you would have to add an A20 save/restore in handle_smi; since 
> CALL32SMM_ENTERID should not nest, I think you can just do this:

Yes, that should be fine.

> --- a/src/fw/smm.c
> +++ b/src/fw/smm.c
> @@ -54,7 +54,8 @@ struct smm_layout {
>      struct smm_state backup2;
>      u8 stack[0x7c00];
>      u64 codeentry;
> -    u8 pad_8008[0x7df8];
> +    u8 a20;
> +    u8 pad_8009[0x7df7];
>      struct smm_state cpu;
>  };

In order to avoid mixing code and data in the same cache line we could
do this instead:

 struct smm_layout {
     struct smm_state backup1;
     struct smm_state backup2;
-    u8 stack[0x7c00];
+    u32 backup_a20;
+    u8 stack[0x8000 - sizeof(struct smm_state)*2 - sizeof(u32)];
     u64 codeentry;
     u8 pad_8008[0x7df8];
     struct smm_state cpu;

Thanks,
-Kevin
