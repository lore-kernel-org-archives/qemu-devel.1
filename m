Received: from eggs.gnu.org ([209.51.188.92]:41312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAvCo-0003IN-9Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAvCn-0002AR-Co
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:34:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hAvCn-00028u-5k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:34:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so10973926wmc.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 04:34:19 -0700 (PDT)
References: <20190329210804.22121-1-wainersm@redhat.com>
	<20190329210804.22121-3-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e047167-9cc9-d837-e3a0-260a660edd1a@redhat.com>
Date: Mon, 1 Apr 2019 13:34:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190329210804.22121-3-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tests/vm: Port basevm to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, alex.bennee@linaro.org, berrange@redhat.com, lersek@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org

On 3/29/19 10:08 PM, Wainer dos Santos Moschetta wrote:
> Fixed tests/vm/basevm.py to run with Python 3:
>  - hashlib.sha1() requires an binary encoded object.
>  - uses floor division ("//") (PEP 238).
>  - decode bytes to unicode when needed.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 0556bdcf9e..083befce9f 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -85,12 +85,12 @@ class BaseVM(object):
>              if not sha256sum:
>                  return True
>              checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
> -            return sha256sum == checksum
> +            return sha256sum == checksum.decode()
>  
>          cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
>          if not os.path.exists(cache_dir):
>              os.makedirs(cache_dir)
> -        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
> +        fname = os.path.join(cache_dir, hashlib.sha1(url.encode()).hexdigest())
>          if os.path.exists(fname) and check_sha256sum(fname):
>              return fname
>          logging.debug("Downloading %s to %s...", url, fname)
> @@ -134,7 +134,7 @@ class BaseVM(object):
>          raise NotImplementedError
>  
>      def add_source_dir(self, src_dir):
> -        name = "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
> +        name = "data-" + hashlib.sha1(src_dir.encode()).hexdigest()[:5]
>          tarfile = os.path.join(self._tmpdir, name + ".tar")
>          logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
>          subprocess.check_call(["./scripts/archive-source.sh", tarfile],
> @@ -204,7 +204,7 @@ def parse_args(vmcls):
>  
>      def get_default_jobs():
>          if kvm_available(vmcls.arch):
> -            return multiprocessing.cpu_count() / 2
> +            return multiprocessing.cpu_count() // 2
>          else:
>              return 1
>  
> 
