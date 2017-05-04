Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1d6CmP-0005Hj-Oj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1d6CmO-0006rb-Mf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:10:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170502081832.9546-17-famz@redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-17-famz@redhat.com>
From: =?UTF-8?B?6LCi5piM6b6Z?= <xiechanglong.d@gmail.com>
Date: Thu, 4 May 2017 17:10:29 +0800
Message-ID: <CAOk4XWrLQ3LdvVbXpt_rtx=H2p0WN34yEP4+oWKxqF1v_CsH3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v16 16/22] tests: Disable image lock in
 test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

2017-05-02 16:18 GMT+08:00 Fam Zheng <famz@redhat.com>:
> The COLO block replication architecture requires one disk to be shared
> between primary and secondary, in the test both processes use posix file
> protocol (instead of over NBD) so it is affected by image locking.
> Disable the lock.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/test-replication.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index 3016c6f..cebeb79 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -179,7 +179,8 @@ static BlockBackend *start_primary(void)
>      char *cmdline;
>
>      cmdline = g_strdup_printf("driver=replication,mode=primary,node-name=xxx,"
> -                              "file.driver=qcow2,file.file.filename=%s"
> +                              "file.driver=qcow2,file.file.filename=%s,"
> +                              "file.file.locking=off"
>                                , p_local_disk);
>      opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
>      g_free(cmdline);
> @@ -310,7 +311,9 @@ static BlockBackend *start_secondary(void)
>      Error *local_err = NULL;
>
>      /* add s_local_disk and forge S_LOCAL_DISK_ID */
> -    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2", s_local_disk);
> +    cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
> +                              "file.locking=off",
> +                              s_local_disk);
>      opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
>      g_free(cmdline);
>
> @@ -331,8 +334,10 @@ static BlockBackend *start_secondary(void)
>      /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
>      cmdline = g_strdup_printf("driver=replication,mode=secondary,top-id=%s,"
>                                "file.driver=qcow2,file.file.filename=%s,"
> +                              "file.file.locking=off,"
>                                "file.backing.driver=qcow2,"
>                                "file.backing.file.filename=%s,"
> +                              "file.backing.file.locking=off,"
>                                "file.backing.backing=%s"
>                                , S_ID, s_active_disk, s_hidden_disk
>                                , S_LOCAL_DISK_ID);

Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com>
> --
> 2.9.3
>
>
