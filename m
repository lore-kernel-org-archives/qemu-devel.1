Received: from eggs.gnu.org ([2001:4830:134:3::10]:40017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUwfY-0004Ni-Ro
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUwfU-0006zB-Av
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:06:16 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUwfU-0006yU-60
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:06:12 -0400
Received: by mail-qk0-x236.google.com with SMTP id d130-v6so9645883qkc.2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:06:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180618130709.19730-1-alex.bennee@linaro.org>
	<20180618130709.19730-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7ea3d9c6-2da4-28eb-6d21-76c9fc793dca@amsat.org>
Date: Mon, 18 Jun 2018 13:06:08 -0300
MIME-Version: 1.0
In-Reply-To: <20180618130709.19730-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] docker: docker.py adding age check
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, cota@braap.org, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 06/18/2018 10:07 AM, Alex Bennée wrote:
> This is useful for querying if an image is too old.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v7
>   - use cached info
> ---
>  tests/docker/docker.py | 46 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index c157ff826a..da1ed4e879 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -29,6 +29,7 @@ from tarfile import TarFile, TarInfo
>  from StringIO import StringIO
>  from shutil import copy, rmtree
>  from pwd import getpwuid
> +from datetime import datetime,timedelta

datetime,<space>timedelta

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>  
>  FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
> @@ -185,6 +186,9 @@ class Docker(object):
>          except subprocess.CalledProcessError:
>              return None
>  
> +    def get_image_creation_time(self, info):
> +        return json.loads(info)[0]["Created"]
> +
>      def get_image_dockerfile_checksum(self, tag):
>          resp = self.inspect_tag(tag)
>          labels = json.loads(resp)[0]["Config"].get("Labels", {})
> @@ -456,11 +460,14 @@ class CheckCommand(SubCommand):
>      def args(self, parser):
>          parser.add_argument("tag",
>                              help="Image Tag")
> -        parser.add_argument("dockerfile",
> -                            help="Dockerfile name")
> +        parser.add_argument("dockerfile", default=None,
> +                            help="Dockerfile name", nargs='?')
> +        parser.add_argument("--checktype", choices=["checksum", "age"],
> +                            default="checksum", help="check type")
> +        parser.add_argument("--olderthan", default=60, type=int,
> +                            help="number of minutes")
>  
>      def run(self, args, argv):
> -        dockerfile = open(args.dockerfile, "rb").read()
>          tag = args.tag
>  
>          dkr = Docker()
> @@ -469,13 +476,32 @@ class CheckCommand(SubCommand):
>              print("Image does not exist")
>              return 1
>  
> -        if dkr.image_matches_dockerfile(tag, dockerfile):
> -            if not args.quiet:
> -                print("Image is up to date")
> -            return 0
> -        else:
> -            print("Image needs updating")
> -            return 1
> +        if args.checktype == "checksum":
> +            if not args.dockerfile:
> +                print("Need a dockerfile for tag:%s" % (tag))
> +                return 1
> +
> +            dockerfile = open(args.dockerfile, "rb").read()
> +
> +            if dkr.image_matches_dockerfile(tag, dockerfile):
> +                if not args.quiet:
> +                    print("Image is up to date")
> +                return 0
> +            else:
> +                print("Image needs updating")
> +                return 1
> +        elif args.checktype == "age":
> +            timestr = dkr.get_image_creation_time(info).split(".")[0]
> +            created = datetime.strptime(timestr, "%Y-%m-%dT%H:%M:%S")
> +            past = datetime.now() - timedelta(minutes=args.olderthan)
> +            if created < past:
> +                print ("Image created @ %s more than %d minutes old" %
> +                       (timestr, args.olderthan))
> +                return 1
> +            else:
> +                if not args.quiet:
> +                    print ("Image less than %d minutes old" % (args.olderthan))
> +                return 0
>  
>  
>  def main():
> 
