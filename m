Received: from eggs.gnu.org ([2001:4830:134:3::10]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZ0Jz-0006j6-PL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZ0Jv-0002fK-I5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:16:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:13427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eZ0Jv-0002a4-8W
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:16:27 -0500
Date: Wed, 10 Jan 2018 04:16:16 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180109201616.dsrhwi5xzmrqbgnq@hz-desktop>
References: <20180109193745.GA18506@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109193745.GA18506@amt.cnet>
Subject: Re: [Qemu-devel] [PATCH] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 01/09/18 17:37 -0200, Marcelo Tosatti wrote:
> 
> Improve hugepage allocation failure message, indicating
> whats happening to the user.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/exec.c b/exec.c
> index 4722e521d4..439abedb98 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1643,7 +1643,8 @@ static void *file_ram_alloc(RAMBlock *block,
>                           block->flags & RAM_SHARED);
>      if (area == MAP_FAILED) {
>          error_setg_errno(errp, errno,
> -                         "unable to map backing store for guest RAM");
> +                         "unable to map backing store for guest RAM, "
> +                         "falling back to malloc based RAM allocation");
>          return NULL;
>      }
>  

The backing store here is not always hugetlbfs, e.g., it can be NVDIMM
and even regular files. In those cases, the failure of file_ram_alloc()
does not fall back to malloc.

Haozhong
