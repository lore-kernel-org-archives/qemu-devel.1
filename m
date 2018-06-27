Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9uh-0006Ck-99
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9ud-0005SJ-Al
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:51:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fY9ud-0005SC-48
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:51:07 -0400
References: <20180627021423.18404-1-ehabkost@redhat.com>
	<20180627021423.18404-7-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c6da5dd-0ab4-b4c4-9411-169f9dfbbdfc@redhat.com>
Date: Wed, 27 Jun 2018 07:51:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180627021423.18404-7-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] docker: Open dockerfiles in text mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 06/26/2018 09:14 PM, Eduardo Habkost wrote:
> Instead of treating dockerfile contents as byte sequences, always
> open dockerfiles in text mode and treat it as text.
> 
> This is not strictly required to make the script compatible with
> Python 3, but it's a simpler and safer way than opening
> dockerfiles in binary mode and decoding the data data later.

s/data data/data/

> 
> To make the code compatible with both Python 2 and 3, use
> io.open(), which accepts a 'encoding' argument on both versions.

How does this compare to the recent change to the QAPI generators in 
commit de685ae5e?  Should we be trying to use similar mechanisms in both 
places?

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   tests/docker/docker.py | 46 ++++++++++++++++++++++++------------------
>   1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index f58af8e894..412a031c1c 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -23,6 +23,7 @@ import argparse
>   import tempfile
>   import re
>   import signal
> +import io
>   from tarfile import TarFile, TarInfo
>   from io import BytesIO
>   from shutil import copy, rmtree
> @@ -30,7 +31,7 @@ from pwd import getpwuid
>   from datetime import datetime,timedelta
>   
>   try:
> -    from typing import List, Union, Tuple
> +    from typing import List, Union, Tuple, Text
>   except ImportError:
>       # needed only to make type annotations work
>       pass
> @@ -52,13 +53,13 @@ def _fsdecode(name):
>           return name # type: ignore
>   
>   def _text_checksum(text):
> -    # type: (bytes) -> str
> +    # type: (Text) -> str
>       """Calculate a digest string unique to the text content"""
> -    return hashlib.sha1(text).hexdigest()
> +    return hashlib.sha1(text.encode('utf-8')).hexdigest()
>   
>   def _file_checksum(filename):
>       # type: (str) -> str
> -    return _text_checksum(open(filename, 'rb').read())
> +    return _text_checksum(io.open(filename, 'r', encoding='utf-8').read())
>   
>   def _guess_docker_command():
>       # type: () -> List[str]
> @@ -129,14 +130,14 @@ def _copy_binary_with_libs(src, dest_dir):
>               _copy_with_mkdir(l , dest_dir, so_path)
>   
>   def _read_qemu_dockerfile(img_name):
> -    # type: (str) -> str
> +    # type: (Text) -> str
>       df = os.path.join(os.path.dirname(__file__), "dockerfiles",
>                         img_name + ".docker")
> -    return open(df, "r").read()
> +    return io.open(df, "r", encoding='utf-8').read()
>   
>   def _dockerfile_preprocess(df):
> -    # type: (str) -> str
> -    out = ""
> +    # type: (Text) -> Text
> +    out = u""
>       for l in df.splitlines():
>           if len(l.strip()) == 0 or l.startswith("#"):
>               continue
> @@ -149,7 +150,7 @@ def _dockerfile_preprocess(df):
>               inlining = _read_qemu_dockerfile(l[len(from_pref):])
>               out += _dockerfile_preprocess(inlining)
>               continue
> -        out += l + "\n"
> +        out += l + u"\n"
>       return out
>   
>   class Docker(object):
> @@ -220,32 +221,37 @@ class Docker(object):
>       def build_image(self,
>                       tag,                 # type: str
>                       docker_dir,          # type: str
> -                    dockerfile,          # type: str
> +                    dockerfile,          # type: Text
>                       quiet=True,          # type: bool
>                       user=False,          # type: bool
>                       argv=[],             # type: List[str]
>                       extra_files_cksum=[] # List[Tuple[str, bytes]]
>                       ):
>           # type(...) -> None
> -        tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
> +        tmp_ndf = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
> +        # on Python 2.7, NamedTemporaryFile doesn't support encoding parameter,
> +        # so reopen it in text mode:
> +        tmp_df = io.open(tmp_ndf.name, mode='w+t', encoding='utf-8')
>           tmp_df.write(dockerfile)
>   
>           if user:
>               uid = os.getuid()
>               uname = getpwuid(uid).pw_name
> -            tmp_df.write("\n")
> -            tmp_df.write("RUN id %s 2>/dev/null || useradd -u %d -U %s" %
> +            tmp_df.write(u"\n")
> +            tmp_df.write(u"RUN id %s 2>/dev/null || useradd -u %d -U %s" %
>                            (uname, uid, uname))
>   
> -        tmp_df.write("\n")
> -        tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
> -                     _text_checksum(_dockerfile_preprocess(dockerfile)))
> +        dockerfile = _dockerfile_preprocess(dockerfile)
> +
> +        tmp_df.write(u"\n")
> +        tmp_df.write(u"LABEL com.qemu.dockerfile-checksum=%s" %
> +                     _text_checksum(dockerfile))
>           for f, c in extra_files_cksum:
> -            tmp_df.write("LABEL com.qemu.%s-checksum=%s" % (f, c))
> +            tmp_df.write(u"LABEL com.qemu.%s-checksum=%s" % (f, c))
>   
>           tmp_df.flush()
>   
> -        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + \
> +        self._do_check(["build", "-t", tag, "-f", tmp_ndf.name] + argv + \
>                          [docker_dir],
>                          quiet=quiet)
>   
> @@ -326,7 +332,7 @@ class BuildCommand(SubCommand):
>   
>       def run(self, args, argv):
>           # type: (argparse.Namespace, List[str]) -> int
> -        dockerfile = open(args.dockerfile, "rb").read()
> +        dockerfile = io.open(args.dockerfile, "r", encoding='utf-8').read()
>           tag = args.tag
>   
>           dkr = Docker()
> @@ -519,7 +525,7 @@ class CheckCommand(SubCommand):
>                   print("Need a dockerfile for tag:%s" % (tag))
>                   return 1
>   
> -            dockerfile = open(args.dockerfile, "rb").read()
> +            dockerfile = io.open(args.dockerfile, "r", encoding='utf-8').read()
>   
>               if dkr.image_matches_dockerfile(tag, dockerfile):
>                   if not args.quiet:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
