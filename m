Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25093C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE34E20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE34E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Qol-0002qe-6W
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5Qnw-0002Ka-6C
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5Qnu-0008Ea-Cb
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5Qnu-0008E5-4O
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:38:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1067D4E924;
 Wed,  4 Sep 2019 08:38:13 +0000 (UTC)
Received: from work-vm (ovpn-117-227.ams2.redhat.com [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69DEE19D70;
 Wed,  4 Sep 2019 08:37:59 +0000 (UTC)
Date: Wed, 4 Sep 2019 09:37:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190904083756.GB2828@work-vm>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <0d668ccf7c5fa09d4968d618df069ab74787ec29.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d668ccf7c5fa09d4968d618df069ab74787ec29.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 04 Sep 2019 08:38:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 40/45] multi-process/mon: Refactor
 monitor/chardev functions out of vl.c
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> Some of the initialization helper functions w.r.t monitor & chardev
> in vl.c are also used by the remote process. Therefore, these functions
> are refactored into a shared file that both QEMU & remote process
> could use.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>

Shouldn't the monitor parts be moved into something under monitor/ and
the chardev parts be moved into chardev/ ?

Dave

> ---
>  New patch in v3
> 
>  vl-parse.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  vl.c       | 91 -------------------------------------------------------------
>  vl.h       |  4 +++
>  3 files changed, 96 insertions(+), 91 deletions(-)
> 
> diff --git a/vl-parse.c b/vl-parse.c
> index d3716d1..bee904d 100644
> --- a/vl-parse.c
> +++ b/vl-parse.c
> @@ -155,3 +155,95 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      object_unref(OBJECT(dev));
>      return 0;
>  }
> +
> +void monitor_parse(const char *optarg, const char *mode, bool pretty)
> +{
> +    static int monitor_device_index;
> +    QemuOpts *opts;
> +    const char *p;
> +    char label[32];
> +
> +    if (strstart(optarg, "chardev:", &p)) {
> +        snprintf(label, sizeof(label), "%s", p);
> +    } else {
> +        snprintf(label, sizeof(label), "compat_monitor%d",
> +                 monitor_device_index);
> +        opts = qemu_chr_parse_compat(label, optarg, true);
> +        if (!opts) {
> +            error_report("parse error: %s", optarg);
> +            exit(1);
> +        }
> +    }
> +
> +    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
> +    qemu_opt_set(opts, "mode", mode, &error_abort);
> +    qemu_opt_set(opts, "chardev", label, &error_abort);
> +    if (!strcmp(mode, "control")) {
> +        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
> +    } else {
> +        assert(pretty == false);
> +    }
> +    monitor_device_index++;
> +}
> +
> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    Chardev *chr;
> +    bool qmp;
> +    bool pretty = false;
> +    const char *chardev;
> +    const char *mode;
> +
> +    mode = qemu_opt_get(opts, "mode");
> +    if (mode == NULL) {
> +        mode = "readline";
> +    }
> +    if (strcmp(mode, "readline") == 0) {
> +        qmp = false;
> +    } else if (strcmp(mode, "control") == 0) {
> +        qmp = true;
> +    } else {
> +        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> +        return -1;
> +    }
> +
> +    if (!qmp && qemu_opt_get(opts, "pretty")) {
> +        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
> +                    "and will be removed in future versions");
> +    }
> +    if (qemu_opt_get_bool(opts, "pretty", 0)) {
> +        pretty = true;
> +    }
> +
> +    chardev = qemu_opt_get(opts, "chardev");
> +    if (!chardev) {
> +        error_report("chardev is required");
> +        exit(1);
> +    }
> +    chr = qemu_chr_find(chardev);
> +    if (chr == NULL) {
> +        error_setg(errp, "chardev \"%s\" not found", chardev);
> +        return -1;
> +    }
> +
> +    if (qmp) {
> +        monitor_init_qmp(chr, pretty);
> +    } else {
> +        monitor_init_hmp(chr, true);
> +    }
> +    return 0;
> +}
> +
> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +        exit(0);
> +    }
> +    return 0;
> +}
> diff --git a/vl.c b/vl.c
> index 08e9c09..3c03405 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2264,19 +2264,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
>      return qdev_device_help(opts);
>  }
>  
> -static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> -{
> -    Error *local_err = NULL;
> -
> -    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return -1;
> -        }
> -        exit(0);
> -    }
> -    return 0;
> -}
>  
>  #ifdef CONFIG_VIRTFS
>  static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
> @@ -2285,84 +2272,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  }
>  #endif
>  
> -static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> -{
> -    Chardev *chr;
> -    bool qmp;
> -    bool pretty = false;
> -    const char *chardev;
> -    const char *mode;
> -
> -    mode = qemu_opt_get(opts, "mode");
> -    if (mode == NULL) {
> -        mode = "readline";
> -    }
> -    if (strcmp(mode, "readline") == 0) {
> -        qmp = false;
> -    } else if (strcmp(mode, "control") == 0) {
> -        qmp = true;
> -    } else {
> -        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> -        return -1;
> -    }
> -
> -    if (!qmp && qemu_opt_get(opts, "pretty")) {
> -        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
> -                    "and will be removed in future versions");
> -    }
> -    if (qemu_opt_get_bool(opts, "pretty", 0)) {
> -        pretty = true;
> -    }
> -
> -    chardev = qemu_opt_get(opts, "chardev");
> -    if (!chardev) {
> -        error_report("chardev is required");
> -        exit(1);
> -    }
> -    chr = qemu_chr_find(chardev);
> -    if (chr == NULL) {
> -        error_setg(errp, "chardev \"%s\" not found", chardev);
> -        return -1;
> -    }
> -
> -    if (qmp) {
> -        monitor_init_qmp(chr, pretty);
> -    } else {
> -        monitor_init_hmp(chr, true);
> -    }
> -    return 0;
> -}
> -
> -static void monitor_parse(const char *optarg, const char *mode, bool pretty)
> -{
> -    static int monitor_device_index = 0;
> -    QemuOpts *opts;
> -    const char *p;
> -    char label[32];
> -
> -    if (strstart(optarg, "chardev:", &p)) {
> -        snprintf(label, sizeof(label), "%s", p);
> -    } else {
> -        snprintf(label, sizeof(label), "compat_monitor%d",
> -                 monitor_device_index);
> -        opts = qemu_chr_parse_compat(label, optarg, true);
> -        if (!opts) {
> -            error_report("parse error: %s", optarg);
> -            exit(1);
> -        }
> -    }
> -
> -    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
> -    qemu_opt_set(opts, "mode", mode, &error_abort);
> -    qemu_opt_set(opts, "chardev", label, &error_abort);
> -    if (!strcmp(mode, "control")) {
> -        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
> -    } else {
> -        assert(pretty == false);
> -    }
> -    monitor_device_index++;
> -}
> -
>  struct device_config {
>      enum {
>          DEV_USB,       /* -usbdevice     */
> diff --git a/vl.h b/vl.h
> index 8c40fed..21ca747 100644
> --- a/vl.h
> +++ b/vl.h
> @@ -50,5 +50,9 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
>  int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp);
>  int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp);
>  
> +void monitor_parse(const char *optarg, const char *mode, bool pretty);
> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
> +
>  #endif /* VL_H */
>  
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

