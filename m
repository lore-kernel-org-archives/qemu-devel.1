Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E925C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C62420663
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp38xZxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C62420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcAs-0001qF-AH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itc9z-0000wU-Rd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itc9v-0006rY-SV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:52:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itc9v-0006rD-P8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579546342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGzVZePhoRnWPrBVe5+ISOBW8O8DsJGnJDJw6nDSzms=;
 b=fp38xZxocphVhLkts3AaDywSOjDzYttA794cN5hYJ/5FAQ3qDLua7po30QC/D4DQXKZb+q
 vrw/Y2bPV2Dlp94yRiQwoUpZJrOi1v0L4hln51tAQz0+XuoTVehOOTEqhXcnQOxPxiZxSb
 LyjaTdgPGzEeN3ibJ2A+AdYSlIVn+1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-uG2I3aVkPLiyxkvogjSAVw-1; Mon, 20 Jan 2020 13:52:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD27C800D41
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 18:52:19 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BC8085723;
 Mon, 20 Jan 2020 18:52:13 +0000 (UTC)
Date: Mon, 20 Jan 2020 18:52:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 105/104] virtiofsd: Unref old/new inodes with the same
 mutex lock in lo_rename()
Message-ID: <20200120185211.GT2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20200117133257.16906-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200117133257.16906-1-philmd@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uG2I3aVkPLiyxkvogjSAVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> We can unref both old/new inodes with the same mutex lock.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Based-on: <20191212163904.159893-1-dgilbert@redhat.com>
> "virtiofs daemon"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg664652.html
>=20
>  tools/virtiofsd/passthrough_ll.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 57f58aef26..5c717cb5a1 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1461,8 +1461,10 @@ static void lo_rename(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
>      }
> =20
>  out:
> -    unref_inode_lolocked(lo, oldinode, 1);
> -    unref_inode_lolocked(lo, newinode, 1);
> +    pthread_mutex_lock(&lo->mutex);
> +    unref_inode(lo, oldinode, 1);
> +    unref_inode(lo, newinode, 1);
> +    pthread_mutex_unlock(&lo->mutex);

While that would work; I'd rather keep that code simpler and the
same as every other normal operation - we only use the unref_inode
in one other place and that's because we're iterating the hash table
while deleting stuff.

Dave

>      lo_inode_put(lo, &oldinode);
>      lo_inode_put(lo, &newinode);
>      lo_inode_put(lo, &parent_inode);
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


