Received: from eggs.gnu.org ([2001:4830:134:3::10]:51597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYxNs-0002j5-NO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYxNp-00024i-FO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:08:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYxNp-000246-9Q
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:08:17 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-5-f4bug@amsat.org>
	<5d8097eb-3300-56b5-adc4-94fb8de9c0ba@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b5bb4bf-3f85-1b09-fa6b-2a2269a203f1@redhat.com>
Date: Tue, 9 Jan 2018 18:08:06 +0100
MIME-Version: 1.0
In-Reply-To: <5d8097eb-3300-56b5-adc4-94fb8de9c0ba@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] slirp: add in6_multicast() and use
 it instead of IN6_IS_ADDR_MULTICAST()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 09.01.2018 17:33, Richard Henderson wrote:
> On 01/08/2018 09:28 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Host: Mac OS 10.12.5
>> Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
>>
>>   slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip=
_src' of class or
>>         structure 'ip6' may result in an unaligned pointer value
>>         [-Waddress-of-packed-member]
>>       if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
>>                                  ^~~~~~~~~~
>>   /usr/include/netinet6/in6.h:299:36: note: expanded from macro 'IN6_I=
S_ADDR_MULTICAST'
>>   #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff=
)
>=20
> The fact that you replace a macro with a function of exactly the same c=
ode in
> order to avoid a diagnostic sure looks like a compiler bug to me.

I think this might also be a bug in the macro definitions. On Linux, it
is defined like this:

#define IN6_IS_ADDR_MULTICAST(a) (((const uint8_t *) (a))[0] =3D=3D 0xff)

 Thomas
