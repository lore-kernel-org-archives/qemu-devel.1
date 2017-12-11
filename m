Received: from eggs.gnu.org ([2001:4830:134:3::10]:59379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOMSo-0003Ki-Qo
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOMSo-0001ud-3M
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:41:38 -0500
Date: Mon, 11 Dec 2017 19:41:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171211114129.GC3350@lemon>
References: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
Subject: Re: [Qemu-devel] QEMU not honouring bootorder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On Thu, 12/07 13:10, Michal Privoznik wrote:
> Dear list,
> 
> I've encountered the following problem. I have two disks:
> 
>   /var/lib/libvirt/images/fedora.qcow2  (which contains OS)
>   /dev/sde (iSCSI dummy disk just for testing)
> 
> Now, when I configure QEMU to start with both of them, QEMU/Seabios
> tries to boot from /dev/sde which fails obviously. Even setting
> bootorder does not help. Here's my command line:
> 
>   qemu-system-x86_64 \
>   -boot menu=on,strict=on \
>   -device lsi,id=scsi0,bus=pci.0 \
>   -drive file=/var/lib/libvirt/images/fedora.qcow2,format=qcow2,if=none,id=drive-scsi0 \
>   -device scsi-hd,bus=scsi0.0,drive=drive-scsi0,bootindex=1 \
>   -drive file=/dev/sde,format=raw,if=none,id=drive-scsi1 \
>   -device scsi-block,bus=scsi0.0,drive=drive-scsi1,bootindex=2
> 
> It was found that if 'drive-scsi1' is scsi-hd instead of scsi-block
> everything works as expected and I can boot my guest successfully.

Does it help if you add SCSI level ordering with "lun={0,1},channel=0,scsi-id=0"
for both devices?

Fam
