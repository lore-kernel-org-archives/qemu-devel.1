Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cuyTl-0002Eg-N9
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cuyTg-0007PL-NS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:40:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cuyTg-0007LT-Eo
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:40:48 -0400
References: <CA+KKJYCUmxtb7o7Fg-DLFaEqhjZk5MhfBjSMt6L146PYmnGWxw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <24019a06-4e75-1819-1485-066d475ba58c@redhat.com>
Date: Mon, 3 Apr 2017 11:40:39 +0200
MIME-Version: 1.0
In-Reply-To: <CA+KKJYCUmxtb7o7Fg-DLFaEqhjZk5MhfBjSMt6L146PYmnGWxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/43] net: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org, jasowang@redhat.com, huth@tuxfamily.org, peter.maydell@linaro.org

 Hi,

thanks for looking into this issue ... but I've got some comments:

On 01.04.2017 15:52, Danil Antonov wrote:
> From d01cd76d0b20ee8fa67c07da64b0e2301e510247 Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com <mailto:g.danil.anto@gmail.=
com>>
> Date: Wed, 29 Mar 2017 12:30:42 +0300
> Subject: [PATCH 17/43] net: made printf always compile in debug output

These header lines should not be in the body of the mail ... looks like
something went wrong with your mail setup?

> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
>=20
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com
> <mailto:g.danil.anto@gmail.com>>

... and please do not send HTML mails to the list. I strongly recommend
to set up a proper "git send-email" environment on your system if you
want to contribute more than one or two patches (which you obviously do
with your patch series of 43 patches already). And yes, you can use "git
send-email" with gmail, too!

> ---
>  hw/net/dp8393x.c        | 15 ++++++++++-----
>  hw/net/lan9118.c        | 20 ++++++++++++++------
>  hw/net/mcf_fec.c        | 18 +++++++++++-------
>  hw/net/stellaris_enet.c | 28 ++++++++++++++++++----------
>  4 files changed, 53 insertions(+), 28 deletions(-)
[...]
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index 3db8937..427160a 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -22,17 +22,25 @@
> =20
>  //#define DEBUG_LAN9118

I suggest you remove the above line now that you introduce the new one
below.

