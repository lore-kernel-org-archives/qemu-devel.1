Received: from eggs.gnu.org ([2001:4830:134:3::10]:35981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe2YW-0003tf-0b
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 14:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe2YL-0004cf-F0
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 14:12:35 -0400
References: <20180713071033.15938-1-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b444806b-61da-9930-f0cb-7610d241a16e@redhat.com>
Date: Fri, 13 Jul 2018 14:12:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180713071033.15938-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Use host_device instead of
 file in 149
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>



On 07/13/2018 03:10 AM, Kevin Wolf wrote:
> The test case uses block devices with driver=3Dfile, which causes the t=
est
> to fail after commit 230ff73904 added a deprecation warning for this.
> Fix the test case to use driver=3Dhost_device and update the reference
> output accordingly.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

149         [not run] requires password-less sudo access: sudo: a
password is required

Ah, this one hides from regression scripts quite well...

This test fails both before and after this patch for me, with

+Traceback (most recent call last):
+  File "149", line 525, in <module>
+    test_once(config, qemu_img=3DFalse)
+  File "149", line 336, in test_once
+    cryptsetup_open(config)
+  File "149", line 200, in cryptsetup_open
+    cryptsetup(args, password)
+  File "149", line 124, in cryptsetup
+    raise Exception(msg)
+Exception: Device qiotest-145-twofish-128-xts-plain64-sha1 already exist=
s.
+Command failed with code 17: File exists

Am I missing some prerequisite, maybe?

Anyway, this fixes the regression in the warning output from what I can
see up to this failure, but I probably can't give an R-B here until I
set my own setup straight.

> ---
>  tests/qemu-iotests/149     |   2 +-
>  tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++---------------=
--------
>  2 files changed, 173 insertions(+), 173 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index d3ffa259db..9e0cad76f9 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -259,7 +259,7 @@ def qemu_io_image_args(config, dev=3DFalse):
>      if dev:
>          return [
>              "--image-opts",
> -            "driver=3Dfile,filename=3D%s" % config.device_path()]
> +            "driver=3Dhost_device,filename=3D%s" % config.device_path(=
)]
>      else:
>          return [
>              "--object",
> diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
> index 5dea00bfa8..1407ce6dad 100644
> --- a/tests/qemu-iotests/149.out
> +++ b/tests/qemu-iotests/149.out
> @@ -7,13 +7,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts-pla=
in64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.=
img qiotest-145-aes-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -43,13 +43,13 @@ wrote 10485760/10485760 bytes at offset 32985348833=
28
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.=
img qiotest-145-aes-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -67,13 +67,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha1.=
img', fmt=3Dluks size=3D439804651
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.=
img qiotest-145-aes-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -103,13 +103,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.=
img qiotest-145-aes-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -127,13 +127,13 @@ sudo cryptsetup -q -v luksFormat --cipher twofish=
-xts-plain64 --key-size 512 --h
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-s=
ha1.img qiotest-145-twofish-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -163,13 +163,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-s=
ha1.img qiotest-145-twofish-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -187,13 +187,13 @@ Formatting 'TEST_DIR/luks-twofish-256-xts-plain64=
-sha1.img', fmt=3Dluks size=3D43980
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-s=
ha1.img qiotest-145-twofish-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -223,13 +223,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-s=
ha1.img qiotest-145-twofish-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -247,13 +247,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpent=
-xts-plain64 --key-size 512 --h
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-s=
ha1.img qiotest-145-serpent-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -283,13 +283,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-s=
ha1.img qiotest-145-serpent-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -307,13 +307,13 @@ Formatting 'TEST_DIR/luks-serpent-256-xts-plain64=
-sha1.img', fmt=3Dluks size=3D43980
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-s=
ha1.img qiotest-145-serpent-256-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -343,13 +343,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-s=
ha1.img qiotest-145-serpent-256-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -367,13 +367,13 @@ sudo cryptsetup -q -v luksFormat --cipher cast5-c=
bc-plain64 --key-size 128 --has
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha=
1.img qiotest-145-cast5-128-cbc-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -403,13 +403,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha=
1.img qiotest-145-cast5-128-cbc-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -427,13 +427,13 @@ Formatting 'TEST_DIR/luks-cast5-128-cbc-plain64-s=
ha1.img', fmt=3Dluks size=3D4398046
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha=
1.img qiotest-145-cast5-128-cbc-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -463,13 +463,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha=
1.img qiotest-145-cast5-128-cbc-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -488,13 +488,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc=
-plain --key-size 256 --hash sh
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.im=
g qiotest-145-aes-256-cbc-plain-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -524,13 +524,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.im=
g qiotest-145-aes-256-cbc-plain-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -548,13 +548,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain-sha1.=
img', fmt=3Dluks size=3D43980465111
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.im=
g qiotest-145-aes-256-cbc-plain-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -584,13 +584,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.im=
g qiotest-145-aes-256-cbc-plain-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -608,13 +608,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc=
-plain64 --key-size 256 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.=
img qiotest-145-aes-256-cbc-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -644,13 +644,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.=
img qiotest-145-aes-256-cbc-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -668,13 +668,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha=
1.img', fmt=3Dluks size=3D439804651
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.=
img qiotest-145-aes-256-cbc-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -704,13 +704,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.=
img qiotest-145-aes-256-cbc-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -728,13 +728,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-cbc=
-essiv:sha256 --key-size 256 --
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-=
sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -764,13 +764,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-=
sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -788,13 +788,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-sha25=
6-sha1.img', fmt=3Dluks size=3D4398
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-=
sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -824,13 +824,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-=
sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -848,13 +848,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts=
-essiv:sha256 --key-size 512 --
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-=
sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -884,13 +884,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-=
sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -908,13 +908,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-essiv-sha25=
6-sha1.img', fmt=3Dluks size=3D4398
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-=
sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -944,13 +944,13 @@ wrote 10485760/10485760 bytes at offset 329853488=
3328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-=
sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sh=
a1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -968,13 +968,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-xts=
-plain64 --key-size 256 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1004,13 +1004,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1028,13 +1028,13 @@ Formatting 'TEST_DIR/luks-aes-128-xts-plain64-s=
ha256-sha1.img', fmt=3Dluks size=3D43
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1064,13 +1064,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1088,13 +1088,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 384 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1124,13 +1124,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1148,13 +1148,13 @@ Formatting 'TEST_DIR/luks-aes-192-xts-plain64-s=
ha256-sha1.img', fmt=3Dluks size=3D43
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1184,13 +1184,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha25=
6-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1208,13 +1208,13 @@ sudo cryptsetup -q -v luksFormat --cipher twofi=
sh-xts-plain64 --key-size 256 --h
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-s=
ha1.img qiotest-145-twofish-128-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1244,13 +1244,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-s=
ha1.img qiotest-145-twofish-128-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1268,13 +1268,13 @@ Formatting 'TEST_DIR/luks-twofish-128-xts-plain=
64-sha1.img', fmt=3Dluks size=3D43980
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-s=
ha1.img qiotest-145-twofish-128-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1304,13 +1304,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-s=
ha1.img qiotest-145-twofish-128-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1329,13 +1329,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpe=
nt-xts-plain64 --key-size 256 --h
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-s=
ha1.img qiotest-145-serpent-128-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1365,13 +1365,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-s=
ha1.img qiotest-145-serpent-128-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1389,13 +1389,13 @@ Formatting 'TEST_DIR/luks-serpent-128-xts-plain=
64-sha1.img', fmt=3Dluks size=3D43980
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-s=
ha1.img qiotest-145-serpent-128-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1425,13 +1425,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-s=
ha1.img qiotest-145-serpent-128-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1449,13 +1449,13 @@ sudo cryptsetup -q -v luksFormat --cipher serpe=
nt-xts-plain64 --key-size 384 --h
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-s=
ha1.img qiotest-145-serpent-192-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1485,13 +1485,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-s=
ha1.img qiotest-145-serpent-192-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1509,13 +1509,13 @@ Formatting 'TEST_DIR/luks-serpent-192-xts-plain=
64-sha1.img', fmt=3Dluks size=3D43980
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-s=
ha1.img qiotest-145-serpent-192-xts-plain64-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1545,13 +1545,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-s=
ha1.img qiotest-145-serpent-192-xts-plain64-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha=
1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1571,13 +1571,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha22=
4.img qiotest-145-aes-256-xts-plain64-sha224
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1607,13 +1607,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha22=
4.img qiotest-145-aes-256-xts-plain64-sha224
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1631,13 +1631,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-s=
ha224.img', fmt=3Dluks size=3D4398046
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha22=
4.img qiotest-145-aes-256-xts-plain64-sha224
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1667,13 +1667,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha22=
4.img qiotest-145-aes-256-xts-plain64-sha224
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1691,13 +1691,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha25=
6.img qiotest-145-aes-256-xts-plain64-sha256
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1727,13 +1727,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha25=
6.img qiotest-145-aes-256-xts-plain64-sha256
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1751,13 +1751,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-s=
ha256.img', fmt=3Dluks size=3D4398046
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha25=
6.img qiotest-145-aes-256-xts-plain64-sha256
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1787,13 +1787,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha25=
6.img qiotest-145-aes-256-xts-plain64-sha256
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1811,13 +1811,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha38=
4.img qiotest-145-aes-256-xts-plain64-sha384
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1847,13 +1847,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha38=
4.img qiotest-145-aes-256-xts-plain64-sha384
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1871,13 +1871,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-s=
ha384.img', fmt=3Dluks size=3D4398046
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha38=
4.img qiotest-145-aes-256-xts-plain64-sha384
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1907,13 +1907,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha38=
4.img qiotest-145-aes-256-xts-plain64-sha384
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1931,13 +1931,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha51=
2.img qiotest-145-aes-256-xts-plain64-sha512
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1967,13 +1967,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha51=
2.img qiotest-145-aes-256-xts-plain64-sha512
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -1991,13 +1991,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-s=
ha512.img', fmt=3Dluks size=3D4398046
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha51=
2.img qiotest-145-aes-256-xts-plain64-sha512
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2027,13 +2027,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha51=
2.img qiotest-145-aes-256-xts-plain64-sha512
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2051,13 +2051,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain64 --key-size 512 --hash
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripem=
d160.img qiotest-145-aes-256-xts-plain64-ripemd160
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2087,13 +2087,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripem=
d160.img qiotest-145-aes-256-xts-plain64-ripemd160
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2111,13 +2111,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-r=
ipemd160.img', fmt=3Dluks size=3D4398
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripem=
d160.img qiotest-145-aes-256-xts-plain64-ripemd160
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2147,13 +2147,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripem=
d160.img qiotest-145-aes-256-xts-plain64-ripemd160
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd1=
60
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2171,13 +2171,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-x=
ts-plain --key-size 512 --hash sh
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
slot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwsl=
ot3
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwsl=
ot3
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2207,13 +2207,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
slot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwsl=
ot3
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwsl=
ot3
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2245,13 +2245,13 @@ sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-=
aes-256-xts-plain-sha1-pwallslots
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
allslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2281,13 +2281,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
allslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2305,13 +2305,13 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain-sha=
1-pwallslots.img', fmt=3Dluks size=3D
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
allslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2341,13 +2341,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pw=
allslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwal=
lslots
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2365,13 +2365,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-c=
bc-essiv:sha256 --key-size 256 --
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sh=
a1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2401,13 +2401,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sh=
a1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2425,13 +2425,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-aut=
o-sha1.img', fmt=3Dluks size=3D439804
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sh=
a1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2461,13 +2461,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sh=
a1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2485,13 +2485,13 @@ sudo cryptsetup -q -v luksFormat --cipher aes-c=
bc-plain64:sha256 --key-size 256
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha25=
6-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2521,13 +2521,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha25=
6-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2545,13 +2545,13 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-s=
ha256-sha1.img', fmt=3Dluks size=3D43
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha25=
6-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  # Write test pattern 0xa7
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c write -P 0xa7 100M 10M --image-opts driver=3Dhost_device,fi=
lename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Write test pattern 0x13
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dfile,filen=
ame=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=3Dhost_devic=
e,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  wrote 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> @@ -2581,13 +2581,13 @@ wrote 10485760/10485760 bytes at offset 3298534=
883328
>  sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha25=
6-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  # Read test pattern 0x91
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dfile,filename=3D=
/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c read -P 0x91 100M 10M --image-opts driver=3Dhost_device,fil=
ename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 104857600
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  # Read test pattern 0x5e
>  sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-=
sha1
> -qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dfile,filena=
me=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
> +qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=3Dhost_device=
,filename=3D/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
>  read 10485760/10485760 bytes at offset 3298534883328
>  10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>=20

--=20
=E2=80=94js
