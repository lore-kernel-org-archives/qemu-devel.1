Received: from eggs.gnu.org ([2001:4830:134:3::10]:38624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJG6-0004ak-Dg
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJG2-0004Rf-FO
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSJG2-0004R3-5l
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:30 -0400
Date: Tue, 4 Jul 2017 09:32:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704083224.GB3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499099693-22903-3-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/22] configure: early test for supported
 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On Mon, Jul 03, 2017 at 06:34:33PM +0200, Paolo Bonzini wrote:
> Check for unsupported targets in target_list, and print an
> error early in the configuration process.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 65 ++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/configure b/configure
> index 0f14e79..6d1a6a9 100755
> --- a/configure
> +++ b/configure
> @@ -40,14 +40,18 @@ printf " '%s'" "$0" "$@" >> config.log
>  echo >> config.log
>  echo "#" >> config.log
>  
> -error_exit() {
> -    echo
> +print_error() {
> +    (echo
>      echo "ERROR: $1"
>      while test -n "$2"; do
>          echo "       $2"
>          shift
>      done
> -    echo
> +    echo) >&2
> +}
> +
> +error_exit() {
> +    print_error "$@"
>      exit 1
>  }
>  
> @@ -207,6 +211,25 @@ supported_xen_target() {
>      return 1
>  }
>  
> +supported_target() {
> +    case "$1" in
> +        ${target_name}-softmmu) ;;

Nit-pick, I'd prefer the ';;' on a separate line, as currently it at
first looks like the -softmmu line will fallthrough to the -linux-user
block below. Took a while before I noticed the trailing ;;

Or alternatively add a blank line between cases

> +        ${target_name}-linux-user)
> +            if test "$linux" != "yes"; then
> +                print_error "Target '$target' is only available on a Linux host"
> +                return 1
> +            fi
> +            ;;
> +        ${target_name}-bsd-user)
> +            if test "$bsd" != "yes"; then
> +                print_error "Target '$target' is only available on a BSD host"
> +                return 1
> +            fi
> +            ;;

Add a wildcard match as a catch-all to avoid falling through to the
success codepath on unknown items ?

> +    esac
> +    return 0
> +}
> +
>  # default parameters
>  source_path=$(dirname "$0")
>  cpu=""
> @@ -1734,23 +1757,27 @@ if test "$solaris" = "yes" ; then
>  fi
>  
>  if test -z "${target_list+xxx}" ; then
> -    target_list="$default_target_list"
> +    for target in $default_target_list; do
> +        supported_target $target 2>/dev/null && \
> +            target_list="$target_list $target"
> +    done

I'm not sure what the benefit of this change is ?  It is calling
supported_target but throwing away anything it prints. So if there
was a mistake in the default target list setup, we'd never see it,
just silently discard it.

> +    target_list="${target_list# }"
>  else
>      target_list=$(echo "$target_list" | sed -e 's/,/ /g')
> +    for target in $target_list; do
> +        # Check that we recognised the target name; this allows a more
> +        # friendly error message than if we let it fall through.
> +        case " $default_target_list " in
> +            *" $target "*)
> +                ;;
> +            *)
> +                error_exit "Unknown target name '$target'"
> +                ;;
> +        esac
> +        supported_target $target || exit 1
> +    done
>  fi
>  
> -# Check that we recognised the target name; this allows a more
> -# friendly error message than if we let it fall through.
> -for target in $target_list; do
> -    case " $default_target_list " in
> -        *" $target "*)
> -            ;;
> -        *)
> -            error_exit "Unknown target name '$target'"
> -            ;;
> -    esac
> -done
> -

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
