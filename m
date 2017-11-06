Received: from eggs.gnu.org ([2001:4830:134:3::10]:32868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiKj-0006bR-4b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiKg-0007Qm-0b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:25:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiKf-0007QW-PS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:24:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id y83so14511151wmc.4
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:24:57 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-15-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71b05271-1d21-2081-6f4f-5d56f297b7bb@redhat.com>
Date: Mon, 6 Nov 2017 15:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-15-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/18] Disable rlimit under Windows
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
>  hw/9pfs/9p.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 53f812ec06..e0ef1a2a6b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3630,6 +3630,7 @@ void v9fs_reset(V9fsState *s)
>  
>  static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
>  {
> +#ifndef _WIN32
>      struct rlimit rlim;
>      if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
>          error_report("Failed to get the resource limit");
> @@ -3637,4 +3638,5 @@ static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
>      }
>      open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur/3);
>      open_fd_rc = rlim.rlim_cur/2;
> +#endif
>  }
> 

There should be a function in util/oslib-* that returns the rlim_cur value.

9p obviously needs a nonzero value in open_fd_hw and open_fd_rc, so the
last two lines need to be there for Win32 as well.  Perhaps a stub
implementation that just returns a fixed number (could be 1000?) is okay
for Windows.


Paolo
