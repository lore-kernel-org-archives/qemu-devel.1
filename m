Received: from eggs.gnu.org ([2001:4830:134:3::10]:49560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPnzd-0006dN-FI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPnza-0001lJ-8P
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:22:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPnza-0001kn-2k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:21:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so9053642wrx.9
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 04:21:58 -0800 (PST)
References: <20181122112947.7586-1-peter.maydell@linaro.org>
	<20181122112947.7586-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7761e2e2-f325-81b9-ea25-20bc6a78d1fd@redhat.com>
Date: Thu, 22 Nov 2018 13:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181122112947.7586-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/3] disas.c: Use
 address_space_read() to read memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, patches@linaro.org

On 22/11/18 12:29, Peter Maydell wrote:
> Currently disas.c reads physical memory using
> cpu_physical_memory_read(). This effectively hard-codes
> assuming that all CPUs have the same view of physical
> memory. Switch to address_space_read() instead, which
> lets us use the AddressSpace for the CPU we're
> disassembling for.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  disas.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/disas.c b/disas.c
> index 5325b7e6be6..f9c517b3588 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -588,7 +588,10 @@ static int
>  physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
>                       struct disassemble_info *info)
>  {
> -    cpu_physical_memory_read(memaddr, myaddr, length);
> +    CPUDebug *s = container_of(info, CPUDebug, info);
> +
> +    address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
> +                       myaddr, length);
>      return 0;
>  }
>  
> 
