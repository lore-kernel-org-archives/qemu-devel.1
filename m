Received: from eggs.gnu.org ([2001:4830:134:3::10]:50495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9kwb-0005GX-QD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9kwY-00012i-Jn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:52:33 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9kwY-00010Q-C9
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:52:30 -0400
Received: by mail-wr1-f44.google.com with SMTP id w5-v6so360770wrt.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 22:52:23 -0700 (PDT)
References: <1539052760-11730-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a26945a-d94f-98db-7ae2-0d4c089ab975@redhat.com>
Date: Tue, 9 Oct 2018 07:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <1539052760-11730-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: print error message if load
 fw_cfg file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, f4bug@amsat.org
Cc: qemu-devel@nongnu.org

Hi Li,

On 09/10/2018 04:39, Li Qiang wrote:
> It makes sense to print the error message while reading
> file failed.

OK

> 
> Change since v1:
> free error

Changes are useful for reviewer, but not in the git history.
You can have them automatically stripped if you place them below the
next '---' separator.

Hopefully the maintainer taking this patch can clean this up.

> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

Here goes comment not worth to stay forever in git history:

  Since v1: ...

>  vl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 4e25c78..69fc77c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2207,8 +2207,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
>      } else {
> -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_report("can't load %s", file);
> +        GError *error = NULL;
> +        if (!g_file_get_contents(file, &buf, &size, &error)) {
> +            error_report("can't load %s, %s", file, error->message);

If you ever respin, you can help Markus [1] effort using:

            error_setg(errp, "can't load %s, %s", file, error->message);

Else your patch will clash with [2].

> +            g_error_free(error);
>              return -1;
>          }
>      }
> 

Regards,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01394.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01406.html
