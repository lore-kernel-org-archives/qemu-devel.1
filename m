Received: from eggs.gnu.org ([209.51.188.92]:51478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gzGE9-0006ya-6F
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gzGE8-00008M-3c
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:35:33 -0500
Received: from mail-oln040092072075.outbound.protection.outlook.com
	([40.92.72.75]:21570
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <casasfernando@outlook.com>)
	id 1gzGE7-0008Sw-IZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:35:32 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Thu, 28 Feb 2019 07:35:23 +0000
Message-ID: <VI1PR0602MB324518C5DF856414A8F7006EA4750@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB32453A8B5CBC0308C7D18F1DA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190223124940.48ff504b@ncopa-desktop.copa.dup.pw>
	<63bf2219-08ee-1741-49d6-856fca0e8d2c@redhat.com>
In-Reply-To: <63bf2219-08ee-1741-49d6-856fca0e8d2c@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Natanael Copa <ncopa@alpinelinux.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

Just wanted to share a small update on the situation after updating QEMU to=
 the new Alpine package patched with Natanael's patch.
So far so good, moreover I switched a few other guests from SATA to VirtIO =
SCSI and after two days no issues.
Unless I find any problem I will report back with an update in a week from =
now.

Thanks everyone for all you did to help find a solution to this issue.

On mar, feb 26, 2019 at 2:30 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
On 23/02/19 12:49, Natanael Copa wrote:
I suspect this happens due to the Alpine toolchain will enable _FORTIFY_SOU=
RCE=3D2 by default and the way this is implemented via fortify-headers: htt=
p://git.2f30.org/fortify-headers/file/include/string.h.html#l39
The call to __orig_memcpy is the culprit there, is there any reason not to =
do something like _FORTIFY_FN(memcpy) void *__memcpy_chk(void *__od, const =
void *__os, size_t __n) { size_t __bd =3D __builtin_object_size(__od, 0); s=
ize_t __bs =3D __builtin_object_size(__os, 0); char *__d =3D (char *)__od; =
const char *__s =3D (const char *)__os; /* trap if pointers are overlapping=
 but not if dst =3D=3D src. * gcc seems to like to generate code that relie=
s on dst =3D=3D src */ if ((__d < __s && __d + __n > __s) || (__s < __d && =
__s + __n > __d)) __builtin_trap(); if (__n > __bd || __n > __bs) __builtin=
_trap(); return memcpy(__od, __os, __n); } #define memcpy __memcpy_chk ? Th=
at is, getting rid of _FORTIFY_ORIG altogether. Paolo
