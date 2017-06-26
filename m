Received: from eggs.gnu.org ([2001:4830:134:3::10]:58571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPap4-0008KV-CT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPaoy-0000jS-7t
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:41:26 -0400
References: <20170622121713.27601-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f274e0eb-ec19-346d-2c64-07ee6b30ca69@redhat.com>
Date: Mon, 26 Jun 2017 16:40:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170622121713.27601-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] docs: add
 qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org



On 06/22/2017 08:17 AM, Stefan Hajnoczi wrote:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
>=20
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, this is really useful information to have. Looks good to me, but
Paolo's changes prevent it from applying now.

So, as of last week:

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  Makefile                     |  28 +-
>  docs/qemu-block-drivers.texi | 692 +++++++++++++++++++++++++++++++++++=
++++++++
>  qemu-doc.texi                | 673 +----------------------------------=
------
>  3 files changed, 712 insertions(+), 681 deletions(-)
>  create mode 100644 docs/qemu-block-drivers.texi
>=20
> diff --git a/Makefile b/Makefile
> index c830d7a..ee9b434 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -209,6 +209,9 @@ ifdef BUILD_DOCS
>  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga=
.8
>  DOCS+=3Ddocs/qemu-qmp-ref.html docs/qemu-qmp-ref.txt docs/qemu-qmp-ref=
.7
>  DOCS+=3Ddocs/qemu-ga-ref.html docs/qemu-ga-ref.txt docs/qemu-ga-ref.7
> +DOCS+=3Ddocs/qemu-block-drivers.html
> +DOCS+=3Ddocs/qemu-block-drivers.txt
> +DOCS+=3Ddocs/qemu-block-drivers.7
>  ifdef CONFIG_VIRTFS
>  DOCS+=3Dfsdev/virtfs-proxy-helper.1
>  endif
> @@ -520,10 +523,10 @@ distclean: clean
>  	rm -f config.log
>  	rm -f linux-headers/asm
>  	rm -f docs/qemu-ga-qapi.texi docs/qemu-qmp-qapi.texi docs/version.tex=
i
> -	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
> -	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
> -	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
> -	rm -f docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
> +	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7 docs/qemu-block-drivers.=
7
> +	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt docs/qemu-block-driv=
ers.txt
> +	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf docs/qemu-block-driv=
ers.pdf
> +	rm -f docs/qemu-qmp-ref.html docs/qemu-ga-ref.html docs/qemu-block-dr=
ivers.html
>  	for d in $(TARGET_DIRS); do \
>  	rm -rf $$d || exit 1 ; \
>          done
> @@ -564,11 +567,14 @@ install-doc: $(DOCS)
>  	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
> +	$(INSTALL_DATA) docs/qemu-block-drivers.html "$(DESTDIR)$(qemu_docdir=
)"
> +	$(INSTALL_DATA) docs/qemu-block-drivers.txt "$(DESTDIR)$(qemu_docdir)=
"
>  ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
> +	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
>  ifneq ($(TOOLS),)
>  	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
> @@ -688,6 +694,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
> =20
>  docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.txt docs/=
qemu-ga-ref.pdf docs/qemu-ga-ref.7.pod: docs/version.texi
>  docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.txt do=
cs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.pod: docs/version.texi
> +docs/qemu-block-drivers.html docs/qemu-block-drivers.info docs/qemu-bl=
ock-drivers.txt docs/qemu-block-drivers.pdf docs/qemu-block-drivers.pod: =
docs/version.texi
> =20
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxt=
ool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN"=
,"$@")
> @@ -716,15 +723,15 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-h=
elper.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
>  qemu-ga.8: qemu-ga.texi
> =20
> -html: qemu-doc.html docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
> -info: qemu-doc.info docs/qemu-qmp-ref.info docs/qemu-ga-ref.info
> -pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
> -txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
> +html: qemu-doc.html docs/qemu-qmp-ref.html docs/qemu-ga-ref.html docs/=
qemu-block-drivers.html
> +info: qemu-doc.info docs/qemu-qmp-ref.info docs/qemu-ga-ref.info docs/=
qemu-block-drivers.info
> +pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf docs/qemu=
-block-drivers.pdf
> +txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt docs/qemu=
-block-drivers.txt
> =20
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>  	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi =
\
>  	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
> -	qemu-monitor-info.texi
> +	qemu-monitor-info.texi docs/qemu-block-drivers.texi
> =20
>  docs/qemu-ga-ref.dvi docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/=
qemu-ga-ref.pdf docs/qemu-ga-ref.txt docs/qemu-ga-ref.7: \
>  docs/qemu-ga-ref.texi docs/qemu-ga-qapi.texi
> @@ -732,6 +739,9 @@ docs/qemu-ga-ref.texi docs/qemu-ga-qapi.texi
>  docs/qemu-qmp-ref.dvi docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info do=
cs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7: \
>  docs/qemu-qmp-ref.texi docs/qemu-qmp-qapi.texi
> =20
> +docs/qemu-block-drivers.dvi docs/qemu-block-drivers.html docs/qemu-blo=
ck-drivers.info docs/qemu-block-drivers.pdf docs/qemu-block-drivers.txt d=
ocs/qemu-block-drivers.7: \
> +docs/qemu-block-drivers.texi
> +
> =20
>  ifdef CONFIG_WIN32
> =20
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.tex=
i
> new file mode 100644
> index 0000000..a43e878
> --- /dev/null
> +++ b/docs/qemu-block-drivers.texi
> @@ -0,0 +1,692 @@
> +@c man begin SYNOPSIS
> +QEMU block driver reference manual
> +@c man end
> +
> +@c man begin DESCRIPTION
> +
> +@node disk_images_formats
> +
> +@subsection Disk image file formats
> +
> +QEMU supports many image file formats that can be used with VMs as wel=
l as with
> +any of the tools (like @code{qemu-img}). This includes the preferred f=
ormats
> +raw and qcow2 as well as formats that are supported for compatibility =
with
> +older QEMU versions or other hypervisors.
> +
> +Depending on the image format, different options can be passed to
> +@code{qemu-img create} and @code{qemu-img convert} using the @code{-o}=
 option.
> +This section describes each format and the options that are supported =
for it.
> +
> +@table @option
> +@item raw
> +
> +Raw disk image format. This format has the advantage of
> +being simple and easily exportable to all other emulators. If your
> +file system supports @emph{holes} (for example in ext2 or ext3 on
> +Linux or NTFS on Windows), then only the written sectors will reserve
> +space. Use @code{qemu-img info} to know the real size used by the
> +image or @code{ls -ls} on Unix/Linux.
> +
> +Supported options:
> +@table @code
> +@item preallocation
> +Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{f=
ull}).
> +@code{falloc} mode preallocates space for image by calling posix_fallo=
cate().
> +@code{full} mode preallocates space for image by writing zeros to unde=
rlying
> +storage.
> +@end table
> +
> +@item qcow2
> +QEMU image format, the most versatile format. Use it to have smaller
> +images (useful if your filesystem does not supports holes, for example
> +on Windows), zlib based compression and support of multiple VM
> +snapshots.
> +
> +Supported options:
> +@table @code
> +@item compat
> +Determines the qcow2 version to use. @code{compat=3D0.10} uses the
> +traditional image format that can be read by any QEMU since 0.10.
> +@code{compat=3D1.1} enables image format extensions that only QEMU 1.1=
 and
> +newer understand (this is the default). Amongst others, this includes
> +zero clusters, which allow efficient copy-on-read for sparse images.
> +
> +@item backing_file
> +File name of a base image (see @option{create} subcommand)
> +@item backing_fmt
> +Image format of the base image
> +@item encryption
> +If this option is set to @code{on}, the image is encrypted with 128-bi=
t AES-CBC.
> +
> +The use of encryption in qcow and qcow2 images is considered to be fla=
wed by
> +modern cryptography standards, suffering from a number of design probl=
ems:
> +
> +@itemize @minus
> +@item The AES-CBC cipher is used with predictable initialization vecto=
rs based
> +on the sector number. This makes it vulnerable to chosen plaintext att=
acks
> +which can reveal the existence of encrypted data.
> +@item The user passphrase is directly used as the encryption key. A po=
orly
> +chosen or short passphrase will compromise the security of the encrypt=
ion.
> +@item In the event of the passphrase being compromised there is no way=
 to
> +change the passphrase to protect data in any qcow images. The files mu=
st
> +be cloned, using a different encryption passphrase in the new file. Th=
e
> +original file must then be securely erased using a program like shred,
> +though even this is ineffective with many modern storage technologies.
> +@end itemize
> +
> +Use of qcow / qcow2 encryption with QEMU is deprecated, and support fo=
r
> +it will go away in a future release.  Users are recommended to use an
> +alternative encryption technology such as the Linux dm-crypt / LUKS
> +system.
> +
> +@item cluster_size
> +Changes the qcow2 cluster size (must be between 512 and 2M). Smaller c=
luster
> +sizes can improve the image file size whereas larger cluster sizes gen=
erally
> +provide better performance.
> +
> +@item preallocation
> +Preallocation mode (allowed values: @code{off}, @code{metadata}, @code=
{falloc},
> +@code{full}). An image with preallocated metadata is initially larger =
but can
> +improve performance when the image needs to grow. @code{falloc} and @c=
ode{full}
> +preallocations are like the same options of @code{raw} format, but set=
s up
> +metadata also.
> +
> +@item lazy_refcounts
> +If this option is set to @code{on}, reference count updates are postpo=
ned with
> +the goal of avoiding metadata I/O and improving performance. This is
> +particularly interesting with @option{cache=3Dwritethrough} which does=
n't batch
> +metadata updates. The tradeoff is that after a host crash, the referen=
ce count
> +tables must be rebuilt, i.e. on the next open an (automatic) @code{qem=
u-img
> +check -r all} is required, which may take some time.
> +
> +This option can only be enabled if @code{compat=3D1.1} is specified.
> +
> +@item nocow
> +If this option is set to @code{on}, it will turn off COW of the file. =
It's only
> +valid on btrfs, no effect on other file systems.
> +
> +Btrfs has low performance when hosting a VM image file, even more when=
 the guest
> +on the VM also using btrfs as file system. Turning off COW is a way to=
 mitigate
> +this bad performance. Generally there are two ways to turn off COW on =
btrfs:
> +a) Disable it by mounting with nodatacow, then all newly created files=
 will be
> +NOCOW. b) For an empty file, add the NOCOW file attribute. That's what=
 this option
> +does.
> +
> +Note: this option is only valid to new or empty files. If there is an =
existing
> +file which is COW and has data blocks already, it couldn't be changed =
to NOCOW
> +by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to =
check if
> +the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
> +
> +@end table
> +
> +@item qed
> +Old QEMU image format with support for backing files and compact image=
 files
> +(when your filesystem or transport medium does not support holes).
> +
> +When converting QED images to qcow2, you might want to consider using =
the
> +@code{lazy_refcounts=3Don} option to get a more QED-like behaviour.
> +
> +Supported options:
> +@table @code
> +@item backing_file
> +File name of a base image (see @option{create} subcommand).
> +@item backing_fmt
> +Image file format of backing file (optional).  Useful if the format ca=
nnot be
> +autodetected because it has no header, like some vhd/vpc files.
> +@item cluster_size
> +Changes the cluster size (must be power-of-2 between 4K and 64K). Smal=
ler
> +cluster sizes can improve the image file size whereas larger cluster s=
izes
> +generally provide better performance.
> +@item table_size
> +Changes the number of clusters per L1/L2 table (must be power-of-2 bet=
ween 1
> +and 16).  There is normally no need to change this value but this opti=
on can be
> +used for performance benchmarking.
> +@end table
> +
> +@item qcow
> +Old QEMU image format with support for backing files, compact image fi=
les,
> +encryption and compression.
> +
> +Supported options:
> +@table @code
> +@item backing_file
> +File name of a base image (see @option{create} subcommand)
> +@item encryption
> +If this option is set to @code{on}, the image is encrypted.
> +@end table
> +
> +@item vdi
> +VirtualBox 1.1 compatible image format.
> +Supported options:
> +@table @code
> +@item static
> +If this option is set to @code{on}, the image is created with metadata
> +preallocation.
> +@end table
> +
> +@item vmdk
> +VMware 3 and 4 compatible image format.
> +
> +Supported options:
> +@table @code
> +@item backing_file
> +File name of a base image (see @option{create} subcommand).
> +@item compat6
> +Create a VMDK version 6 image (instead of version 4)
> +@item hwversion
> +Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
> +if hwversion is specified.
> +@item subformat
> +Specifies which VMDK subformat to use. Valid options are
> +@code{monolithicSparse} (default),
> +@code{monolithicFlat},
> +@code{twoGbMaxExtentSparse},
> +@code{twoGbMaxExtentFlat} and
> +@code{streamOptimized}.
> +@end table
> +
> +@item vpc
> +VirtualPC compatible image format (VHD).
> +Supported options:
> +@table @code
> +@item subformat
> +Specifies which VHD subformat to use. Valid options are
> +@code{dynamic} (default) and @code{fixed}.
> +@end table
> +
> +@item VHDX
> +Hyper-V compatible image format (VHDX).
> +Supported options:
> +@table @code
> +@item subformat
> +Specifies which VHDX subformat to use. Valid options are
> +@code{dynamic} (default) and @code{fixed}.
> +@item block_state_zero
> +Force use of payload blocks of type 'ZERO'.  Can be set to @code{on} (=
default)
> +or @code{off}.  When set to @code{off}, new blocks will be created as
> +@code{PAYLOAD_BLOCK_NOT_PRESENT}, which means parsers are free to retu=
rn
> +arbitrary data for those blocks.  Do not set to @code{off} when using
> +@code{qemu-img convert} with @code{subformat=3Ddynamic}.
> +@item block_size
> +Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on ima=
ge size.
> +@item log_size
> +Log size; min 1 MB.
> +@end table
> +@end table
> +
> +@subsubsection Read-only formats
> +More disk image file formats are supported in a read-only mode.
> +@table @option
> +@item bochs
> +Bochs images of @code{growing} type.
> +@item cloop
> +Linux Compressed Loop image, useful only to reuse directly compressed
> +CD-ROM images present for example in the Knoppix CD-ROMs.
> +@item dmg
> +Apple disk image.
> +@item parallels
> +Parallels disk image format.
> +@end table
> +
> +
> +@node host_drives
> +@subsection Using host drives
> +
> +In addition to disk image files, QEMU can directly access host
> +devices. We describe here the usage for QEMU version >=3D 0.8.3.
> +
> +@subsubsection Linux
> +
> +On Linux, you can directly use the host device filename instead of a
> +disk image filename provided you have enough privileges to access
> +it. For example, use @file{/dev/cdrom} to access to the CDROM.
> +
> +@table @code
> +@item CD
> +You can specify a CDROM device even if no CDROM is loaded. QEMU has
> +specific code to detect CDROM insertion or removal. CDROM ejection by
> +the guest OS is supported. Currently only data CDs are supported.
> +@item Floppy
> +You can specify a floppy device even if no floppy is loaded. Floppy
> +removal is currently not detected accurately (if you change floppy
> +without doing floppy access while the floppy is not loaded, the guest
> +OS will think that the same floppy is loaded).
> +Use of the host's floppy device is deprecated, and support for it will
> +be removed in a future release.
> +@item Hard disks
> +Hard disks can be used. Normally you must specify the whole disk
> +(@file{/dev/hdb} instead of @file{/dev/hdb1}) so that the guest OS can
> +see it as a partitioned disk. WARNING: unless you know what you do, it
> +is better to only make READ-ONLY accesses to the hard disk otherwise
> +you may corrupt your host data (use the @option{-snapshot} command
> +line option or modify the device permissions accordingly).
> +@end table
> +
> +@subsubsection Windows
> +
> +@table @code
> +@item CD
> +The preferred syntax is the drive letter (e.g. @file{d:}). The
> +alternate syntax @file{\\.\d:} is supported. @file{/dev/cdrom} is
> +supported as an alias to the first CDROM drive.
> +
> +Currently there is no specific code to handle removable media, so it
> +is better to use the @code{change} or @code{eject} monitor commands to
> +change or eject media.
> +@item Hard disks
> +Hard disks can be used with the syntax: @file{\\.\PhysicalDrive@var{N}=
}
> +where @var{N} is the drive number (0 is the first hard disk).
> +
> +WARNING: unless you know what you do, it is better to only make
> +READ-ONLY accesses to the hard disk otherwise you may corrupt your
> +host data (use the @option{-snapshot} command line so that the
> +modifications are written in a temporary file).
> +@end table
> +
> +
> +@subsubsection Mac OS X
> +
> +@file{/dev/cdrom} is an alias to the first CDROM.
> +
> +Currently there is no specific code to handle removable media, so it
> +is better to use the @code{change} or @code{eject} monitor commands to
> +change or eject media.
> +
> +@node disk_images_fat_images
> +@subsection Virtual FAT disk images
> +
> +QEMU can automatically create a virtual FAT disk image from a
> +directory tree. In order to use it, just type:
> +
> +@example
> +qemu-system-i386 linux.img -hdb fat:/my_directory
> +@end example
> +
> +Then you access access to all the files in the @file{/my_directory}
> +directory without having to copy them in a disk image or to export
> +them via SAMBA or NFS. The default access is @emph{read-only}.
> +
> +Floppies can be emulated with the @code{:floppy:} option:
> +
> +@example
> +qemu-system-i386 linux.img -fda fat:floppy:/my_directory
> +@end example
> +
> +A read/write support is available for testing (beta stage) with the
> +@code{:rw:} option:
> +
> +@example
> +qemu-system-i386 linux.img -fda fat:floppy:rw:/my_directory
> +@end example
> +
> +What you should @emph{never} do:
> +@itemize
> +@item use non-ASCII filenames ;
> +@item use "-snapshot" together with ":rw:" ;
> +@item expect it to work when loadvm'ing ;
> +@item write to the FAT directory on the host system while accessing it=
 with the guest system.
