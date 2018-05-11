Received: from eggs.gnu.org ([2001:4830:134:3::10]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH5Wo-0003aK-9l
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH5Wn-0003ZG-2D
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:43:58 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH5Wm-0003Z1-Ry
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:43:57 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so5697928ott.13
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 03:43:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510205949.26455-1-laurent@vivier.eu>
References: <20180510205949.26455-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 11:43:35 +0100
Message-ID: <CAFEAcA99yoOKX4Vy8e455cFQOe_WZN0rgu+CV1LLyvSonxQCoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: correctly align types in
 thunking code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 10 May 2018 at 21:59, Laurent Vivier <laurent@vivier.eu> wrote:
> This is a follow up
> of patch:
>
>         commit c2e3dee6e03527baf8698698cce76b1a3174969a
>         Author: Laurent Vivier <laurent@vivier.eu>
>         Date:   Sun Feb 13 23:37:34 2011 +0100
>
>             linux-user: Define target alignment size
>
> In my case m68k aligns "int" on 2 not 4. You can check this with the
> following program:
>
> int main(void)
> {
>         struct rtentry rt;
>         printf("rt_pad1 %ld %zd\n", offsetof(struct rtentry, rt_pad1),
>                 sizeof(rt.rt_pad1));
>         printf("rt_dst %ld %zd\n", offsetof(struct rtentry, rt_dst),
>                 sizeof(rt.rt_dst));
>         printf("rt_gateway %ld %zd\n", offsetof(struct rtentry, rt_gateway),
>                 sizeof(rt.rt_gateway));
>         printf("rt_genmask %ld %zd\n", offsetof(struct rtentry, rt_genmask),
>                 sizeof(rt.rt_genmask));
>         printf("rt_flags %ld %zd\n", offsetof(struct rtentry, rt_flags),
>                 sizeof(rt.rt_flags));
>         printf("rt_pad2 %ld %zd\n", offsetof(struct rtentry, rt_pad2),
>                 sizeof(rt.rt_pad2));
>         printf("rt_pad3 %ld %zd\n", offsetof(struct rtentry, rt_pad3),
>                 sizeof(rt.rt_pad3));
>         printf("rt_pad4 %ld %zd\n", offsetof(struct rtentry, rt_pad4),
>                 sizeof(rt.rt_pad4));
>         printf("rt_metric %ld %zd\n", offsetof(struct rtentry, rt_metric),
>                 sizeof(rt.rt_metric));
>         printf("rt_dev %ld %zd\n", offsetof(struct rtentry, rt_dev),
>                 sizeof(rt.rt_dev));
>         printf("rt_mtu %ld %zd\n", offsetof(struct rtentry, rt_mtu),
>                 sizeof(rt.rt_mtu));
>         printf("rt_window %ld %zd\n", offsetof(struct rtentry, rt_window),
>                 sizeof(rt.rt_window));
>         printf("rt_irtt %ld %zd\n", offsetof(struct rtentry, rt_irtt),
>                 sizeof(rt.rt_irtt));
> }
>
> And result is :
>
> i386
>
> rt_pad1 0 4
> rt_dst 4 16
> rt_gateway 20 16
> rt_genmask 36 16
> rt_flags 52 2
> rt_pad2 54 2
> rt_pad3 56 4
> rt_pad4 62 2
> rt_metric 64 2
> rt_dev 68 4
> rt_mtu 72 4
> rt_window 76 4
> rt_irtt 80 2
>
> m68k
>
> rt_pad1 0 4
> rt_dst 4 16
> rt_gateway 20 16
> rt_genmask 36 16
> rt_flags 52 2
> rt_pad2 54 2
> rt_pad3 56 4
> rt_pad4 62 2
> rt_metric 64 2
> rt_dev 66 4
> rt_mtu 70 4
> rt_window 74 4
> rt_irtt 78 2
>
> This affects the "route" command :
>
> WITHOUT this patch:
>
> $ sudo route add -net default gw 10.0.3.1 window 1024 irtt 2 eth0
> $ netstat -nr
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
> 0.0.0.0         10.0.3.1        0.0.0.0         UG        0 67108866  32768 eth0
> 10.0.3.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
>
> WITH this patch:
>
> $ sudo route add -net default gw 10.0.3.1 window 1024 irtt 2 eth0
> $ netstat -nr
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
> 0.0.0.0         10.0.3.1        0.0.0.0         UG        0 1024       2 eth0
> 10.0.3.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  include/exec/user/thunk.h | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index f19ef4b230..8f55b233b3 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -149,20 +149,32 @@ static inline int thunk_type_align(const argtype *type_ptr, int is_host)
>      case TYPE_CHAR:
>          return 1;
>      case TYPE_SHORT:
> -        return 2;
> +        if (is_host) {
> +            return __alignof__(short);
> +        } else {
> +            return ABI_SHORT_ALIGNMENT;
> +        }
>      case TYPE_INT:
> -        return 4;
> +        if (is_host) {
> +            return __alignof__(int);
> +        } else {
> +            return ABI_INT_ALIGNMENT;
> +        }
>      case TYPE_LONGLONG:
>      case TYPE_ULONGLONG:
> -        return 8;
> +        if (is_host) {
> +            return __alignof__(long long);
> +        } else {
> +            return ABI_LLONG_ALIGNMENT;
> +        }
>      case TYPE_LONG:
>      case TYPE_ULONG:
>      case TYPE_PTRVOID:
>      case TYPE_PTR:
>          if (is_host) {
> -            return sizeof(void *);
> +            return __alignof__(long);
>          } else {
> -            return TARGET_ABI_BITS / 8;
> +            return ABI_LONG_ALIGNMENT;
>          }
>          break;
>      case TYPE_OLDDEVT:
> --

This definitely looks like the right thing. As well as m68k,
this will also affect sh4 and i386 (where long long is 4
aligned but we were saying it should be 8 aligned) -- I wonder
if that fixes any bugs...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
