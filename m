Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EA120756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk9wj9Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EA120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZsCA-0005jj-TB
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZsB0-0005El-1p
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZsAw-0003wg-64
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604394021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPXsXTezcXIB1ny6YU0t2HN0AfYZZpLRli9QV2ILw5Q=;
 b=Gk9wj9UdEKCHcevlEBgEgtmuxCi/BeFmAOrI/X0ZAf0j9+DW4eU3n0zLom7whAH4a3ZGOa
 pvp4+GOQZ5qPf8cEZa39VMskC86cy0sYewX8Xh0xu/J3mkSN5jWAB5/zr2VxvlLwcenSZK
 RvPmzBaYtBnyb/Z1GNVJRBJxNZtZ+VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-pFCrKgdQNdqpjhu_61_GnA-1; Tue, 03 Nov 2020 04:00:19 -0500
X-MC-Unique: pFCrKgdQNdqpjhu_61_GnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468CD8030C4
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 09:00:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6626260C04;
 Tue,  3 Nov 2020 09:00:16 +0000 (UTC)
Subject: Re: [PATCH v3 5/7] virtiofsd: Announce sub-mount points
To: Miklos Szeredi <mszeredi@redhat.com>
References: <20201102161859.156603-1-mreitz@redhat.com>
 <20201102161859.156603-6-mreitz@redhat.com>
 <CAOssrKdrRV6vbooVnMH2Hrq3XPAG6uX4N8nxgwxRDzAyKF1A1g@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cecb2ca8-d15a-76e7-a34d-c37b85929961@redhat.com>
Date: Tue, 3 Nov 2020 10:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAOssrKdrRV6vbooVnMH2Hrq3XPAG6uX4N8nxgwxRDzAyKF1A1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.11.20 09:10, Miklos Szeredi wrote:
> On Mon, Nov 2, 2020 at 5:19 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> Whenever we encounter a directory with an st_dev or mount ID that
>> differs from that of its parent, we set the FUSE_ATTR_SUBMOUNT flag so
>> the guest can create a submount for it.
>>
>> We only need to do so in lo_do_lookup().  The following functions return
>> a fuse_attr object:
>> - lo_create(), though fuse_reply_create(): Calls lo_do_lookup().
>> - lo_lookup(), though fuse_reply_entry(): Calls lo_do_lookup().
>> - lo_mknod_symlink(), through fuse_reply_entry(): Calls lo_do_lookup().
>> - lo_link(), through fuse_reply_entry(): Creating a link cannot create a
>>   submount, so there is no need to check for it.
>> - lo_getattr(), through fuse_reply_attr(): Announcing submounts when the
>>   node is first detected (at lookup) is sufficient.  We do not need to
>>   return the submount attribute later.
>> - lo_do_readdir(), through fuse_add_direntry_plus(): Calls
>>   lo_do_lookup().
>>
>> Make announcing submounts optional, so submounts are only announced to
>> the guest with the announce_submounts option.  Some users may prefer the
>> current behavior, so that the guest learns nothing about the host mount
>> structure.
>>
>> (announce_submounts is force-disabled when the guest does not present
>> the FUSE_SUBMOUNTS capability, or when there is no statx().)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  tools/virtiofsd/helper.c         |  1 +
>>  tools/virtiofsd/passthrough_ll.c | 22 ++++++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
>> index 2e181a49b5..4433724d3a 100644
>> --- a/tools/virtiofsd/helper.c
>> +++ b/tools/virtiofsd/helper.c
>> @@ -190,6 +190,7 @@ void fuse_cmdline_help(void)
>>             "                               retain/discard O_DIRECT flags passed down\n"
>>             "                               to virtiofsd from guest applications.\n"
>>             "                               default: no_allow_direct_io\n"
>> +           "    -o announce_submounts      Announce sub-mount points to the guest\n"
>>             );
>>  }
>>
>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
>> index 34d107975f..ec1008bceb 100644
>> --- a/tools/virtiofsd/passthrough_ll.c
>> +++ b/tools/virtiofsd/passthrough_ll.c
>> @@ -40,6 +40,7 @@
>>  #include "fuse_virtio.h"
>>  #include "fuse_log.h"
>>  #include "fuse_lowlevel.h"
>> +#include "standard-headers/linux/fuse.h"
>>  #include <assert.h>
>>  #include <cap-ng.h>
>>  #include <dirent.h>
>> @@ -167,6 +168,7 @@ struct lo_data {
>>      int readdirplus_set;
>>      int readdirplus_clear;
>>      int allow_direct_io;
>> +    int announce_submounts;
>>      bool use_statx;
>>      struct lo_inode root;
>>      GHashTable *inodes; /* protected by lo->mutex */
>> @@ -207,6 +209,7 @@ static const struct fuse_opt lo_opts[] = {
>>      { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
>>      { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
>>      { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
>> +    { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
>>      FUSE_OPT_END
>>  };
>>  static bool use_syslog = false;
>> @@ -601,6 +604,20 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>>          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
>>          conn->want &= ~FUSE_CAP_READDIRPLUS;
>>      }
>> +
>> +    if (!(conn->capable & FUSE_CAP_SUBMOUNTS) && lo->announce_submounts) {
>> +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, client "
>> +                 "does not support it\n");
>> +        lo->announce_submounts = false;
>> +    }
>> +
>> +#ifndef CONFIG_STATX
>> +    if (lo->announce_submounts) {
>> +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, there "
>> +                 "is no statx()\n");
>> +        lo->announce_submounts = false;
> 
> Minor issue: this warns only when libc doesn't have statx, and not
> when kernel doesn't have it.
> 
>> +    }
>> +#endif
>>  }
>>
>>  static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
>> @@ -877,6 +894,11 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>>          goto out_err;
>>      }
>>
>> +    if (S_ISDIR(e->attr.st_mode) && lo->announce_submounts &&
>> +        (e->attr.st_dev != dir->key.dev || mnt_id != dir->key.mnt_id)) {
>> +        e->attr_flags |= FUSE_ATTR_SUBMOUNT;
>> +    }
> 
> ... and since announce_submounts isn't turned off in case the kernel
> doesn't have STATX_MNT_ID, this will trigger a submount when crossing
> into a different filesystem.

Oh.  Yes.  I totally forgot that when writing the warning.

> Possible solutions:
> 
> a) test and warn at startup in case kernel doesn't have statx
> 
> b) do not test st_dev, only mnt_id (which will always be zero if not supported)
> 
> c) merge announce_submounts and use_statx, which are basically doing
> the same thing

Isn’t that a single thing?  I.e., if we decide not to test st_dev, then
we should do all of these, I think.

OTOH, we could also just drop the warning (that statx()) isn’t
available, because as the code is, we can still announce submounts.  The
only problem is that we’ll suffer from the bug fixed by patch 4
(different mounts with the same st_dev being treated as the same tree),
but that’s unrelated to announcing submounts.

(Well, to be fair, not having statx() does break one thing about
submounts: I suppose you could mount a device inside of its own mount
(“mount $mount_opts $dir; mount $mount_opts $dir/sub” – then $dir/sub
wouldn’t be marked as a submount without statx()), but that probably
yields a host of other problems besides not announcing the nested mount
as a submount (virtiofsd would treat $dir/sub as the same node as $dir,
I think), so again, I wouldn’t worry too much about not getting the
FUSE_SUBMOUNT flag right.)

So I think I’d rather just drop the warning and leave the rest as it is.
 Not least because STATX_MNT_ID is rather new.

Max


