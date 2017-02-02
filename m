Received: from eggs.gnu.org ([2001:4830:134:3::10]:45577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZMkV-0003Uk-3o
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cZMkR-0002bP-Ro
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:08:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cZMkR-0002aQ-Iu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:08:47 -0500
Date: Thu, 2 Feb 2017 21:08:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170202210558-mutt-send-email-mst@kernel.org>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
	<CAFEAcA9zEaATTwGLNCB=X_mhqjapC-0jxPpv8OjDt=zqaFBnjA@mail.gmail.com>
	<CAFEAcA_SCHQ06uON3pEgpt2ku4HO2C-fUTHr7TZAVmZ1PEq09Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_SCHQ06uON3pEgpt2ku4HO2C-fUTHr7TZAVmZ1PEq09Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] tci build failure (was Re:  [PULL v5 00/22] virtio,
 vhost, pci: fixes, features)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Feb 02, 2017 at 04:25:34PM +0000, Peter Maydell wrote:
> On 2 February 2017 at 13:56, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > On 31 January 2017 at 20:18, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >> virtio, vhost, pci: fixes, features
> >>
> >> generic pci root port support
> >> disable shpc by default
> >> safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
> >> fixes and cleanups all over the place
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> > Applied, thanks.
>=20
> ...travis builds now fail for the --enable-tcg-interpreter config:
> https://travis-ci.org/qemu/qemu/jobs/197648661
>=20
> In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c: In function =E2=80=
=98tcg_out_op=E2=80=99:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:117: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:255: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:115: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:255: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
>=20
> These look to be because we were trying to use ARRAY_SIZE()
> on a non-array, which was previously undetected. The use is
> only in an assert() so fairly harmless.
>=20
> Would somebody who cares about TCI like to provide a fix?
>=20
> thanks
> -- PMM

I think the following should do it. Completely untested.

-->

tcg/tci: fix ARRAY_SIZE misuse

tb_jmp_insn_offset and tb_jmp_reset_offset are
pointers, not arrays, so using ARRAY_SIZE on them will
not do the right thing.

They point to arrays within TranslationBlock so check
the size of these instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 26ee9b1..a2ba654 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -556,6 +556,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, =
const TCGArg *args,
                        const int *const_args)
 {
     uint8_t *old_code_ptr =3D s->code_ptr;
+    TranslationBlock *tb;
=20
     tcg_out_op_t(s, opc);
=20
@@ -566,7 +567,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, =
const TCGArg *args,
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
             /* Direct jump method. */
-            tcg_debug_assert(args[0] < ARRAY_SIZE(s->tb_jmp_insn_offset)=
);
+            tcg_debug_assert(args[0] < ARRAY_SIZE(tb->jmp_insn_offset));
             /* Align for atomic patching and thread safety */
             s->code_ptr =3D QEMU_ALIGN_PTR_UP(s->code_ptr, 4);
             s->tb_jmp_insn_offset[args[0]] =3D tcg_current_code_size(s);
@@ -575,7 +576,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, =
const TCGArg *args,
             /* Indirect jump method. */
             TODO();
         }
-        tcg_debug_assert(args[0] < ARRAY_SIZE(s->tb_jmp_reset_offset));
+        tcg_debug_assert(args[0] < ARRAY_SIZE(tb->jmp_reset_offset));
         s->tb_jmp_reset_offset[args[0]] =3D tcg_current_code_size(s);
         break;
     case INDEX_op_br:
