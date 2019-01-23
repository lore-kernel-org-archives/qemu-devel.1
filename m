Received: from eggs.gnu.org ([209.51.188.92]:50934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmGMh-0006U6-1L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmGMa-0000Zz-QP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:06:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmGMY-0000Wb-Tg
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:06:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so1927952wrp.3
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:06:26 -0800 (PST)
Date: Wed, 23 Jan 2019 12:06:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190123110622.5lnxx537wrqg6fgt@steredhat>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9zA3xo9h=2+LBZ4_38kk8D3CnSS1reWyexc0JpCLfcXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9zA3xo9h=2+LBZ4_38kk8D3CnSS1reWyexc0JpCLfcXA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/49] Misc patches for 2019-01-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 22, 2019 at 05:19:09PM +0000, Peter Maydell wrote:
> On Mon, 21 Jan 2019 at 18:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit cce871c504694cf1034adf525556e3ca3c7eebb6:
> >
> >   hw/block/xen: use proper format string for printing sectors (2019-01-21 14:45:49 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 6ba20c9c9515dfcf22f5e0d0b7628041b6b183f0:
> >
> >   docker: disable Xen on CentOS 7 (2019-01-21 18:39:47 +0100)
> >
> > ----------------------------------------------------------------
> > * cpu-exec fixes (Emilio, Laurent)
> > * high address load for linuxboot (Zhijian)
> > * PVH support (Liam, Stefano)
> > * Linux header update (Paolo)
> > * enable vhost-net for all targets that have virtio-net (Paolo)
> > * vhost-user-test cleanups (Paolo)
> > * misc i386 changes (Paolo, Robert)
> > * hexloader-test change to avoid O_NONBLOCK on stdin (Peter)
> > * configure tweak for openpty (Thomas)
> > * elf2dmp port to Windows (Viktor)
> >
> > ----------------------------------------------------------------
> 
> Compile failure, x86-64 clang build:
> 
>   CC      optionrom/pvh_main.o
> In file included from
> /home/petmay01/linaro/qemu-for-merges/pc-bios/optionrom/pvh_main.c:26:
> /home/petmay01/linaro/qemu-for-merges/pc-bios/optionrom/optrom.h:79:18:
> error: invalid operand f
> or instruction
>     asm volatile("rep insb (%%dx), %%es:(%%edi)"
>                  ^
> <inline asm>:1:11: note: instantiated into assembly here
>         rep insb (%dx), %es:(%edi)
>                  ^~~~~~
> 
> thanks
> -- PMM
> 

This patch should fix the failure with clang, leaving the behaviour
unchanged.

diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
index 1e5e265d4f..357819259a 100644
--- a/pc-bios/optionrom/optrom.h
+++ b/pc-bios/optionrom/optrom.h
@@ -76,7 +76,7 @@ static inline uint32_t inl(uint16_t port)
 
 static inline void insb(uint16_t port, uint8_t *buf, uint32_t len)
 {
-    asm volatile("rep insb (%%dx), %%es:(%%edi)"
+    asm volatile("rep insb %%dx, %%es:(%%edi)"
                  : "+c"(len), "+D"(buf) : "d"(port) : "memory");
 

Thanks,
Stefano
