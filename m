Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiMG-0007gp-Nt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiMD-0000ZJ-Ie
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:26:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:52637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiMD-0000X5-Ba
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:26:33 -0500
Received: by mail-wr0-f195.google.com with SMTP id j23so4581096wra.9
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:26:33 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-10-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc6a2b22-f0f4-e625-2f38-52cb96446312@redhat.com>
Date: Mon, 6 Nov 2017 15:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-10-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/18] Dont initialize fields which aren't
 available on Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
> Signed-off-by: Michael Fritscher <michael@fritscher.net>
> ---
>  hw/9pfs/9p-synth.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index df0a8de08a..e1bf0438b8 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -150,8 +150,10 @@ static void synth_fill_statbuf(V9fsSynthNode *node, struct stat *stbuf)
>      stbuf->st_gid = 0;
>      stbuf->st_rdev = 0;
>      stbuf->st_size = 0;
> +#ifndef _WIN32
>      stbuf->st_blksize = 0;
>      stbuf->st_blocks = 0;
> +#endif
>      stbuf->st_atime = 0;
>      stbuf->st_mtime = 0;
>      stbuf->st_ctime = 0;
> 

Just memset the whole stbuf instead, and then overwrite
st_ino/st_mode/st_nlink.

Paolo
