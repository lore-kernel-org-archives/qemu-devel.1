Received: from eggs.gnu.org ([209.51.188.92]:54445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrqq-0006ao-QG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrqp-0005Ad-KQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:08:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grrqp-0005AT-EU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:08:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so1495593wrn.11
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 14:08:55 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <172d8017-c3db-f35a-4091-b9f1400c43bf@redhat.com>
Date: Thu, 7 Feb 2019 23:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/18] tests/vm: Be verbose while
 extracting compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>

Hi Alex,

Can you queue this patch?

On 1/29/19 6:53 PM, Philippe Mathieu-Daudé wrote:
> Depending of the host hardware, copying and extracting VM images can
> take up to few minutes. Add verbosity to avoid the user to worry about
> VMs hanging.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/vm/centos  | 3 ++-
>  tests/vm/freebsd | 3 ++-
>  tests/vm/netbsd  | 3 ++-
>  tests/vm/openbsd | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/vm/centos b/tests/vm/centos
> index daa2dbca03..ba133ea429 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -65,8 +65,9 @@ class CentosVM(basevm.BaseVM):
>      def build_image(self, img):
>          cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> -        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
> +        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
>          subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>          self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
>          self.wait_ssh()
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 19a3729172..2007c495a8 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -34,8 +34,9 @@ class FreeBSDVM(basevm.BaseVM):
>                  sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index fac6a7ce51..93b267c292 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -34,8 +34,9 @@ class NetBSDVM(basevm.BaseVM):
>                                           sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index cfe0572c59..2105c01a26 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -35,8 +35,9 @@ class OpenBSDVM(basevm.BaseVM):
>                  sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
>          img_tmp_xz = img + ".tmp.xz"
>          img_tmp = img + ".tmp"
> +        sys.stderr.write("Extracting the image...\n")
>          subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> 
