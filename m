Received: from eggs.gnu.org ([2001:4830:134:3::10]:52460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOFk-0001Na-4S
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOFf-0000sK-Ct
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOFf-0000s4-99
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:03 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so12199807qke.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:12:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170323113156.9277-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57523454-4e1c-36ac-5b0b-82e5ddd87bd7@amsat.org>
Date: Tue, 4 Apr 2017 10:11:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170323113156.9277-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: tftp, copy sockaddr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 03/23/2017 08:31 AM, Marc-André Lureau wrote:
> ASAN detects an "unknown-crash" when running pxe-test:
>
> /ppc64/pxe/spapr-vlan: =================================================================
> ==7143==ERROR: AddressSanitizer: unknown-crash on address 0x7f6dcd298d30 at pc 0x55e22218830d bp 0x7f6dcd2989e0 sp 0x7f6dcd2989d0
> READ of size 128 at 0x7f6dcd298d30 thread T2
>     #0 0x55e22218830c in tftp_session_allocate /home/elmarco/src/qq/slirp/tftp.c:73
>     #1 0x55e22218a1f8 in tftp_handle_rrq /home/elmarco/src/qq/slirp/tftp.c:289
>     #2 0x55e22218b54c in tftp_input /home/elmarco/src/qq/slirp/tftp.c:446
>     #3 0x55e2221833fe in udp6_input /home/elmarco/src/qq/slirp/udp6.c:82

Interesting bug, udp6.c seems to have been started as a copy of udp.c, 
which uses:

	struct sockaddr_storage lhost;
	struct sockaddr_in *lhost4;

but in udp6.c this was changed to:

     struct sockaddr_in6 lhost;

tftp_session_allocate() behavior was fine with IPv4 but dual-stack broke it.

Your fix uses sockaddr_size() which is the cleaner/safer way to do it 
but I'm wondering how to avoid such dual-stack sockaddr issues before 
runtime ASAN spotting.

One way can be to use 'union slirp_sockaddr' recently extracted by Dave 
Gilbert (see http://patchwork.ozlabs.org/patch/746605), it uses more 
stack but this avoid partial underflows.

>     #4 0x55e222137b17 in ip6_input /home/elmarco/src/qq/slirp/ip6_input.c:67
>
> Address 0x7f6dcd298d30 is located in stack of thread T2 at offset 96 in frame
>     #0 0x55e222182420 in udp6_input /home/elmarco/src/qq/slirp/udp6.c:13
>
>   This frame has 3 object(s):
>     [32, 48) '<unknown>'
>     [96, 124) 'lhost' <== Memory access at offset 96 partially overflows this variable
>     [160, 200) 'save_ip' <== Memory access at offset 96 partially underflows this variable
>
> The sockaddr_storage pointer is the sockaddr_in6 lhost on the
> stack. Copy only the source addr size.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/tftp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp/tftp.c b/slirp/tftp.c
> index 50e714807d..a9bc4bb1b6 100644
> --- a/slirp/tftp.c
> +++ b/slirp/tftp.c
> @@ -70,7 +70,7 @@ static int tftp_session_allocate(Slirp *slirp, struct sockaddr_storage *srcsas,
>
>   found:
>    memset(spt, 0, sizeof(*spt));
> -  spt->client_addr = *srcsas;
> +  memcpy(&spt->client_addr, srcsas, sockaddr_size(srcsas));
>    spt->fd = -1;
>    spt->block_size = 512;
>    spt->client_port = tp->udp.uh_sport;
>
