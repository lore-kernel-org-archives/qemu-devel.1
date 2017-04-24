Received: from eggs.gnu.org ([2001:4830:134:3::10]:36417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2eAM-0004Kb-Rq
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2eAJ-0007z9-Jm
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2eAJ-0007yl-D7
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:36:31 -0400
Date: Mon, 24 Apr 2017 14:36:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424133624.GP20809@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: GM.Ijewski@web.de, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 24, 2017 at 02:30:25PM +0100, Peter Maydell wrote:
> On 24 April 2017 at 13:50, Daniel P. Berrange <berrange@redhat.com> wrote:
> > For subject line, better to describe the change made, rather than
> > the problem.
> >
> > On Mon, Apr 24, 2017 at 02:17:56PM +0200, GM.Ijewski@web.de wrote:
> >> Now it calls CryptGenRandom() if is it compiled for windows.
> >>
> >> It might be possible to save the cryptographic provider in between
> >> invocations, e.g. by making it static -- I have no idea how computationally
> >> intensive that operation actually is.
> >
> > I'd think most people should really just enable gnutls during build. This just
> > has to provide a fallback that's good enough to be functional. If someone really
> > cares about performance of this fallback, they can send patches later....
> 
> What I think is more worrying is the suggestion in the CryptAcquireContext
> docs that this might for instance prompt the user for a password to
> decrypt keys. We definitely don't want to do that every time. In
> fact we'd rather not do it at all.
> 
> Googling suggests that the approach used by web browsers is
> to use the not-very-documented RtlGenRandom function:
> https://dxr.mozilla.org/mozilla-central/source/security/nss/lib/freebl/win_rand.c#141
> https://chromium.googlesource.com/chromium/src.git/+/master/base/rand_util_win.cc
> 
> That looks much simpler than trying to use the official crypto
> APIs. (It's also what the MS C runtime library does to implement
> rand_s().)

FYI, both gnutls and openssl use these CryptAcquireContext/CryptGenRandom
methods, so I'd prefer to stick with that.

It seems we merely need to set CRYPT_SILENT in the flags to prevent any
chance of interactive prompts.

https://msdn.microsoft.com/en-us/library/windows/desktop/aa379886(v=vs.85).aspx

"CRYPT_SILENT is intended for use with applications for which the UI
 cannot be displayed by the CSP."

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
