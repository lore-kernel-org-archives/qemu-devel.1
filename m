Received: from eggs.gnu.org ([2001:4830:134:3::10]:51721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYfKl-0002uf-QG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYfKi-0004ak-MO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:51:55 -0500
Received: from bart.luffy.cx ([78.47.78.131]:47774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1eYfKi-0004Xy-7l
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:51:52 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
Date: Mon, 08 Jan 2018 22:51:48 +0100
In-Reply-To: <20180108211623.GJ6646@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 8 Jan 2018 19:16:23 -0200")
Message-ID: <m3d12k9fyj.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

 =E2=9D=A6  8 janvier 2018 19:16 -0200, Eduardo Habkost <ehabkost@redhat.co=
m>=C2=A0:

> One possible way to work around this problem is to declare that
> QEMU 2.12 with KVM will require Linux v3.6 and newer (because we
> need Linux kernel commit ad756a1603c5 "KVM: VMX: Implement
> PCID/INVPCID for guests with EPT").  I have proposed something
> similar to allow us to enable kvm_pv_eoi by default, some time
> ago:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html
> ("qemu-doc: Document minimum kernel version for KVM in x86_64").

I don't see a way to probe KVM to know what's supported, so yes. Should
I add a paragraph similar to yours or would your patch be merged soon?
What are the consequences of running a too old kernel? Would KVM just
hide PCID flag?

> Second, we need compatibility entries setting pcid=3Doff on
> PC_COMPAT_2_10 so we don't break compatibility on older
> machine-types.

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6f77eb066587..da5bd8304eb0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,6 +327,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_=
t *);
         .driver   =3D TYPE_X86_CPU,\
         .property =3D "x-hv-max-vps",\
         .value    =3D "0x40",\
+    },{\
+        .driver   =3D "SandyBridge-" TYPE_X86_CPU,\
+        .property =3D "pcid",\
+        .value    =3D "off",\
+    },{\
+        .driver   =3D "IvyBridge-" TYPE_X86_CPU,\
+        .property =3D "pcid",\
+        .value    =3D "off",\
     },{\
         .driver   =3D "i440FX-pcihost",\
         .property =3D "x-pci-hole64-fix",\

I'll resend a proper patch once the first point is cleared.
--=20
Make sure input cannot violate the limits of the program.
            - The Elements of Programming Style (Kernighan & Plauger)
