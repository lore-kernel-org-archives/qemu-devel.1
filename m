Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVLGz-0004JR-84
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVLGw-0000cJ-1W
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:18:01 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVLGv-0000c9-Sm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:17:57 -0400
Received: by mail-qt0-f181.google.com with SMTP id b40so18062439qtb.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:17:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712075528.22770-1-famz@redhat.com>
	<20170712075528.22770-3-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e0b8f1b-02f7-6362-0719-525d8cca8a32@amsat.org>
Date: Wed, 12 Jul 2017 14:16:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170712075528.22770-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] docker.py: Improve subprocess exit
 code handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/12/2017 04:55 AM, Fam Zheng wrote:
> A few error handlings are missing because we ignore the subprocess exit
> code, for example "docker build" errors are currently ignored.
> 
> Introduce _do_check() aside the existing _do() method and use it in a
> few places.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/docker/docker.py | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index f5ac86b..ee40ca0 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -117,6 +117,11 @@ class Docker(object):
>               kwargs["stdout"] = DEVNULL
>           return subprocess.call(self._command + cmd, **kwargs)
>   
> +    def _do_check(self, cmd, quiet=True, **kwargs):
> +        if quiet:
> +            kwargs["stdout"] = DEVNULL
> +        return subprocess.check_call(self._command + cmd, **kwargs)
> +
>       def _do_kill_instances(self, only_known, only_active=True):
>           cmd = ["ps", "-q"]
>           if not only_active:
> @@ -175,14 +180,14 @@ class Docker(object):
>                                       extra_files_cksum)))
>           tmp_df.flush()
>   
> -        self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
> -                 [docker_dir],
> -                 quiet=quiet)
> +        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + \
> +                       [docker_dir],
> +                       quiet=quiet)
>   
>       def update_image(self, tag, tarball, quiet=True):
>           "Update a tagged image using "
>   
> -        self._do(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
> +        self._do_check(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
>   
>       def image_matches_dockerfile(self, tag, dockerfile):
>           try:
> @@ -195,9 +200,9 @@ class Docker(object):
>           label = uuid.uuid1().hex
>           if not keep:
>               self._instances.append(label)
> -        ret = self._do(["run", "--label",
> -                        "com.qemu.instance.uuid=" + label] + cmd,
> -                       quiet=quiet)
> +        ret = self._do_check(["run", "--label",
> +                             "com.qemu.instance.uuid=" + label] + cmd,
> +                             quiet=quiet)
>           if not keep:
>               self._instances.remove(label)
>           return ret
> 
