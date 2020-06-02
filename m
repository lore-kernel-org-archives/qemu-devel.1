Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C111206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzkvBy5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C111206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg4lX-00036U-QV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg4ky-0002fi-OH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg4kx-0008Aa-C3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591096013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFAB3dSD3+8F9x7PeVSeAvxiAADDCO97eRJR8oA9n6A=;
 b=AzkvBy5IhE2w4X+F9PzJZ5Z1NRGyIRRyQ3cmEXywKQTUQRmxFjo01gq9qDyqx4wpiTXHuL
 Y4OGM2PgSymbtYtjw+UBFQWWuVbwcIouySbzAF5jtcj5WLI4XIDFKDuSddkkxEs06ICyEF
 Fgqd0f2DAbW7cSWgsyLbAdGoKozOon0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-_w5tuXHlOCaej_M5S7A7eQ-1; Tue, 02 Jun 2020 07:06:51 -0400
X-MC-Unique: _w5tuXHlOCaej_M5S7A7eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E2BF1883600;
 Tue,  2 Jun 2020 11:06:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B99ED10013D6;
 Tue,  2 Jun 2020 11:06:49 +0000 (UTC)
Date: Tue, 2 Jun 2020 13:06:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: [question] Partial sector issue while discard in qcow2 image
Message-ID: <20200602110648.GE5940@linux.fritz.box>
References: <BY5PR18MB331316E948CB9AFDA33A6F6DC58B0@BY5PR18MB3313.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR18MB331316E948CB9AFDA33A6F6DC58B0@BY5PR18MB3313.namprd18.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.06.2020 um 09:45 hat Lin Ma geschrieben:
> Hi all,
> 
> During  woring to add GET LBA STATUS support in qemu scsi emulation
> layer, I encountered an unmap issue with qcow2 image, It's likely
> about how to unmap partial clusters. e.g.:
> 
> With these default values:
> * the default value of s->qdev.blocksize: 512
> * the default value of s->cluster_size of qcow2 image: 65536
> 
> Running 'sg_unmap -l 1024 -n 32 /dev/sda' hits the condition
> 'if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size))' in the
> function qcow2_co_pdiscard, Then it won't perform
> qcow2_cluster_discard(), So the corresponding clusters won't be
> discard in this situation, Correct?

Yes, this is correct. Discard is just a hint, so doing nothing is a
perfectly valid implementation. In the case of qcow2, only full clusters
are discarded.

> Of cause, with the default blocksize and cluster_size, The below
> examples won't hit the condition 'if (!QEMU_IS_ALIGNED...'.
> sg_unmap -l 1024 -n 128 /dev/sda
> or
> sg_unmap -l 256 -n 128 /dev/sda

Yes, and when discarding whole block devices (e.g. while creating a new
filesystem on them) or large files, you'll probably get this case for
most parts.

Kevin


