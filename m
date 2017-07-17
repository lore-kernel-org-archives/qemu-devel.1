Received: from eggs.gnu.org ([2001:4830:134:3::10]:48997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX6Tk-0005e4-7J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX6Tg-0003eu-Av
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX6Tg-0003eP-13
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:54:24 -0400
References: <20170717132110.29962-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aae6fdcd-93d3-c75c-5401-10e1bc37e7e9@redhat.com>
Date: Mon, 17 Jul 2017 15:54:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170717132110.29962-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Daniel P . Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 17.07.2017 15:21, Laurent Vivier wrote:
> Only emit "XXX accelerator not found", if there are not
> further accelerators listed. eg
> 
>    accel=kvm:tcg
> 
> doesn't print a "KVM accelerator not found" warning
> when it falls back to tcg, but a
> 
>    accel=kvm
> 
> prints a warning, since no fallback is given.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  accel/accel.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index fa85844..ababeb8 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -69,19 +69,20 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
>  
>  void configure_accelerator(MachineState *ms)
>  {
> -    const char *p;
> +    const char *accel, *p;
>      char buf[10];
>      int ret;
>      bool accel_initialised = false;
>      bool init_failed = false;
>      AccelClass *acc = NULL;
>  
> -    p = qemu_opt_get(qemu_get_machine_opts(), "accel");
> -    if (p == NULL) {
> +    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
> +    if (accel == NULL) {
>          /* Use the default "accelerator", tcg */
> -        p = "tcg";
> +        accel = "tcg";
>      }
>  
> +    p = accel;
>      while (!accel_initialised && *p != '\0') {
>          if (*p == ':') {
>              p++;
> @@ -89,7 +90,6 @@ void configure_accelerator(MachineState *ms)
>          p = get_opt_name(buf, sizeof(buf), p, ':');
>          acc = accel_find(buf);
>          if (!acc) {
> -            fprintf(stderr, "\"%s\" accelerator not found.\n", buf);
>              continue;
>          }
>          if (acc->available && !acc->available()) {
> @@ -110,7 +110,8 @@ void configure_accelerator(MachineState *ms)
>  
>      if (!accel_initialised) {
>          if (!init_failed) {
> -            fprintf(stderr, "No accelerator found!\n");
> +            fprintf(stderr, "-machine accel=%s: No accelerator found!\n",
> +                    accel);
>          }
>          exit(1);
>      }

Maybe use error_report() instead of fprintf(stderr, ...) ?

Apart from that, looks fine to me, so feel free to add my:

Reviewed-by: Thomas Huth <thuth@redhat.com>
