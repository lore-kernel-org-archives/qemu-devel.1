Received: from eggs.gnu.org ([209.51.188.92]:50574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gjABh-00086C-MK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gjABg-0005k1-BU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:54:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gjABg-0005jm-1k
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:54:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id j2so701946wrw.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 13:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
	<154743580351.25737.15317721560138541527@2d170d368aaa>
	<20190114071815.lcvod3nr5vr5usqs@function>
In-Reply-To: <20190114071815.lcvod3nr5vr5usqs@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Jan 2019 01:54:15 +0400
Message-ID: <CAJ+F1CL-M7YWE9Oj2yp=65jSfGx28hkMqD9BJsH9KE6MVuMFKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv2 00/65] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: QEMU <qemu-devel@nongnu.org>, fam@euphon.net, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Mon, Jan 14, 2019 at 11:19 AM Samuel Thibault
<samuel.thibault@gnu.org> wrote:
>
> no-reply@patchew.org, le dim. 13 janv. 2019 19:16:44 -0800, a ecrit:
> > This series failed the docker-mingw@fedora build test. Please find the =
testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> > The full log is available at
> > http://patchew.org/logs/20190114000326.29847-1-samuel.thibault@ens-lyon=
.org/testing.docker-mingw@fedora/?type=3Dmessage.
>
> make[1]: *** No rule to make target '../slirp/arp_table.o', needed by 'qe=
mu-system-aarch64w.exe'.  Stop.

Build failure when building entirely outside of QEMU source tree, it
needs to have correct dependency set on SUBDIR_RULES targets. Please
squash in "build-sys: use a seperate slirp-obj-y && slirp.mo":

diff --git a/Makefile b/Makefile
index a9ac16d94e8..dccba1dca27 100644
--- a/Makefile
+++ b/Makefile
@@ -379,7 +379,8 @@ dummy :=3D $(call unnest-vars,, \
                 ui-obj-m \
                 audio-obj-y \
                 audio-obj-m \
-                trace-obj-y)
+                trace-obj-y \
+                slirp-obj-y)

 include $(SRC_PATH)/tests/Makefile.include

@@ -452,7 +453,7 @@ CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
 subdir-capstone: .git-submodule-status
        $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone
CAPSTONE_SHARED=3Dno BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)"
AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)"
$(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))

-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y)
$(slirp-obj-y) \
        $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))

--=20
Marc-Andr=C3=A9 Lureau
