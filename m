Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B411CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601ED20873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymyx8Hng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601ED20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBYX-0002Yl-Sx
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jordipujolp@gmail.com>) id 1iQAZf-0000Qk-46
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jordipujolp@gmail.com>) id 1iQAZd-0003P3-EM
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:33:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jordipujolp@gmail.com>)
 id 1iQAZd-0003NY-7q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:33:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id t8so5374819otl.6
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b8WfBtkBYtvhtzdH/YlQo1f41oCGaEAOJrce5DObJnE=;
 b=Ymyx8HngulfzMbl1rJSGHP6J9Z/eFR98WP0bc7PRhElUI4jwl1knWKiGLpDXQVcpVv
 lNN7C4urxvPNbJPd8wQUhbmVlhZJ4W6x27q+Saw10BQQMOFKAvRdzwN4oWje70RYoxQY
 54ShoWDOFDGXpwb5SVSRNFnVmHEerlAuQmV4nRbBmFL9aBtFXxoQY0ZMW6fREiSYFfg7
 cYvGOvLEPjzewTLfrhS+cZopbR74zQ5qUIU8xV7+aXDl6+c8jQakRyNK9ihl+6R8BF+p
 xUhyFYCcmrlkcdJUAW0COldlZRk0TRS52hZaNdeX2Q+SF3doAQ4OwAlYV20+o9UwL2RF
 nveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b8WfBtkBYtvhtzdH/YlQo1f41oCGaEAOJrce5DObJnE=;
 b=HEu89/XrHY0PFZM9uT/HmYjrg6KDNoDUcK+QbpZ7F/PI472QSlkXZQ5dneZDj6j79w
 RtiOYjkjtflgcN5VaZ4o35cq6ZRL93vfXRfbPGlAJl7QtVJKnMHHJNnX/xZjZBBLuCSq
 2yEZCOnspkpoQGvaeNo60r3BtQ+t8XDrNwp5WQVSM8yvWaQtL+Hg7Wc/FgevajpgcYX3
 YPpE1VrHvt4CwspWt8tTLwVxXMNFi5Y9J6uFiNWR4X7fyayZ3HBnYzHngLnCPKQWBqEE
 aFYzE/I+N2qYkkVskVxbL1L/Dnfb6MKTZkSf4lVTyCfkLxapxzixugU1X1t7CN6+LgET
 Ff6A==
X-Gm-Message-State: APjAAAX8zxiDbj3BpEyaJzV9cGR7E9Ls5wAKW7s3FwWttGZlZr5bt7xs
 mOCIe/25GkfbwhjAPz0LoITTts4vp9L+zo/lcQw=
X-Google-Smtp-Source: APXvYqylmvb8E1R4P8eRGlkJjAPvSas9NPaqPsPD2g/kze3rpGCVG353yAdPzqzkmAU38t4GRI28au16npT2v7lovk0=
X-Received: by 2002:a9d:600b:: with SMTP id h11mr4737614otj.334.1572528791917; 
 Thu, 31 Oct 2019 06:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACTE=gpFbUSxXeTwu6_tzSeoh_9Yp905aMdzCPCUz3h7kcgeyw@mail.gmail.com>
 <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
In-Reply-To: <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
From: Jordi Pujol <jordipujolp@gmail.com>
Date: Thu, 31 Oct 2019 14:33:00 +0100
Message-ID: <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
Subject: Re: [PATCH v2] smb daemon get additional command line parameters from
 env variable
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
X-Mailman-Approved-At: Thu, 31 Oct 2019 10:28:18 -0400
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Many thanks Laurent,

This is the version 2 of this patch, has been modified according to
the qemu guidelines.

**************************************************
From: Jordi Pujol Palomer <jordipujolp@gmail.com>
Date: Thu, 31 Oct 2019 14:31:14 +0200
Subject: [PATCH v2] QEMU samba daemon: additional command line options

The smbd daemon takes additional command line options
from environment variable SMBDOPTIONS.
Set the environment variable SMBDOPTIONS before executing qemu.

Example:

export SMBDOPTIONS="--option='server min protocol=CORE' -d 4"

Signed-off-by: Jordi Pujol Palomer <jordipujolp@gmail.com>
---
--- qemu-4.1-a/net/slirp.c
+++ qemu_4.1-b/net/slirp.c
@@ -909,6 +909,12 @@ static int slirp_smb(SlirpState* s, cons
              CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
     g_free(smb_conf);

+    char *options = g_strdup(g_getenv("SMBDOPTIONS"));
+    if (options) {
+        smb_cmdline = g_strdup_printf("%s %s", smb_cmdline, options);
+    }
+    g_free(options);
+
     if (slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 139) < 0 ||
         slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 445) < 0) {
         slirp_smb_cleanup(s);

--- qemu-4.1-a/slirp/src/misc.c 2019-10-29 14:40:15.043120941 +0100
+++ qemu-4.1-b/slirp/src/misc.c 2019-10-29 14:41:04.440235684 +0100
@@ -168,7 +168,9 @@ g_spawn_async_with_fds_slirp(const gchar
 int fork_exec(struct socket *so, const char *ex)
 {
     GError *err = NULL;
-    char **argv;
+    gint argc = 0;
+    gchar **argv = NULL;
+    gboolean ret;
     int opt, sp[2];

     DEBUG_CALL("fork_exec");
@@ -179,7 +181,13 @@ int fork_exec(struct socket *so, const c
         return 0;
     }

-    argv = g_strsplit(ex, " ", -1);
+    ret = g_shell_parse_argv(ex, &argc, &argv, &err);
+    if (err) {
+        g_critical("fork_exec invalid command: %s", err->message);
+        g_error_free(err);
+        return 0;
+    }
+
     g_spawn_async_with_fds(NULL /* cwd */, argv, NULL /* env */,
                            G_SPAWN_SEARCH_PATH, fork_exec_child_setup,
                            NULL /* data */, NULL /* child_pid */, sp[1], sp[1],
**************************************************

Thanks,

Jordi Pujol

