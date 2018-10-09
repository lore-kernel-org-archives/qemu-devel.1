Received: from eggs.gnu.org ([2001:4830:134:3::10]:44285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9ty1-0008Vv-E7
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9txy-0008ET-2x
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:30:37 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9txu-0008BD-OB
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:30:32 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009150629.GK22838@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-5-berrange@redhat.com>
	<w51h8hv88og.fsf@maestria.local.igalia.com>
	<20181009150629.GK22838@redhat.com>
Date: Tue, 09 Oct 2018 17:30:25 +0200
Message-ID: <w51bm8387e6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/6] crypto: convert xts_tweak_encdec to
 use xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

>> >      for (i = 0; i < lim; i++) {
>> > -        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
>> > +        xts_uint128 S, D;
>> > +
>> > +        memcpy(&S, src, XTS_BLOCK_SIZE);
>> > +        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
>> > +        memcpy(dst, &D, XTS_BLOCK_SIZE);
>> 
>> Why do you need S and D?
>
> I think src & dst pointers can't be guaranteed to be aligned
> sufficiently for int64 operations, if we just cast from uint8t*.

I see. I did a quick test without the memcpy() calls and it doesn't seem
to have a visible effect on performance, but if it turns out that it
does then maybe this is worth investigating further. I suspect all
buffers received by this code are allocated with qemu_try_blockalign()
anyway, so it should be safe.

Berto
