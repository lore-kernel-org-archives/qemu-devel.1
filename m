Received: from eggs.gnu.org ([2001:4830:134:3::10]:49092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6FIB-0002OE-5S
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6FIA-0002EW-Fn
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:51:31 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-2-pbonzini@redhat.com>
	<20170504111536.GG32376@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22c7d16c-116a-3d28-8cc8-88f737ee7cc8@redhat.com>
Date: Thu, 4 May 2017 13:51:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170504111536.GG32376@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/17] block: access
 copy_on_read with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 13:15, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 02:00:42PM +0200, Paolo Bonzini wrote:
>>  void bdrv_disable_copy_on_read(BlockDriverState *bs)
>>  {
>> -    assert(bs->copy_on_read > 0);
>> -    bs->copy_on_read--;
>> +    assert(atomic_read(&bs->copy_on_read) > 0);
>> +    atomic_dec(&bs->copy_on_read);
>>  }
>=20
> To make this truly thread-safe:
>=20
>   old =3D atomic_dec_fetch(&bs->copy_on_read);
>   assert(old > 0);

Good point.  It feels wrong to assert after the fact, but then so does
making the assertion not quite thread safe.

Paolo
