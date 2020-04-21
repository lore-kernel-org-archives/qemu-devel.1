Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B7C55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DF12068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hDZlvLGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DF12068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqLc-0005aW-MV
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQqKv-00055i-FV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQqKr-0003m8-LE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:41:05 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jQqKq-0003jg-Tk; Tue, 21 Apr 2020 06:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=LRDYyK2Vqu7cmJLr8qjV0EjAnATp34KSqhJbIBCS9K8=; 
 b=hDZlvLGlXU0G646i6BTuD3Mb6ZbhTAUW97MSJftlisDQIAkr/bZ1DUMpsNPQlhazXy7joSjym6eL3Q7Ggcaz8MVlSvSmEpnI7y/356nRQeU0+6TexM395fLS19WiO6cbDuMSb98cDsMBYvPkNB9S+nM4MHCWpfVdQ/STUQS/MD69lwArehpFr7MthQYa9SASSKdtiZM4AdlIl5BPNfs4CTiSbnaJZgTxo8tFQ2Jek7EOZ4TdD2vQLbhJ3DwjAGx70Asst4/nEIOKVfb+zr9pXTPJi3yuImC3I0J4DqFd0KTnKRCl2B9CIeuhwoauCP3NR9lFHy5irU581KOkc5qNgA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jQqKm-0001py-Rq; Tue, 21 Apr 2020 12:40:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jQqKm-0002c6-IO; Tue, 21 Apr 2020 12:40:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v20 1/4] qcow2: introduce compression type feature
In-Reply-To: <20200421081117.7595-2-dplotnikov@virtuozzo.com>
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-2-dplotnikov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 21 Apr 2020 12:40:56 +0200
Message-ID: <w51zhb59l53.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 06:35:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 21 Apr 2020 10:11:14 AM CEST, Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
>
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
>
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
>
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
>
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
>
> The tests are fixed in the following ways:
>     * filter out compression_type for many tests
>     * fix header size, feature table size and backing file offset
>       affected tests: 031, 036, 061, 080
>       header_size +=8: 1 byte compression type
>                        7 bytes padding
>       feature_table += 48: incompatible feature compression type
>       backing_file_offset += 56 (8 + 48 -> header_change + feature_table_change)
>     * add "compression type" for test output matching when it isn't filtered
>       affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

