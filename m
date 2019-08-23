Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0723A2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0723A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ao8-0003wd-Ff
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AeC-0001Mi-Ga
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AeA-0002q7-KZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1Ae6-0002n9-Gn; Fri, 23 Aug 2019 10:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E36358980EE;
 Fri, 23 Aug 2019 14:34:29 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4F36CE58;
 Fri, 23 Aug 2019 14:34:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: nbd@other.debian.org
Date: Fri, 23 Aug 2019 09:34:26 -0500
Message-Id: <20190823143426.26838-2-eblake@redhat.com>
In-Reply-To: <20190823143426.26838-1-eblake@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143426.26838-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 23 Aug 2019 14:34:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it may be counterintuitive at first, the introduction of
NBD_CMD_WRITE_ZEROES and NBD_CMD_BLOCK_STATUS has caused a performance
regression in qemu [1], when copying a sparse file. When the
destination file must contain the same contents as the source, but it
is not known in advance whether the destination started life with all
zero content, then there are cases where it is faster to request a
bulk zero of the entire device followed by writing only the portions
of the device that are to contain data, as that results in fewer I/O
transactions overall. In fact, there are even situations where
trimming the entire device prior to writing zeroes may be faster than
bare write zero request [2]. However, if a bulk zero request ever
falls back to the same speed as a normal write, a bulk pre-zeroing
algorithm is actually a pessimization, as it ends up writing portions
of the disk twice.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06389.html
[2] https://github.com/libguestfs/nbdkit/commit/407f8dde

Hence, it is desirable to have a way for clients to specify that a
particular write zero request is being attempted for a fast wipe, and
get an immediate failure if the zero request would otherwise take the
same time as a write.  Conversely, if the client is not performing a
pre-initialization pass, it is still more efficient in terms of
networking traffic to send NBD_CMD_WRITE_ZERO requests where the
server implements the fallback to the slower write, than it is for the
client to have to perform the fallback to send NBD_CMD_WRITE with a
zeroed buffer.

Add a protocol flag and corresponding transmission advertisement flag
to make it easier for clients to inform the server of their intent. If
the server advertises NBD_FLAG_SEND_FAST_ZERO, then it promises two
things: to perform a fallback to write when the client does not
request NBD_CMD_FLAG_FAST_ZERO (so that the client benefits from the
lower network overhead); and to fail quickly with ENOTSUP, preferably
without modifying the export, if the client requested the flag but the
server cannot write zeroes more efficiently than a normal write (so
that the client is not penalized with the time of writing data areas
of the disk twice).

Note that the semantics are chosen so that servers should advertise
the new flag whether or not they have fast zeroing (that is, this is
NOT the server advertising that it has fast zeroes, but rather
advertising that the client can get fast feedback as needed on whether
zeroing is fast).  It is also intentional that the new advertisement
includes a new errno value, ENOTSUP, with rules that this error should
not be returned for any pre-existing behaviors, must not happen when
the client does not request a fast zero, and must be returned quickly
if the client requested fast zero but anything other than the error
would not be fast; while leaving it possible for clients to
distinguish other errors like EINVAL if alignment constraints are not
met.  Clients should not send the flag unless the server advertised
support, but well-behaved servers should already be reporting EINVAL
to unrecognized flags. If the server does not advertise the new
feature, clients can safely fall back to assuming that writing zeroes
is no faster than normal writes (whether or not the assumption
actually holds).

Note that the Linux fallocate(2) interface may or may not be powerful
enough to easily determine if zeroing will be efficient - in
particular, FALLOC_FL_ZERO_RANGE in isolation does NOT give that
insight; likewise, for block devices, it is known that
ioctl(BLKZEROOUT) does NOT have a way for userspace to probe if it is
efficient or slow.  But with enough demand, the kernel may add another
FALLOC_FL_ flag to use with FALLOC_FL_ZERO_RANGE, and/or appropriate
ioctls with guaranteed ENOTSUP failures if a fast path cannot be
taken.  If a server cannot easily determine if write zeroes will be
efficient, the server should either fail all NBD_CMD_FLAG_FAST_ZERO
with ENOTSUP, or else choose to not advertise NBD_FLAG_SEND_FAST_ZERO.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 doc/proto.md | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/doc/proto.md b/doc/proto.md
index 52d3e7b..702688b 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -1070,6 +1070,18 @@ The field has the following format:
   which support the command without advertising this bit, and
   conversely that this bit does not guarantee that the command will
   succeed or have an impact.
