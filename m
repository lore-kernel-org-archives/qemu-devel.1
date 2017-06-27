Received: from eggs.gnu.org ([2001:4830:134:3::10]:53543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dPtlQ-00082r-PQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dPskw-0000xe-7d
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:50:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59974
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dPskw-0000tQ-0I
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:50:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5RFmqpN099730
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:50:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bbfskwkhc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:50:19 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 27 Jun 2017 16:50:18 +0100
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 17:50:14 +0200
MIME-Version: 1.0
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 27.06.2017 13:48, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image (based on a Linux installation), but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
>=20
> This patch series now introduces network booting via DHCP and TFTP
> directly into the s390-ccw firmware by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.Neat :)
>=20
> Once the patches have been applied, you can download an .INS file
> via TFTP which contains the information about the further files
> that have to be loaded - kernel, initrd, etc. For example, you can
> use the built-in TFTP and DHCP server of QEMU for this by starting
> QEMU with:
>=20
>  qemu-system-s390x ... -device virtio-net,netdev=3Dn1,bootindex=3D1 \
>        -netdev user,id=3Dn1,tftp=3D/path/to/tftp,bootfile=3Dgeneric.ins
>=20
or the dnsmasq tftp server configured by libvirt (SCNR)
> The .INS file has to use the same syntax as the .INS files that can
> already be found on s390x Linux distribution installation CD-ROMs.
>=20
> The patches are still in a rough shape, but before I continue here,
> I though I'd get some feedback first. Specifically:
>=20
> - This adds a lot of additional code to the s390-ccw firmware (and
>   the binary is afterwards three times as big as before, 75k instead
>   of 25k) ... is that still acceptable?
The size may be less of an issue than the general overhead for
initialization. Since the current approach of the s390-ccw firmware of
lazy loading (only if a network boot is requested) takes care of that,
would it be conceivable that you build a standalone network boot
firmware image instead of incorporating that into the base firmware?
>=20
> - Is it OK to require loading an .INS file first? Or does anybody
>   have a better idea how to load multiple files (kernel, initrd,
>   etc. ...)?
It would be nice to support PXE-style boot, because the majority of boot
servers is set up that way. A straightforward way would be to do a PXE
emulation by attempting to download a pxelinux.cfg from the well-known
locations, parsing the content (menu) and finally load the kernel,
initrd and set the kernel command line as specified there. (I know, but
you're already parsing the INS-File).
Alternatively, one could load a single boot image (consisting of kernel
and initrd concatenated, i.e. the bootable ISO format). This could serve
as a more potent "stage 2" boot loader.
>=20
> - The code from SLOF uses a different coding style (TABs instead
>   of space) ... is it OK to keep that coding style here so we
>   can share patches between SLOF and s390-ccw more easil>
> - The code only supports TFTP (via UDP) ... I think that is OK for
>   most use-cases, but if we ever want to support network booting
>   via HTTP or something else that is based on TCP, we would need to
>   use something else instead... Should we maybe rather head towards
>   grub2, petitboot or something different instead?
I don't have an opinion on whether HTTP, FTP, etc is needed, but at some
point in time it would definitely be cool to have IPv6 support. Not sure
whether SLOF has that included.
>=20
>  Thomas
>=20
>=20
[...]
--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
