Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21988C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7B42070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwIL5M96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7B42070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwMt-0006RM-1y
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwLp-0005Wo-Le
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwLo-0002Ty-Cz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:38:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iuwLl-0002MS-Lw; Fri, 24 Jan 2020 05:38:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OANHpE051393;
 Fri, 24 Jan 2020 10:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=kJYuGOHxAJSijG0ahMlaMAPg8iWcWaOUuXKZkKmTajM=;
 b=nwIL5M96u+fRUucd+2W4y5k2wj7QcyeRG4jse2aOnCimgRkuRORkEFX7YJON6ePCeN8M
 fEAw7knrbEfnBPaTtUw0P2vvPjlG2ASNmmOWeL6Qjb/ksJlrd9DrrZcNLk72d7ttMmiI
 M2co+IZqEQCs0V8RCP1HztsXK4viXk4SDdEk/O41qN0cX1tW2MBcZFw0KNNjEaSqdAu5
 ukWVY6jtNcymDZxn+33lmR9VSUP65E7947qKq8KaAyXCSQ3n+JC9d79PlZrrbMCKcw+d
 QVii+Mk3GYdAW75q1vIjAYl8q2DVz4tJ7OmH2dsMaQ4u+qz8dpYgkh7+sMbJyp3rPpTm Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2xksyqr853-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:38:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAVJGR112268;
 Fri, 24 Jan 2020 10:36:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2xqmuepue4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:36:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00OAa4pa007328;
 Fri, 24 Jan 2020 10:36:04 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Jan 2020 02:36:03 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 4f429e87;
 Fri, 24 Jan 2020 10:36:00 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 2/2] doc: Use @code rather than @var for options
Date: Fri, 24 Jan 2020 10:34:58 +0000
Message-Id: <20200124103458.1525982-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124103458.1525982-1-david.edmondson@oracle.com>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
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
Cc: David Edmondson <david.edmondson@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Texinfo defines @var for metasyntactic variables and such terms are
shown in upper-case or italics in the output of makeinfo. When
considering an option to a command, such as "-n", upper-casing is
undesirable as it may confuse the reader or be in conflict with the
equivalent upper-case option.

Replace the use of @var for options with @code to avoid this.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 qemu-img.texi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6dfd8682..6b4a1ac961 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -74,13 +74,13 @@ keys.
 @item --image-opts
 Indicates that the source @var{filename} parameter is to be interpreted as a
 full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-f} parameter.
+exclusive with the @code{-f} parameter.
 
 @item --target-image-opts
 Indicates that the @var{output_filename} parameter(s) are to be interpreted as
 a full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-O} parameters. It is currently required to also use
-the @var{-n} parameter to skip image creation. This restriction may be relaxed
+exclusive with the @code{-O} parameters. It is currently required to also use
+the @code{-n} parameter to skip image creation. This restriction may be relaxed
 in a future release.
 
 @item --force-share (-U)
@@ -103,13 +103,13 @@ with or without a command shows help and lists the supported formats
 
 @item -p
 display progress bar (compare, convert and rebase commands only).
-If the @var{-p} option is not used for a command that supports it, the
+If the @code{-p} option is not used for a command that supports it, the
 progress is reported when the process receives a @code{SIGUSR1} or
 @code{SIGINFO} signal.
 
 @item -q
 Quiet mode - do not print any output (except errors). There's no progress bar
-in case both @var{-q} and @var{-p} options are used.
+in case both @code{-q} and @code{-p} options are used.
 
 @item -S @var{size}
 indicates the consecutive number of bytes that must contain only zeros
@@ -298,14 +298,14 @@ the top image stays valid).
 Check if two images have the same content. You can compare images with
 different format or settings.
 
-The format is probed unless you specify it by @var{-f} (used for
-@var{filename1}) and/or @var{-F} (used for @var{filename2}) option.
+The format is probed unless you specify it by @code{-f} (used for
+@var{filename1}) and/or @code{-F} (used for @var{filename2}) option.
 
 By default, images with different size are considered identical if the larger
 image contains only unallocated and/or zeroed sectors in the area after the end
 of the other image. In addition, if any sector is not allocated in one image
 and contains only zero bytes in the second one, it is evaluated as equal. You
-can use Strict mode by specifying the @var{-s} option. When compare runs in
+can use Strict mode by specifying the @code{-s} option. When compare runs in
 Strict mode, it fails in case image size differs or a sector is allocated in
 one image and is not allocated in the second one.
 
-- 
2.24.1


