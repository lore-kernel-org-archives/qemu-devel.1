Received: from eggs.gnu.org ([209.51.188.92]:54025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsES-00033w-7Z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsEO-0004bd-Bf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLsEI-0003wx-0j
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so9537741wrb.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:37:04 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-8-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190428155451.15653-8-thuth@redhat.com>
Date: Wed, 01 May 2019 17:37:02 +0100
Message-ID: <87sgty5dxt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
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

> Currently, all tests are in the "auto" group. This is a little bit pointl=
ess.
> OTOH, we need a group for the tests that we can automatically run during
> "make check" each time, too. Tests in this new group are supposed to run
> with every possible QEMU configuration, for example they must run with ev=
ery
> QEMU binary (also non-x86), without failing when an optional features
> is

I'm curious as to what tests fail on non-x86? I was under the naive
impression that at least for Linux all the file-system relevant bits
where fairly uniformly implemented.

> missing (but reporting "skip" is ok), and be able to run on all kind of h=
ost
> filesystems and users (i.e. also as "nobody" or "root").
> So let's use the "auto" group for this class of tests now. The initial
> list has been determined by running the iotests with non-x86 QEMU targets
> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. including
> macOS and FreeBSD).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



> ---
>  tests/qemu-iotests/group | 169 +++++++++++++++++++++------------------
>  1 file changed, 91 insertions(+), 78 deletions(-)
>
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index bae7718380..4d0b6ae256 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -1,8 +1,21 @@
>  #
>  # QA groups control file
>  # Defines test groups
> +#
> +# Some notes about the groups:
> +#
>  # - do not start group names with a digit
>  #
> +# - quick : Tests in this group should finish within some few seconds.
> +#
> +# - img : Tests in this group can be used to excercise the qemu-img tool.
> +#
> +# - auto : Tests in this group are used during "make check" and should be
> +#   runnable in any case. That means they should run with every QEMU bin=
ary
> +#   (also non-x86), with every QEMU configuration (i.e. must not fail if
> +#   an optional feature is not compiled in - but reporting a "skip" is o=
k),
> +#   and work all kind of host filesystems and users (e.g. "nobody" or "r=
oot").
> +#
>
>  #
>  # test-group association ... one line per test
> @@ -32,11 +45,11 @@
>  023 rw auto
>  024 rw backing auto quick
>  025 rw auto quick
> -026 rw blkdbg auto
> +026 rw blkdbg
>  027 rw auto quick
>  028 rw backing auto quick

028 failed on an armhf host for me.

>  029 rw auto quick
> -030 rw auto backing
> +030 rw backing
<snip>
> +245 rw
> +246 rw quick
>  247 rw auto quick

And 247

> -248 rw auto quick
> +248 rw quick


--
Alex Benn=C3=A9e
