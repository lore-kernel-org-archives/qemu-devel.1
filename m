Received: from eggs.gnu.org ([2001:4830:134:3::10]:32785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd4gg-000352-Sb
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 22:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd4gc-0000sJ-3a
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 22:17:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fd4gb-0000sC-Ta
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 22:16:58 -0400
Date: Wed, 11 Jul 2018 10:16:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180711021654.GB1280@lemon.usersys.redhat.com>
References: <20180628153535.1411-1-f4bug@amsat.org>
	<20180628153535.1411-3-f4bug@amsat.org>
	<20180702071823.GJ26002@lemon.usersys.redhat.com>
	<fb49e069-e485-268d-6150-06910b416685@amsat.org>
	<5815c1eb-b5ef-a298-3267-be710e736a38@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5815c1eb-b5ef-a298-3267-be710e736a38@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] tests/vm: Add a dependency to qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Tue, 07/03 12:56, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 07/02/2018 12:19 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 07/02/2018 04:18 AM, Fam Zheng wrote:
> >> On Thu, 06/28 12:35, Philippe Mathieu-Daud=E9 wrote:
> >>> Before the first use, the VM image are resized with qemu-img.
> >>>
> >>> Add a dependency to the qemu-img tool to fix:
> >>>
> >>>   $ make vm-build-ubuntu.i386
> >>>   Traceback (most recent call last):
> >>>     File "source/qemu/tests/vm/basevm.py", line 236, in main
> >>>       return vm.build_image(args.image)
> >>>     File "tests/vm/ubuntu.i386", line 67, in build_image
> >>>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> >>>   OSError: [Errno 2] No such file or directory
> >>>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.=
i386.img' failed
> >>>   make: *** [tests/vm/ubuntu.i386.img] Error 2
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >>> ---
> >>>  tests/vm/Makefile.include | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> >>> index 5daa2a3b73..e5e8146267 100644
> >>> --- a/tests/vm/Makefile.include
> >>> +++ b/tests/vm/Makefile.include
> >>> @@ -17,10 +17,13 @@ vm-test:
> >>> =20
> >>>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
> >>> =20
> >>> +$(IMAGE_FILES): qemu-img$(EXESUF)
> >>
> >> No, please don't do this. Let's keep on supporting vm tests from a c=
lean source
> >> tree. Similar to qemu_bin, this can be handled in basevm.py.
> >=20
> > OK.
>=20
> The ubuntu.i386 VM is the only one using the qemu-img tool in his
> build_image() method implementation. Is it OK to add this check there?
> The basevm.build_image() is only an abstract method.

Maybe you can add a BaseVM.qemu_img() method that looks up for available
qemu-img on the system or build dir.

Fam

>=20
> >>> +
> >>>  tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
> >>>  		$(SRC_PATH)/tests/vm/basevm.py \
> >>>  		$(SRC_PATH)/tests/vm/Makefile.include
> >>>  	$(call quiet-command, \
> >>> +		PATH=3D$(PATH):. \
> >>>  		$< \
> >>>  		$(if $(V)$(DEBUG), --debug) \
> >>>  		--image "$@" \
> >>> --=20
> >>> 2.18.0
> >>>
> >>
