Received: from eggs.gnu.org ([2001:4830:134:3::10]:55790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvss-0002YO-Oz
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvso-00054N-4N
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:31:02 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxvsn-00052u-TU
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:30:58 -0400
Received: by mail-wm0-x22e.google.com with SMTP id w64so63808549wma.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 06:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411131327.10734-1-mreitz@redhat.com>
References: <20170411131327.10734-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 14:30:36 +0100
Message-ID: <CAFEAcA_bvMvXa7MtYY0UGhF6xwqFhTCU2ZEy7phj95fFXTzd8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 14:13, Max Reitz <mreitz@redhat.com> wrote:
> Parsing the URI is not required to give us a scheme; uri->scheme may be
> NULL.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/nfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/nfs.c b/block/nfs.c
> index 0816678307..0c7d5619fe 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -83,7 +83,7 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
>          error_setg(errp, "Invalid URI specified");
>          goto out;
>      }
> -    if (strcmp(uri->scheme, "nfs") != 0) {
> +    if (!uri->scheme || strcmp(uri->scheme, "nfs") != 0) {
>          error_setg(errp, "URI scheme must be 'nfs'");
>          goto out;
>      }

Just as a record of IRC discussion, a lot of the callers of uri_parse()
get this wrong; for instance
 qemu-img info -f nbd blub#://
 qemu-img info -f sheepdog blub#://
both segfault. So since this isn't new (2.8 behaved the same way) I think
we should not try to fix this at this point in the 2.9 release cycle.
For 2.10 we might consider whether there's a change we could make to
the uri_parse() API that makes this mistake less easy. (For instance
do any of the users really ever want to handle a relative URL without
a schema?)

thanks
-- PMM
