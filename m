Received: from eggs.gnu.org ([2001:4830:134:3::10]:60203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTVII-0007QR-IR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTVIC-0003GO-W1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:03:30 -0500
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
	<b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
	<20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <196ac8f5-2fd7-37e9-d577-8177802d0fb4@redhat.com>
Date: Tue, 17 Jan 2017 16:03:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>



On 17/01/2017 12:22, Fabian Gr=FCnbichler wrote:
> 6) repeat 3-5 until md5sum does not match, kernel spews error
> messages, or you are convinced that everything is OK
>=20
> sample kernel message (for ext3):
> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 FAILED Result: =
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Sense Key : Ill=
egal Request [current]
> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Add. Sense: Inv=
alid field in cdb
> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 CDB: Write(10) =
2a 00 0f 3a 90 00 00 07 d8 00
> Jan 17 11:39:32 ubuntu kernel: blk_update_request: critical target erro=
r, dev sda, sector 255496192

Can you reproduce it if QEMU runs under "strace -e ioctl -ff" in the=20
host?  Or also using this systemtap script.

The important bit would be the lines with a nonzero status, but the
others can be useful to see what the surroundings look like.

# example output for "sudo stap -v strace.stp -c 'sg_opcodes /dev/sda'"
# | sg_opcodes[3444] 00000000 12 00 00 00 24 00 00 00 be 91
# | sg_opcodes[3444] 08100002 a3 0c 00 00 00 00 00 00 20 00

global cdbs%
global reqs%
global names%

function check_pid() {
    return target() =3D=3D 0 || pid() =3D=3D target();
}

probe kernel.function("blk_fill_sghdr_rq") {
    if (!check_pid()) next;

    names[$rq]=3Dsprintf("%s[%d]", execname(), tid())
    cdbs[$rq]=3Dsprintf("%02x %02x %02x %02x %02x %02x %02x %02x %02x %02=
x",
		    $hdr->cmdp[0],$hdr->cmdp[1],$hdr->cmdp[2],$hdr->cmdp[3],$hdr->cmdp[=
4],
		    $hdr->cmdp[6],$hdr->cmdp[5],$hdr->cmdp[7],$hdr->cmdp[8],$hdr->cmdp[=
9])
}

probe kernel.function("scsi_setup_cmnd") {
    if (!($req in cdbs)) next;
    reqs[$req->special] =3D $req;
}

probe kernel.function("scsi_finish_command") {
    if (!($cmd in reqs)) next;
    rq =3D reqs[$cmd];
    printf("%s %08x %s\n", names[rq], $cmd->result, cdbs[rq]);
    delete reqs[$cmd]
    delete cdbs[rq]
}
