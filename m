Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAJI-0000fV-Nt
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAJH-0005w3-AD
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEAJH-0005v8-0I
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so2283297wrq.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 03:18:26 -0700 (PDT)
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-12-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c093a13c-efa6-caa0-8c16-b889ef30e775@redhat.com>
Date: Wed, 10 Apr 2019 12:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-12-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 11/12] Makefile: install the
 edk2 firmware images and their descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> Decompress and install the edk2 firmware blobs as part of "make install",
> unless blob installation was disabled with configure's "--disable-blobs"
> option.
> 
> Additionally, decompress the blobs as a pre-requisite for building softmmu
> binaries -- this is helpful for both "make check" and other ad-hoc tests
> one might want to run in the build directory.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Note that this job (with install) on Travis takes <30min:
https://travis-ci.org/philmd/qemu/jobs/518117217

> ---
> 
> Notes:
>     v4:
>     
>     - no change
>     
>     v3:
>     
>     - pick up Michal's R-b
>     
>     - pick up Phil's R-b
>     
>     - pick up Michael's R-b
>     
>     - Decompress fd.bz2 files with bzip2 rather than fd.xz files with xz, so
>       that decompression at "make install" time succeed on older build OSes
>       too [Peter]. Note that "BUNZIP2" matches the name of the actual
>       command "bunzip2" (i.e. it is sensible), and that it consists of 7
>       characters, satisfying the quiet-command limit.
>     
>     - do not pick up Phil's T-b, consequently
>     
>     - do not pick up Igor's T-b for the same reason
>     
>     v2:
>     
>     - adapt to tracking the edk2 flash device files in compressed form [Dan,
>       Michael, Phil]
>     
>     - do not pick up Michal's and Michael's R-b's due to the above change
> 
>  configure  |  1 +
>  Makefile   | 29 +++++++++++++++++++-
>  .gitignore |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a70276a..e1ad87b697e0 100755
> --- a/configure
> +++ b/configure
> @@ -7892,6 +7892,7 @@ for bios_file in \
>      $source_path/pc-bios/*.img \
>      $source_path/pc-bios/openbios-* \
>      $source_path/pc-bios/u-boot.* \
> +    $source_path/pc-bios/edk2-*.fd.bz2 \
>      $source_path/pc-bios/palcode-*
>  do
>      LINKS="$LINKS pc-bios/$(basename $bios_file)"
> diff --git a/Makefile b/Makefile
> index 04a0d4505085..626a04d305cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,6 +296,10 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile
>  $(KEYCODEMAP_GEN): .git-submodule-status
>  $(KEYCODEMAP_CSV): .git-submodule-status
>  
> +edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
> +pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
> +	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
> +
>  # Don't try to regenerate Makefile or configure
>  # We don't generate any of them
>  Makefile: ;
> @@ -445,6 +449,7 @@ $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
> +$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
>  
>  subdir-%:
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" all,)
> @@ -633,6 +638,7 @@ clean:
>  		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
>  		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
>  		-exec rm {} +
> +	rm -f $(edk2-decompressed)
>  	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
> @@ -723,9 +729,14 @@ spapr-rtas.bin slof.bin skiboot.lid \
>  palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
> +edk2-licenses.txt \
>  hppa-firmware.img
> +
> +DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> +60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
>  else
>  BLOBS=
> +DESCS=
>  endif
>  
>  # Note that we manually filter-out the non-Sphinx documentation which
> @@ -786,7 +797,8 @@ endif
>  
>  ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
>  
> -install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir
> +install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
> +	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
>  ifneq ($(TOOLS),)
>  	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
>  endif
> @@ -808,6 +820,21 @@ ifneq ($(BLOBS),)
>  	set -e; for x in $(BLOBS); do \
>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>  	done
> +endif
> +ifdef INSTALL_BLOBS
> +	set -e; for x in $(edk2-decompressed); do \
> +		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
> +	done
> +endif
> +ifneq ($(DESCS),)
> +	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
> +	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
> +	for x in $(DESCS); do \
> +		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
> +			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
> +		$(INSTALL_DATA) "$$tmpf" \
> +			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
> +	done
>  endif
>  	for s in $(ICON_SIZES); do \
>  		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
> diff --git a/.gitignore b/.gitignore
> index 8f782218044e..fd6e6c38c7b9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -97,6 +97,7 @@
>  *.gcno
>  *.gcov
>  /pc-bios/bios-pq/status
> +/pc-bios/edk2-*.fd
>  /pc-bios/vgabios-pq/status
>  /pc-bios/optionrom/linuxboot.asm
>  /pc-bios/optionrom/linuxboot.bin
> 
