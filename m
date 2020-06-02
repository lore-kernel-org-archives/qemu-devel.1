Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D803C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DFB2077D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHB81eic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DFB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9oU-0004L3-9Y
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg9nS-0003gz-3L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:29:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg9nP-0000OC-4y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591115386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BGMGIeD7NkkAhxUwJKv1MAja5tGqFCMcN5LPZpDApjY=;
 b=HHB81eicPaFp3dexYCq50sBGA9LitNpV3jKqYnJKkJHUMMONy2h7IwAZQRkc78qPtXkI86
 QYJASHzsrVFfckcArwrkCtk21ruidrJ0UDdAcXeXikRNJ3gwmrBe2hegiOHh24wlbbpYYK
 l8WLqUutSUz+B4zSVs5H8uJBWFzR6+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-v4BgZb-ZOkSXJE6F1qgU5g-1; Tue, 02 Jun 2020 12:29:43 -0400
X-MC-Unique: v4BgZb-ZOkSXJE6F1qgU5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D032835B40;
 Tue,  2 Jun 2020 16:29:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-81.ams2.redhat.com
 [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4BC22BE58;
 Tue,  2 Jun 2020 16:29:39 +0000 (UTC)
Subject: Re: [PATCH v7 00/14] LUKS: encryption slot management using amend
 interface
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200518122041.10694-1-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <3266027d-8baf-a970-3141-3131106ff98c@redhat.com>
Date: Tue, 2 Jun 2020 18:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518122041.10694-1-mlevitsk@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.05.20 14:20, Maxim Levitsky wrote:
> Hi!
> Here is the updated series of my patches, incorporating all the feedback I received.

You asked me on IRC what to do to get this series to move forward;
considering I don’t think there were objections from anyone but me on
v6, there are no further (substantial) objections from anyone on v7, and
I gave all feedback I had on v6, I don’t think there’s much you can do
right now.  (Sorry for the delay, but, well, I was on PTO as you know.)

As usual, I’ll try to get around to see whether I can rebase your series
myself (because Dan hinted at some conflicts), and whether I feel like
my comments were appropriately addressed (which I have little doubt
about).  That’s the plan.

Note from a couple minutes later: From what I can see, the rebase
conflicts don’t look too wild, but I don’t feel quite comfortable
addressing all of them.  There’s a functional one I could address in
qemu-img.c (patch 3), where we need to bump OPTION_FORCE from 269 to
276.  I could do that, but that’s not the only one, unfortunately.

Patch 7 needs a bit more extensive modification: First, we need
%s/bdrv_filter_default_perms/bdrv_default_perms/.  Second, this will
still not compile, because the .bdrv_child_perm interface has changed.
BdrvChildRole is now an integer, so we also need
s/const BdrvChildRole \*/BdrvChildRole /.
(That gives us the nice side effect of being able to align the second
line of the bdrv_default_perms() parameters (called from
block_crypto_child_perms()) on the opening parenthesis.)

Third, it becomes really interesting.  With these changes, it would be
wrong, because bdrv_default_perms() will then not use the permissions
for a filter but for an image file with metadata – because that’s what
the LUKS file child is.

But that’s actually a bug that’s already there (and that I introduced).
 It makese sense to fix it in your series here, because to fix it we
need a dedicated block_crypto_child_perms() function anyway.

So, well.  Do we want to cheat?  Just let block_crypto_child_perms()
call bdrv_default_perms() with role=BDRV_CHILD_FILTERED?  That would be
the previous behavior, but it would also be bad cheating.

The comment that exists (before patch 7) above
bdrv_crypto_luks.bdrv_child_perm says that we just want to allow
share-rw=on, and we could achieve that simply by force-sharing the WRITE
permission after invoking bdrv_default_perms() with the actual role
(which is BDRV_CHILD_IMAGE).

But what about the other stuff that sets
bdrv_default_perms_for_storage() apart from bdrv_filter_default_perms()?
 I.e., force-taking WRITE and RESIZE permissions if the file is
writable; force-taking the CONSISTENT_READ permission because we need
the metadata; and unsharing the RESIZE permission?

I think the best thing to do would be to call bdrv_default_perms() with
the @role passed to block_crypto_child_perms() (i.e., BDRV_CHILD_IMAGE),
and then relaxing the permissions, that is to share the WRITE and RESIZE
persmissions, and to perhaps restore the WRITE and RESIZE permissions
from what’s given to block_crypto_child_perms() (i.e., *nperm &= ~(WRITE
| RESIZE); *nperm |= perm & (WRITE | RESIZE);), because LUKS doesn’t
need them unless the image may actually be written.

(OTOH, force-taking CONSISTENT_READ seems entirely reasonable.)

Max


