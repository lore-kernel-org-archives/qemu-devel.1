Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ftDJX-0007P6-VS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ftDJU-0002qc-KI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ftDJU-0002pZ-Ce
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:43:48 -0400
Date: Fri, 24 Aug 2018 15:43:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180824144341.GU3430@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, Aug 24, 2018 at 10:36:30AM -0400, Brad Smith wrote:
> I very much appreciate the effort to bump up to 6.3 as I was going
> to suggest doing that at some point. But bumping up to 6.3 at the
> moment will fail with the configure script. We've switched from GCC 4.2
> to Clang. The TLS check will fail with Clang's emulated TLS. We've
> had a local patch for awhile to fix the test but I don't think it is
> appropriate to upstream as is.
> 
> Index: configure
> --- configure.orig
> +++ configure
> @@ -1876,7 +1876,7 @@ static __thread int tls_var;
>  int main(void) { return tls_var; }
>  EOF
> -if ! compile_prog "-Werror" "" ; then
> +if ! compile_prog "-Werror" "-pthread" ; then
>      error_exit "Your compiler does not support the __thread specifier for " \
>  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
>  fi

Later on in the configure script there's a check for pthreads that
sets $PTHREAD_LIB to the desired arg.

Best is probably to move that check higher up, and then use $PTHREAD_LIB
as the argument to the compile_prog call you show.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
