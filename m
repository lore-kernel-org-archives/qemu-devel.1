Received: from eggs.gnu.org ([2001:4830:134:3::10]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSgmB-0008R3-Gv
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSgm7-0000Fv-Ha
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSgm7-0000FO-Aw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:15:59 -0500
Date: Fri, 30 Nov 2018 11:15:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130111555.GA9162@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543574620-17506-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543574620-17506-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] compiler.h: Add an explicit check
 for the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com, peter.maydell@linaro.org

On Fri, Nov 30, 2018 at 11:43:40AM +0100, Thomas Huth wrote:
> The questions about our minimum compiler requirement pops up every
> couple of months, and we then have to recall the details each time.
> So let's document this in a proper way, by adding a comment and
> check for the right compiler version to our compiler.h header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index ca9bc85..775446b 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -22,6 +22,14 @@
>  # define QEMU_GNUC_PREREQ(maj, min) 0
>  #endif
>  
> +/*
> + * We need at least GCC 4.1 for atomics support. Clang also supports these,
> + * and reports itself as GCC 4.2, so it passes this check, too.
> + */
> +#if !QEMU_GNUC_PREREQ(4, 1)
> +#error QEMU needs a compiler that is compatible with GCC v4.1 or newer
> +#endif

This encodes our current minimum which is fine as a first step.

I think we could reasonably increase our min version now that we
have declared explicitly what platforms we intend to support

      RHEL-7: 4.8.5
      Debian (Stretch): 6.3.0
      Debian (Jessie): 4.8.4
      OpenBSD (ports): 4.9.4
      FreeBSD (ports): 8.2.0
      OpenSUSE Leap 15: 7.3.1
      Ubuntu (Xenial): 5.3.1
      macOS (Homebrew): 8.2.0

Arguably we don't care about gcc version for *BSD and macOS since those
platforms normally use CLang

Anyway, with this info I think we can reasonably pick gcc 4.8.0

We would need an explicit check for clang, however, instead of
relying on it claiming gcc 4.2 support - that's a way inaccurate
claim anyway so detecting a specific clang version would be
better regardless IMHO


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
