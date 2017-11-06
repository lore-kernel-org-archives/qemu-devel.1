Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiVs-0004ii-1A
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiVm-0006BY-EJ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:36:32 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:48544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiVm-0006B9-8S
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:36:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id 15so8799777wrb.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:36:26 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-16-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d86b8115-9512-d487-a508-906c5f259764@redhat.com>
Date: Mon, 6 Nov 2017 15:36:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-16-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/18] Fix unavailable fields in stbuf
 under Windows.
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
> @@ -886,14 +886,34 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
>      v9lstat->st_gid = stbuf->st_gid;
>      v9lstat->st_rdev = stbuf->st_rdev;
>      v9lstat->st_size = stbuf->st_size;
> +#ifdef _WIN32
> +    /* Blksize is the optimal EA-block,
> +       while blocks always refers to 512 byte blocks
> +    */
> +    v9lstat->st_blksize = 4096;
> +    v9lstat->st_blocks = ((stbuf->st_size + 1) / 512) + 1;
> +#else
>      v9lstat->st_blksize = stbuf->st_blksize;
>      v9lstat->st_blocks = stbuf->st_blocks;
> +#endif
>      v9lstat->st_atime_sec = stbuf->st_atime;
> +#ifdef _WIN32
> +    v9lstat->st_atime_nsec = 0;
> +#else
>      v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
> +#endif
>      v9lstat->st_mtime_sec = stbuf->st_mtime;
> +#ifdef _WIN32
> +    v9lstat->st_mtime_nsec = 0;
> +#else
>      v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
> +#endif
>      v9lstat->st_ctime_sec = stbuf->st_ctime;
> +#ifdef _WIN32
> +    v9lstat->st_ctime_nsec = 0;
> +#else
>      v9lstat->st_ctime_nsec = stbuf->st_ctim.tv_nsec;
> +#endif
>      /* Currently we only support BASIC fields in stat */
>      v9lstat->st_result_mask = P9_STATS_BASIC;
>  

Likewise, I think it should be struct FileOperations's lstat member that
uses struct V9fsStatDotl instead of struct stat.  Then
stat_to_v9stat_dotl would be hidden inside 9p-local.c (and 9p-local.c
isn't going to be used by Windows at all, so this patch disappears).

Paolo
