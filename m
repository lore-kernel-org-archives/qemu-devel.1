Received: from eggs.gnu.org ([2001:4830:134:3::10]:40101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faAPZ-0002MB-Jd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faAPW-00035x-Ej
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:47:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1faAPW-000353-1O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:47:18 -0400
Date: Tue, 3 Jul 2018 09:47:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180703014714.GC485@lemon.usersys.redhat.com>
References: <20180628153535.1411-1-f4bug@amsat.org>
	<20180628153535.1411-2-f4bug@amsat.org>
	<20180702071205.GI26002@lemon.usersys.redhat.com>
	<beca5523-ea92-6c2b-c931-6b3523f18460@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <beca5523-ea92-6c2b-c931-6b3523f18460@amsat.org>
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

On Mon, 07/02 12:11, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 07/02/2018 04:12 AM, Fam Zheng wrote:
> > On Thu, 06/28 12:35, Philippe Mathieu-Daud=E9 wrote:
> >> If ftp_proxy/http_proxy/https_proxy standard environment variables
> >> are available, pass them to the vm images.
> >>
> >> As per 06cc3551714:
> >> This is required when building behind corporate proxy/firewall, but
> >> also help when using local cache server (ie: apt/yum).
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  tests/vm/ubuntu.i386 | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> >> index fc319e0e6e..be16ceed50 100755
> >> --- a/tests/vm/ubuntu.i386
> >> +++ b/tests/vm/ubuntu.i386
> >> @@ -68,6 +68,10 @@ class UbuntuX86VM(basevm.BaseVM):
> >>          self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_clou=
d_init_iso()])
> >>          self.wait_ssh()
> >>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> >> +        for k, v in os.environ.iteritems():
> >> +            kl =3D k.lower()
> >> +            if kl in ['ftp_proxy', 'http_proxy', 'https_proxy']:
> >> +                self.ssh_root_check("echo 'Acquire::{}::Proxy \"{}\=
";' >> /etc/apt/apt.conf.d/01proxy".format(kl[:-6].upper(), v))
> >=20
> > Reasonable, but do we want it for other apps and images? How about se=
tting these
> > env vars to ssh commands?
>=20
> I see 2 different network usages:
>=20
> 1/ how the guest connect to the outer world, this goes via the firewall=
.
> Here the change only affects apt* based commands (via the apt.conf file=
).
> Do we have other commands requiring network connectivity? If we have,
> then yes, we should add the same env vars in the guest.
> One case I think of is "git submodule init" calling "git clone".

Yes, I think this case is what we are looking at here. But this patch is =
very
specific: it only affects one command in one VM, albeit we don't have man=
y.
Doing this means we'll need to specially open code tests/vm/fedora,
tests/vm/debian, or any other images we introduce later, to be consistent=
 with
ubuntu.i386. It is a poor way to do this, IMO.

What I mean is, can we do it more generically? Like setting the env var i=
n guest
/etc/profile or change BaseVM._ssh_do() to inject env vars:

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3643117816..94501e7dc7 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -106,7 +106,9 @@ class BaseVM(object):
         if interactive:
             ssh_cmd +=3D ['-t']
         assert not isinstance(cmd, str)
-        ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
+        env =3D ["%s=3D%s" % (k, v) for k, v in os.environ.items() if k =
in \
+                ["ftp_proxy", "http_proxy", "https_proxy"]]
+        ssh_cmd +=3D ["%s@127.0.0.1" % user] + env + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
         r =3D subprocess.call(ssh_cmd)
         if check and r !=3D 0:
