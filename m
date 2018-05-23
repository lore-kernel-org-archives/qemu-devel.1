Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLRfi-0003DZ-Ti
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLRfh-00056o-Oy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:11:10 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fLRfh-00056B-G2
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:11:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id k5-v6so13642271wrn.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:11:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
	<20180523023944-mutt-send-email-mst@kernel.org>
	<e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 23 May 2018 19:11:06 +0800
Message-ID: <CAKwiv-jMKSUYusO4S4HR5HCMXLxGNrpYwywm1dWBWsFKMEGzpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, alex.williamson@redhat.com, eauger@redhat.com, drjones@redhat.com, wei@redhat.com

Hi all,

Thanks for all your comments and suggestions, I wasn't expecting so many
professional
reviewers. Some of the things you mentioned are beyond my knowledge right
now.
Please correct me if I'm wrong below.

The original purpose was just to support multiple segments in Intel Q35
archtecure
for PCIe topology, which makes bus number a less scarce resource. The
patches are
very primitive and many things are left for firmware to finish(the initial
plan was
to implement it in SeaBIOS), the AML part in QEMU is not finished either.
I'm not
familiar with OVMF or edk2, so there is no plan to touch it yet, but it
seems not
necessary since it already supports multi-segment in the end.

Also, in this patch the assumption is one domain per host bridge, described
by '_SEG()'
in AML, which means a ECAM range per host bridge, but that should be
configurable
if the user prefers to staying in the same domain, I guess?

I'd like to list a few things you've discussed to confirm I don't get it
wrong

* ARI enlarges the number of functions, but they does not solve the
hot-pluggable issue.
  The multifunction PCIe endpoints cannot span PCIe domains
* IOMMUs cannot span domains either, so bringing new domains introduces the
need
  to add a VT-d DHRD or vIOMMU per PCIe domain
* 64-bit space is crowded and there are no standards within QEMU for
placing per
  domain 64-bit MMIO and MMCFG ranges
* NUMA modeling seems to be a stronger motivation than the limitation of
256 but
  nubmers, that each NUMA node holds its own PCI(e) sub-hierarchy
* We cannot put ECAM arbitrarily high because guest's PA width is limited
by host's
  when EPT is enabled.
* Compatibility issues in platforms that do not have MCFG table at all
(perhaps we limit
  it to only q35 at present in which MCFG is present).

Based on your discussions, I guess this proposal is still worth doing
overall, but it seems
many restrictions should be imposed to be compatible with some complicated
situations.

Please correct me if I get anything wrong or missing.

Thanks
Zihan
