Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CAC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB6B20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXBQTrWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6B20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1GlN-000530-RJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1GkL-0004Md-VQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1GkI-0006Wr-UV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:37:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1GkI-0006UL-QC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581370654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FNPJLAwxlqp6XYsrI52R3aM36dx1U5zMd2uuI+0CAw4=;
 b=CXBQTrWQHawG+eMIMrkV5U5nmhcQ0CId+VlHo6RNP6Romg06BJrz4SKEgwyPq77civwwYn
 MfMBa2xoxpPdaiAKElN08G1zci5t6XyvdKBAPXFomy0vMeuVOrPkIE9P9G5jVsF9RsoIMA
 e2Mtdm86z19EKUIKPgERp0tzVU5NuWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-o5p4pWqfOUGlSo6mQhP9jA-1; Mon, 10 Feb 2020 16:37:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55C08017CC;
 Mon, 10 Feb 2020 21:37:24 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FD35C1D4;
 Mon, 10 Feb 2020 21:37:21 +0000 (UTC)
To: "nbd@other.debian.org" <nbd@other.debian.org>,
 QEMU <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "libguestfs@redhat.com" <libguestfs@redhat.com>
From: Eric Blake <eblake@redhat.com>
Subject: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
Organization: Red Hat, Inc.
Message-ID: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
Date: Mon, 10 Feb 2020 15:37:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: o5p4pWqfOUGlSo6mQhP9jA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I will be following up to this email with four separate threads each 
addressed to the appropriate single list, with proposed changes to:
- the NBD protocol
- qemu: both server and client
- libnbd: client
- nbdkit: server

The feature in question adds a new optional NBD_INFO_ packet to the 
NBD_OPT_GO portion of handshake, adding up to 16 bits of information 
that the server can advertise to the client at connection time about any 
known initial state of the export [review to this series may propose 
slight changes, such as using 32 bits; but hopefully by having all four 
series posted in tandem it becomes easier to see whether any such tweaks 
are warranted, and can keep such tweaks interoperable before any of the 
projects land the series upstream].  For now, only 2 of those 16 bits 
are defined: NBD_INIT_SPARSE (the image has at least one hole) and 
NBD_INIT_ZERO (the image reads completely as zero); the two bits are 
orthogonal and can be set independently, although it is easy enough to 
see completely sparse files with both bits set.  Also, advertising the 
bits is orthogonal to whether the base:allocation metacontext is used, 
although a server with all possible extensions is likely to have the two 
concepts match one another.

The new bits are added as an information chunk rather than as runtime 
flags; this is because the intended client of this information is 
operations like copying a sparse image into an NBD server destination. 
Such a client only cares at initialization if it needs to perform a 
pre-zeroing pass or if it can rely on the destination already reading as 
zero.  Once the client starts making modifications, burdening the server 
with the ability to do a live runtime probe of current reads-as-zero 
state does not help the client, and burning per-export flags for 
something that quickly goes stale on the first edit was not thought to 
be wise, similarly, adding a new NBD_CMD did not seem worthwhile.

The existing 'qemu-img convert source... nbd://...' is the first command 
line example that can benefit from the new information; the goal of 
adding a protocol extension was to make this benefit automatic without 
the user having to specify the proposed --target-is-zero when possible. 
I have a similar thread pending for qemu which adds similar 
known-reads-zero information to qcow2 files:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08075.html

That qemu series is at v1, and based on review it has had so far, it 
will need some interface changes for v2, which means my qemu series here 
will need a slight rebasing, but I'm posting this series to all lists 
now to at least demonstrate what is possible when we have better startup 
information.

Note that with this new bit, it is possible to learn if a destination is 
sparse as part of NBD_OPT_GO rather than having to use block-status 
commands.  With existing block-status commands, you can use an O(n) scan 
of block-status to learn if an image reads as all zeroes (or 
short-circuit in O(1) time if the first offset is reported as probable 
data rather than reading as zero); but with this new bit, the answer is 
O(1).  So even with Vladimir's recent change to make the spec permit 4G 
block-status even when max block size is 32M, or the proposed work to 
add 64-bit block-status, you still end up with more on-the-wire traffic 
for block-status to learn if an image is all zeroes than if the server 
just advertises this bit.  But by keeping both extensions orthogonal, a 
server can implement whichever one or both reporting methods it finds 
easiest, and a client can work with whatever a server supplies with sane 
fallbacks when the server lacks either extension.  Conversely, 
block-status tracks live changes to the image, while this bit is only 
valid at connection time.

My repo for each of the four projects contains a tag 'nbd-init-v1':
  https://repo.or.cz/nbd/ericb.git/shortlog/refs/tags/nbd-init-v1
  https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-init-v1
  https://repo.or.cz/libnbd/ericb.git/shortlog/refs/tags/nbd-init-v1
  https://repo.or.cz/nbdkit/ericb.git/shortlog/refs/tags/nbd-init-v1

For doing interoperability testing, I find it handy to use:

PATH=/path/to/built/qemu:/path/to/built/nbdkit:$PATH
/path/to/libnbd/run your command here

to pick up just-built qemu-nbd, nbdsh, and nbdkit that all support the 
feature.

For quickly setting flags:
nbdkit eval init_sparse='exit 0' init_zero='exit 0' ...

For quickly checking flags:
qemu-nbd --list ... | grep init
nbdsh -u uri... -c 'print(h.get_init_flags())'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


