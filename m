Received: from eggs.gnu.org ([2001:4830:134:3::10]:35279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cQdlW-0004DL-B2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cQdlV-0007w1-3b
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:29:50 -0500
References: <1483981521-6789-1-git-send-email-peter.maydell@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9ec773dd-c146-6647-7893-1ce8908d7b3f@siemens.com>
Date: Mon, 9 Jan 2017 18:29:39 +0100
MIME-Version: 1.0
In-Reply-To: <1483981521-6789-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386/kvmvapic: Remove dead code in
 patch_hypercalls()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 2017-01-09 18:05, Peter Maydell wrote:
> The patch_hypercalls() function sets up a 'patches'
> variable and checks it at the end of the function, but
> never modifies it in the middle. Remove this dead code,
> which seems to have been present since the function was
> added in commit e5ad936b0fd7 in 2012.
> 
> (Spotted by Coverity: CID 1005581.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Perhaps this was unintentionally retained debug code?
> It's not clear to me why the ROM should be required to
> have exactly zero or two hypercalls in it. In any case
> we've been fine without checking the patch count for
> five years :-)
> 
> CC'd Jan as original code author just in case he remembers.
> ---
>  hw/i386/kvmvapic.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
> index b30d1b9..418dba1 100644
> --- a/hw/i386/kvmvapic.c
> +++ b/hw/i386/kvmvapic.c
> @@ -534,7 +534,6 @@ static int patch_hypercalls(VAPICROMState *s)
>      uint8_t alternates[2];
>      const uint8_t *pattern;
>      const uint8_t *patch;
> -    int patches = 0;
>      off_t pos;
>      uint8_t *rom;
>  
> @@ -565,11 +564,6 @@ static int patch_hypercalls(VAPICROMState *s)
>      }
>  
>      g_free(rom);
> -
> -    if (patches != 0 && patches != 2) {
> -        return -1;
> -    }
> -
>      return 0;
>  }
>  
> 

Hmm, it looked that dead from day #1 on, and I cannot blame it on the
qemu-kvm version as well. Maybe the idea was to count the number of
patches we applied and have this as cross-check. But then I forgot to
count. It's probably safer to bury this code than to try starting to
count to 2 now.

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
