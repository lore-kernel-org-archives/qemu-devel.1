Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI8Nh-0001ng-TD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 02:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI8Nd-0001cl-EI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 02:54:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
Date: Tue, 06 Jun 2017 08:54:08 +0200
In-Reply-To: <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com> (Kamil
	Rytarowski's message of "Mon, 5 Jun 2017 16:52:16 +0200")
Message-ID: <877f0p38tr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, peter.maydell@redhat.com, f4bug@amsat.org

Kamil Rytarowski <n54@gmx.com> writes:

> On 05.06.2017 16:29, Michael Tokarev wrote:
>> 31.05.2017 15:00, Kamil Rytarowski wrote:
>>> Currently ivshmem requires eventfd() which is Linux specific.
>>> Do not and build it unconditionally on every Linux/BSD/Solaris.
>>>
>>> This patch indirectly fixes build failure on NetBSD, where these tools
>>> additionally require -lrt for shm_open(3). In future there should be
>>> added support for NetBSD and the linking addressed appropriately.
>>=20
>> Unfortunately this breaks static build.
>>=20
>> $ ../configure --disable-system --disable-linux-user --static
>> $ make V=3D1
>> ...
>> c++ -I/usr/include/pixman-1  -Werror -pthread -I/usr/include/glib-2.0 -I=
/usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredun=
dant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-nega=
tive-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-st=
yle-declaration -Wold-style-definition -Wtype-limits -fstack-protector-stro=
ng
>> -I/usr/include/libpng16 -I/build/qemu/git/tests -O2 -U_FORTIFY_SOURCE -D=
_FORTIFY_SOURCE=3D2 -g  -Wl,--warn-common -m64 -static -g  -o ivshmem-server
>> libqemuutil.a libqemustub.a   -lm -lgthread-2.0 -pthread -lglib-2.0 -pth=
read -lpcre -pthread  -lz -lrt -lz -lnettle  -lutil
>> /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/crt1.o: In fun=
ction `_start':
>> (.text+0x20): undefined reference to `main'
>> collect2: error: ld returned 1 exit status
>> Makefile:475: error building =C2=ABivshmem-server=C2=BB
>> $ _
>>=20
>> I'll take a look at this later. reverting it for now.
>>=20
>> Thanks,
>>=20
>> /mjt
>>=20
>
> I will try to reproduce it locally.

I haven't, but here's a quick guess on what we need to squash into the
patch:

diff --git a/Makefile b/Makefile
index c830d7a..2ef5a78 100644
--- a/Makefile
+++ b/Makefile
@@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
=20
+ifdef CONFIG_IVSHMEM
 ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
+endif
=20
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3df..ab70d01 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -203,7 +203,7 @@ gcov-files-pci-y +=3D hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) +=3D hw/display/virtio-vga.c
 check-qtest-pci-y +=3D tests/intel-hda-test$(EXESUF)
 gcov-files-pci-y +=3D hw/audio/intel-hda.c hw/audio/hda-codec.c
-check-qtest-pci-$(CONFIG_EVENTFD) +=3D tests/ivshmem-test$(EXESUF)
+check-qtest-pci-$(CONFIG_IVSHMEM) +=3D tests/ivshmem-test$(EXESUF)
 gcov-files-pci-y +=3D hw/misc/ivshmem.c
=20
 check-qtest-i386-y =3D tests/endianness-test$(EXESUF)
