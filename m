Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cUVmc-0004JZ-9P
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cUVmY-0003U9-3x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:58 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:33980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cUVmX-0003O2-O4
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:54 -0500
Date: Fri, 20 Jan 2017 10:46:35 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20170120094635.GA28338@olga.wb>
References: <1476776717-24807-1-git-send-email-ppandit@redhat.com>
	<CAJ+F1CKnyE1d8nT_dj2D5St=2e9+W5Zx0zvXGxPDsOsg1NW66w@mail.gmail.com>
	<alpine.LFD.2.20.1611281003090.19776@wniryva>
	<20170111145934.nogaszs5gvmn5bad@perseus.local>
	<1484167421.26755.10.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484167421.26755.10.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] display: cirrus: check vga bits per
 pixel(bpp) value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Huawei PSIRT <psirt@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

On Wed, Jan 11, 2017 at 09:43:41PM +0100, Gerd Hoffmann wrote:
> On Mi, 2017-01-11 at 16:59 +0200, Alberto Garcia wrote:
> > On Mon, Nov 28, 2016 at 11:52:08AM +0530, P J P wrote:
> > > | > --- a/hw/display/cirrus_vga.c
> > > | > +++ b/hw/display/cirrus_vga.c
> > > | > @@ -272,6 +272,9 @@ static void cirrus_update_memory_access(CirrusVGAState
> > > | > *s);
> > > | >  static bool blit_region_is_unsafe(struct CirrusVGAState *s,
> > > | >                                    int32_t pitch, int32_t addr)
> > > | >  {
> > > | > +    if (!pitch) {
> > > | > +        return true;
> > > | > +    }
> > > | >
> > > | 
> > > | That doesn't look directly related to 'cirrus_get_bpp', care to explain?
> > > 
> > >   'blit_region_is_unsafe' is called from 'blit_is_unsafe' to check if blit 
> > > parameters (cirrus_blt_srcpitch/cirrus_blt_dstpitch)  are safe for 
> > > 'cirrus_do_copy'. These too could lead to div by zero in cirrus_do_copy
> > 
> > This change is causing display artifacts in QEMU 2.8.
> > 
> > What seems to happen is that blit_is_unsafe() is also called for
> > CIRRUS_BLTMODE_PATTERNCOPY, but in this case cirrus_blt_srcpitch is
> > not used. However, because of this new check if its value is 0 then
> > cirrus_bitblt_common_patterncopy() returns early and becomes a no-op.
> 
> inflight vga queue pull request has a fix for that.

Do you mean:
 [PATCH] display: cirrus: ignore source pitch value as needed in blit_is_unsafe
 (Message-Id: <20170109203520.5619-1-brogers@suse.com>)

Because I'm still seeing artifacts on some setups (eg. on win XP).
As far as I can tell the check is still too strong:
The rops used by cirrus_bitblt_common_patterncopy seem to only be using
the destination pitch as far as I can see (all functions in
cirrus_vga_rop2.h) and in my tests only the destination pitch got
filled in, the source pitch was left as zero. Adapting the check when
coming from cirrus_bitblt_common_patterncopy seems to fix the issue for
me.

Additionally (but this didn't have any visible effect in my test (and
shouldn't)) the cirrus_fill rops called from cirrus_bitblt_solidfill
don't actually divide by the pitch (as far as I can see) but just add
it to their destination offset (cirrus_vga_rop2.h around line 276?),
not sure if it makes sense to change how this is handled at all as a
zero pitch there would IMO produce artifacts with or without the check.
I just thought I'd point it out in case someone wanted to know.

What do you think of the patch below? (Applied on top of both other
patches)?

It could definitely use some auditing to see if I missed any of the
code paths, since it involves a bunch of function pointers fetched from
lists depending on parameters. Here's a debug print showing the
situtation in cirrus_bitblt_common_patterncopy() when the artifacts
occured:

    s->cirrus_blt_mode               = 0xc0,
    s->cirrus_blt_modeext            = 0x00,
      Inferred use of s->vga.gr[0x32] from above values:
    rop_to_index[s->vga.gr[0x32]]    = 5
      (should be ROP2(cirrus_colorexpand_pattern_src) ?)
    s->cirrus_blt_pixelwidth         = 2
    s->cirrus_blt_width              = 1242
    s->cirrus_blt_height             = 27
    s->cirrus_blt_srcpitch           = 0      <-- culprit
    s->cirrus_blt_dstpitch           = 2560


---- 8< ----

>From a3be50cc3e3bb0f5eb784d30048b88333366bdca Mon Sep 17 00:00:00 2001
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Fri, 20 Jan 2017 09:44:39 +0100
Subject: [PATCH] cirrus: allow zero source pitch in pattern fill rops

The rops used by cirrus_bitblt_common_patterncopy only use
the destination pitch, so the source pitch shoul allowed to
be zero.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
 hw/display/cirrus_vga.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..c2fce8c 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -272,9 +272,6 @@ static void cirrus_update_memory_access(CirrusVGAState *s);
 static bool blit_region_is_unsafe(struct CirrusVGAState *s,
                                   int32_t pitch, int32_t addr)
 {
-    if (!pitch) {
-        return true;
-    }
     if (pitch < 0) {
         int64_t min = addr
             + ((int64_t)s->cirrus_blt_height-1) * pitch;
@@ -294,7 +291,7 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     return false;
 }
 
-static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
+static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only, bool zero_src_pitch_ok)
 {
     /* should be the case, see cirrus_bitblt_start */
     assert(s->cirrus_blt_width > 0);
@@ -304,6 +301,10 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
         return true;
     }
 
+    if (!s->cirrus_blt_dstpitch) {
+        return true;
+    }
+
     if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
                               s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {
         return true;
@@ -311,6 +312,11 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
     if (dst_only) {
         return false;
     }
+
+    if (!zero_src_pitch_ok && !s->cirrus_blt_srcpitch) {
+        return true;
+    }
+
     if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
                               s->cirrus_blt_srcaddr & s->cirrus_addr_mask)) {
         return true;
@@ -676,8 +682,9 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
 
     dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
 
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, true)) {
         return 0;
+    }
 
     (*s->cirrus_rop) (s, dst, src,
                       s->cirrus_blt_dstpitch, 0,
@@ -694,7 +701,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 {
     cirrus_fill_t rop_func;
 
-    if (blit_is_unsafe(s, true)) {
+    if (blit_is_unsafe(s, true, true)) {
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
@@ -798,7 +805,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
 static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
 {
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, false))
         return 0;
 
     return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-- 
2.1.4
