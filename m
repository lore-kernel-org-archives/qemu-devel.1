Received: from eggs.gnu.org ([2001:4830:134:3::10]:57449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIrUy-0000mx-R6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIrUv-0007jt-Ll
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIrUv-0007jc-Dp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1496899257-25800-1-git-send-email-thuth@redhat.com>
Date: Thu, 08 Jun 2017 09:04:46 +0200
In-Reply-To: <1496899257-25800-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 8 Jun 2017 07:20:57 +0200")
Message-ID: <87shjbj6y9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vl: Fix broken thread=xxx option of the
 --accel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Emilio G Cota <cota@braap.org>

Thomas Huth <thuth@redhat.com> writes:

> Commit bde4d9205 ("Fix the -accel parameter and the documentation for
> 'hax'") introduced a regression by adding a new local accel_opts
> variable which shadows the variable with the same name that is
> declared at the beginning of the main() scope. This causes the
> qemu_tcg_configure() call later to be always called with NULL, so
> that the thread=xxx option gets ignored. Fix it by removing the
> local accel_opts variable and use "opts" instead, which is meant
> for storing temporary QemuOpts values.
> And while we're at it, also change the exit(1) here to exit(0)
> since asking for help is not an error.
>
> Fixes: bde4d9205ee9def98852ff6054cdef4efd74e1f8
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Reported-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index be4dcf2..5aba544 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3757,21 +3757,18 @@ int main(int argc, char **argv, char **envp)
>                  qdev_prop_register_global(&kvm_pit_lost_tick_policy);
>                  break;
>              }
> -            case QEMU_OPTION_accel: {
> -                QemuOpts *accel_opts;
> -
> +            case QEMU_OPTION_accel:
>                  accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
>                                                       optarg, true);
>                  optarg = qemu_opt_get(accel_opts, "accel");
>                  if (!optarg || is_help_option(optarg)) {
>                      error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
> -                    exit(1);
> +                    exit(0);
>                  }
> -                accel_opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
> -                                              false, &error_abort);
> -                qemu_opt_set(accel_opts, "accel", optarg, &error_abort);
> +                opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
> +                                        false, &error_abort);
> +                qemu_opt_set(opts, "accel", optarg, &error_abort);
>                  break;
> -            }
>              case QEMU_OPTION_usb:
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "usb=on", false);

The fix is fine, so

Reviewed-by: Markus Armbruster <armbru@redhat.com>

The code could use further cleanup, however:

* I hate how we use accel_opts.  It effectively caches the value of
  qemu_accel_opts' "active" QemuOpts, to be passed to
  qemu_tcg_configure() later.  Two reasons:

  - Action at a distance: to understand the call
    qemu_tcg_configure(accel_opts, &error_fatal), you have to trace
    execution backwards to find the last assignment to accel_opts.

  - QemuOpts is odd, and this interacts with one of its oddities in a
    less than obvious way: qemu_accel_opts has .merge_lists set.
    Because of that, repeated -accel with the same @id get merged into a
    single QemuOpts.

    Example: -machine pc -machine graphics=off
    combines with defaults into a single QemuOpts
    firmware=bios-256k.bin,accel=kvm,usb=on,type=pc,graphics=off

    Example: -machine pc -machine graphics=off,id=bad-idea
    results in *two* QemuOpts, one without @id
    firmware=bios-256k.bin,accel=kvm,usb=on,type=pc
    and one with id=bad-idea, which gets silently ignored.

    Example: -name Peter -name Paul
    results in a single QemuOpts guest=Peter.

    Example: -name Peter -name Paul,id=bad-idea
    results in two QemuOpts guest=Peter and guest=Paul,id=bad-idea.
    We use *both*, and the resulting guest name is actually Paul.  We
    suck.

    Example: -accel=kvm -accel=tcg
    results in a single QemuOpts accel=tcg

    Example: -accel=kvm -accel=tcg,id=bad-idea
    results in a two QemuOpts, and we use whichever comes last.  Subtly
    different from using both.  We always find new ways to suck.

    Option group "boot-opts", "memory", "smp-opts" behave like
    "machine", I think.

    Option group "icount" behaves like "name" (same action at a distance
    anti-pattern).

* The list of accelerators in qemu-options.hx is approaching a length
  where sorting may make sense.  You decide.

* Assigning to optarg is not nice.  It should be assigned to only once
  per iteration, via lookup_opt().

  Even more pointless abuse in case QEMU_OPTION_rotate.  That one should
  be converted to qemu_strtol().

* The error reporting for invalid accelerator is ugly, e.g. for -accel
  xxx, we get:

    "xxx" accelerator not found.
    No accelerator found!

  Want one error message, without the over-excited '!'.