> +@end itemize
> +
> +@node disk_images_nbd
> +@subsection NBD access
> +
> +QEMU can access directly to block device exported using the Network Bl=
ock Device
> +protocol.
> +
> +@example
> +qemu-system-i386 linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> +@end example
> +
> +If the NBD server is located on the same host, you can use an unix soc=
ket instead
> +of an inet socket:
> +
> +@example
> +qemu-system-i386 linux.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +@end example
> +
> +In this case, the block device must be exported using qemu-nbd:
> +
> +@example
> +qemu-nbd --socket=3D/tmp/my_socket my_disk.qcow2
> +@end example
> +
> +The use of qemu-nbd allows sharing of a disk between several guests:
> +@example
> +qemu-nbd --socket=3D/tmp/my_socket --share=3D2 my_disk.qcow2
> +@end example
> +
> +@noindent
> +and then you can use it with two guests:
> +@example
> +qemu-system-i386 linux1.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +qemu-system-i386 linux2.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> +@end example
> +
> +If the nbd-server uses named exports (supported since NBD 2.9.18, or w=
ith QEMU's
> +own embedded NBD server), you must specify an export name in the URI:
> +@example
> +qemu-system-i386 -cdrom nbd://localhost/debian-500-ppc-netinst
> +qemu-system-i386 -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> +@end example
> +
> +The URI syntax for NBD is supported since QEMU 1.3.  An alternative sy=
ntax is
> +also available.  Here are some example of the older syntax:
> +@example
> +qemu-system-i386 linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> +qemu-system-i386 linux2.img -hdb nbd:unix:/tmp/my_socket
> +qemu-system-i386 -cdrom nbd:localhost:10809:exportname=3Ddebian-500-pp=
c-netinst
> +@end example
> +
> +@node disk_images_sheepdog
> +@subsection Sheepdog disk images
> +
> +Sheepdog is a distributed storage system for QEMU.  It provides highly
> +available block level storage volumes that can be attached to
> +QEMU-based virtual machines.
> +
> +You can create a Sheepdog disk image with the command:
> +@example
> +qemu-img create sheepdog:///@var{image} @var{size}
> +@end example
> +where @var{image} is the Sheepdog image name and @var{size} is its
> +size.
> +
> +To import the existing @var{filename} to Sheepdog, you can use a
> +convert command.
> +@example
> +qemu-img convert @var{filename} sheepdog:///@var{image}
> +@end example
> +
> +You can boot from the Sheepdog disk image with the command:
> +@example
> +qemu-system-i386 sheepdog:///@var{image}
> +@end example
> +
> +You can also create a snapshot of the Sheepdog image like qcow2.
> +@example
> +qemu-img snapshot -c @var{tag} sheepdog:///@var{image}
> +@end example
> +where @var{tag} is a tag name of the newly created snapshot.
> +
> +To boot from the Sheepdog snapshot, specify the tag name of the
> +snapshot.
> +@example
> +qemu-system-i386 sheepdog:///@var{image}#@var{tag}
> +@end example
> +
> +You can create a cloned image from the existing snapshot.
> +@example
> +qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{i=
mage}
> +@end example
> +where @var{base} is a image name of the source snapshot and @var{tag}
> +is its tag name.
> +
> +You can use an unix socket instead of an inet socket:
> +
> +@example
> +qemu-system-i386 sheepdog+unix:///@var{image}?socket=3D@var{path}
> +@end example
> +
> +If the Sheepdog daemon doesn't run on the local host, you need to
> +specify one of the Sheepdog servers to connect to.
> +@example
> +qemu-img create sheepdog://@var{hostname}:@var{port}/@var{image} @var{=
size}
> +qemu-system-i386 sheepdog://@var{hostname}:@var{port}/@var{image}
> +@end example
> +
> +@node disk_images_iscsi
> +@subsection iSCSI LUNs
> +
> +iSCSI is a popular protocol used to access SCSI devices across a compu=
ter
> +network.
> +
> +There are two different ways iSCSI devices can be used by QEMU.
> +
> +The first method is to mount the iSCSI LUN on the host, and make it ap=
pear as
> +any other ordinary SCSI device on the host and then to access this dev=
ice as a
> +/dev/sd device from QEMU. How to do this differs between host OSes.
> +
> +The second method involves using the iSCSI initiator that is built int=
o
> +QEMU. This provides a mechanism that works the same way regardless of =
which
> +host OS you are running QEMU on. This section will describe this secon=
d method
> +of using iSCSI together with QEMU.
> +
> +In QEMU, iSCSI devices are described using special iSCSI URLs
> +
> +@example
> +URL syntax:
> +iscsi://[<username>[%<password>]@@]<host>[:<port>]/<target-iqn-name>/<=
lun>
> +@end example
> +
> +Username and password are optional and only used if your target is set=
 up
