Received: from eggs.gnu.org ([2001:4830:134:3::10]:46319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme66-00030J-DQ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme62-0004BS-7W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dme61-0004A7-Tm
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:50:14 -0400
Date: Tue, 29 Aug 2017 18:50:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170829105007.GC8146@lemon>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-9-famz@redhat.com>
	<9113cbb5-f15d-7ce2-fdb0-3609ddb56837@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9113cbb5-f15d-7ce2-fdb0-3609ddb56837@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/10] Makefile: Add rules to run vm
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, 08/28 17:18, Philippe Mathieu-Daud=E9 wrote:
> On 08/28/2017 02:47 PM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   Makefile                  |  2 ++
> >   configure                 |  2 +-
> >   tests/vm/Makefile.include | 40 ++++++++++++++++++++++++++++++++++++=
++++
> >   3 files changed, 43 insertions(+), 1 deletion(-)
> >   create mode 100644 tests/vm/Makefile.include
> >=20
> > diff --git a/Makefile b/Makefile
> > index 81447b1f08..2798a5ca69 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -813,6 +813,7 @@ endif
> >   -include $(wildcard *.d tests/*.d)
> >   include $(SRC_PATH)/tests/docker/Makefile.include
> > +include $(SRC_PATH)/tests/vm/Makefile.include
> >   .PHONY: help
> >   help:
> > @@ -836,6 +837,7 @@ help:
> >   	@echo  'Test targets:'
> >   	@echo  '  check           - Run all tests (check-help for details)=
'
> >   	@echo  '  docker          - Help about targets running tests insid=
e Docker containers'
> > +	@echo  '  vm-test         - Help about targets running tests inside=
 VM'
> >   	@echo  ''
> >   	@echo  'Documentation targets:'
> >   	@echo  '  html info pdf txt'
> > diff --git a/configure b/configure
> > index dd73cce62f..9a3052e9ad 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6544,7 +6544,7 @@ if test "$ccache_cpp2" =3D "yes"; then
> >   fi
> >   # build tree in object directory in case the source is not in the c=
urrent directory
> > -DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos t=
ests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
> > +DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos t=
ests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
> >   DIRS=3D"$DIRS docs docs/interop fsdev"
> >   DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw=
"
> >   DIRS=3D"$DIRS roms/seabios roms/vgabios"
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > new file mode 100644
> > index 0000000000..6e133ae2a6
> > --- /dev/null
> > +++ b/tests/vm/Makefile.include
> > @@ -0,0 +1,40 @@
> > +# Makefile for VM tests
> > +
> > +.PHONY: vm-build-all
> > +
> > +IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd
> > +IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
> > +
> > +.PRECIOUS: $(IMAGE_FILES)
> > +
> > +vm-test:
> > +	@echo "vm-test: Test QEMU in preconfigured virtual machines"
> > +	@echo
> > +	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i38=
6 VM"
> > +	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM=
"
> > +	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
> > +	@echo "  vm-build-freebsd                - Build QEMU in OpenBSD VM=
"
>=20
> vm-build-openbsd ;)

Yes, thanks!

>=20
> is it possible to specify OS version?
>=20
> like "vm-build-ubuntu:16.04@i386" and having a default:
>=20
> "vm-build-ubuntu@i386" -> "vm-build-ubuntu:16.04@i386"

Maybe, when we do have more than one options. :)

Fam

>=20
> > +
> > +vm-build-all: $(addprefix vm-build-, $(IMAGES))
> > +
> > +tests/vm/%.img: $(SRC_PATH)/tests/vm/%
> > +	$(call quiet-command, \
> > +		$(SRC_PATH)/tests/vm/$* \
> > +		$(if $(V)$(DEBUG), --debug) \
> > +		--image "$@" \
> > +		--force \
> > +		--build-image $@, \
> > +		"  VM-IMAGE $*")
> > +
> > +
> > +# Build in VM $(IMAGE)
> > +vm-build-%: tests/vm/%.img
> > +	$(call quiet-command, \
> > +		$(SRC_PATH)/tests/vm/$* \
> > +		$(if $(V)$(DEBUG), --debug) \
> > +		$(if $(DEBUG), --interactive) \
> > +		$(if $(J),--jobs $(J)) \
> > +		--image "$<" \
> > +		--build-qemu $(SRC_PATH), \
> > +		"  VM-BUILD $*")
> > +
> >=20
>=20
