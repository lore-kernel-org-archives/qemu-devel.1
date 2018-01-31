Received: from eggs.gnu.org ([2001:4830:134:3::10]:33844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eh0p9-0007QG-DQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eh0p8-000122-Jd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:25:47 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eh0p8-00010U-B2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:25:46 -0500
Received: by mail-ot0-x243.google.com with SMTP id d9so14970422oth.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 14:25:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 31 Jan 2018 14:25:44 -0800
Message-ID: <CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 30, 2018 at 10:02 PM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> files on ext4/xfs file system mounted with '-o dax').

Wait, MAP_SYNC does not guarantee persistence. It makes sure that the
metadata is in sync after a fault. However, that does not make
filesystem-DAX safe for use with QEMU, because we still need to
coordinate DMA with fileystem operations. There is no way to do that
coordination from within a guest. QEMU needs to use device-dax if the
guest might ever perform DMA to a virtual-pmem range. See this patch
set for more details on the DAX vs DMA problem [1]. I think we need to
enforce this in the host kernel. I.e. do not allow file backed DAX
pages to be mapped in EPT entries unless / until we have a solution to
the DMA synchronization problem. Apologies for not noticing this
earlier.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2017-December/013704.html