> +using CHAP authentication for access control.
> +Alternatively the username and password can also be set via environmen=
t
> +variables to have these not show up in the process list
> +
> +@example
> +export LIBISCSI_CHAP_USERNAME=3D<username>
> +export LIBISCSI_CHAP_PASSWORD=3D<password>
> +iscsi://<host>/<target-iqn-name>/<lun>
> +@end example
> +
> +Various session related parameters can be set via special options, eit=
her
> +in a configuration file provided via '-readconfig' or directly on the
> +command line.
> +
> +If the initiator-name is not specified qemu will use a default name
> +of 'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of th=
e
> +virtual machine.
> +
> +
> +@example
> +Setting a specific initiator name to use when logging in to the target
> +-iscsi initiator-name=3Diqn.qemu.test:my-initiator
> +@end example
> +
> +@example
> +Controlling which type of header digest to negotiate with the target
> +-iscsi header-digest=3DCRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +@end example
> +
> +These can also be set via a configuration file
> +@example
> +[iscsi]
> +  user =3D "CHAP username"
> +  password =3D "CHAP password"
> +  initiator-name =3D "iqn.qemu.test:my-initiator"
> +  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +  header-digest =3D "CRC32C"
> +@end example
> +
> +
> +Setting the target name allows different options for different targets
> +@example
> +[iscsi "iqn.target.name"]
> +  user =3D "CHAP username"
> +  password =3D "CHAP password"
> +  initiator-name =3D "iqn.qemu.test:my-initiator"
> +  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> +  header-digest =3D "CRC32C"
> +@end example
> +
> +
> +Howto use a configuration file to set iSCSI configuration options:
> +@example
> +cat >iscsi.conf <<EOF
> +[iscsi]
> +  user =3D "me"
> +  password =3D "my password"
> +  initiator-name =3D "iqn.qemu.test:my-initiator"
> +  header-digest =3D "CRC32C"
> +EOF
> +
> +qemu-system-i386 -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> +    -readconfig iscsi.conf
> +@end example
> +
> +
> +Howto set up a simple iSCSI target on loopback and accessing it via QE=
MU:
> +@example
> +This example shows how to set up an iSCSI target with one CDROM and on=
e DISK
> +using the Linux STGT software target. This target is available on Red =
Hat based
> +systems as the package 'scsi-target-utils'.
> +
> +tgtd --iscsi portal=3D127.0.0.1:3260
> +tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
> +tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \
> +    -b /IMAGES/disk.img --device-type=3Ddisk
> +tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \
> +    -b /IMAGES/cd.iso --device-type=3Dcd
> +tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
> +
> +qemu-system-i386 -iscsi initiator-name=3Diqn.qemu.test:my-initiator \
> +    -boot d -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> +    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
> +@end example
> +
> +@node disk_images_gluster
> +@subsection GlusterFS disk images
> +
> +GlusterFS is a user space distributed file system.
> +
> +You can boot from the GlusterFS disk image with the command:
> +@example
> +URI:
> +qemu-system-x86_64 -drive file=3Dgluster[+@var{type}]://[@var{host}[:@=
var{port}]]/@var{volume}/@var{path}
> +                               [?socket=3D...][,file.debug=3D9][,file.=
logfile=3D...]
> +
> +JSON:
> +qemu-system-x86_64 'json:@{"driver":"qcow2",
> +                           "file":@{"driver":"gluster",
> +                                    "volume":"testvol","path":"a.img",=
"debug":9,"logfile":"...",
> +                                    "server":[@{"type":"tcp","host":".=
..","port":"..."@},
> +                                              @{"type":"unix","socket"=
:"..."@}]@}@}'
> +@end example
> +
> +@var{gluster} is the protocol.
> +
> +@var{type} specifies the transport type used to connect to gluster
> +management daemon (glusterd). Valid transport types are
> +tcp and unix. In the URI form, if a transport type isn't specified,
> +then tcp type is assumed.
> +
> +@var{host} specifies the server where the volume file specification fo=
r
> +the given volume resides. This can be either a hostname or an ipv4 add=
ress.
> +If transport type is unix, then @var{host} field should not be specifi=
ed.
> +Instead @var{socket} field needs to be populated with the path to unix=
 domain
> +socket.
> +
> +@var{port} is the port number on which glusterd is listening. This is =
optional
> +and if not specified, it defaults to port 24007. If the transport type=
 is unix,
> +then @var{port} should not be specified.
> +
> +@var{volume} is the name of the gluster volume which contains the disk=
 image.
> +
> +@var{path} is the path to the actual disk image that resides on gluste=
r volume.
> +
> +@var{debug} is the logging level of the gluster protocol driver. Debug=
 levels
