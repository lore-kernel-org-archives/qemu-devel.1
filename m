Received: from eggs.gnu.org ([209.51.188.92]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gycoc-00029x-KB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gycoW-00052j-9Y
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:30:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gycoQ-0004y9-Kv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:30:23 -0500
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63bf2219-08ee-1741-49d6-856fca0e8d2c@redhat.com>
Date: Tue, 26 Feb 2019 14:30:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190223124940.48ff504b@ncopa-desktop.copa.dup.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Natanael Copa <ncopa@alpinelinux.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On 23/02/19 12:49, Natanael Copa wrote:
> I suspect this happens due to the Alpine toolchain will enable
> _FORTIFY_SOURCE=2 by default and the way this is implemented via fortify-headers:
> http://git.2f30.org/fortify-headers/file/include/string.h.html#l39

The call to __orig_memcpy is the culprit there, is there any reason not
to do something like

_FORTIFY_FN(memcpy)
void *__memcpy_chk(void *__od, const void *__os, size_t __n)
{
	size_t __bd = __builtin_object_size(__od, 0);
	size_t __bs = __builtin_object_size(__os, 0);
	char *__d = (char *)__od;
	const char *__s = (const char *)__os;

	/* trap if pointers are overlapping but not if dst == src.
	 * gcc seems to like to generate code that relies on dst == src */
	if ((__d < __s && __d + __n > __s) ||
	    (__s < __d && __s + __n > __d))
		__builtin_trap();
	if (__n > __bd || __n > __bs)
		__builtin_trap();
	return memcpy(__od, __os, __n);
}
#define memcpy __memcpy_chk

?  That is, getting rid of _FORTIFY_ORIG altogether.

Paolo
