Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C5C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB83820760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUIWSwey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB83820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPnGT-0002es-Hz
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kPnFv-0002FR-I0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kPnFt-00088l-M8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 09:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601991829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wKfgzx42lITCiNHnkfrQCM90waahNcXGMIwe+DC4wwc=;
 b=JUIWSweyDIKNMtUj8Xj0VWjOKBtIIoQQ6IuKN4K6x8AKtOQnfToioE82RqPKXLGB9lYbTo
 5xsi4mifBHI6QGSNP6dcNJhc69rHuqyllIJB/V2r4ISoh+xYfNVZRo6RiptsPbepb9mbMn
 AXGlTttghOziwBrduu1Sw6O8vfULZPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-PW_igdK5MKe-_UhwIN3Vdg-1; Tue, 06 Oct 2020 09:43:47 -0400
X-MC-Unique: PW_igdK5MKe-_UhwIN3Vdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511619CC37
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 13:43:46 +0000 (UTC)
Received: from localhost (ovpn-113-0.ams2.redhat.com [10.36.113.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E28221002C02;
 Tue,  6 Oct 2020 13:43:39 +0000 (UTC)
Date: Tue, 6 Oct 2020 15:43:38 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofsd: avoid /proc/self/fd tempdir
Message-ID: <20201006134338.GA49600@linux.fritz.box>
References: <20201006095826.59813-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006095826.59813-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jfreimann@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jfreimann@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 10:58:26AM +0100, Stefan Hajnoczi wrote:
>In order to prevent /proc/self/fd escapes a temporary directory is
>created where /proc/self/fd is bind-mounted. This doesn't work on
>read-only file systems.
>
>Avoid the temporary directory by bind-mounting /proc/self/fd over /proc.
>This does not affect other processes since we remounted / with MS_REC |
>MS_SLAVE. /proc must exist and virtiofsd does not use it so it's safe to
>do this.
>
>Path traversal can be tested with the following function:
>
>  static void test_proc_fd_escape(struct lo_data *lo)
>  {
>      int fd;
>      int level = 0;
>      ino_t last_ino = 0;
>
>      fd = lo->proc_self_fd;
>      for (;;) {
>          struct stat st;
>
>          if (fstat(fd, &st) != 0) {
>              perror("fstat");
>              return;
>          }
>          if (last_ino && st.st_ino == last_ino) {
>              fprintf(stderr, "inode number unchanged, stopping\n");
>              return;
>          }
>          last_ino = st.st_ino;
>
>          fprintf(stderr, "Level %d dev %lu ino %lu\n", level,
>                  (unsigned long)st.st_dev,
>                  (unsigned long)last_ino);
>          fd = openat(fd, "..", O_PATH | O_DIRECTORY | O_NOFOLLOW);
>          level++;
>      }
>  }
>
>Before and after this patch only Level 0 is displayed. Without
>/proc/self/fd bind-mount protection it is possible to traverse parent
>directories.
>
>Fixes: 397ae982f4df4 ("virtiofsd: jail lo->proc_self_fd")
>Cc: Miklos Szeredi <mszeredi@redhat.com>
>Cc: Jens Freimann <jfreimann@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks Stefan, it fixes the problem we had!

Tested-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com> 

regards,
Jens 


