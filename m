Received: from eggs.gnu.org ([209.51.188.92]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqiX0-0003e1-1n
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqiWy-0003MQ-4N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:41 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqiWv-0003Fp-5D
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:38 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so1350972otl.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20190204142638.27021-1-mst@redhat.com>
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 17:59:16 +0000
Message-ID: <CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Feb 2019 at 14:43, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313=
b4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-02-01 17:58:27 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5feab30ea98e30446361d184331b7b5ff94b4116:
>
>   contrib/libvhost-user: cleanup casts (2019-02-04 09:23:56 -0500)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, cleanups, features
>
> vhost user blk discard/write zeroes features
> misc cleanups and fixes all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; I'm afraid this failed build/test on various platforms.


Format string issues on ppc64 host:

/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
=E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:636:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
         ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:636:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]


Compilation failure on 32-bit:

/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c: In
function 'vu_set_mem_table_exec_postcopy':
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:594:23:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         ret =3D madvise((void *)dev_region->mmap_addr,
                       ^
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:606:23:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         ret =3D madvise((void *)dev_region->mmap_addr,
                       ^
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:639:22:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         if (mprotect((void *)dev_region->mmap_addr,
                      ^


More format string issues on 32-bit:

/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c: In
function 'vub_readv':
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c:146:25:
error: format '%lu' expects argument of type 'long unsigned int', but
argument 5 has type 'size_t {aka unsigned int}' [-Werror=3Dformat=3D]
         fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with %s\n",
                         ^
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c: In
function 'vub_writev':
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c:169:25:
error: format '%lu' expects argument of type 'long unsigned int', but
argument 5 has type 'size_t {aka unsigned int}' [-Werror=3Dformat=3D]
         fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with %s\n",
                         ^
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c: In
function 'vub_discard_write_zeroes':
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c:188:25:
error: format '%ld' expects argument of type 'long int', but argument
3 has type 'ssize_t {aka int}' [-Werror=3Dformat=3D]
         fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*de=
sc));
                         ^
/home/peter.maydell/qemu/contrib/vhost-user-blk/vhost-user-blk.c:188:25:
error: format '%ld' expects argument of type 'long int', but argument
4 has type 'unsigned int' [-Werror=3Dformat=3D]


Compiler warning in a test case on the BSDs and OSX:

tests/vhost-user-test.c: In function 'main':
tests/vhost-user-test.c:942:17: warning: unused variable 'hugefs'
[-Wunused-variable]
     const char *hugefs;
                 ^


Test failures on sparc host due to an assert:

ERROR:/home/pm215/qemu/tests/vhost-user-test.c:243:wait_for_fds:
assertion failed: (s->fds_num)
Aborted

and the same on s390x, with a bit more detail:

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=3Dqemu-img tests/vhost-user-test -m=3Dquick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name=3D"vhost-user-test"
qemu-system-i386: backend does not support LE vnet headers; falling
back on userspace virtio
qemu-system-i386: backend does not support LE vnet headers; falling
back on userspace virtio
**
ERROR:/home/linux1/qemu/tests/vhost-user-test.c:243:wait_for_fds:
assertion failed: (s->fds_num)
Aborted (core dumped)
ERROR - too few tests run (expected 4, got 0)
/home/linux1/qemu/tests/Makefile.include:858: recipe for target
'check-qtest-i386' failed


New warnings about taking address of packed member on the clang
build: these aren't compile failures but we are very close to being
able to make them compile failures, so please don't add new ones:

/home/petmay01/linaro/qemu-for-merges/contrib/libvhost-user/libvhost-user.c=
:515:32:
warning: taking address
 of packed member 'payload' of class or structure 'VhostUserMsg' may
result in an unaligned pointer value [
-Waddress-of-packed-member]
    VhostUserMemory *memory =3D &vmsg->payload.memory;
                               ^~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/contrib/libvhost-user/libvhost-user.c=
:657:32:
warning: taking address
 of packed member 'payload' of class or structure 'VhostUserMsg' may
result in an unaligned pointer value [
-Waddress-of-packed-member]
    VhostUserMemory *memory =3D &vmsg->payload.memory;
                               ^~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/contrib/libvhost-user/libvhost-user.c=
:786:37:
warning: taking address
 of packed member 'payload' of class or structure 'VhostUserMsg' may
result in an unaligned pointer value [
-Waddress-of-packed-member]
    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
                                    ^~~~~~~~~~~~~~~~~~


Compile error on the clang build:

/home/petmay01/linaro/qemu-for-merges/contrib/libvhost-user/libvhost-user.c=
:953:20:
error: implicit conversion from enumeration type 'enum
VhostUserSlaveRequest' to different enumeration type
'VhostUserRequest' (aka 'enum VhostUserRequest')
[-Werror,-Wenum-conversion]
        .request =3D VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


thanks
-- PMM
