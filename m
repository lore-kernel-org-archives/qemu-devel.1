Received: from eggs.gnu.org ([2001:4830:134:3::10]:44375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Mzi-0000Ya-4w
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Mzh-0002rA-AV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:28:34 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3Mzh-0002qT-2m
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:28:33 -0400
Received: by mail-wr0-x233.google.com with SMTP id l50so135446wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:28:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149321290672.6890.14889421479138766387.stgit@bahia>
References: <149321290672.6890.14889421479138766387.stgit@bahia>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 14:28:11 +0100
Message-ID: <CAFEAcA_K6ixbbYxvqW3gY40kbUOGuVovFPhP7dngX2i36+Wf3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: fix trace backend list for
 out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 26 April 2017 at 14:21, Greg Kurz <groug@kaod.org> wrote:
> Since commit "c53eeaf75a04 configure: eliminate Python dependency for
> --help", configure --help fails to produce the list of available trace
> backends if invoked out-of-tree. It also spits the following error:
>
> grep: scripts/tracetool/backend/*.py: No such file or directory
>
> This patch simply adds the missing $source_path to fix it.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  configure |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index c35acf119261..96847b092c8d 100755
> --- a/configure
> +++ b/configure
> @@ -1271,7 +1271,7 @@ for config in $mak_wilds; do
>  done
>
>  # Enumerate public trace backends for --help output
> -trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
> +trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' $source_path/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))

Lots of things will break if $source_path includes a
space in its value, but we don't need to add another one,
so "$source_path" would be better here.

thanks
-- PMM
