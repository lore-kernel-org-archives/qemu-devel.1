Received: from eggs.gnu.org ([2001:4830:134:3::10]:57029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Yws-00066P-Sm
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Ywp-00057L-Nu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:42:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Ywp-00056q-IP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:42:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33B794040073
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:42:28 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-8-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c71c9a6-7e56-3a22-21e8-af4338237b1a@redhat.com>
Date: Mon, 26 Mar 2018 15:42:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-8-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 7/8] tests: introduce
 qtest_init_with_qmp_format()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:39 AM, Peter Xu wrote:
> It is abstracted from qtest_init_without_qmp_handshake(). It works just
> like qtest_init_without_qmp_handshake() but further it would allow the
> caller to specify the QMP parameter.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/libqtest.c | 14 +++++++++++---
>   tests/libqtest.h | 14 ++++++++++++++
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 

[Reviewing in reverse order; you may want to look at 
scripts/git.orderfile for how to present your patches in a more logical 
manner with .h changes first.]

 > diff --git a/tests/libqtest.h b/tests/libqtest.h
 > index 811169453a..1f3605ce73 100644
 > --- a/tests/libqtest.h
 > +++ b/tests/libqtest.h
 > @@ -62,6 +62,20 @@ QTestState *qtest_init(const char *extra_args);
 >    */
 >   QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 >
 > +/**
 > + * qtest_init_with_qmp_format:
 > + * @extra_args: other arguments to pass to QEMU.

Not your fault, but I'm already not a fan of 'extra_args'; it would be 
better to make these functions take an array of arguments, or even use 
varargs, instead of relying on shell word splitting.  Our testsuite is a 
gaping security hole if executed in a directory where a shell 
metacharacter causes the shell word splitting to do something different 
than planned.

 > + * @qmp_format: format of QMP parameters, should contain one "%s"
 > + *              field so that the socket path will be filled later.
 > + *
 > + * Note that this function will work just like
 > + * qtest_init_without_qmp_handshake(), so no QMP handshake will be done.
 > + *
 > + * Returns: #QTestState instance.
 > + */
 > +QTestState *qtest_init_with_qmp_format(const char *extra_args,
 > +                                       const char *qmp_format);

Ouch - you didn't use any attribute to mark the format string so that 
the compiler can enforce that it is treated as a printf-style argument. 
I wonder if it would have been better to just have a 'bool use_oob' 
parameter rather than playing ugly games with passing printf-style 
format arguments around.

 > +
 >   /**
 >    * qtest_quit:
 >    * @s: #QTestState instance to operate on.
 >

> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 200b2b9e92..d2af1b17f0 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -166,19 +166,22 @@ static const char *qtest_qemu_binary(void)
>       return qemu_bin;
>   }
>   
> -QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
> +QTestState *qtest_init_with_qmp_format(const char *extra_args,
> +                                       const char *qmp_format)
>   {
>       QTestState *s;
>       int sock, qmpsock, i;
>       gchar *socket_path;
>       gchar *qmp_socket_path;
>       gchar *command;
> +    gchar *qmp_params;
>       const char *qemu_binary = qtest_qemu_binary();
>   
>       s = g_new(QTestState, 1);
>   
>       socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>       qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
> +    qmp_params = g_strdup_printf(qmp_format, qmp_socket_path);

And in addition to my earlier comment about not using a compiler 
attribute, you aren't even bothering to assert that the caller didn't 
pass in a garbage string, which can really lead to weird breakages.

>   
>       /* It's possible that if an earlier test run crashed it might
>        * have left a stale unix socket lying around. Delete any
> @@ -199,12 +202,12 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>           command = g_strdup_printf("exec %s "
>                                     "-qtest unix:%s,nowait "
>                                     "-qtest-log %s "
> -                                  "-qmp unix:%s,nowait "
> +                                  "%s "
>                                     "-machine accel=qtest "
>                                     "-display none "
>                                     "%s", qemu_binary, socket_path,
>                                     getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
> -                                  qmp_socket_path,
> +                                  qmp_params,

Again, if you used the idea of a 'bool use_oob',  this would look more like:

"-qmp unix:%s,nowait%s ",
...
qmp_socket_path, use_oob ? "x-oob=on" : "",

which is a lot more limited in scope to prevent auditing nightmares, 
while no less powerful for what you are actually using this new function 
for.

>                                     extra_args ?: "");
>           execlp("/bin/sh", "sh", "-c", command, NULL);
>           exit(1);
> @@ -237,6 +240,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>       return s;
>   }
>   
> +QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
> +{
> +    return qtest_init_with_qmp_format(extra_args, "-qmp unix:%s,nowait");
> +}

There are so few callers of qtest_init_without_qmp_handshake() that I'd 
just add the parameter to the existing function and update its two 
callers, instead of adding yet another forwarding wrapper.  Especially 
if it is just adding a 'bool use_oob' parameter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
