Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eYYQ2-0002qT-HP
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eYYPz-00064x-Ry
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:54 -0500
Received: from verein.lst.de ([213.95.11.211]:33017 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eYYPz-000641-Lh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:51 -0500
Date: Mon, 8 Jan 2018 15:28:50 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180108142850.GB10273@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-6-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514940265-18093-6-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v1 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

> +    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> +        if (get_field(env->satp, SATP_MODE) == VM_1_09_MBARE) {
> +            mode = PRV_M;
> +        }
> +    } else {
> +        if (get_field(env->mstatus, MSTATUS_VM) == VM_1_10_MBARE) {
> +            mode = PRV_M;
> +        }
> +    }

This mixes up VM_1_09_MBARE and VM_1_10_MBARE, but they evaluate to
the same value anyway.

And as Richard said just rely on the mmu_idx from cpu_mmu_index.  I
actually already did the change to remove it in a patch for a new riscv
CSR I developed and can thus confirm it works fine.

> +    case CSR_SPTBR:

This should use CSR_SATP.  In fact even if you want to keep 1.9.1 support
I would highly recommend to remove the CSR_SPTBR define and only use
CSR_SATP in code, with sptbr limited to comments to avoid confusion.
