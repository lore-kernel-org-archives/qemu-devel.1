Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF4C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FD5206CB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuXyPNVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FD5206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij0qI-0004HZ-Oc
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 08:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ij0pT-0003gg-QI
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ij0pQ-0004me-RA
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:59:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57095
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ij0pQ-0004g5-Gm
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577019563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnWycme6P9ILUug4JR+gsMKshS/h1cJa3fGlELpm6Sw=;
 b=IuXyPNVFyIUXdJ7qNoG9gIVrFWoys8eBbF9CP+ffi1lsvqrHAd6LdJs08C7jTiSQFfZZTM
 QdiAUN2R4JZs3IlGOTYBm7TDmWmMv0kRNGQT0SkpKhxUA50+fJ/kN8L86D45yormmnX1s2
 2+bw48xqqyzxEV2k73FciI6NVdr8tYM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-m4dEGHBqPcmDuzz061wfBQ-1; Sun, 22 Dec 2019 07:59:21 -0500
Received: by mail-qt1-f198.google.com with SMTP id d18so9417113qtp.16
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 04:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3VfY79AaT9OCz9fYtZIxc0pbTybcuktunwaJ6yDMVkY=;
 b=TXYKjzqRHbTnu2Wz0uz6IcvrOZhfxCs6CNbQILhRiugx7CGBcsuwcbFxbr+NkZXQIN
 71PdUSmbIkXNdwJ04lc8IHhCK45fFDrxxyTDf8JVo9FnBqZT2wUqeFF/WEybE5x8/deG
 /eWQpm8PeBWGhseNp0Yeb0c8Ht/COW8XiOZssYx5tptiwDfTcuw8Y3wg029ZU/d4xXoy
 QG/PKmVr7jZP88OWG6c58D7wkrcaAY9drm1Xc0PAkLQqLl9qLXSxZ5vdEyIPdnlI5OR+
 WYJyzPmZefRWET4IbtlskkVEO8kJ9Ytlku9Yw84isuTl6RxPEX7RPF/TqxjCCf48Jm1/
 Ev2Q==
X-Gm-Message-State: APjAAAU5HzLkuEF+3IXXnXFCTe/JCJ8tqu8ZUmp9JihJfgjDz9KPJJoj
 0FR7+lBdGwsDHaLFL0pzyHSGyz9B2ybw2KTQ99DqIqEJYTrrKXNdtXBHjt6YPOq03n0rCQqnjV+
 O+QFIjCEXmxwApxk=
X-Received: by 2002:a05:6214:162c:: with SMTP id
 e12mr19624909qvw.3.1577019561132; 
 Sun, 22 Dec 2019 04:59:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHttv3+BaW3nJzk9Roqa9ew+PJ+OWrXkOPbUzrYQsRywPsHMNQlr1+SSRtV9E4hsRFWur6Zw==
X-Received: by 2002:a05:6214:162c:: with SMTP id
 e12mr19624904qvw.3.1577019560933; 
 Sun, 22 Dec 2019 04:59:20 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id f19sm4773031qkk.69.2019.12.22.04.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2019 04:59:19 -0800 (PST)
Date: Sun, 22 Dec 2019 07:59:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/24] virtio, pci, pc: fixes, features
Message-ID: <20191222075324-mutt-send-email-mst@kernel.org>
References: <20191219132621.16595-1-mst@redhat.com>
 <CAFEAcA9HVKxVi4vg7F4ELRpjgk=vFtREXRfJySGy5mdjsJuj9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HVKxVi4vg7F4ELRpjgk=vFtREXRfJySGy5mdjsJuj9A@mail.gmail.com>
X-MC-Unique: m4dEGHBqPcmDuzz061wfBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 06:24:43PM +0000, Peter Maydell wrote:
> On Thu, 19 Dec 2019 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit b0ca999a43a22b38158a222233d3f5881648=
bb4f:
> >
> >   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to d4fbea918a37c0586f1a0e15ac6ef04c9fc7b96b=
:
> >
> >   vhost-user-scsi: reset the device if supported (2019-12-19 08:25:35 -=
0500)
> >
> > ----------------------------------------------------------------
> > virtio, pci, pc: fixes, features
> >
> > Bugfixes all over the place.
> > HMAT support.
> > New flags for vhost-user-blk utility.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
>=20
> Compile failure on OSX:
> /Users/pm215/src/qemu-for-merges/hw/core/numa.c:427:20: error: format
> specifies type 'unsigned char' but the argument has type 'int'
> [-Werror,-Wformat]
>                    node->level - 1);
> ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/hw/core/numa.c:440:20: error: format
> specifies type 'unsigned char' but the argument has type 'int'
> [-Werror,-Wformat]
>                    node->level + 1);
> ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^~~~~~~~~~~
> 2 errors generated.
>=20
> thanks
> -- PMM


Could you pls check whether the following fixes it?
Thanks!

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 33fda31a4c..747c9680b0 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -421,7 +421,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCa=
cheOptions *node,
             ms->numa_state->hmat_cache[node->node_id][node->level - 1]->si=
ze)) {
         error_setg(errp, "Invalid size=3D%" PRIu64 ", the size of level=3D=
%" PRIu8
                    " should be less than the size(%" PRIu64 ") of "
-                   "level=3D%" PRIu8, node->size, node->level,
+                   "level=3D%u", node->size, node->level,
                    ms->numa_state->hmat_cache[node->node_id]
                                              [node->level - 1]->size,
                    node->level - 1);
@@ -434,7 +434,7 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCa=
cheOptions *node,
             ms->numa_state->hmat_cache[node->node_id][node->level + 1]->si=
ze)) {
         error_setg(errp, "Invalid size=3D%" PRIu64 ", the size of level=3D=
%" PRIu8
                    " should be larger than the size(%" PRIu64 ") of "
-                   "level=3D%" PRIu8, node->size, node->level,
+                   "level=3D%u", node->size, node->level,
                    ms->numa_state->hmat_cache[node->node_id]
                                              [node->level + 1]->size,
                    node->level + 1);


