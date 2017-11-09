Received: from eggs.gnu.org ([2001:4830:134:3::10]:44676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCd6y-0000EU-K7
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCd6x-0003b7-Fx
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:02:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<7d327222a677c66a4de74f563fa9af09b87b636a.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3fbc39a-b63e-ab27-58ac-67edb72d590b@amsat.org>
Date: Thu, 9 Nov 2017 00:02:25 -0300
MIME-Version: 1.0
In-Reply-To: <7d327222a677c66a4de74f563fa9af09b87b636a.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 06/45] hw/block: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Aurelien Jarno <aurelien@aurel32.net>, Samuel Tardieu <sam@rfc1149.net>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexis Polti <alexis.polti@telecom-paristech.fr>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, qemu-block@nongnu.org

On 11/08/2017 07:56 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
[...]
> diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
> index 1d9f7ee000..d274c9aafe 100644
> --- a/hw/block/tc58128.c
> +++ b/hw/block/tc58128.c

OMG you found a rare pearl, I enjoyed reading this file git history :)
Not a single logical change since his origin...

http://web.archive.org/web/20070917001736/perso.enst.fr/~polti/realisations/shix20
<3 <3

> @@ -50,8 +50,8 @@ static void init_dev(tc58128_dev * dev, const char *filename)
>  	    dev->flash_contents[1] = (blocks >> 8) & 0xff;
>  	    dev->flash_contents[2] = (blocks >> 16) & 0xff;
>  	    dev->flash_contents[3] = (blocks >> 24) & 0xff;
> -	    fprintf(stderr, "loaded %d bytes for %s into flash\n", ret,
> -		    filename);
> +        error_report("loaded %d bytes for %s into flash", ret,
> +                     filename);

This one should be info_report().

>  	}
>      }
>  }
> @@ -60,26 +60,26 @@ static void handle_command(tc58128_dev * dev, uint8_t command)
>  {
>      switch (command) {
>      case 0xff:
> -	fprintf(stderr, "reset flash device\n");
> -	dev->state = WAIT;
> -	break;
> +        error_report("reset flash device");

info_report() or even cleaner trace_tc58128_command()?

> +        dev->state = WAIT;
> +        break;
>      case 0x00:
> -	fprintf(stderr, "read mode 1\n");
> -	dev->state = READ1;
> -	dev->address_cycle = 0;
> -	break;
> +        error_report("read mode 1");

Ditto.

> +        dev->state = READ1;
> +        dev->address_cycle = 0;
> +        break;
>      case 0x01:
> -	fprintf(stderr, "read mode 2\n");
> -	dev->state = READ2;
> -	dev->address_cycle = 0;
> -	break;
> +        error_report("read mode 2");

Ditto.

> +        dev->state = READ2;
> +        dev->address_cycle = 0;
> +        break;
>      case 0x50:
> -	fprintf(stderr, "read mode 3\n");
> -	dev->state = READ3;
> -	dev->address_cycle = 0;
> -	break;
> +        error_report("read mode 3");

Ditto.

> +        dev->state = READ3;
> +        dev->address_cycle = 0;
> +        break;
>      default:
> -	fprintf(stderr, "unknown flash command 0x%02x\n", command);
> +        error_report("unknown flash command 0x%02x", command);
>          abort();
>      }
>  }
> @@ -103,8 +103,8 @@ static void handle_address(tc58128_dev * dev, uint8_t data)
>  	    break;
>  	case 2:
>  	    dev->address += data * 528;
> -	    fprintf(stderr, "address pointer in flash: 0x%08x\n",
> -		    dev->address);
> +        error_report("address pointer in flash: 0x%08x",
> +                     dev->address);

warn_report()?

>  	    break;
>  	default:
>  	    /* Invalid data */
> @@ -119,10 +119,6 @@ static void handle_address(tc58128_dev * dev, uint8_t data)
>  
>  static uint8_t handle_read(tc58128_dev * dev)
>  {
> -#if 0
> -    if (dev->address % 0x100000 == 0)
> -	fprintf(stderr, "reading flash at address 0x%08x\n", dev->address);
> -#endif
>      return dev->flash_contents[dev->address++];
>  }
