Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l6z-0000N4-4P
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l6g-0007ZF-Lo
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:03:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9l6g-0006Ue-0M
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:02:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so513768wma.3
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:02:12 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-21-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcbe4c36-d2df-fe41-60e2-cde3a1057771@redhat.com>
Date: Tue, 9 Oct 2018 08:02:04 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 20/31] vl: Clean up error reporting in
 machine_set_property()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/10/2018 19:31, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  machine_set_property() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index ecb70f87d8..3adc9dbe4f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2676,7 +2676,7 @@ static int machine_set_property(void *opaque,
>      g_free(qom_name);
>  
>      if (local_err) {
> -        error_report_err(local_err);
> +        error_propagate(errp, local_err);
>          return -1;
>      }
>  
> @@ -4201,11 +4201,8 @@ int main(int argc, char **argv, char **envp)
>      }
>  
>      machine_opts = qemu_get_machine_opts();
> -    if (qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
> -                         NULL)) {
> -        object_unref(OBJECT(current_machine));
> -        exit(1);
> -    }
> +    qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
> +                     &error_fatal);
>  
>      configure_accelerator(current_machine);
>  
> 
