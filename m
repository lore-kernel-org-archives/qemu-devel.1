Received: from eggs.gnu.org ([2001:4830:134:3::10]:59744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpCNl-0007sG-S7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpCNh-0004yc-6s
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpCNg-0004y0-Tw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:51:01 -0400
References: <150451194093.7046.18254446012958612468.stgit@bahia>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2799e274-32ff-4251-3d92-6e3026cdac24@redhat.com>
Date: Tue, 5 Sep 2017 13:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <150451194093.7046.18254446012958612468.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtfs: error out gracefully when
 mandatory suboptions are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 04.09.2017 09:59, Greg Kurz wrote:
> We internally convert -virtfs to -fsdev/-device. If the user doesn't
> provide the path or security_model suboptions, and the fsdev backend
> requires them, we hit an assertion when populating the internal -fsdev
> option:
> 
> util/qemu-option.c:547: opt_set: Assertion `opt->str' failed.
> Aborted (core dumped)
> 
> Let's test the suboption presence on the command line before trying
> to set it in the internal -fsdev option, and let the backend code
> error out gracefully (ie, like it already does when the user passes
> -fsdev on the command line).
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  vl.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 8e247cc2a239..d63269332fed 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3557,7 +3557,7 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_virtfs: {
>                  QemuOpts *fsdev;
>                  QemuOpts *device;
> -                const char *writeout, *sock_fd, *socket;
> +                const char *writeout, *sock_fd, *socket, *path, *security_model;
>  
>                  olist = qemu_find_opts("virtfs");
>                  if (!olist) {
> @@ -3596,11 +3596,15 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  qemu_opt_set(fsdev, "fsdriver",
>                               qemu_opt_get(opts, "fsdriver"), &error_abort);
> -                qemu_opt_set(fsdev, "path", qemu_opt_get(opts, "path"),
> -                             &error_abort);
> -                qemu_opt_set(fsdev, "security_model",
> -                             qemu_opt_get(opts, "security_model"),
> -                             &error_abort);
> +                path = qemu_opt_get(opts, "path");
> +                if (path) {
> +                    qemu_opt_set(fsdev, "path", path, &error_abort);
> +                }
> +                security_model = qemu_opt_get(opts, "security_model");
> +                if (security_model) {
> +                    qemu_opt_set(fsdev, "security_model", security_model,
> +                                 &error_abort);
> +                }
>                  socket = qemu_opt_get(opts, "socket");
>                  if (socket) {
>                      qemu_opt_set(fsdev, "socket", socket, &error_abort);
> 

Looks good to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
