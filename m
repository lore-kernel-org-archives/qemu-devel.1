Received: from eggs.gnu.org ([2001:4830:134:3::10]:44891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tz9-0000i7-TU
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9tz6-0000aX-Kf
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9tz4-0000Vo-OQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:31:43 -0400
Date: Tue, 9 Oct 2018 16:31:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181009153132.GL22838@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-5-berrange@redhat.com>
	<w51h8hv88og.fsf@maestria.local.igalia.com>
	<20181009150629.GK22838@redhat.com>
	<w51bm8387e6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51bm8387e6.fsf@maestria.local.igalia.com>
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
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 09, 2018 at 05:30:25PM +0200, Alberto Garcia wrote:
> >> >      for (i = 0; i < lim; i++) {
> >> > -        xts_tweak_encdec(datactx, decfunc, src, dst, (uint8_t *)&T);
> >> > +        xts_uint128 S, D;
> >> > +
> >> > +        memcpy(&S, src, XTS_BLOCK_SIZE);
> >> > +        xts_tweak_encdec(datactx, decfunc, &S, &D, &T);
> >> > +        memcpy(dst, &D, XTS_BLOCK_SIZE);
> >> 
> >> Why do you need S and D?
> >
> > I think src & dst pointers can't be guaranteed to be aligned
> > sufficiently for int64 operations, if we just cast from uint8t*.
> 
> I see. I did a quick test without the memcpy() calls and it doesn't seem
> to have a visible effect on performance, but if it turns out that it
> does then maybe this is worth investigating further. I suspect all
> buffers received by this code are allocated with qemu_try_blockalign()
> anyway, so it should be safe.

The extra memcpy() calls certainly had a perf impact when I added
them, so if we can determine that we can safely do without, that
would be desirable.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
