Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02B217D8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q8l+zbyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02B217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKCW-0004NL-37
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jmKBi-0003rC-H1; Fri, 19 Jun 2020 12:48:22 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jmKBg-00013D-BF; Fri, 19 Jun 2020 12:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=JgTXGwDCMB5C5SgsM9I1jkupuN4Oy7eBKut8vxZLMgA=; 
 b=Q8l+zbyvZu7xvBhzn91Nmt6HKThqjggYFDmPHUmVHcfZwh68z6sJSnYwppJzTFoM8shSIWBL+M9HYygwpTwUdaZdBgs6O0I1RlNdVE2Fc15CT8qW4uiT/xXh3EyXbympEiSJAZj2OwlqFeHBmUBvVFsr5CUW8SZqnrkvlTyNb2rPVn7gl1NJjsn667MHYQowQX+VuiieKcnx4zYPYIZH12FovaPvaAgjPBHMpHMsNQZgxwuO0QhGIxOS5ctdxq8kNOjOsz6yob1lDHKTkZJl/kA5ADbclFkWyrVApt9ASPZatFZIqzsyrh/axqDSPhbTQeLpLgbqLYgVjJFT5mk5jQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jmKBJ-0001Z8-5e; Fri, 19 Jun 2020 18:47:57 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jmKBI-0002ej-SK; Fri, 19 Jun 2020 18:47:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
In-Reply-To: <20200619104012.235977-2-mreitz@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 19 Jun 2020 18:47:56 +0200
Message-ID: <w51eeqb9f43.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:47:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 19 Jun 2020 12:40:11 PM CEST, Max Reitz wrote:
> +    if (qcow2_opts->data_file_raw &&
> +        qcow2_opts->preallocation == PREALLOC_MODE_OFF)
> +    {
> +        /*
> +         * data-file-raw means that "the external data file can be
> +         * read as a consistent standalone raw image without looking
> +         * at the qcow2 metadata."  It does not say that the metadata
> +         * must be ignored, though (and the qcow2 driver in fact does
> +         * not ignore it), so the L1/L2 tables must be present and
> +         * give a 1:1 mapping, so you get the same result regardless
> +         * of whether you look at the metadata or whether you ignore
> +         * it.
> +         */
> +        qcow2_opts->preallocation = PREALLOC_MODE_METADATA;

I'm not convinced by this, but your comment made me think of another
possible alternative: in qcow2_get_cluster_offset(), if the cluster is
unallocated and we are using a raw data file then we return _ZERO_PLAIN:

--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -654,6 +654,10 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
+    if (type == QCOW2_CLUSTER_UNALLOCATED && data_file_is_raw(bs)) {
+        type = QCOW2_CLUSTER_ZERO_PLAIN;
+    }
+
     return type;

You could even add a '&& bs->backing' to the condition and emit a
warning to make it more explicit.

Berto

