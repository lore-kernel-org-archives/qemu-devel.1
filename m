Received: from eggs.gnu.org ([2001:4830:134:3::10]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZi5v-0007Fr-T9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZi5s-0003gZ-T2
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:00:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZi5s-0003fa-Md
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:00:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96030C04BD57
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 19:00:46 +0000 (UTC)
Date: Thu, 11 Jan 2018 19:00:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111190036.GF13384@work-vm>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105215246.908-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/11] tests: Consolidate accelerators
 declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 32f3bb86a8..d81f22118b 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -434,27 +434,29 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>      gchar *cmd_src, *cmd_dst;
>      char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>      const char *arch = qtest_get_arch();
> +    const char *accel = "kvm:tcg";
>  
>      got_stop = false;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          init_bootfile_x86(bootpath);
> -        cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> +        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name pcsource,debug-threads=on"
>                                    " -serial file:%s/src_serial"
>                                    " -drive file=%s,format=raw",
> -                                  tmpfs, bootpath);
> -        cmd_dst = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> +                                  accel, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name pcdest,debug-threads=on"
>                                    " -serial file:%s/dest_serial"
>                                    " -drive file=%s,format=raw"
>                                    " -incoming %s",
> -                                  tmpfs, bootpath, uri);
> +                                  accel, tmpfs, bootpath, uri);
>      } else if (strcmp(arch, "ppc64") == 0) {
> -        const char *accel;
>  
>          /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
> -        accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
> +        if (access("/sys/module/kvm_hv", F_OK)) {
> +            accel = "tcg";
> +        }
>          init_bootfile_ppc(bootpath);
>          cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
>                                    " -name pcsource,debug-threads=on"
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
