Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897E920721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I917bYgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkwi-0002OP-Or
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbkwB-0001nA-1I
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:08:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbkwA-0001Iq-6H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590066517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwYqN44/Mg/NgyQdOmt2lzEtYwXJVDcFuKcopnQEGEQ=;
 b=I917bYgFjJrjrL3Y65tSVMQU+A/+AdiYar0FCbFe9QwhNhGmy+5nRN2aZAKJyNab47eYh/
 5Z/TSiA9NXigmc310ZbajTw2R3HmKEglbbV5WNDPiUoOMHNqQynL0QeEurKqFUj4lkl5tC
 xgKmZKRQIBhBbe3uNlQjuZ1r/mzgxz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-eks_47UZMimrwGn21LlUHg-1; Thu, 21 May 2020 09:08:28 -0400
X-MC-Unique: eks_47UZMimrwGn21LlUHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C732680183C;
 Thu, 21 May 2020 13:08:27 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12C6760C84;
 Thu, 21 May 2020 13:08:27 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <69fec648-ec51-6a0d-1703-4017db901119@redhat.com>
Date: Thu, 21 May 2020 08:08:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 6:00 PM, Nir Soffer wrote:

>>
>> On the command-line side, 'qemu-img measure' gains a new --bitmaps
>> flag.  When present, the bitmap size is rolled into the two existing
>> measures (or errors if either the source image or destination format
>> lacks bitmaps); when absent, there is never an error (for
>> back-compat), but the output will instead include a new line item for
>> bitmaps (which you would have to manually add), with that line being
>> omitted in the same cases where passing --bitmaps would error.
> 
> Supporting 2 ways to measure, one by specifying --bitmaps, and another
> by adding bitmaps key is not a good idea. We really need one way.
> 
> Each one has advantages. adding --bitmaps flag is consistent with
> "qemu-img convert"
> and future extensions that may require  new flag, and adding "bitmaps"
> key is consistent
> with "qmeu-img info", showing bitmaps when they exist.
> 
> Adding a "bitmaps" key has an advantage that we can use it to test if qemu-img
> supports measuring and copying bitmaps (since both features are expected to
> be delivered at the same time). So we can avoid checking --help learn about
> the capabilities.
> 
> I'm ok with both options, can we have only one?

That was the crux of the conversation after v3, where we were trying to 
figure out what interface you actually needed.  I implemented both to 
show the difference, but if you want only one, then my preference is to 
delete the --bitmaps option and only expose the optional 'bitmaps size' 
field in all cases where bitmaps can be copied.

Here's the diff that would accomplish that:

diff --git i/docs/tools/qemu-img.rst w/docs/tools/qemu-img.rst
index 35050fc51070..69cd9a30373a 100644
--- i/docs/tools/qemu-img.rst
+++ w/docs/tools/qemu-img.rst
@@ -597,7 +597,7 @@ Command description:
    For more information, consult ``include/block/block.h`` in QEMU's
    source code.

-.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] 
[--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [--bitmaps] [-l 
SNAPSHOT_PARAM] FILENAME]
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] 
[--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l 
SNAPSHOT_PARAM] FILENAME]

    Calculate the file size required for a new image.  This information
    can be used to size logical volumes or SAN LUNs appropriately for
@@ -634,10 +634,7 @@ Command description:
    copy bitmaps from a source image in addition to the guest-visible
    data; the line is omitted if either source or destination lacks
    bitmap support, or 0 if bitmaps are supported but there is nothing
-  to copy.  If the ``--bitmaps`` option is in use, the bitmap size is
-  instead folded into the required and fully-allocated size for
-  convenience, rather than being a separate line item; using the
-  option will raise an error if bitmaps are not supported.
+  to copy.

  .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l 
| -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME

diff --git i/qemu-img.c w/qemu-img.c
index 1494d8f5c409..8dc4cae2c274 100644
--- i/qemu-img.c
+++ w/qemu-img.c
@@ -5207,7 +5207,6 @@ static int img_measure(int argc, char **argv)
          {"output", required_argument, 0, OPTION_OUTPUT},
          {"size", required_argument, 0, OPTION_SIZE},
          {"force-share", no_argument, 0, 'U'},
-        {"bitmaps", no_argument, 0, OPTION_BITMAPS},
          {0, 0, 0, 0}
      };
      OutputFormat output_format = OFORMAT_HUMAN;
@@ -5224,7 +5223,6 @@ static int img_measure(int argc, char **argv)
      QemuOpts *sn_opts = NULL;
      QemuOptsList *create_opts = NULL;
      bool image_opts = false;
-    bool bitmaps = false;
      uint64_t img_size = UINT64_MAX;
      BlockMeasureInfo *info = NULL;
      Error *local_err = NULL;
@@ -5297,10 +5295,6 @@ static int img_measure(int argc, char **argv)
              img_size = (uint64_t)sval;
          }
          break;
-        case OPTION_BITMAPS:
-            bitmaps = true;
-            break;
-        }
      }

      if (qemu_opts_foreach(&qemu_object_opts,
@@ -5328,10 +5322,6 @@ static int img_measure(int argc, char **argv)
          error_report("Either --size N or one filename must be 
specified.");
          goto out;
      }
-    if (!filename && bitmaps) {
-        error_report("--bitmaps is only supported with a filename.");
-        goto out;
-    }

      if (filename) {
          in_blk = img_open(image_opts, filename, fmt, 0,
@@ -5387,18 +5377,6 @@ static int img_measure(int argc, char **argv)
          goto out;
      }

-    if (bitmaps) {
-        if (!info->has_bitmaps) {
-            error_report("no bitmaps measured, either source or 
destination "
-                         "format lacks bitmap support");
-            goto out;
-        } else {
-            info->required += info->bitmaps;
-            info->fully_allocated += info->bitmaps;
-            info->has_bitmaps = false;
-        }
-    }
-
      if (output_format == OFORMAT_HUMAN) {
          printf("required size: %" PRIu64 "\n", info->required);
          printf("fully allocated size: %" PRIu64 "\n", 
info->fully_allocated);
diff --git i/qemu-img-cmds.hx w/qemu-img-cmds.hx
index e9beb15e614e..10b910b67cf8 100644
--- i/qemu-img-cmds.hx
+++ w/qemu-img-cmds.hx
@@ -76,9 +76,9 @@ SRST
  ERST

  DEF("measure", img_measure,
-"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | 
[--object objectdef] [--image-opts] [-f fmt] [--bitmaps] [-l 
snapshot_param] filename]")
+"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | 
[--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
  SRST
-.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] 
[--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [--bitmaps] [-l 
SNAPSHOT_PARAM] FILENAME]
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] 
[--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l 
SNAPSHOT_PARAM] FILENAME]
  ERST

  DEF("snapshot", img_snapshot,


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


