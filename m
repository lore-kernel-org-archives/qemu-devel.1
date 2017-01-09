Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQYVO-0001tv-IW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQYVL-0003rD-GJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:52:50 -0500
References: <20170109110921.4931-1-rka@sysgo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <271cfbcc-5230-99d4-ba0b-501ca6183314@redhat.com>
Date: Mon, 9 Jan 2017 12:52:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170109110921.4931-1-rka@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec: Add missing rcu_read_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>



On 09/01/2017 12:09, Roman Kapl wrote:
> rcu_read_unlock was not called if the address_space_access_valid result is
> negative.
> 
> This caused (at least) a problem when qemu on PPC/E500+TAP failed to terminate
> properly and instead got stuck in a deadlock.
> 
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index 8d4bb0e..6895db5 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2927,6 +2927,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
>          if (!memory_access_is_direct(mr, is_write)) {
>              l = memory_access_size(mr, l, addr);
>              if (!memory_region_access_valid(mr, xlat, l, is_write)) {
> +                rcu_read_unlock();
>                  return false;
>              }
>          }
> 

Thanks, queued!

Cc: qemu-stable <qemu-stable@nongnu.org>

Paolo