> +#ifndef DEBUG_LAN9118
> +#define DEBUG_LAN9118 0
> +#endif
> +
>  #ifdef DEBUG_LAN9118
> -#define DPRINTF(fmt, ...) \
> -do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
>  #define BADF(fmt, ...) \
>  do { hw_error("lan9118: error: " fmt , ## __VA_ARGS__);} while (0)
>  #else
> -#define DPRINTF(fmt, ...) do {} while(0)
>  #define BADF(fmt, ...) \
>  do { fprintf(stderr, "lan9118: error: " fmt , ## __VA_ARGS__);} while =
(0)
>  #endif

Since DEBUG_LAN9118 is now always defined, BADF will always be defined
here, too - so this is a change in behavior. I suggest you change the
above "#ifdef DEBUG_LAN9118" into "#if DEBUG_LAN9118" instead.

> +#define DPRINTF(fmt, ...)                                     \
> +    do {                                                      \
> +        if (DEBUG_LAN9118) {                                  \
> +            fprintf(stderr, "lan9118: " fmt, ## __VA_ARGS__); \
> +        }                                                     \
> +    } while (0)
> +
>  #define CSR_ID_REV      0x50
>  #define CSR_IRQ_CFG     0x54
>  #define CSR_INT_STS     0x58
> @@ -1033,7 +1041,7 @@ static void lan9118_writel(void *opaque, hwaddr
> offset,
>          s->int_sts |=3D val & SW_INT;
>          break;
>      case CSR_FIFO_INT:
> -        DPRINTF("FIFO INT levels %08x\n", val);
> +        DPRINTF("FIFO INT levels %08x\n", (int)val);
>          s->fifo_int =3D val;
>          break;
>      case CSR_RX_CFG:
> @@ -1114,9 +1122,9 @@ static void lan9118_writel(void *opaque, hwaddr
> offset,
>          if (val & 0x80000000) {
>              if (val & 0x40000000) {
>                  s->mac_data =3D do_mac_read(s, val & 0xf);
> -                DPRINTF("MAC read %d =3D 0x%08x\n", val & 0xf, s->mac_=
data);
> +                DPRINTF("MAC read %lx =3D 0x%08x\n", val & 0xf, s->mac=
_data);

The correct way to print an uint64_t value is to use PRIx64 ...
otherwise you'll run into problems when compiling this code on a 64-bit
host.

>              } else {
> -                DPRINTF("MAC write %d =3D 0x%08x\n", val & 0xf, s->mac=
_data);
> +                DPRINTF("MAC write %lx =3D 0x%08x\n", val & 0xf,
> s->mac_data);

PRIx64 again

>                  do_mac_write(s, val & 0xf, s->mac_data);
>              }
>          }
> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
> index bfa6b4b..b1430ee 100644
> --- a/hw/net/mcf_fec.c
> +++ b/hw/net/mcf_fec.c
> @@ -18,12 +18,16 @@
> =20
>  //#define DEBUG_FEC 1

Remove above line.

> -#ifdef DEBUG_FEC
> -#define DPRINTF(fmt, ...) \
> -do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> +#ifndef DEBUG_FEC
> +#define DEBUG_FEC 0
> +#endif
> +
> +#define DPRINTF(fmt, ...)                                     \
> +    do {                                                      \
> +        if (DEBUG_FEC) {                                      \
> +            fprintf(stderr, "mcf_fec: " fmt, ## __VA_ARGS__); \
> +        }                                                     \
> +    } while (0)
> =20
>  #define FEC_MAX_DESC 1024
>  #define FEC_MAX_FRAME_SIZE 2032
> @@ -557,7 +561,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc,
> const uint8_t *buf, size_t si
>      unsigned int buf_len;
>      size_t retsize;
> =20
> -    DPRINTF("do_rx len %d\n", size);
> +    DPRINTF("do_rx len %lx\n", size);

I think this is not portable, too. Either use %zd (or %zu), or cast the
size parameter instead.

>      if (!s->rx_enabled) {
>          return -1;
>      }
> diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
> index 04bd10a..e6f5e28 100644
> --- a/hw/net/stellaris_enet.c
> +++ b/hw/net/stellaris_enet.c
> @@ -13,16 +13,24 @@
> =20
>  //#define DEBUG_STELLARIS_ENET 1

Remove above line

> -#ifdef DEBUG_STELLARIS_ENET
> -#define DPRINTF(fmt, ...) \
> -do { printf("stellaris_enet: " fmt , ## __VA_ARGS__); } while (0)
> -#define BADF(fmt, ...) \
> -do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);
> exit(1);} while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#define BADF(fmt, ...) \
> -do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);}
> while (0)
> -#endif
> +#ifndef DEBUG_STELLARIS_ENET
> +#define DEBUG_STELLARIS_ENET 0
> +#endif
> +
> +#define DPRINTF(fmt, ...)                                            \
> +    do {                                                             \
> +        if (DEBUG_STELLARIS_ENET) {                                  \
> +            fprintf(stderr, "stellaris_enet: " fmt, ## __VA_ARGS__); \
> +        }                                                            \
> +    } while (0)
> +
> +#define BADF(fmt, ...)                                                =
   \
> +    do {                                                              =
   \
> +        fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__=
); \
> +        if (DEBUG_STELLARIS_ENET) {                                   =
   \
> +            exit(1);                                                  =
   \
> +        }                                                             =
   \
> +    } while (0)
> =20
>  #define SE_INT_RX       0x01
>  #define SE_INT_TXER     0x02
> --=20
> 2.8.0.rc3

 Thomas
