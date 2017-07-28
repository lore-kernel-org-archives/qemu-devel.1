Received: from eggs.gnu.org ([2001:4830:134:3::10]:56568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxP8-0001i2-K4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxP6-0005f4-1I
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:01:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxP5-0005ek-Rs
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:01:35 -0400
Received: by mail-qt0-x244.google.com with SMTP id d10so10573254qtb.4
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:01:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170718163437.18001-1-marcandre.lureau@redhat.com>
	<20170726203933-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89be4d2c-1b7e-2a12-b4e4-5f279cb88a91@amsat.org>
Date: Fri, 28 Jul 2017 02:01:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170726203933-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 07/26/2017 02:52 PM, Michael S. Tsirkin wrote:
> On Tue, Jul 18, 2017 at 06:34:37PM +0200, Marc-André Lureau wrote:
...
>> In the future, we may want to hide vhost-user from QAPI/introspection
>> with conditional compilation, although the design of this hasn't been
>> fully fleshed out yet and shouldn't prevent this patch from being
>> applied.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> After an offline discussion, looks like the idea is to be able to ship a
> cut down binary with less features (and e.g. smaller attack surface?).

I think it deserves it own thread, there will be many ideas about it.

I liked this idea a first because it speeds up compilation time (so the 
CI build system can run more tests, cover more of less code...) but then 
we have this unreadable unmanageable ifdefery very hard to maintain, you 
end up not compiling this piece of code, then move things around, 
refactor a bit, change some API and zombie code survives around until 
someone who has this lib try to compile the obsolete code.

This is also why I now prefer to build via docker images (the 
qemu:debian-amd64 try to come with as many dev packages as possible to 
increase code coverage).

There is some dream about having one monolithic QEMU binary able to run 
all cpus/machines/devices. I think this way do reduce attack surface by 
exposing all the surface. This is a bit what is happening during release 
candidate testing when /master is closed, people start to use QEMU 
[differently than while adding features], more surface is stressed, then 
many issues appear and get resolved.

Thomas Huth did some effort adding more poisoned macros and move common 
objects to common-obj, we can do more here, we may need to split more 
sources to move more common code.


Another experience is I'm trying to model a 32-bit big endian ARM board 
then got bugged with 64-bit code this board will never use, or issue 
with PCI and AHCI, so I started to comment those objects using 
obj-$(CONFIG_X) but then CONFIG_X also depends of CONFIG_Y and so, then 
it become hardly scalable, see [1]:

+CONFIG_LAN9118=$(or 
$(CONFIG_REALVIEW),$(CONFIG_EXYNOS4),$(CONFIG_FSL_IMX31))
+CONFIG_SMC91C111=$(or 
$(CONFIG_PXA2XX),$(CONFIG_MAINSTONE),$(CONFIG_REALVIEW))
+CONFIG_ARM_MPTIMER=$(or 
$(CONFIG_A9MPCORE),$(CONFIG_ARM11MPCORE),$(CONFIG_A15MPCORE))
+CONFIG_HIGHBANK=$(and $(CONFIG_A9MPCORE),$(CONFIG_A15MPCORE))

we already have:

crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += 
hmac-glib.o
crypto/Makefile.objs:23:crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if 
$(CONFIG_GNUTLS_RND),n,y)) += random-platform.o

I ended dropping this branch, I was thinking about using kconfig to 
manage dependencies... The obj-$(CONFIG_XYZ) is useful when kept tiny, 
at most 1 bitwise operation.

I wanted to share my experience and thoughts about it, I hope it's still 
understandable because it's very late :S

Regards,

Phil.

 > Besides failing build on freebsd, this patch has too much ifdefery for
 > my taste. How about we patch just net/net.c?

[1] 
https://github.com/philmd/qemu/commit/2c1c515345d626f47d0968821980f9389d4588b2#diff-6006132695caf8d409e781fbf3d4401f
