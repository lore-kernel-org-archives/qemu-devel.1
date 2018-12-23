Received: from eggs.gnu.org ([2001:4830:134:3::10]:44117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gb7HB-0005IE-53
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gb7HA-0003DI-9Q
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:10:53 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gb7HA-0003Cw-55
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:10:52 -0500
Received: by mail-ot1-x341.google.com with SMTP id s5so9343341oth.7
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 09:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127121724.19755-1-sw@weilnetz.de>
	<20181127121724.19755-3-sw@weilnetz.de>
In-Reply-To: <20181127121724.19755-3-sw@weilnetz.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 23 Dec 2018 18:10:38 +0100
Message-ID: <CAL1e-=g9u5PONfeord2BUWsu-EKm7h2rx-_-9QarE=50JoZdfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] disas/nanomips: Fix format
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Nov 27, 2018 at 1:19 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  disas/nanomips.cpp | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>

Hi, Stefan,

My plan is to accept this patch plus (in the same patch) following
changes in nanomips.h:

This code:

typedef unsigned short uint16;
typedef unsigned int uint32;
typedef long long int64;
typedef unsigned long long uint64;

namespace img
{
    typedef unsigned long long address;
}

should become:

typedef uint16_t uint16;
typedef uint32_t uint32;
typedef int64_t int64;
typedef uint64_t uint64;

namespace img
{
    typedef uint64_t address;
}

The reason is that I would like to keep custom types. The custom types
names "uint32", "int64", etc. are admittedly too generic, but that
will change in further development, and it looks do not bother any
compiler so far. This means that patch 1/1 will not be applied.

There is no need for respin, I will do the corrections while
integrating pull request.

Please let me know if you object over this.

Thanks again for bringing all these issues!

Aleksandar




> diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
> index 4c3cfceaba..a3f69348b3 100644
> --- a/disas/nanomips.cpp
> +++ b/disas/nanomips.cpp
> @@ -284,7 +284,8 @@ uint64_t NMD::renumber_registers(uint64_t index, uint64_t *register_list,
>      }
>
>      throw std::runtime_error(img::format(
> -                   "Invalid register mapping index %d, size of list = %d",
> +                   "Invalid register mapping index %" PRIu64
> +                   ", size of list = %zu",
>                     index, register_list_size));
>  }
>
> @@ -501,7 +502,8 @@ std::string NMD::GPR(uint64_t reg)
>          return gpr_reg[reg];
>      }
>
> -    throw std::runtime_error(img::format("Invalid GPR register index %d", reg));
> +    throw std::runtime_error(img::format("Invalid GPR register index %" PRIu64,
> +                                         reg));
>  }
>
>
> @@ -518,7 +520,8 @@ std::string NMD::FPR(uint64_t reg)
>          return fpr_reg[reg];
>      }
>
> -    throw std::runtime_error(img::format("Invalid FPR register index %d", reg));
> +    throw std::runtime_error(img::format("Invalid FPR register index %" PRIu64,
> +                                         reg));
>  }
>
>
> @@ -532,26 +535,27 @@ std::string NMD::AC(uint64_t reg)
>          return ac_reg[reg];
>      }
>
> -    throw std::runtime_error(img::format("Invalid AC register index %d", reg));
> +    throw std::runtime_error(img::format("Invalid AC register index %" PRIu64,
> +                                         reg));
>  }
>
>
>  std::string NMD::IMMEDIATE(uint64_t value)
>  {
> -    return img::format("0x%x", value);
> +    return img::format("0x%" PRIx64, value);
>  }
>
>
>  std::string NMD::IMMEDIATE(int64_t value)
>  {
> -    return img::format("%d", value);
> +    return img::format("%" PRId64, value);
>  }
>
>
>  std::string NMD::CPR(uint64_t reg)
>  {
>      /* needs more work */
> -    return img::format("CP%d", reg);
> +    return img::format("CP%" PRIu64, reg);
>  }
>
>
> --
> 2.11.0
>
>
