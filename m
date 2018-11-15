Received: from eggs.gnu.org ([2001:4830:134:3::10]:48235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEcL-0004O6-Qf
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEcK-0005ib-Vt
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:11:21 -0500
Date: Thu, 15 Nov 2018 10:11:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115101112.GF10900@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181115035659.85245-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115035659.85245-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] configure/fdt: Use more strict test
 for libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, Nov 15, 2018 at 02:56:59PM +1100, Alexey Kardashevskiy wrote:
> The libfdt installed in the system is preferred to the dtc submodule by
> default. The recent libfdt update added a new symbol - fdt_check_full -
> and this breaks compile if there is an older libfdt installed in
> the system.

Unless I'm missing something, QEMU doesn't use the fdt_check_full symbol,
so why would the lack of this symbol cause a compile failure. 

It should be fine if the dtc submodule contains a newer libfdt than the
host system. As long as QEMU doesn't actually need any of the APIs in
the newer libfdt we should be able to continue using the older system
version if it is present.

Could you elaborate on what build problems you are having.

> This changes the test to force ./configure into using newer libfdt.

I'm not convinced we want todo that.

> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 74e313a..7e16a6c 100755
> --- a/configure
> +++ b/configure
> @@ -3826,7 +3826,7 @@ if test "$fdt" != "no" ; then
>    cat > $TMPC << EOF
>  #include <libfdt.h>
>  #include <libfdt_env.h>
> -int main(void) { fdt_first_subnode(0, 0); return 0; }
> +int main(void) { fdt_check_full(NULL, 0); return 0; }
>  EOF
>    if compile_prog "" "$fdt_libs" ; then
>      # system DTC is good - use it

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
