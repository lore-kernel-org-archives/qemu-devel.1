Received: from eggs.gnu.org ([2001:4830:134:3::10]:50498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUvjk-0004pN-J5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUvjh-0006Ey-CQ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:06:32 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUvjh-0006El-7m
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:06:29 -0400
Received: by mail-qt0-x243.google.com with SMTP id y89-v6so15367895qtd.10
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 08:06:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-51-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <22634562-afef-04a9-da54-2f04d722a3fc@amsat.org>
Date: Mon, 18 Jun 2018 12:06:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180615194705.28019-51-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 50/54] docker: docker.py add check
 sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 06/15/2018 04:47 PM, Alex Bennée wrote:
> This command allows you to check if we need to re-build a docker
> image. If the image isn't in the repository or the checksums don't
> match then we return false and some text (for processing in
> makefiles).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
>   - fix prints to be "modern"
>   - PEP8 fixes
> ---
>  tests/docker/docker.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 2593a12d04..3666197a16 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -442,6 +442,31 @@ class CcCommand(SubCommand):
>          return Docker().command("run", cmd, args.quiet)
>  
>  
> +class CheckCommand(SubCommand):
> +    """Check if we need to re-build a docker image out of a dockerfile.
> +    Arguments: <tag> <dockerfile>"""
> +    name = "check"
> +
> +    def args(self, parser):
> +        parser.add_argument("tag",
> +                            help="Image Tag")
> +        parser.add_argument("dockerfile",
> +                            help="Dockerfile name")
> +
> +    def run(self, args, argv):
> +        dockerfile = open(args.dockerfile, "rb").read()
> +        tag = args.tag
> +
> +        dkr = Docker()
> +        if dkr.image_matches_dockerfile(tag, dockerfile):
> +            if not args.quiet:
> +                print("Image is up to date.")
> +            return 0
> +        else:
> +            print("Image needs updating")
> +            return 1
> +
> +
>  def main():
>      parser = argparse.ArgumentParser(description="A Docker helper",
>              usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
> 
