Received: from eggs.gnu.org ([2001:4830:134:3::10]:55485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsVT-0000gl-1X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsVO-0007jq-J5
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHsVO-0007it-CN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:34:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1540352349-12737-1-git-send-email-liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 16:33:56 +0100
In-Reply-To: <1540352349-12737-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Tue, 23 Oct 2018 20:39:09 -0700")
Message-ID: <878t2eqgez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vl.c: print error message if loading
 fw_cfg file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

> It makes sense to print the error message while reading
> file failed.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Your commit message suggests the patch adds an error message where none
was before.

> ---
>  vl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index b2a405f..ee6f982 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2234,8 +2234,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
>      } else {
> -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_setg(errp, "can't load %s", file);
> +        GError *err = NULL;
> +        if (!g_file_get_contents(file, &buf, &size, &err)) {
> +            error_setg(errp, "can't load %s, %s", file, err->message);
> +            g_error_free(err);
>              return -1;
>          }
>      }

What the patch actually does is improving an existing error message.

Suggest to rephrase the commit message like this:

    vl: Improve error message when we can't load fw_cfg from file

    parse_fw_cfg() reports "can't load" without further details.  Get
    the details from g_file_get_contents(), and include them in the
    error message.
