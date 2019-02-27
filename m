Received: from eggs.gnu.org ([209.51.188.92]:33521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gywy4-0004us-0A
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gywy2-0005Pa-Eb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:01:39 -0500
Date: Wed, 27 Feb 2019 11:01:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227110127.GE31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227012132.16271-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
> At present, when seccomp support is compiled out with --disable-seccomp
> we fail with an error if the user puts -sandbox on the command line.
> 
> That kind of makes sense, but it's a bit strange that we reject a request
> to disable sandboxing with "-sandbox off" saying we don't support
> sandboxing.
> 
> This puts in a small sandbox to (correctly) silently ignore -sandbox off
> when we don't have sandboxing support compiled in.  This makes life easier
> for testcases, since they can safely specify "-sandbox off" without having
> to care if the qemu they're using is compiled with sandbox support or not.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  vl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 502857a176..9d5f1b7ebb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3857,9 +3857,11 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>  #else
> -                error_report("-sandbox support is not enabled "
> -                             "in this QEMU binary");
> -                exit(1);
> +                if (!g_str_equal(optarg, "off")) {
> +                    error_report("-sandbox support is not enabled "
> +                                 "in this QEMU binary");
> +                    exit(1);
> +                }

'-sandbox off'  is just syntax sugar for '-sandbox enable=off', with
the default arg name handled by QemuOpts.

If we want to keep ability to run "-sandbox off" we should do it via
the QEMU opts code we already have in the first part of the conditional,
so that "-sandbox enable=off" also works as normal.

Essentially we need to push the #ifdef CONFIG_SECCOMP down into the
parse_sandbox method, so that it parses the "enable" option normally
but rejects any value except disabled..

The QemuOptsList should also be conditional to only register the
"enable"  arg and not the other bits.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
