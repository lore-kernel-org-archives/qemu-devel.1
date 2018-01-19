Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecY5V-0000sa-2T
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecY5R-0002nU-3u
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:13 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ecY5Q-0002nH-Vr
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:09 -0500
Received: by mail-qt0-f182.google.com with SMTP id o35so4359394qtj.13
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:56:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151637257830.599.12053715954868331479@5adcb62bf0d6>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<151637257830.599.12053715954868331479@5adcb62bf0d6>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 19 Jan 2018 15:56:07 +0100
Message-ID: <CAMxuvawiLgNL9UGORr2chS7m6YqckB+UuSPh4Gk5iuzx_wGrtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tpm: CRB device and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: marcandre <marcandre.lureau@redhat.com>, famz@redhat.com, stefanb@linux.vnet.ibm.com

On Fri, Jan 19, 2018 at 3:36 PM,  <no-reply@patchew.org> wrote:
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c: In function 'tpm_crb_mmio_read':
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:126:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>      DPRINTF("CRB read 0x%lx:%s len:%u\n",
>              ^
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>              printf(fmt, ## __VA_ARGS__);        \
>                     ^~~
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c: In function 'tpm_crb_mmio_write':
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:146:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>      DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
>              ^
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>              printf(fmt, ## __VA_ARGS__);        \
>                     ^~~
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:146:13: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
>              ^
> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>              printf(fmt, ## __VA_ARGS__);        \
>                     ^~~

This will fix it:
Stefan feel free to squash it if no further changes required

--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -123,7 +123,7 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
     CRBState *s = CRB(opaque);
-    DPRINTF("CRB read 0x%lx:%s len:%u\n",
+    DPRINTF("CRB read 0x" TARGET_FMT_plx ":%s len:%u\n",
             addr, addr_desc(addr), size);
     void *regs = (void *)&s->regs + addr;

@@ -143,7 +143,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     CRBState *s = CRB(opaque);
-    DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
+    DPRINTF("CRB write 0x" TARGET_FMT_plx ":%s len:%u val:%" PRIu64 "\n",
             addr, addr_desc(addr), size, val);

     switch (addr) {
