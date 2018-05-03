Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fECSD-0005Dr-GH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fECSC-00040P-Im
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fECSC-0003zx-FK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1525345473-31593-1-git-send-email-thuth@redhat.com>
Date: Thu, 03 May 2018 13:31:12 +0200
In-Reply-To: <1525345473-31593-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 3 May 2018 13:04:33 +0200")
Message-ID: <87wowlou0v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Mark -virtioconsole as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> The qemu-doc already states that this option is only maintained for
> backward compatibility and "-device virtconsole" should be used
> instead. So let's take the next step and mark this option officially
> as deprecated.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi   | 5 +++++
>  qemu-options.hx | 2 +-
>  vl.c            | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 5813d27..e48ed05 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2931,6 +2931,11 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
>  
>  The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
>  
> +@subsection -virtioconsole (since 2.13.0)
> +
> +You can use @code{-device virtconsole} instead of @code{-virtioconsole}
> +to configure a virtio-console.
> +

Or maybe "Option @option{-virtioconsole} has been replaced by
@option{-device virtconsole}", to better match similar notes nearby.
Your choice.

>  @section qemu-img command line arguments
>  
>  @subsection convert -s (since 2.0.0)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c611766..7693d2c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3676,7 +3676,7 @@ STEXI
>  @findex -virtioconsole
>  Set virtio console.
>  
> -This option is maintained for backward compatibility.
> +This option is deprecated and only maintained for backward compatibility.

Suggest "This option is deprecated, use @option{-device virtconsole}
instead".

>  
>  Please use @code{-device virtconsole} for the new way of invocation.
>  ETEXI
> diff --git a/vl.c b/vl.c
> index 7487535..c409ff3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3634,6 +3634,8 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_virtiocon:
> +                warn_report("This option is deprecated, "
> +                            "use '-device virtconsole' instead.");

Please drop the period.

>                  add_device_config(DEV_VIRTCON, optarg);
>                  default_virtcon = 0;
>                  if (strncmp(optarg, "mon:", 4) == 0) {

With that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
