Received: from eggs.gnu.org ([2001:4830:134:3::10]:45750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftFOq-00079W-0K
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftFGj-0006Ir-D4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:49:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ftFGj-0006Hr-6E
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:49:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id v90-v6so8032101wrc.0
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:49:04 -0700 (PDT)
References: <20180824155804.azxqj5kvhbswyy5n@mac.bytemobile.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <1efbdd93-03c4-26d6-7ea0-8d1c85654d5b@gmail.com>
Date: Fri, 24 Aug 2018 19:49:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180824155804.azxqj5kvhbswyy5n@mac.bytemobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] usage of mremap in pvrdma break FreeBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Roger,


On 08/24/2018 06:58 PM, Roger Pau Monné wrote:
> Hello,
>
> The usage of mremap in the pvrdma code breaks the build on FreeBSD:
>
> /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: implicit declaration of
>        function 'mremap' is invalid in C99 [-Wimplicit-function-declaration]
>      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
>                  ^
> /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: this function
>        declaration is not a prototype [-Wstrict-prototypes]
> /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:46: error: use of undeclared
>        identifier 'MREMAP_MAYMOVE'
>      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
>                                               ^
> /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:48: error: use of undeclared
>        identifier 'MREMAP_MAYMOVE'
>          mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
>                                                 ^
> /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:65: error: use of undeclared
>        identifier 'MREMAP_FIXED'
>          mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
>                                                                  ^
>
> FreeBSD has librdma in base so by default QEMU configure script will
> enable the build of the rdma bits in QEMU. Sadly this code uses mremap
> which is Linux-specific.
>
> AFAICT either the build of pvrdma is limited to Linux in the configure
> script, or the calls to mremap are replaced with a portable
> equivalent.
>
> Thanks, Roger.

A fix has been submitted and merged:

https://patchew.org/QEMU/20180819202300.10590-1-marcel.apfelbaum@gmail.com/20180819202300.10590-16-marcel.apfelbaum@gmail.com/

Thanks,
Marcel
