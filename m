Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dItcR-000709-Jx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dItcO-0000dH-H6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:20:43 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dItcO-0000cu-8g
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:20:40 -0400
Received: by mail-wm0-x231.google.com with SMTP id m7so36766048wmg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 02:20:40 -0700 (PDT)
References: <1496899257-25800-1-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1496899257-25800-1-git-send-email-thuth@redhat.com>
Date: Thu, 08 Jun 2017 10:21:05 +0100
Message-ID: <8760g6deda.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Emilio G Cota <cota@braap.org>


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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>

I'll leave the wider question of a better layout to the QemuOpts experts
(I was/am very much an amateur when I first added the thread option).

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


--
Alex Bennée
