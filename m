Received: from eggs.gnu.org ([2001:4830:134:3::10]:53980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Rzi-0005X2-5y
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 02:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Rze-0007vC-B9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 02:56:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-89-f4bug@amsat.org>
Date: Mon, 09 Oct 2017 08:46:57 +0200
In-Reply-To: <20171006235023.11952-89-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Oct 2017 20:50:23
	-0300")
Message-ID: <87po9wstr2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 88/88] scripts/coverity-model: use g_new()
 family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

Please cc me on changes to stuff I maintain, as scripts/get_maintainer
tells you :)

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/coverity-model.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
> index c702804f41..de07bffb57 100644
> --- a/scripts/coverity-model.c
> +++ b/scripts/coverity-model.c
> @@ -363,7 +363,7 @@ int g_poll (GPollFD *fds, unsigned nfds, int timeout)
>  typedef struct _GIOChannel GIOChannel;
>  GIOChannel *g_io_channel_unix_new(int fd)
>  {
> -    GIOChannel *c =3D g_malloc0(sizeof(GIOChannel));
> +    GIOChannel *c =3D g_new0(GIOChannel, 1);
>      __coverity_escape__(fd);
>      return c;
>  }

Hmm.

The Coverity model carefully explains g_malloc0().  It doesn't explain
g_new0().  With any luck, Coverity can see through g_new0() --- it's a
macro in my <gmem.h>.  But why complicate matters?  The normal reason
for changing g_malloc0() to g_new0() doesn't apply here.  Let's leave
the model alone.
