Received: from eggs.gnu.org ([2001:4830:134:3::10]:52876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP2ad-00087c-DN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP2aa-0002ed-7Q
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gP2aZ-0002e0-WD
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00087A402B
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 09:44:58 +0000 (UTC)
References: <20181115122930.25732-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c33763c1-57bc-c9f9-e790-6c184763c62e@redhat.com>
Date: Tue, 20 Nov 2018 10:44:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181115122930.25732-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1?] qtest: log QEMU command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com

On 2018-11-15 13:29, Paolo Bonzini wrote:
> Record the command line that was used to start QEMU.  This can be
> useful for debugging.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/libqtest.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 44ce118cfc..f6e061da44 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -215,24 +215,28 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
>  
>      qtest_add_abrt_handler(kill_qemu_hook_func, s);
>  
> +    command = g_strdup_printf("exec %s "
> +                              "-qtest unix:%s,nowait "
> +                              "-qtest-log %s "
> +                              "-chardev socket,path=%s,nowait,id=char0 "
> +                              "-mon chardev=char0,mode=control%s "
> +                              "-machine accel=qtest "
> +                              "-display none "
> +                              "%s", qemu_binary, socket_path,
> +                              getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
> +                              qmp_socket_path, use_oob ? ",x-oob=on" : "",
> +                              extra_args ?: "");
> +
> +    g_test_message("starting QEMU: %s\n", command);

I think we don't need the trailing \n here, do we? Looking at the output
when I run a test with --verbose, it seems like glib is taking care of
this already... (if you agree, I can fix it up when picking the patch up)

 Thomas
