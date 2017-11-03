Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAeO4-0003Bi-En
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAeO0-0002ks-IL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:00:04 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:44691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAeO0-0002kA-E8
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:00:00 -0400
Received: by mail-qk0-x231.google.com with SMTP id r64so3792103qkc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 09:00:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171103131229.4737-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a860d2a7-ef85-71ec-3967-b36bdf649c30@amsat.org>
Date: Fri, 3 Nov 2017 12:59:54 -0300
MIME-Version: 1.0
In-Reply-To: <20171103131229.4737-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Improved image checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

Thanks Fam, this fixes Shippable builds :)

On 11/03/2017 10:12 AM, Fam Zheng wrote:
> When a base image locally defined by QEMU, such as in the debian images,
> is updated, the dockerfile checksum mechanism in docker.py still skips
> updating the derived image, because it only looks at the literal content
> of the dockerfile, without considering changes to the base image.
> 
> For example we have a recent fix e58c1f9b35e81 that fixed
> debian-win64-cross by updating its base image, debian8-mxe, but due to
> above "feature" of docker.py the image in question is automatically NOT
> rebuilt unless you add NOCACHE=1. It is noticed on Shippable:
> 
> https://app.shippable.com/github/qemu/qemu/runs/541/2/console
> 
> because after the fix is merged, the error still occurs, and the log
> shows the container image is, as explained above, not updated.
> 
> This is because at the time docker.py was written, there wasn't any
> dependencies between QEMU's docker images.
> 
> Now improve this to preprocess any "FROM qemu:*" directives in the
> dockerfiles while doing checksum, and inline the base image's dockerfile
> content, recursively. This ensures any changes on the depended _QEMU_
> images are taken into account.
> 
> This means for external images that we expect to retrieve from docker
> registries, we still do it as before. It is not perfect, because
> registry images can get updated too. Technically we could substitute the
> image name with its hex ID as obtained with $(docker images $IMAGE
> --format="{{.Id}}"), but --format is not supported by RHEL 7, so leave
> it for now.
> 
> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 08122ca17d..1246ba9578 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -105,6 +105,28 @@ def _copy_binary_with_libs(src, dest_dir):
>              so_path = os.path.dirname(l)
>              _copy_with_mkdir(l , dest_dir, so_path)
>  
> +def _read_qemu_dockerfile(img_name):
> +    df = os.path.join(os.path.dirname(__file__), "dockerfiles",
> +                      img_name + ".docker")
> +    return open(df, "r").read()
> +
> +def _dockerfile_preprocess(df):
> +    out = ""
> +    for l in df.splitlines():
> +        if len(l.strip()) == 0 or l.startswith("#"):
> +            continue
> +        from_pref = "FROM qemu:"
> +        if l.startswith(from_pref):
> +            # TODO: Alternatively we could replace this line with "FROM $ID"
> +            # where $ID is the image's hex id obtained with
> +            #    $ docker images $IMAGE --format="{{.Id}}"
> +            # but unfortunately that's not supported by RHEL 7.
> +            inlining = _read_qemu_dockerfile(l[len(from_pref):])
> +            out += _dockerfile_preprocess(inlining)
> +            continue
> +        out += l + "\n"
> +    return out
> +
>  class Docker(object):
>      """ Running Docker commands """
>      def __init__(self):
> @@ -196,7 +218,7 @@ class Docker(object):
>              checksum = self.get_image_dockerfile_checksum(tag)
>          except Exception:
>              return False
> -        return checksum == _text_checksum(dockerfile)
> +        return checksum == _text_checksum(_dockerfile_preprocess(dockerfile))
>  
>      def run(self, cmd, keep, quiet):
>          label = uuid.uuid1().hex
> 
