Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ACC2071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpbcnN8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ACC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ49-0001l6-9B
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDQ2l-0000qy-6L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDQ2f-0004j6-R6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghZBnv4YjnU3x73RREH3TzJZDIOrk3lJZpfbOk1U0MM=;
 b=SpbcnN8oFcFy7ZW2D+zs1yI8YnsOpsMQ2jznmapaB7Mge1sdeI9yf6i0vzKXHVNIhwu6XH
 fJrR4rq0pVbjHLPFCnxZc1E5sUtPHsHuj2v0mqWbTOxqUKkSwGD9j0wsuqgzFlH7+Jtub3
 lSkWBwRbQoDjCt0JFUhfO0g31k36KUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Q3q6_FyANmidaD4pBSQ4Qw-1; Wed, 02 Sep 2020 06:30:58 -0400
X-MC-Unique: Q3q6_FyANmidaD4pBSQ4Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08317801ADE;
 Wed,  2 Sep 2020 10:30:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8C075D9CC;
 Wed,  2 Sep 2020 10:30:55 +0000 (UTC)
Subject: Re: [PATCH 02/13] oslib: do not call g_strdup from qemu_get_exec_dir
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <10522b86-cd46-e428-a63a-e8622f468289@redhat.com>
Date: Wed, 2 Sep 2020 12:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901062020.26660-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 08.20, Paolo Bonzini wrote:
> Just return the directory without requiring the caller to free it.
> This also removes a bogus check for NULL in os_find_datadir and
> module_load_one; g_strdup of a static variable cannot return NULL.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/osdep.h    |  8 ++------
>  os-posix.c              |  6 +-----
>  os-win32.c              |  2 +-
>  tests/qtest/fuzz/fuzz.c |  4 ++--
>  util/module.c           |  7 +------
>  util/oslib-posix.c      |  8 +++++---
>  util/oslib-win32.c      | 12 ++++++++----
>  7 files changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 412962d91a..db2cfffaff 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -590,12 +590,8 @@ char *qemu_get_local_state_pathname(const char *relative_pathname);
>   * Try OS specific API first, if not working, parse from argv0. */
>  void qemu_init_exec_dir(const char *argv0);
>  
> -/* Get the saved exec dir.
> - *
> - * The caller is responsible for releasing the value returned with g_free()
> - * after use.
> - */
> -char *qemu_get_exec_dir(void);
> +/* Get the saved exec dir.  */
> +const char *qemu_get_exec_dir(void);
>  
>  /**
>   * qemu_getauxval:
> diff --git a/os-posix.c b/os-posix.c
> index bf98508b6d..8d8e7fc15c 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -90,13 +90,9 @@ void os_setup_signal_handling(void)
>   */
>  char *os_find_datadir(void)
>  {
> -    g_autofree char *exec_dir = NULL;
>      g_autofree char *dir = NULL;
>  
> -    exec_dir = qemu_get_exec_dir();
> -    g_return_val_if_fail(exec_dir != NULL, NULL);
> -
> -    dir = g_build_filename(exec_dir, "pc-bios", NULL);
> +    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
>      }
> diff --git a/os-win32.c b/os-win32.c
> index c9c3afe648..eb8501b9e5 100644
> --- a/os-win32.c
> +++ b/os-win32.c
> @@ -65,7 +65,7 @@ void os_setup_early_signal_handling(void)
>   */
>  char *os_find_datadir(void)
>  {
> -    return qemu_get_exec_dir();
> +    return g_strdup(qemu_get_exec_dir());
>  }
>  
>  void os_set_line_buffering(void)
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 391223219d..1811cb1d88 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -143,7 +143,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>  {
>  
>      char *target_name;
> -    char *bindir, *datadir;
> +    const char *bindir;
> +    char *datadir;
>      bool serialize = false;
>  
>      /* Initialize qgraph and modules */
> @@ -167,7 +168,6 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>           */
>          bindir = qemu_get_exec_dir();
>          datadir = g_build_filename(bindir, "pc-bios", NULL);
> -        g_free(bindir);
>          if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
>              qemu_add_data_dir(datadir);
>          }
> diff --git a/util/module.c b/util/module.c
> index 6e63006a8f..aed04b578a 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -172,7 +172,6 @@ bool module_load_one(const char *prefix, const char *lib_name)
>  
>  #ifdef CONFIG_MODULES
>      char *fname = NULL;
> -    char *exec_dir;
>  #ifdef CONFIG_MODULE_UPGRADES
>      char *version_dir;
>  #endif
> @@ -199,13 +198,12 @@ bool module_load_one(const char *prefix, const char *lib_name)
>          return true;
>      }
>  
> -    exec_dir = qemu_get_exec_dir();
>      search_dir = getenv("QEMU_MODULE_DIR");
>      if (search_dir != NULL) {
>          dirs[n_dirs++] = g_strdup_printf("%s", search_dir);
>      }
>      dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
> -    dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
> +    dirs[n_dirs++] = g_strdup(qemu_get_exec_dir());
>  
>  #ifdef CONFIG_MODULE_UPGRADES
>      version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
> @@ -216,9 +214,6 @@ bool module_load_one(const char *prefix, const char *lib_name)
>  
>      assert(n_dirs <= ARRAY_SIZE(dirs));
>  
> -    g_free(exec_dir);
> -    exec_dir = NULL;
> -
>      for (i = 0; i < n_dirs; i++) {
>          fname = g_strdup_printf("%s/%s%s",
>                  dirs[i], module_name, CONFIG_HOST_DSOSUF);
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index ad8001a4ad..0dd8d24076 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -366,7 +366,9 @@ void qemu_init_exec_dir(const char *argv0)
>      char *p = NULL;
>      char buf[PATH_MAX];
>  
> -    assert(!exec_dir[0]);
> +    if (exec_dir[0]) {
> +        return;
> +    }
>  
>  #if defined(__linux__)
>      {
> @@ -439,9 +441,9 @@ void qemu_init_exec_dir(const char *argv0)
>      g_free(dir);
>  }
>  
> -char *qemu_get_exec_dir(void)
> +const char *qemu_get_exec_dir(void)
>  {
> -    return g_strdup(exec_dir);
> +    return exec_dir;
>  }
>  
>  static void sigbus_handler(int signal)
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c654dafd93..1a33912944 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -315,7 +315,7 @@ void qemu_set_tty_echo(int fd, bool echo)
>      }
>  }
>  
> -static char exec_dir[PATH_MAX];
> +static char *exec_dir;
>  
>  void qemu_init_exec_dir(const char *argv0)
>  {
> @@ -324,6 +324,10 @@ void qemu_init_exec_dir(const char *argv0)
>      char buf[MAX_PATH];
>      DWORD len;
>  
> +    if (exec_dir) {
> +        return;
> +    }
> +
>      len = GetModuleFileName(NULL, buf, sizeof(buf) - 1);
>      if (len == 0) {
>          return;
> @@ -336,13 +340,13 @@ void qemu_init_exec_dir(const char *argv0)
>      }
>      *p = 0;
>      if (access(buf, R_OK) == 0) {
> -        pstrcpy(exec_dir, sizeof(exec_dir), buf);
> +        exec_dir = g_strdup(buf);
>      }
>  }
>  
> -char *qemu_get_exec_dir(void)
> +const char *qemu_get_exec_dir(void)
>  {
> -    return g_strdup(exec_dir);
> +    return exec_dir;
>  }
>  
>  #if !GLIB_CHECK_VERSION(2, 50, 0)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


