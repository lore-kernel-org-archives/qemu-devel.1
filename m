Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczVI-00073h-FQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczVE-0006eo-12
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:56 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczVD-0006eA-Ss
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:44:51 -0400
Received: by mail-qt0-x242.google.com with SMTP id a5-v6so5050104qtp.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 13:44:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dba15966-cc27-947c-ae52-b57b4153d0f5@amsat.org>
Date: Tue, 10 Jul 2018 17:44:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180709152117.21585-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 03/10] docker: fail more gracefully
 on docker.py check
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

On 07/09/2018 12:21 PM, Alex Bennée wrote:
> As this is called directly from the Makefile while determining
> dependencies and it is possible the user was configured in one window
> but not have credentials in the other. Let's catch the Exceptions and
> deal with it quietly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 69e7130db7..2f81c6b13b 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -479,7 +479,12 @@ class CheckCommand(SubCommand):
>      def run(self, args, argv):
>          tag = args.tag
>  
> -        dkr = Docker()
> +        try:
> +            dkr = Docker()
> +        except:
> +            print("Docker not set up")
> +            return 1
> +
>          info = dkr.inspect_tag(tag)
>          if info is None:
>              print("Image does not exist")
> 
