Received: from eggs.gnu.org ([2001:4830:134:3::10]:55758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1etaON-0001Kh-Sg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1etaOJ-0000Cx-CA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:50:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1etaOJ-0000C5-6N
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:50:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 107ED76FB9
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 14:49:59 +0000 (UTC)
Date: Wed, 7 Mar 2018 15:49:51 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: lersek@redhat.com, kraxel@redhat.com, berrange@redhat.com

Problem background
------------------

The various OVMF binary file names and paths are slightly different[+]
for each Linux distribution.  And each high-level management tool
(libguestfs, oVirt, `virt-manager` and OpenStack Nova) is inventing its
own approach to detect and configure the said OVMF files.  This email
thread is about arriving at some common understanding to make this a bit
more "unified" by addressing these needs in QEMU and libvirt.


Suggested approach
------------------

Based on an upstream discussion on 'virt-tools'[1] mailing list and some
Bugzillas, Gerd Hoffmann, Laszlo Ersek and Dan Berrang=E9 had a suggestio=
n
to define a firmware metadata format and file (example in [1]):

  - For each firmware file we need a metadata file in a well defined
    location, e.g. /usr/share/qemu/bios/ that lists stuff like:

      - Path to the firmware binary
      - Path to the pre-built OVMF 'vars' file (if any)
      - Support architectures - associated QEMU feature flags (Secure
        Boot)
      - If the binary provides / requires SMM (System Management Mode)

     Essentially, QEMU would define[*] the file format, and provide
     metadata files from any ROMs it ships directly.  If Linux
     distributions / vendors ship extra ROMs like OVMF, etc then they
     should provide suitable metadata files.

  - Libvirt can read these metadata files and then pick the correct
    firmware binary based on the settings for the guest.

  - Management tools can then wire up the libvirt-based OVMF SB (Secure
    Boot) configuration.

[*] Open question: Who, between QEMU and libvirt, should define the said
firmware metadata format and file?


References
----------=20

[1] A past proposal from Gerd to create a sort of a "firmware registry"

    https://www.redhat.com/archives/virt-tools-list/2014-September/msg001=
45.html

[2] A libvirt upstream RFE bug requesting to simplify handling UEFI
    https://bugzilla.redhat.com/show_bug.cgi?id=3D1295146 -- RFE: provide
    a bios=3Duefi XML convenience option

[3] DanPB wrote a PoC in libvirt:
    https://www.redhat.com/archives/libvir-list/2016-October/msg00045.htm=
l
    -- [libvirt] [PATCH 0/3] Make UEFI firmware config simpler

    But later came to the conclusion that it is flawed, and said we go
    the route of "Suggested approach" mentioned earlier).


[*] OVMF package path names for different distributions
-------------------------------------------------------

  - Debian (https://packages.debian.org/stretch/all/ovmf/filelist)
     - /usr/share/OVMF/OVMF_CODE.fd
     - /usr/share/OVMF/OVMF_VARS.fd

  - OpenSUSE (package: "qemu-ovmf-x86_64" -- and it has *35*
    files in that package):
     - /usr/share/qemu/ovmf-x86_64-opensuse-code.bin
     - /usr/share/qemu/ovmf-x86_64-opensuse-vars.bin [...]

     Their RPM spec file gives some hints (where all the files with
     'ms' means signed with MS keys; the files with 'opensuse-4096'
     means signed with OpenSUSE 4096 bit CA keys -- I think that's one
     of the points of Secure Boot, to let people have control over
     system keys):
     https://build.opensuse.org/package/view_file/openSUSE:Factory/ovmf/o=
vmf.spec?expand=3D1

  - Fedora 27 (package: "edk2-ovmf", x86_64):
     - /usr/share/edk2/ovmf/OVMF_CODE.fd
     - /usr/share/edk2/ovmf/OVMF_CODE.secboot.fd
     - /usr/share/edk2/ovmf/OVMF_VARS.fd

  - RHEL-7.4 (package: "OVMF", x86_64):
     - /usr/share/OVMF/OVMF_CODE.secboot.fd
     - /usr/share/OVMF/OVMF_VARS.fd

  - Gerd's firmware repo from Git:
     - /usr/share/edk2.git/ovmf-x64/OVMF_VARS-need-smm.fd
     - /usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd

--
/kashyap
