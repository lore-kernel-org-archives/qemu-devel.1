Received: from eggs.gnu.org ([2001:4830:134:3::10]:40578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZt0P-0008Nr-12
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZt0L-0004Gu-NF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:12:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fZt0L-0004G8-IK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:12:09 -0400
Date: Mon, 2 Jul 2018 15:12:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180702071205.GI26002@lemon.usersys.redhat.com>
References: <20180628153535.1411-1-f4bug@amsat.org>
	<20180628153535.1411-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180628153535.1411-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] tests/vm: Support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Thu, 06/28 12:35, Philippe Mathieu-Daud=E9 wrote:
> If ftp_proxy/http_proxy/https_proxy standard environment variables
> are available, pass them to the vm images.
>=20
> As per 06cc3551714:
> This is required when building behind corporate proxy/firewall, but
> also help when using local cache server (ie: apt/yum).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/vm/ubuntu.i386 | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index fc319e0e6e..be16ceed50 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -68,6 +68,10 @@ class UbuntuX86VM(basevm.BaseVM):
>          self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_i=
nit_iso()])
>          self.wait_ssh()
>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> +        for k, v in os.environ.iteritems():
> +            kl =3D k.lower()
> +            if kl in ['ftp_proxy', 'http_proxy', 'https_proxy']:
> +                self.ssh_root_check("echo 'Acquire::{}::Proxy \"{}\";'=
 >> /etc/apt/apt.conf.d/01proxy".format(kl[:-6].upper(), v))

Reasonable, but do we want it for other apps and images? How about settin=
g these
env vars to ssh commands?

Fam

>          self.ssh_root_check("apt-get update")
>          self.ssh_root_check("apt-get install -y cloud-initramfs-growro=
ot")
>          # Don't check the status in case the guest hang up too quickly
> --=20
> 2.18.0
>=20
