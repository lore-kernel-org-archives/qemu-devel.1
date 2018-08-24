Received: from eggs.gnu.org ([2001:4830:134:3::10]:58272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1ftDCh-0003vu-Ad
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1ftDCg-0005AN-ER
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:36:47 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:24765
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1ftDCg-00051i-8a
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:36:46 -0400
References: <20180824012126.22721-1-famz@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
Date: Fri, 24 Aug 2018 10:36:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180824012126.22721-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

I very much appreciate the effort to bump up to 6.3 as I was going
to suggest doing that at some point. But bumping up to 6.3 at the
moment will fail with the configure script. We've switched from GCC 4.2
to Clang. The TLS check will fail with Clang's emulated TLS. We've
had a local patch for awhile to fix the test but I don't think it is
appropriate to upstream as is.

Index: configure
--- configure.orig
+++ configure
@@ -1876,7 +1876,7 @@ static __thread int tls_var;
  int main(void) { return tls_var; }
  EOF
  
-if ! compile_prog "-Werror" "" ; then
+if ! compile_prog "-Werror" "-pthread" ; then
      error_exit "Your compiler does not support the __thread specifier for " \
  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
  fi

On 8/23/2018 9:21 PM, Fam Zheng wrote:
> Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
> include SDL2.
>
> One limitation of this patch is that we need a temporary HTTP server on
> host 80 port for auto_install, because slirp cannot do guest forward on
> "host addr".
