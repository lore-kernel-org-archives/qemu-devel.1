Received: from eggs.gnu.org ([209.51.188.92]:48425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn6L-0003UA-7s
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn6I-0006NH-6q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLn6H-0006Mt-UG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16so21822308wrp.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 04:08:33 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190428155451.15653-3-thuth@redhat.com>
Date: Wed, 01 May 2019 12:08:31 +0100
Message-ID: <877eba77ps.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> "check -raw 005" fails when running on ext4 filesystems - these do not
> support such large sparse files. Use the same check as in test 220 to
> skip the test in this case.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/005 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 2fef63af88..6136ced5c8 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>      _notrun "image protocol $IMGPROTO does not support large image sizes"
>  fi
>
> +# Sanity check: For raw, we require a file system that permits the creat=
ion
> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.

Is this comment correct? Running on my ext4 home partition this test
seems to be running fine and not skipping. Indeed:

  12:06:29 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + p=
wd
  /home/alex/lsrc/qemu.git/builds/kvm/tests/qemu-iotests
  12:07:12 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + s=
tat -f -c %T .
  ext2/ext3
  12:07:40 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + t=
ouch scratch/t.img
  12:07:45 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + t=
runcate --size=3D5T scratch/t.img
  12:07:47 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + l=
s -lh scratch/t.img
  -rw-r--r-- 1 alex alex 5.0T May  1 12:07 scratch/t.img
  12:07:51 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + s=
tat -f -c %T scratch/t.img
  ext2/ext3
  12:07:58 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + d=
u -sh scratch/
  4.0K    scratch/


> +if [ "$IMGFMT" =3D "raw" ]; then
> +    if ! truncate --size=3D5T "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +fi
> +
>  echo
>  echo "creating large image"
>  _make_test_img 5000G

--
Alex Benn=C3=A9e
