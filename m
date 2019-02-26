Received: from eggs.gnu.org ([209.51.188.92]:56980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyblM-0006wr-P3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyblG-0006qj-L4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyblF-0006nk-7r
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:02 -0500
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902252029.28990.randrianasulu@gmail.com>
	<6de6b2df-380a-75dd-b3e9-4197ca4db866@redhat.com>
	<201902261158.09086.randrianasulu@gmail.com>
	<e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
	<CAFEAcA8idrLohrWrieChU1Mm55NVaiEAXYQZEcNP5Dy2QjqeKg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a973e888-0a52-da7f-2885-dbb427b58f7e@redhat.com>
Date: Tue, 26 Feb 2019 13:16:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8idrLohrWrieChU1Mm55NVaiEAXYQZEcNP5Dy2QjqeKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26/02/2019 12.05, Peter Maydell wrote:
> On Tue, 26 Feb 2019 at 09:06, Thomas Huth <thuth@redhat.com> wrote:
>> Ok, then that's the problem here: GCC often produces some additional
>> "may be unused" warnings with -O3, and we normally only guarantee that
>> QEMU compiles without warnings when using the standard -O2 optimizatio=
n
>> level.
>> So if you want to compile with -O3, you also have to specify
>> --disable-werror (or add -Wno-error=3Dmaybe-unitialized to the CFLAGS)=
.
>> But unless you have really an urgent need for O3, I'd rather recommend
>> to compile with the well-tested O2 optimization level instead.
>=20
> I think in general we should probably look at fixing warnings
> that occur at -O3 when they're reported to us, even if we don't
> habitually build that way.

Have you ever tried building QEMU with -O3 (and --enable-werror)? That
list ist looong, e.g. here are just the warnings when compiling aarch64:

qemu/block/vmdk.c: In function =E2=80=98vmdk_open_vmdk4=E2=80=99:
qemu/block/vmdk.c:741:9: warning: =E2=80=98extent=E2=80=99 may be used un=
initialized in this function [-Wmaybe-uninitialized]
     ret =3D vmdk_init_tables(bs, extent, errp);
         ^
qemu/block/vmdk.c: In function =E2=80=98vmdk_open_sparse=E2=80=99:
qemu/block/vmdk.c:550:9: warning: =E2=80=98extent=E2=80=99 may be used un=
initialized in this function [-Wmaybe-uninitialized]
     ret =3D vmdk_init_tables(bs, extent, errp);
         ^
qemu/block/vmdk.c:529:17: note: =E2=80=98extent=E2=80=99 was declared her=
e
     VmdkExtent *extent;
                 ^
qemu/block/vmdk.c: In function =E2=80=98vmdk_open_desc_file.isra.15=E2=80=
=99:
qemu/block/vmdk.c:893:39: warning: =E2=80=98extent=E2=80=99 may be used u=
ninitialized in this function [-Wmaybe-uninitialized]
             extent->flat_start_offset =3D flat_offset << 9;
                                       ^
qemu/block/vmdk.c:823:17: note: =E2=80=98extent=E2=80=99 was declared her=
e
     VmdkExtent *extent;
                 ^
qemu/block/nbd-client.c: In function =E2=80=98nbd_co_request=E2=80=99:
qemu/block/nbd-client.c:608:8: warning: =E2=80=98local_reply.type=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
        ^
qemu/block/nbd-client.c:573:14: note: =E2=80=98local_reply.type=E2=80=99 =
was declared here
     NBDReply local_reply;
              ^
qemu/block/nbd-client.c:614:22: warning: =E2=80=98local_reply.flags=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->flags & NBD_REPLY_FLAG_DONE) {
                      ^
qemu/block/nbd-client.c:573:14: note: =E2=80=98local_reply.flags=E2=80=99=
 was declared here
     NBDReply local_reply;
              ^
qemu/block/nbd-client.c:601:8: warning: =E2=80=98local_reply.<U3390>.magi=
c=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitiali=
zed]
     if (nbd_reply_is_simple(reply) || s->quit) {
        ^
qemu/block/nbd-client.c:573:14: note: =E2=80=98local_reply.<U3390>.magic=E2=
=80=99 was declared here
     NBDReply local_reply;
              ^
qemu/block/nbd-client.c: In function =E2=80=98nbd_client_co_preadv=E2=80=99=
:
qemu/block/nbd-client.c:209:8: warning: =E2=80=98reply.length=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->length !=3D sizeof(offset) + sizeof(hole_size)) {
        ^
qemu/block/nbd-client.c:652:14: note: =E2=80=98reply.length=E2=80=99 was =
declared here
     NBDReply reply;
              ^
qemu/block/nbd-client.c:664:9: warning: =E2=80=98reply.type=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
         switch (chunk->type) {
         ^
qemu/block/nbd-client.c:652:14: note: =E2=80=98reply.type=E2=80=99 was de=
clared here
     NBDReply reply;
              ^
qemu/block/nbd-client.c:614:22: warning: =E2=80=98reply.flags=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->flags & NBD_REPLY_FLAG_DONE) {
                      ^
qemu/block/nbd-client.c:652:14: note: =E2=80=98reply.flags=E2=80=99 was d=
eclared here
     NBDReply reply;
              ^
qemu/block/nbd-client.c: In function =E2=80=98nbd_client_co_block_status=E2=
=80=99:
qemu/block/nbd-client.c:241:8: warning: =E2=80=98reply.length=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->length !=3D sizeof(context_id) + sizeof(*extent)) {
        ^
qemu/block/nbd-client.c:703:14: note: =E2=80=98reply.length=E2=80=99 was =
declared here
     NBDReply reply;
              ^
qemu/block/nbd-client.c:717:9: warning: =E2=80=98reply.type=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
         switch (chunk->type) {
         ^
qemu/block/nbd-client.c:703:14: note: =E2=80=98reply.type=E2=80=99 was de=
clared here
     NBDReply reply;
              ^
qemu/block/nbd-client.c:614:22: warning: =E2=80=98reply.flags=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
     if (chunk->flags & NBD_REPLY_FLAG_DONE) {
                      ^
qemu/block/nbd-client.c:703:14: note: =E2=80=98reply.flags=E2=80=99 was d=
eclared here
     NBDReply reply;
              ^
qemu/qobject/block-qdict.c: In function =E2=80=98qdict_array_split=E2=80=99=
:
qemu/qobject/block-qdict.c:259:25: warning: =E2=80=98subqdict=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
         qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
                         ^
qemu/hw/intc/i8259.c: In function =E2=80=98pic_read_irq=E2=80=99:
qemu/hw/intc/i8259.c:200:13: warning: =E2=80=98irq2=E2=80=99 may be used =
uninitialized in this function [-Wmaybe-uninitialized]
         irq =3D irq2 + 8;
             ^
qemu/migration/qemu-file.c: In function =E2=80=98qemu_get_buffer_in_place=
=E2=80=99:
qemu/migration/qemu-file.c:537:18: warning: =E2=80=98src=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]
             *buf =3D src;
                  ^
qemu/slirp/socket.c: In function =E2=80=98soread=E2=80=99:
qemu/slirp/socket.c:232:5: warning: =E2=80=98n=E2=80=99 may be used unini=
tialized in this function [-Wmaybe-uninitialized]
  if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
     ^
In file included from /usr/lib64/glib-2.0/include/glibconfig.h:9:0,
                 from /usr/include/glib-2.0/glib/gtypes.h:32,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from qemu/slirp/ip.h:36,
                 from qemu/slirp/slirp.h:50,
                 from qemu/slirp/socket.c:8:
qemu/slirp/socket.c: In function =E2=80=98soreadbuf=E2=80=99:
/usr/include/glib-2.0/glib/gmacros.h:300:39: warning: =E2=80=98iov.iov_le=
n=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitiali=
zed]
 #define MIN(a, b)  (((a) < (b)) ? (a) : (b))
                                       ^
qemu/slirp/socket.c:253:15: note: =E2=80=98iov.iov_len=E2=80=99 was decla=
red here
  struct iovec iov[2];
               ^
qemu/slirp/socket.c: In function =E2=80=98sorecvoob=E2=80=99:
qemu/slirp/socket.c:232:5: warning: =E2=80=98n=E2=80=99 may be used unini=
tialized in this function [-Wmaybe-uninitialized]
  if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
     ^
qemu/slirp/socket.c:175:6: note: =E2=80=98n=E2=80=99 was declared here
  int n, nn;
      ^
qemu/gdbstub.c: In function =E2=80=98gdb_handle_packet=E2=80=99:
qemu/gdbstub.c:1655:17: warning: =E2=80=98tid=E2=80=99 may be used uninit=
ialized in this function [-Wmaybe-uninitialized]
             cpu =3D gdb_get_cpu(s, pid, tid);
                 ^
qemu/gdbstub.c:1655:17: warning: =E2=80=98pid=E2=80=99 may be used uninit=
ialized in this function [-Wmaybe-uninitialized]
qemu/target/arm/translate-a64.c: In function =E2=80=98disas_simd_two_reg_=
misc_fp16=E2=80=99:
qemu/target/arm/translate-a64.c:12529:34: warning: =E2=80=98rmode=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
         tcg_rmode =3D tcg_const_i32(arm_rmode_to_sf(rmode));
                                  ^

IIRC, most of the time, GCC is just wrong, so I really
doubt that it is worth the effort to fix all of them ...

 Thomas
