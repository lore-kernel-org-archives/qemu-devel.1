Received: from eggs.gnu.org ([209.51.188.92]:46427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyqb-0001Vd-77
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyqU-0008W7-6Z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:08 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEyqP-0008Re-3Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id 4so11953749wmf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:15:55 -0700 (PDT)
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
	<20190412152713.16018-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f3fee902-fe59-9381-7ff5-d3b3c6abb8dd@redhat.com>
Date: Fri, 12 Apr 2019 18:15:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190412152713.16018-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: add -vga help support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com

On 4/12/19 5:27 PM, Marc-André Lureau wrote:
> Provide help output similar to other argument help handling:
> 
> $ qemu-system-x86_64 -vga help
> none
> std                  standard VGA (default)
> cirrus               Cirrus VGA
> vmware               VMWare SVGA
> xenfb
> qxl                  QXL VGA
> virtio               Virtio VG

Maybe you can show the previous behavior:

$ qemu-system-x86_64 -vga help
qemu-system-x86_64: unknown vga type: help

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 0a96232e95..840c45c00f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2080,11 +2080,39 @@ static bool vga_interface_available(VGAInterfaceType t)
>             object_class_by_name(ti->class_names[1]);
>  }
>  
> -static void select_vgahw(const char *p)
> +static const char *
> +get_default_vga_model(const MachineClass *machine_class)
> +{
> +    if (machine_class->default_display) {
> +        return machine_class->default_display;
> +    } else if (vga_interface_available(VGA_CIRRUS)) {
> +        return "cirrus";
> +    } else if (vga_interface_available(VGA_STD)) {
> +        return "std";
> +    }
> +
> +    return NULL;
> +}
> +
> +static void select_vgahw(const MachineClass *machine_class, const char *p)
>  {
>      const char *opts;
>      int t;
>  
> +    if (g_str_equal(p, "help")) {
> +        const char *def = get_default_vga_model(machine_class);
> +
> +        for (t = 0; t < VGA_TYPE_MAX; t++) {
> +            const VGAInterfaceInfo *ti = &vga_interfaces[t];
> +
> +            if (vga_interface_available(t) && ti->opt_name) {
> +                printf("%-20s %s%s\n", ti->opt_name, ti->name ?: "",
> +                       g_str_equal(ti->opt_name, def) ? " (default)" : "");
> +            }
> +        }
> +        exit(0);
> +    }
> +
>      assert(vga_interface_type == VGA_NONE);
>      for (t = 0; t < VGA_TYPE_MAX; t++) {
>          const VGAInterfaceInfo *ti = &vga_interfaces[t];
> @@ -4437,16 +4465,10 @@ int main(int argc, char **argv, char **envp)
>  
>      /* If no default VGA is requested, the default is "none".  */
>      if (default_vga) {
> -        if (machine_class->default_display) {
> -            vga_model = machine_class->default_display;
> -        } else if (vga_interface_available(VGA_CIRRUS)) {
> -            vga_model = "cirrus";
> -        } else if (vga_interface_available(VGA_STD)) {
> -            vga_model = "std";
> -        }
> +        vga_model = get_default_vga_model(machine_class);
>      }
>      if (vga_model) {
> -        select_vgahw(vga_model);
> +        select_vgahw(machine_class, vga_model);
>      }
>  
>      if (watchdog) {
> 