+- bit 11, `NBD_FLAG_SEND_FAST_ZERO`: allow clients to detect whether
+  `NBD_CMD_WRITE_ZEROES` is faster than a corresponding write. The
+  server MUST set this transmission flag to 1 if the
+  `NBD_CMD_WRITE_ZEROES` request supports the `NBD_CMD_FLAG_FAST_ZERO`
+  flag, and MUST set this transmission flag to 0 if
+  `NBD_FLAG_SEND_WRITE_ZEROES` is not set. Servers MAY set this this
+  transmission flag even if it will always use `NBD_ENOTSUP` failures fo=
r
+  requests with `NBD_CMD_FLAG_FAST_ZERO` set (such as if the server
+  cannot quickly determine whether a particular write zeroes request
+  will be faster than a regular write). Clients MUST NOT set the
+  `NBD_CMD_FLAG_FAST_ZERO` request flag unless this transmission flag
+  is set.

 Clients SHOULD ignore unknown flags.

@@ -1647,6 +1659,12 @@ valid may depend on negotiation during the handsha=
ke phase.
   MUST NOT send metadata on more than one extent in the reply. Client
   implementors should note that using this flag on multiple contiguous
   requests is likely to be inefficient.
+- bit 4, `NBD_CMD_FLAG_FAST_ZERO`; valid during
+  `NBD_CMD_WRITE_ZEROES`. If set, but the server cannot perform the
+  write zeroes any faster than it would for an equivalent
+  `NBD_CMD_WRITE`, then the server MUST fail quickly with an error of
+  `NBD_ENOTSUP`. The client MUST NOT set this unless the server advertis=
ed
+  `NBD_FLAG_SEND_FAST_ZERO`.

 ##### Structured reply flags

@@ -2015,7 +2033,10 @@ The following request types exist:
     reached permanent storage, unless `NBD_CMD_FLAG_FUA` is in use.

     A client MUST NOT send a write zeroes request unless
-    `NBD_FLAG_SEND_WRITE_ZEROES` was set in the transmission flags field=
.
+    `NBD_FLAG_SEND_WRITE_ZEROES` was set in the transmission flags
+    field. Additionally, a client MUST NOT send the
+    `NBD_CMD_FLAG_FAST_ZERO` flag unless `NBD_FLAG_SEND_FAST_ZERO` was
+    set in the transimssion flags field.

     By default, the server MAY use trimming to zero out the area, even
     if it did not advertise `NBD_FLAG_SEND_TRIM`; but it MUST ensure
@@ -2025,6 +2046,28 @@ The following request types exist:
     same area will not cause fragmentation or cause failure due to
     insufficient space.

+    If the server advertised `NBD_FLAG_SEND_FAST_ZERO` but
+    `NBD_CMD_FLAG_FAST_ZERO` is not set, then the server MUST NOT fail
+    with `NBD_ENOTSUP`, even if the operation is no faster than a
+    corresponding `NBD_CMD_WRITE`. Conversely, if
+    `NBD_CMD_FLAG_FAST_ZERO` is set, the server MUST fail quickly with
+    `NBD_ENOTSUP` unless the request can be serviced in less time than
+    a corresponding `NBD_CMD_WRITE`, and SHOULD NOT alter the contents
+    of the export when returning this failure. The server's
+    determination of a fast request MAY depend on a number of factors,
+    such as whether the request was suitably aligned, on whether the
+    `NBD_CMD_FLAG_NO_HOLE` flag was present, or even on whether a
+    previous `NBD_CMD_TRIM` had been performed on the region.  If the
+    server did not advertise `NBD_FLAG_SEND_FAST_ZERO`, then it SHOULD
+    NOT fail with `NBD_ENOTSUP`, regardless of the speed of servicing
+    a request, and SHOULD fail with `NBD_EINVAL` if the
+    `NBD_CMD_FLAG_FAST_ZERO` flag was set. A server MAY advertise
+    `NBD_FLAG_SEND_FAST_ZERO` whether or not it can perform fast
+    zeroing; similarly, a server SHOULD fail with `NBD_ENOTSUP` when
+    the flag is set if the server cannot quickly determine in advance
+    whether that request would have been fast, even if it turns out
+    that the same request without the flag would be fast after all.
+
     If an error occurs, the server MUST set the appropriate error code
     in the error field.

@@ -2125,6 +2168,7 @@ The following error values are defined:
 * `NBD_EINVAL` (22), Invalid argument.
 * `NBD_ENOSPC` (28), No space left on device.
 * `NBD_EOVERFLOW` (75), Value too large.
+* `NBD_ENOTSUP` (95), Operation not supported.
 * `NBD_ESHUTDOWN` (108), Server is in the process of being shut down.

 The server SHOULD return `NBD_ENOSPC` if it receives a write request
@@ -2139,6 +2183,10 @@ read-only export.
 The server SHOULD NOT return `NBD_EOVERFLOW` except as documented in
 response to `NBD_CMD_READ` when `NBD_CMD_FLAG_DF` is supported.

+The server SHOULD NOT return `NBD_ENOTSUP` except as documented in
+response to `NBD_CMD_WRITE_ZEROES` when `NBD_CMD_FLAG_FAST_ZERO` is
+supported.
+
 The server SHOULD return `NBD_EINVAL` if it receives an unknown command.

 The server SHOULD return `NBD_EINVAL` if it receives an unknown
--=20
2.21.0