> +are 0-9, with 9 being the most verbose, and 0 representing no debuggin=
g output.
> +The default level is 4. The current logging levels defined in the glus=
ter source
> +are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - W=
arning,
> +6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
> +
> +@var{logfile} is a commandline option to mention log file path which h=
elps in
> +logging to the specified file and also help in persisting the gfapi lo=
gs. The
> +default is stderr.
> +
> +
> +
> +
> +You can create a GlusterFS disk image with the command:
> +@example
> +qemu-img create gluster://@var{host}/@var{volume}/@var{path} @var{size=
}
> +@end example
> +
> +Examples
> +@example
> +qemu-system-x86_64 -drive file=3Dgluster://1.2.3.4/testvol/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+tcp://1.2.3.4/testvol/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+tcp://1.2.3.4:24007/testvol/d=
ir/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]/testv=
ol/dir/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007=
/testvol/dir/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+tcp://server.domain.com:24007=
/testvol/dir/a.img
> +qemu-system-x86_64 -drive file=3Dgluster+unix:///testvol/dir/a.img?soc=
ket=3D/tmp/glusterd.socket
> +qemu-system-x86_64 -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/=
a.img
> +qemu-system-x86_64 -drive file=3Dgluster://1.2.3.4/testvol/a.img,file.=
debug=3D9,file.logfile=3D/var/log/qemu-gluster.log
> +qemu-system-x86_64 'json:@{"driver":"qcow2",
> +                           "file":@{"driver":"gluster",
> +                                    "volume":"testvol","path":"a.img",
> +                                    "debug":9,"logfile":"/var/log/qemu=
-gluster.log",
> +                                    "server":[@{"type":"tcp","host":"1=
.2.3.4","port":24007@},
> +                                              @{"type":"unix","socket"=
:"/var/run/glusterd.socket"@}]@}@}'
> +qemu-system-x86_64 -drive driver=3Dqcow2,file.driver=3Dgluster,file.vo=
lume=3Dtestvol,file.path=3D/path/a.img,
> +                                       file.debug=3D9,file.logfile=3D/=
var/log/qemu-gluster.log,
> +                                       file.server.0.type=3Dtcp,file.s=
erver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> +                                       file.server.1.type=3Dunix,file.=
server.1.socket=3D/var/run/glusterd.socket
> +@end example
> +
> +@node disk_images_ssh
> +@subsection Secure Shell (ssh) disk images
> +
> +You can access disk images located on a remote ssh server
> +by using the ssh protocol:
> +
> +@example
> +qemu-system-x86_64 -drive file=3Dssh://[@var{user}@@]@var{server}[:@va=
r{port}]/@var{path}[?host_key_check=3D@var{host_key_check}]
> +@end example
> +
> +Alternative syntax using properties:
> +
> +@example
> +qemu-system-x86_64 -drive file.driver=3Dssh[,file.user=3D@var{user}],f=
ile.host=3D@var{server}[,file.port=3D@var{port}],file.path=3D@var{path}[,=
file.host_key_check=3D@var{host_key_check}]
> +@end example
> +
> +@var{ssh} is the protocol.
> +
> +@var{user} is the remote user.  If not specified, then the local
> +username is tried.
> +
> +@var{server} specifies the remote ssh server.  Any ssh server can be
> +used, but it must implement the sftp-server protocol.  Most Unix/Linux
> +systems should work without requiring any extra configuration.
> +
> +@var{port} is the port number on which sshd is listening.  By default
> +the standard ssh port (22) is used.
> +
> +@var{path} is the path to the disk image.
> +
> +The optional @var{host_key_check} parameter controls how the remote
> +host's key is checked.  The default is @code{yes} which means to use
> +the local @file{.ssh/known_hosts} file.  Setting this to @code{no}
> +turns off known-hosts checking.  Or you can check that the host key
> +matches a specific fingerprint:
> +@code{host_key_check=3Dmd5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c=
9:c8}
> +(@code{sha1:} can also be used as a prefix, but note that OpenSSH
> +tools only use MD5 to print fingerprints).
> +
> +Currently authentication must be done using ssh-agent.  Other
> +authentication methods may be supported in future.
> +
> +Note: Many ssh servers do not support an @code{fsync}-style operation.
> +The ssh driver cannot guarantee that disk flush requests are
> +obeyed, and this causes a risk of disk corruption if the remote
> +server or network goes down during writes.  The driver will
> +print a warning when @code{fsync} is not supported:
> +
> +warning: ssh server @code{ssh.example.com:22} does not support fsync
> +
> +With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
> +supported.
> +
> +@c man end
> +
> +@ignore
> +
> +@setfilename qemu-block-drivers
> +@settitle QEMU block drivers reference
> +
> +@c man begin AUTHOR
> +Fabrice Bellard and the QEMU Project developers
> +@c man end
> +
> +@end ignore
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 965ba59..740e827 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -490,678 +490,7 @@ state is not saved or restored properly (in parti=
cular USB).
> =20
>  @include qemu-nbd.texi
> =20
> -@node disk_images_formats
> -@subsection Disk image file formats
> -
> -QEMU supports many image file formats that can be used with VMs as wel=
l as with
> -any of the tools (like @code{qemu-img}). This includes the preferred f=
ormats
> -raw and qcow2 as well as formats that are supported for compatibility =
with
> -older QEMU versions or other hypervisors.
> -
> -Depending on the image format, different options can be passed to
> -@code{qemu-img create} and @code{qemu-img convert} using the @code{-o}=
 option.
> -This section describes each format and the options that are supported =
for it.
> -
> -@table @option
> -@item raw
> -
> -Raw disk image format. This format has the advantage of
> -being simple and easily exportable to all other emulators. If your
> -file system supports @emph{holes} (for example in ext2 or ext3 on
> -Linux or NTFS on Windows), then only the written sectors will reserve
> -space. Use @code{qemu-img info} to know the real size used by the
> -image or @code{ls -ls} on Unix/Linux.
> -
> -Supported options:
> -@table @code
> -@item preallocation
> -Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{f=
ull}).
> -@code{falloc} mode preallocates space for image by calling posix_fallo=
cate().
> -@code{full} mode preallocates space for image by writing zeros to unde=
rlying
> -storage.
> -@end table
> -
> -@item qcow2
> -QEMU image format, the most versatile format. Use it to have smaller
> -images (useful if your filesystem does not supports holes, for example
> -on Windows), zlib based compression and support of multiple VM
> -snapshots.
> -
> -Supported options:
> -@table @code
> -@item compat
> -Determines the qcow2 version to use. @code{compat=3D0.10} uses the
> -traditional image format that can be read by any QEMU since 0.10.
> -@code{compat=3D1.1} enables image format extensions that only QEMU 1.1=
 and
> -newer understand (this is the default). Amongst others, this includes
> -zero clusters, which allow efficient copy-on-read for sparse images.
> -
> -@item backing_file
> -File name of a base image (see @option{create} subcommand)
> -@item backing_fmt
> -Image format of the base image
> -@item encryption
> -If this option is set to @code{on}, the image is encrypted with 128-bi=
t AES-CBC.
> -
> -The use of encryption in qcow and qcow2 images is considered to be fla=
wed by
> -modern cryptography standards, suffering from a number of design probl=
ems:
> -
> -@itemize @minus
> -@item The AES-CBC cipher is used with predictable initialization vecto=
rs based
> -on the sector number. This makes it vulnerable to chosen plaintext att=
acks
> -which can reveal the existence of encrypted data.
> -@item The user passphrase is directly used as the encryption key. A po=
orly
> -chosen or short passphrase will compromise the security of the encrypt=
ion.
> -@item In the event of the passphrase being compromised there is no way=
 to
> -change the passphrase to protect data in any qcow images. The files mu=
st
> -be cloned, using a different encryption passphrase in the new file. Th=
e
> -original file must then be securely erased using a program like shred,
> -though even this is ineffective with many modern storage technologies.
> -@end itemize
> -
> -Use of qcow / qcow2 encryption with QEMU is deprecated, and support fo=
r
> -it will go away in a future release.  Users are recommended to use an
> -alternative encryption technology such as the Linux dm-crypt / LUKS
> -system.
> -
> -@item cluster_size
> -Changes the qcow2 cluster size (must be between 512 and 2M). Smaller c=
luster
> -sizes can improve the image file size whereas larger cluster sizes gen=
erally
> -provide better performance.
> -
> -@item preallocation
> -Preallocation mode (allowed values: @code{off}, @code{metadata}, @code=
{falloc},
> -@code{full}). An image with preallocated metadata is initially larger =
but can
> -improve performance when the image needs to grow. @code{falloc} and @c=
ode{full}
> -preallocations are like the same options of @code{raw} format, but set=
s up
> -metadata also.
> -
> -@item lazy_refcounts
> -If this option is set to @code{on}, reference count updates are postpo=
ned with
> -the goal of avoiding metadata I/O and improving performance. This is
> -particularly interesting with @option{cache=3Dwritethrough} which does=
n't batch
> -metadata updates. The tradeoff is that after a host crash, the referen=
ce count
> -tables must be rebuilt, i.e. on the next open an (automatic) @code{qem=
u-img
> -check -r all} is required, which may take some time.
> -
> -This option can only be enabled if @code{compat=3D1.1} is specified.
> -
> -@item nocow
> -If this option is set to @code{on}, it will turn off COW of the file. =
It's only
> -valid on btrfs, no effect on other file systems.
> -
> -Btrfs has low performance when hosting a VM image file, even more when=
 the guest
