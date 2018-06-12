Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSqT7-0003vj-VZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSqT6-0004ko-W7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:04:45 -0400
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
	<15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
Date: Tue, 12 Jun 2018 16:04:33 -0500
MIME-Version: 1.0
In-Reply-To: <15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On 06/12/2018 03:51 PM, Richard Henderson wrote:
> On 06/10/2018 03:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>       xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filenam=
e \"%s\","
>> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
>> +                  " size %" PRId64 " (%llu MB)\n",
>>                     blkdev->type, blkdev->fileproto, blkdev->filename,
>> -                  blkdev->file_size, blkdev->file_size >> 20);
>> +                  blkdev->file_size, blkdev->file_size / MiB);
>=20
> Having to change printf markup is exactly why you shouldn't use ULL in =
MiB.

Conversely, M_BYTE was already ULL, so if you don't use it in MiB,=20
you'll have to change other printf markup where you were changing those=20
uses.

One benefit of using the widest possible type: we avoid risk of silent=20
truncation.  Potential downsides: wasted processing time (when 32 bits=20
was sufficient), and compilers might start warning when we narrow a=20
64-bit value into a 32-bit variable (but I think we already ignore that).

One benefit of using the natural type that holds the value: use of=20
64-bit math is explicit based on the type of what else is being=20
multiplied by the macro.  Potential downside: 32*32 assigned to a 64-bit=20
result may be botched (but hopefully Coverity will flag it).

So there's tradeoffs either way, and you at least need to document in=20
your commit messages what auditing you have done that any type changes=20
introduced by your changes are safe.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
