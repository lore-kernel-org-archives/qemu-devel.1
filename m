Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e723d-0004g2-Fo
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e723Z-0000yu-QK
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e723Z-0000x4-Jr
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:27:57 -0400
Date: Tue, 24 Oct 2017 17:27:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171024162752.GA21671@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171024085853.32615-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171024085853.32615-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On Tue, Oct 24, 2017 at 07:58:53PM +1100, Alexey Kardashevskiy wrote:
> The new git-submodule.sh script writes .git-submodule-status to
> the source directory every time no matter what. This makes it conditional.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I compile out of tree on a remote guest system where I mount the
> source directory as "readonly" and build directory as "rw" and
> scripts/git-submodule.sh tries writing to the source directory even when
> I manually update modules on a host machine which is quite annoying.
> 
> Is this something acceptable? Or I am missing something here?

How did you update the modules - did you manually run  'git submodule update...'
or did you use the git-submodule.sh script on your host machine ?

If you run git-submodule.sh on the host, then it should save the status
file, and then when you run make on the guest system, it should notice
that you're already updated and never even invoke 'git-submodule.sh update'

I'm not against your proposal below, but I'm curious why you're seeing
'git-submodule.sh update' being run by make in the first place.

> 
> ---
>  scripts/git-submodule.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index d8fbc7e47e..b642994a67 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -33,6 +33,8 @@ status)
>      ;;
>  update)
>      git submodule update --init $modules 1>/dev/null 2>&1
> -    git submodule status $modules > "${substat}"
> +    substat_tmp=$(mktemp)
> +    git submodule status $modules > "$substat_tmp"
> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
>      ;;
>  esac
> -- 
> 2.11.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