> -on the VM also using btrfs as file system. Turning off COW is a way to=
 mitigate
> -this bad performance. Generally there are two ways to turn off COW on =
btrfs:
> -a) Disable it by mounting with nodatacow, then all newly created files=
 will be
> -NOCOW. b) For an empty file, add the NOCOW file attribute. That's what=
 this option
> -does.
> -
> -Note: this option is only valid to new or empty files. If there is an =
existing
> -file which is COW and has data blocks already, it couldn't be changed =
to NOCOW
> -by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to =
check if
> -the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
> -
> -@end table
> -
> -@item qed
> -Old QEMU image format with support for backing files and compact image=
 files
> -(when your filesystem or transport medium does not support holes).
> -
> -When converting QED images to qcow2, you might want to consider using =
the
> -@code{lazy_refcounts=3Don} option to get a more QED-like behaviour.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand).
> -@item backing_fmt
> -Image file format of backing file (optional).  Useful if the format ca=
nnot be
> -autodetected because it has no header, like some vhd/vpc files.
> -@item cluster_size
> -Changes the cluster size (must be power-of-2 between 4K and 64K). Smal=
ler
> -cluster sizes can improve the image file size whereas larger cluster s=
izes
> -generally provide better performance.
> -@item table_size
> -Changes the number of clusters per L1/L2 table (must be power-of-2 bet=
ween 1
> -and 16).  There is normally no need to change this value but this opti=
on can be
> -used for performance benchmarking.
> -@end table
> -
> -@item qcow
> -Old QEMU image format with support for backing files, compact image fi=
les,
> -encryption and compression.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand)
> -@item encryption
> -If this option is set to @code{on}, the image is encrypted.
> -@end table
> -
> -@item vdi
> -VirtualBox 1.1 compatible image format.
> -Supported options:
> -@table @code
> -@item static
> -If this option is set to @code{on}, the image is created with metadata
> -preallocation.
> -@end table
> -
> -@item vmdk
> -VMware 3 and 4 compatible image format.
> -
> -Supported options:
> -@table @code
> -@item backing_file
> -File name of a base image (see @option{create} subcommand).
> -@item compat6
> -Create a VMDK version 6 image (instead of version 4)
> -@item hwversion
> -Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
> -if hwversion is specified.
> -@item subformat
> -Specifies which VMDK subformat to use. Valid options are
> -@code{monolithicSparse} (default),
> -@code{monolithicFlat},
> -@code{twoGbMaxExtentSparse},
> -@code{twoGbMaxExtentFlat} and
> -@code{streamOptimized}.
> -@end table
> -
> -@item vpc
> -VirtualPC compatible image format (VHD).
> -Supported options:
> -@table @code
> -@item subformat
> -Specifies which VHD subformat to use. Valid options are
> -@code{dynamic} (default) and @code{fixed}.
> -@end table
> -
> -@item VHDX
> -Hyper-V compatible image format (VHDX).
> -Supported options:
> -@table @code
> -@item subformat
> -Specifies which VHDX subformat to use. Valid options are
> -@code{dynamic} (default) and @code{fixed}.
> -@item block_state_zero
> -Force use of payload blocks of type 'ZERO'.  Can be set to @code{on} (=
default)
> -or @code{off}.  When set to @code{off}, new blocks will be created as
> -@code{PAYLOAD_BLOCK_NOT_PRESENT}, which means parsers are free to retu=
rn
> -arbitrary data for those blocks.  Do not set to @code{off} when using
> -@code{qemu-img convert} with @code{subformat=3Ddynamic}.
> -@item block_size
> -Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on ima=
ge size.
> -@item log_size
> -Log size; min 1 MB.
> -@end table
> -@end table
> -
> -@subsubsection Read-only formats
> -More disk image file formats are supported in a read-only mode.
> -@table @option
> -@item bochs
> -Bochs images of @code{growing} type.
> -@item cloop
> -Linux Compressed Loop image, useful only to reuse directly compressed
> -CD-ROM images present for example in the Knoppix CD-ROMs.
> -@item dmg
> -Apple disk image.
> -@item parallels
> -Parallels disk image format.
> -@end table
> -
> -
> -@node host_drives
> -@subsection Using host drives
> -
> -In addition to disk image files, QEMU can directly access host
> -devices. We describe here the usage for QEMU version >=3D 0.8.3.
> -
> -@subsubsection Linux
> -
> -On Linux, you can directly use the host device filename instead of a
> -disk image filename provided you have enough privileges to access
> -it. For example, use @file{/dev/cdrom} to access to the CDROM.
> -
> -@table @code
> -@item CD
> -You can specify a CDROM device even if no CDROM is loaded. QEMU has
> -specific code to detect CDROM insertion or removal. CDROM ejection by
> -the guest OS is supported. Currently only data CDs are supported.
> -@item Floppy
> -You can specify a floppy device even if no floppy is loaded. Floppy
> -removal is currently not detected accurately (if you change floppy
> -without doing floppy access while the floppy is not loaded, the guest
> -OS will think that the same floppy is loaded).
> -Use of the host's floppy device is deprecated, and support for it will
> -be removed in a future release.
> -@item Hard disks
> -Hard disks can be used. Normally you must specify the whole disk
> -(@file{/dev/hdb} instead of @file{/dev/hdb1}) so that the guest OS can
> -see it as a partitioned disk. WARNING: unless you know what you do, it
> -is better to only make READ-ONLY accesses to the hard disk otherwise
> -you may corrupt your host data (use the @option{-snapshot} command
> -line option or modify the device permissions accordingly).
> -@end table
> -
> -@subsubsection Windows
> -
> -@table @code
> -@item CD
> -The preferred syntax is the drive letter (e.g. @file{d:}). The
> -alternate syntax @file{\\.\d:} is supported. @file{/dev/cdrom} is
> -supported as an alias to the first CDROM drive.
> -
> -Currently there is no specific code to handle removable media, so it
> -is better to use the @code{change} or @code{eject} monitor commands to
> -change or eject media.
> -@item Hard disks
> -Hard disks can be used with the syntax: @file{\\.\PhysicalDrive@var{N}=
}
> -where @var{N} is the drive number (0 is the first hard disk).
> -
> -WARNING: unless you know what you do, it is better to only make
> -READ-ONLY accesses to the hard disk otherwise you may corrupt your
> -host data (use the @option{-snapshot} command line so that the
> -modifications are written in a temporary file).
> -@end table
> -
> -
> -@subsubsection Mac OS X
> -
> -@file{/dev/cdrom} is an alias to the first CDROM.
> -
> -Currently there is no specific code to handle removable media, so it
> -is better to use the @code{change} or @code{eject} monitor commands to
> -change or eject media.
> -
> -@node disk_images_fat_images
> -@subsection Virtual FAT disk images
> -
> -QEMU can automatically create a virtual FAT disk image from a
> -directory tree. In order to use it, just type:
> -
> -@example
> -qemu-system-i386 linux.img -hdb fat:/my_directory
> -@end example
> -
> -Then you access access to all the files in the @file{/my_directory}
> -directory without having to copy them in a disk image or to export
> -them via SAMBA or NFS. The default access is @emph{read-only}.
> -
> -Floppies can be emulated with the @code{:floppy:} option:
> -
> -@example
> -qemu-system-i386 linux.img -fda fat:floppy:/my_directory
> -@end example
> -
> -A read/write support is available for testing (beta stage) with the
> -@code{:rw:} option:
> -
> -@example
> -qemu-system-i386 linux.img -fda fat:floppy:rw:/my_directory
> -@end example
> -
> -What you should @emph{never} do:
> -@itemize
> -@item use non-ASCII filenames ;
> -@item use "-snapshot" together with ":rw:" ;
> -@item expect it to work when loadvm'ing ;
> -@item write to the FAT directory on the host system while accessing it=
 with the guest system.
