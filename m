Received: from eggs.gnu.org ([2001:4830:134:3::10]:54347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f82ET-0006Sg-T4
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f82EP-0008AU-V7
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:23:37 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f82EP-0008AD-Ri
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:23:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id l11so5616156qtj.10
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 04:23:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180416111743.8473-1-berrange@redhat.com>
	<20180416111743.8473-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <98125666-8382-d396-d660-0b97af51cc4f@amsat.org>
Date: Mon, 16 Apr 2018 08:23:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180416111743.8473-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] accel: use g_strsplit for parsing
 accelerator names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04/16/2018 08:17 AM, Daniel P. Berrangé wrote:
> Instead of re-using the get_opt_name() method from QemuOpts to split a
> string on ':', just use g_strsplit().
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  accel/accel.c         | 16 +++++++---------
>  include/qemu/option.h |  1 -
>  util/qemu-option.c    |  3 ++-
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index 93e2434c87..4981e7fff3 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -70,8 +70,8 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
>  
>  void configure_accelerator(MachineState *ms)
>  {
> -    const char *accel, *p;
> -    char buf[10];
> +    const char *accel;
> +    char **accel_list, **tmp;
>      int ret;
>      bool accel_initialised = false;
>      bool init_failed = false;
> @@ -83,13 +83,10 @@ void configure_accelerator(MachineState *ms)
>          accel = "tcg";
>      }
>  
> -    p = accel;
> -    while (!accel_initialised && *p != '\0') {
> -        if (*p == ':') {
> -            p++;
> -        }
> -        p = get_opt_name(buf, sizeof(buf), p, ':');
> -        acc = accel_find(buf);
> +    accel_list = g_strsplit(accel, ":", 0);
> +
> +    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
> +        acc = accel_find(*tmp);
>          if (!acc) {
>              continue;
>          }
> @@ -107,6 +104,7 @@ void configure_accelerator(MachineState *ms)
>              accel_initialised = true;
>          }
>      }
> +    g_strfreev(accel_list);
>  
>      if (!accel_initialised) {
>          if (!init_failed) {
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index 306fdb5f7a..1cfe5cbc2d 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -28,7 +28,6 @@
>  
>  #include "qemu/queue.h"
>  
> -const char *get_opt_name(char *buf, int buf_size, const char *p, char delim);
>  const char *get_opt_value(char *buf, int buf_size, const char *p);
>  
>  void parse_option_size(const char *name, const char *value,
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index d0756fda58..baca40fb94 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -49,7 +49,8 @@
>   * The return value is the position of the delimiter/zero byte after the option
>   * name in p.
>   */
> -const char *get_opt_name(char *buf, int buf_size, const char *p, char delim)
> +static const char *get_opt_name(char *buf, int buf_size, const char *p,
> +                                char delim)
>  {
>      char *q;
>  
> 
