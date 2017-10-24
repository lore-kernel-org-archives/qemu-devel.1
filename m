Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xTR-0002s8-VD
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xTO-0005XI-TQ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:34:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46678)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xTO-0005WV-N5
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:34:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Oct 2017 14:34:14 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <7db986e7-3cec-f606-530d-f442b7562be3@redhat.com>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
	<CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
	<7db986e7-3cec-f606-530d-f442b7562be3@redhat.com>
Message-ID: <09bbb5c0ed85330e0828fbc9cc34583b@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/43] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alistair Francis <alistair23@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-09-26 20:27:
> On 09/26/2017 12:13 PM, Alistair Francis wrote:
>=20
>>> +#if (WINDBG_DEBUG_ON)
>>> +
>>> +# define WINDBG_DEBUG(...) do {    \
>>> +    printf("Debug: " __VA_ARGS__); \
>>> +    printf("\n");                  \
>>> +} while (false)
>>> +
>>> +# define WINDBG_ERROR(...) do {    \
>>> +    printf("Error: " __VA_ARGS__); \
>>> +    printf("\n");                  \
>>> +} while (false)
>>=20
>> Use qemu_log() instead of printf().
>>=20
>> Have a look as some other files for the usual way we handle debug=20
>> printing.
>>=20
>>> +
>>> +#else
>>> +
>>> +# define WINDBG_DEBUG(...)
>>> +# define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
>=20
> What's more - as written, your approach is prone to bit-rot: the
> debug/error statements are not compared against -Werror except for the
> rare person that enables debugging.  Better is go make the macro
> unconditionally expand to something that triggers -Wformat checking,=20
> but
> guarded by an if(0) for normal use.  Or even switch to trace points
> rather than debugging statements, so that you can control at runtime=20
> how
> much debugging information you want, rather than having to recompile to
> turn it on and off.

Thank you for your feedback.

I corrected it like this
#define WINDBG_DEBUG(...) do {             \
     if (WINDBG_DEBUG_ON) {                 \
         qemu_log(WINDBG ": " __VA_ARGS__); \
         qemu_log("\n");                    \
     }                                      \
} while (false)

You can find a new version here:
    =20
https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03912.html

--
Thanks,
Mihail Abakumov