> -@end itemize
> -
> -@node disk_images_nbd
> -@subsection NBD access
> -
> -QEMU can access directly to block device exported using the Network Bl=
ock Device
> -protocol.
> -
> -@example
> -qemu-system-i386 linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> -@end example
> -
> -If the NBD server is located on the same host, you can use an unix soc=
ket instead
> -of an inet socket:
> -
> -@example
> -qemu-system-i386 linux.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -@end example
> -
> -In this case, the block device must be exported using qemu-nbd:
> -
> -@example
> -qemu-nbd --socket=3D/tmp/my_socket my_disk.qcow2
> -@end example
> -
> -The use of qemu-nbd allows sharing of a disk between several guests:
> -@example
> -qemu-nbd --socket=3D/tmp/my_socket --share=3D2 my_disk.qcow2
> -@end example
> -
> -@noindent
> -and then you can use it with two guests:
> -@example
> -qemu-system-i386 linux1.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -qemu-system-i386 linux2.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -@end example
> -
> -If the nbd-server uses named exports (supported since NBD 2.9.18, or w=
ith QEMU's
> -own embedded NBD server), you must specify an export name in the URI:
> -@example
> -qemu-system-i386 -cdrom nbd://localhost/debian-500-ppc-netinst
> -qemu-system-i386 -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> -@end example
> -
> -The URI syntax for NBD is supported since QEMU 1.3.  An alternative sy=
ntax is
> -also available.  Here are some example of the older syntax:
> -@example
> -qemu-system-i386 linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> -qemu-system-i386 linux2.img -hdb nbd:unix:/tmp/my_socket
> -qemu-system-i386 -cdrom nbd:localhost:10809:exportname=3Ddebian-500-pp=
c-netinst
> -@end example
> -
> -@node disk_images_sheepdog
> -@subsection Sheepdog disk images
> -
> -Sheepdog is a distributed storage system for QEMU.  It provides highly
> -available block level storage volumes that can be attached to
> -QEMU-based virtual machines.
> -
> -You can create a Sheepdog disk image with the command:
> -@example
> -qemu-img create sheepdog:///@var{image} @var{size}
> -@end example
> -where @var{image} is the Sheepdog image name and @var{size} is its
> -size.
> -
> -To import the existing @var{filename} to Sheepdog, you can use a
> -convert command.
> -@example
> -qemu-img convert @var{filename} sheepdog:///@var{image}
> -@end example
> -
> -You can boot from the Sheepdog disk image with the command:
> -@example
> -qemu-system-i386 sheepdog:///@var{image}
> -@end example
> -
> -You can also create a snapshot of the Sheepdog image like qcow2.
> -@example
> -qemu-img snapshot -c @var{tag} sheepdog:///@var{image}
> -@end example
> -where @var{tag} is a tag name of the newly created snapshot.
> -
> -To boot from the Sheepdog snapshot, specify the tag name of the
> -snapshot.
> -@example
> -qemu-system-i386 sheepdog:///@var{image}#@var{tag}
> -@end example
> -
> -You can create a cloned image from the existing snapshot.
> -@example
> -qemu-img create -b sheepdog:///@var{base}#@var{tag} sheepdog:///@var{i=
mage}
> -@end example
> -where @var{base} is a image name of the source snapshot and @var{tag}
> -is its tag name.
> -
> -You can use an unix socket instead of an inet socket:
> -
> -@example
> -qemu-system-i386 sheepdog+unix:///@var{image}?socket=3D@var{path}
> -@end example
> -
> -If the Sheepdog daemon doesn't run on the local host, you need to
> -specify one of the Sheepdog servers to connect to.
> -@example
> -qemu-img create sheepdog://@var{hostname}:@var{port}/@var{image} @var{=
size}
> -qemu-system-i386 sheepdog://@var{hostname}:@var{port}/@var{image}
> -@end example
> -
> -@node disk_images_iscsi
> -@subsection iSCSI LUNs
> -
> -iSCSI is a popular protocol used to access SCSI devices across a compu=
ter
> -network.
> -
> -There are two different ways iSCSI devices can be used by QEMU.
> -
> -The first method is to mount the iSCSI LUN on the host, and make it ap=
pear as
> -any other ordinary SCSI device on the host and then to access this dev=
ice as a
> -/dev/sd device from QEMU. How to do this differs between host OSes.
> -
> -The second method involves using the iSCSI initiator that is built int=
o
> -QEMU. This provides a mechanism that works the same way regardless of =
which
> -host OS you are running QEMU on. This section will describe this secon=
d method
> -of using iSCSI together with QEMU.
> -
> -In QEMU, iSCSI devices are described using special iSCSI URLs
> -
> -@example
> -URL syntax:
> -iscsi://[<username>[%<password>]@@]<host>[:<port>]/<target-iqn-name>/<=
lun>
> -@end example
> -
> -Username and password are optional and only used if your target is set=
 up
