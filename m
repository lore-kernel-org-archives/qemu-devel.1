Received: from eggs.gnu.org ([2001:4830:134:3::10]:51269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGGF-000739-FY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGGC-00054K-93
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:02:47 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:40098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGGC-00054D-4k
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:02:44 -0400
Received: by mail-ua0-x244.google.com with SMTP id p22-v6so15639810uao.7
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 20:02:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63c0e5cd-fac0-789c-d7fd-f77ed8d9d047@amsat.org>
Date: Tue, 17 Jul 2018 00:02:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 07/16] docker: gracefully skip
 check_qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> Not all our images are able to run the tests. Rather than use features
> we can just check for the existence and run-ability of gtester. If the
> image has been setup for binfmt_misc it will be able to run anyway.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/common.rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index cfc620d554..6df431eb72 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -47,7 +47,13 @@ check_qemu()
>      else
>          TEST="$@"
>      fi
> -    make $MAKEFLAGS $TEST
> +
> +    if type gtester > /dev/null 2>&1 && \

commit e465ce7d09939d631f1861e0bd8873417c1c0d65

    tests: Use "command -v" instead of which(1) in shell scripts

    When which(1) is not installed, we would complain "perl not found"
    because it's the first set_prog_path check. The error message is
    wrong.

    Fix it by using "command -v", a native way to query the existence
    of a command.

> +           gtester --version > /dev/null 2>&1; then
> +        make $MAKEFLAGS $TEST
> +    else
> +        echo "No working gtester, skipping make $TEST"
> +    fi
>  }
>  
>  test_fail()
> 
