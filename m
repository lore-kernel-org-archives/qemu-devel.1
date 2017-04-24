Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2e4m-0002xI-LQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2e4l-0005ia-PS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:30:48 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2e4l-0005iG-Hq
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:30:47 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w64so62040895wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 06:30:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424125016.GM20809@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 14:30:25 +0100
Message-ID: <CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: GM.Ijewski@web.de, QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 13:50, Daniel P. Berrange <berrange@redhat.com> wrote:
> For subject line, better to describe the change made, rather than
> the problem.
>
> On Mon, Apr 24, 2017 at 02:17:56PM +0200, GM.Ijewski@web.de wrote:
>> Now it calls CryptGenRandom() if is it compiled for windows.
>>
>> It might be possible to save the cryptographic provider in between
>> invocations, e.g. by making it static -- I have no idea how computationally
>> intensive that operation actually is.
>
> I'd think most people should really just enable gnutls during build. This just
> has to provide a fallback that's good enough to be functional. If someone really
> cares about performance of this fallback, they can send patches later....

What I think is more worrying is the suggestion in the CryptAcquireContext
docs that this might for instance prompt the user for a password to
decrypt keys. We definitely don't want to do that every time. In
fact we'd rather not do it at all.

Googling suggests that the approach used by web browsers is
to use the not-very-documented RtlGenRandom function:
https://dxr.mozilla.org/mozilla-central/source/security/nss/lib/freebl/win_rand.c#141
https://chromium.googlesource.com/chromium/src.git/+/master/base/rand_util_win.cc

That looks much simpler than trying to use the official crypto
APIs. (It's also what the MS C runtime library does to implement
rand_s().)

thanks
-- PMM