> -using CHAP authentication for access control.
> -Alternatively the username and password can also be set via environmen=
t
> -variables to have these not show up in the process list
> -
> -@example
> -export LIBISCSI_CHAP_USERNAME=3D<username>
> -export LIBISCSI_CHAP_PASSWORD=3D<password>
> -iscsi://<host>/<target-iqn-name>/<lun>
> -@end example
> -
> -Various session related parameters can be set via special options, eit=
her
> -in a configuration file provided via '-readconfig' or directly on the
> -command line.
> -
> -If the initiator-name is not specified qemu will use a default name
> -of 'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of th=
e
> -virtual machine.
> -
> -
> -@example
> -Setting a specific initiator name to use when logging in to the target
> --iscsi initiator-name=3Diqn.qemu.test:my-initiator
> -@end example
> -
> -@example
> -Controlling which type of header digest to negotiate with the target
> --iscsi header-digest=3DCRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -@end example
> -
> -These can also be set via a configuration file
> -@example
> -[iscsi]
> -  user =3D "CHAP username"
> -  password =3D "CHAP password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -  header-digest =3D "CRC32C"
> -@end example
> -
> -
> -Setting the target name allows different options for different targets
> -@example
> -[iscsi "iqn.target.name"]
> -  user =3D "CHAP username"
> -  password =3D "CHAP password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -  header-digest =3D "CRC32C"
> -@end example
> -
> -
> -Howto use a configuration file to set iSCSI configuration options:
> -@example
> -cat >iscsi.conf <<EOF
> -[iscsi]
> -  user =3D "me"
> -  password =3D "my password"
> -  initiator-name =3D "iqn.qemu.test:my-initiator"
> -  header-digest =3D "CRC32C"
> -EOF
> -
> -qemu-system-i386 -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> -    -readconfig iscsi.conf
> -@end example
> -
> -
> -Howto set up a simple iSCSI target on loopback and accessing it via QE=
MU:
> -@example
> -This example shows how to set up an iSCSI target with one CDROM and on=
e DISK
> -using the Linux STGT software target. This target is available on Red =
Hat based
> -systems as the package 'scsi-target-utils'.
> -
> -tgtd --iscsi portal=3D127.0.0.1:3260
> -tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
> -tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \
> -    -b /IMAGES/disk.img --device-type=3Ddisk
> -tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \
> -    -b /IMAGES/cd.iso --device-type=3Dcd
> -tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
> -
> -qemu-system-i386 -iscsi initiator-name=3Diqn.qemu.test:my-initiator \
> -    -boot d -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \
> -    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
> -@end example
> -
> -@node disk_images_gluster
> -@subsection GlusterFS disk images
> -
> -GlusterFS is a user space distributed file system.
> -
> -You can boot from the GlusterFS disk image with the command:
> -@example
> -URI:
> -qemu-system-x86_64 -drive file=3Dgluster[+@var{type}]://[@var{host}[:@=
var{port}]]/@var{volume}/@var{path}
> -                               [?socket=3D...][,file.debug=3D9][,file.=
logfile=3D...]
> -
> -JSON:
> -qemu-system-x86_64 'json:@{"driver":"qcow2",
> -                           "file":@{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img",=
"debug":9,"logfile":"...",
> -                                    "server":[@{"type":"tcp","host":".=
..","port":"..."@},
> -                                              @{"type":"unix","socket"=
:"..."@}]@}@}'
> -@end example
> -
> -@var{gluster} is the protocol.
> -
> -@var{type} specifies the transport type used to connect to gluster
> -management daemon (glusterd). Valid transport types are
> -tcp and unix. In the URI form, if a transport type isn't specified,
> -then tcp type is assumed.
> -
> -@var{host} specifies the server where the volume file specification fo=
r
> -the given volume resides. This can be either a hostname or an ipv4 add=
ress.
> -If transport type is unix, then @var{host} field should not be specifi=
ed.
> -Instead @var{socket} field needs to be populated with the path to unix=
 domain
> -socket.
> -
> -@var{port} is the port number on which glusterd is listening. This is =
optional
> -and if not specified, it defaults to port 24007. If the transport type=
 is unix,
> -then @var{port} should not be specified.
> -
> -@var{volume} is the name of the gluster volume which contains the disk=
 image.
> -
> -@var{path} is the path to the actual disk image that resides on gluste=
r volume.
> -
> -@var{debug} is the logging level of the gluster protocol driver. Debug=
 levels
> -are 0-9, with 9 being the most verbose, and 0 representing no debuggin=
g output.
> -The default level is 4. The current logging levels defined in the glus=
ter source
> -are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - W=
arning,
> -6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
> -
> -@var{logfile} is a commandline option to mention log file path which h=
elps in
> -logging to the specified file and also help in persisting the gfapi lo=
gs. The
> -default is stderr.
> -
> -
> -
> -
> -You can create a GlusterFS disk image with the command:
> -@example
> -qemu-img create gluster://@var{host}/@var{volume}/@var{path} @var{size=
}
> -@end example
> -
> -Examples
> -@example
> -qemu-system-x86_64 -drive file=3Dgluster://1.2.3.4/testvol/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+tcp://1.2.3.4/testvol/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+tcp://1.2.3.4:24007/testvol/d=
ir/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]/testv=
ol/dir/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007=
/testvol/dir/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+tcp://server.domain.com:24007=
/testvol/dir/a.img
> -qemu-system-x86_64 -drive file=3Dgluster+unix:///testvol/dir/a.img?soc=
ket=3D/tmp/glusterd.socket
> -qemu-system-x86_64 -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/=
a.img
> -qemu-system-x86_64 -drive file=3Dgluster://1.2.3.4/testvol/a.img,file.=
debug=3D9,file.logfile=3D/var/log/qemu-gluster.log
> -qemu-system-x86_64 'json:@{"driver":"qcow2",
> -                           "file":@{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img",
> -                                    "debug":9,"logfile":"/var/log/qemu=
-gluster.log",
> -                                    "server":[@{"type":"tcp","host":"1=
.2.3.4","port":24007@},
> -                                              @{"type":"unix","socket"=
:"/var/run/glusterd.socket"@}]@}@}'
> -qemu-system-x86_64 -drive driver=3Dqcow2,file.driver=3Dgluster,file.vo=
lume=3Dtestvol,file.path=3D/path/a.img,
> -                                       file.debug=3D9,file.logfile=3D/=
var/log/qemu-gluster.log,
> -                                       file.server.0.type=3Dtcp,file.s=
erver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> -                                       file.server.1.type=3Dunix,file.=
server.1.socket=3D/var/run/glusterd.socket
> -@end example
> -
> -@node disk_images_ssh
> -@subsection Secure Shell (ssh) disk images
> -
> -You can access disk images located on a remote ssh server
> -by using the ssh protocol:
> -
> -@example
> -qemu-system-x86_64 -drive file=3Dssh://[@var{user}@@]@var{server}[:@va=
r{port}]/@var{path}[?host_key_check=3D@var{host_key_check}]
> -@end example
> -
> -Alternative syntax using properties:
> -
> -@example
> -qemu-system-x86_64 -drive file.driver=3Dssh[,file.user=3D@var{user}],f=
ile.host=3D@var{server}[,file.port=3D@var{port}],file.path=3D@var{path}[,=
file.host_key_check=3D@var{host_key_check}]
> -@end example
> -
> -@var{ssh} is the protocol.
> -
> -@var{user} is the remote user.  If not specified, then the local
> -username is tried.
> -
> -@var{server} specifies the remote ssh server.  Any ssh server can be
> -used, but it must implement the sftp-server protocol.  Most Unix/Linux
> -systems should work without requiring any extra configuration.
> -
> -@var{port} is the port number on which sshd is listening.  By default
> -the standard ssh port (22) is used.
> -
> -@var{path} is the path to the disk image.
> -
> -The optional @var{host_key_check} parameter controls how the remote
> -host's key is checked.  The default is @code{yes} which means to use
> -the local @file{.ssh/known_hosts} file.  Setting this to @code{no}
> -turns off known-hosts checking.  Or you can check that the host key
> -matches a specific fingerprint:
> -@code{host_key_check=3Dmd5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c=
9:c8}
> -(@code{sha1:} can also be used as a prefix, but note that OpenSSH
> -tools only use MD5 to print fingerprints).
> -
> -Currently authentication must be done using ssh-agent.  Other
> -authentication methods may be supported in future.
> -
> -Note: Many ssh servers do not support an @code{fsync}-style operation.
> -The ssh driver cannot guarantee that disk flush requests are
> -obeyed, and this causes a risk of disk corruption if the remote
> -server or network goes down during writes.  The driver will
> -print a warning when @code{fsync} is not supported:
> -
> -warning: ssh server @code{ssh.example.com:22} does not support fsync
> -
> -With sufficiently new versions of libssh2 and OpenSSH, @code{fsync} is
> -supported.
> +@include docs/qemu-block-drivers.texi
> =20
>  @node pcsys_network
>  @section Network emulation
>=20

--=20
=E2=80=94js
