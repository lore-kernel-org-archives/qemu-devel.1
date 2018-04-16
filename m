Received: from eggs.gnu.org ([2001:4830:134:3::10]:35897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tFd-0004XF-LZ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tFa-0007C5-JT
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:48:13 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tFa-0007Br-Dw
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:48:10 -0400
Received: by mail-qt0-x242.google.com with SMTP id p9so11443416qtn.0
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:48:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e12c62d2-0460-cfba-5b42-a7a5dce811d2@amsat.org>
Date: Sun, 15 Apr 2018 22:48:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/24] docker: Add "cc" subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 1246ba9578..8733266153 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -390,6 +390,29 @@ class ImagesCommand(SubCommand):
>      def run(self, args, argv):
>          return Docker().command("images", argv, args.quiet)
>  
> +class CcCommand(SubCommand):
> +    """Compile sources with cc in images"""
> +    name = "cc"
> +
> +    def args(self, parser):
> +        parser.add_argument("--image", "-i", required=True,
> +                            help="The docker image in which to run cc")
> +        parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
> +                            help="""Extra paths to (ro) mount into container for
> +                            reading sources""")
> +
> +    def run(self, args, argv):
> +        if argv and argv[0] == "--":
> +            argv = argv[1:]
> +        cwd = os.getcwd()
> +        cmd = ["--rm", "-w", cwd,
> +               "-v", "%s:%s:rw" % (cwd, cwd)]
> +        for p in args.paths:
> +           cmd += ["-v", "%s:%s:ro,z" % (p, p)]
> +        cmd += [args.image, "cc"]
> +        cmd += argv
> +        return Docker().command("run", cmd, True)
> +
>  def main():
>      parser = argparse.ArgumentParser(description="A Docker helper",
>              usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
> 
