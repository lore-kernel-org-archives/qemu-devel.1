Received: from eggs.gnu.org ([2001:4830:134:3::10]:37915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9Jpz-00023Q-OW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9Jpw-0008W6-Ir
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:19:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:49779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d9Jpw-0008Uv-8A
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:19:04 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Fri, 12 May 2017 23:19:00 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
In-Reply-To: <20170512193840.GA22454@morn.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

wrote:
> > On 12/05/2017 20:55, Xu, Anthony wrote:
> > > If that's the case,  QEMU/TCG should work with SeaBios even with
> ignoring A20.
> > >
> > > During SeaBios boot, there are >350 port 92 access, if we don't need =
to
> handle A20,
> > > we can make A20 configurable in Seabios, It may reduce SeaBios boot
> time.
> >
> > Yes, that's a good idea.
>=20
> SeaBIOS defaults to enabling A20 and it's a rare beast that disables
> it.  One could change x86.h:set_a20 and romlayout.S:transition32 to
> only issue the outb() if the inb() indicates a change is needed.  That
> would likely eliminate half the accesses.

The 350 port 92 access is for write operation only.
If include the inb(), it would be 700, and every time it actually has a cha=
nge
To be precise, It is about 175 switches from 32 bit to 16 bit, then back to=
 32 bit.
call16 is called 175 times during Seabios boot without any option rom,
It would be more if some option roms are included.


I think A20 is disabled by default in SeaBios.
Call16Data.a20 is initialized to 0,
call16_override may set Call16Data.a20 to 1,
call16 called before call16_override would disable and enable A20.

BTW, A20 is enabled in QEMU by default.



>=20
> I'd be surprised if it would impact the overall boot time though.
> SeaBIOS only touches the port on a cpu mode switch and I would have
> thought that was heavier than an IO port access.  Maybe that is skewed
> on KVM though.

Maybe not, but if we have more these kind  of optimizations , we may see th=
e impact.
A20 is already configurable in SeaBios,  CONFIG_DISABLE_A20.
Then the change is very small. No PORT_A20 access after the change.


-Anthony


diff --git a/src/x86.h b/src/x86.h
index a770e6f..8efb94a 100644
--- a/src/x86.h
+++ b/src/x86.h
@@ -21,6 +21,7 @@
 #ifndef __ASSEMBLY__

 #include "types.h" // u32
+#include "../out/autoconf.h"

 static inline void irq_disable(void)
 {
@@ -254,13 +255,19 @@ static inline void lgdt(struct descloc_s *desc) {
 }

 static inline u8 get_a20(void) {
-    return (inb(PORT_A20) & A20_ENABLE_BIT) !=3D 0;
+    if (CONFIG_DISABLE_A20) {
+        return (inb(PORT_A20) & A20_ENABLE_BIT) !=3D 0;
+    }
+    return 1;
 }

 static inline u8 set_a20(u8 cond) {
-    u8 val =3D inb(PORT_A20);
-    outb((val & ~A20_ENABLE_BIT) | (cond ? A20_ENABLE_BIT : 0), PORT_A20);
-    return (val & A20_ENABLE_BIT) !=3D 0;
+    if (CONFIG_DISABLE_A20) {
+        u8 val =3D inb(PORT_A20);
+        outb((val & ~A20_ENABLE_BIT) | (cond ? A20_ENABLE_BIT : 0), PORT_A=
20);
+        return (val & A20_ENABLE_BIT) !=3D 0;
+    }
+    return 1;
 }
