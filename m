Received: from eggs.gnu.org ([2001:4830:134:3::10]:37368)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cTQn5-0006fU-0j
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cTQmz-0004uo-C4
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:14:58 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47020 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cTQmz-0004tS-2v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:14:53 -0500
References: <5878AF90.8020709@kamp.de> <20170117064028.GC21563@lemon.Home>
From: Peter Lieven <pl@kamp.de>
Message-ID: <9d7408a3-1865-96aa-2d1a-28db6ef46953@kamp.de>
Date: Tue, 17 Jan 2017 11:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170117064028.GC21563@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable]  Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-stable@nongnu.org

Am 17.01.2017 um 07:40 schrieb Fam Zheng:
> On Fri, 01/13 11:44, Peter Lieven wrote:
>> Hi,
>>
>> i currently facing a problem in our testing environment where I see file
>> system corruption with 2.7.1 on iSCSI and Local Storage (LVM).
>> Trying to bisect, but has anyone observed this before?
> The information here is too scarce to tell but a file corruption is more often a
> result of two writers modifying the disk concurrently. Have you ruled that out?
> Is the corruption reproducible?

My issue was primary with iSCSI and I cut bisect it. I already send a patch to the list:

commit 0bd57e907311be6e4f97394cfd9afebe271457e2
Author: Peter Lieven <pl@kamp.de>
Date:   Mon Jan 16 16:10:26 2017 +0100

     block/iscsi: avoid data corruption with cache=writeback

     nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
     request starts and ends within the same cluster. This results
     in passing -1 to bitmap_set and bitmap_clear and they don't
     handle negative values properly. In the end this leads to data
     corruption.

     Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
     Cc: qemu-stable@nongnu.org
     Signed-off-by: Peter Lieven <pl@kamp.de>

However, one user also reported corruption with LVM. I will check if he uses virtio-scsi.

Thanks,
Peter
