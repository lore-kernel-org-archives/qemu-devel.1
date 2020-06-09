Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6E820734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+vU4Kfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6E820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifqK-0003Cq-Nl
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jifp6-0002Qt-Gk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:05:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jifp5-0000DW-Ob
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591715093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wRa/HlqmMfsROrQEgOhz0D0+tW6ZLIPjjg6rq6cGYb0=;
 b=Y+vU4KfoqhzyjTIRRXDxiJpq7VbxMzuUkfgmpa61yjoYl1u8DDlWrc06IBkiF128qUfCU+
 1X1+gYjn1J9VRAvZ1/Nkln1A9qRUJtLjnQiQng2Bup2EhbrGGAeSrlOMRqptfXe5F4kSES
 1+KusRxJE5opLIcqAKoT7COVpxKlnIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-NnNZEu0PMByVHE74m7N8Sg-1; Tue, 09 Jun 2020 11:04:51 -0400
X-MC-Unique: NnNZEu0PMByVHE74m7N8Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B11100CC8D;
 Tue,  9 Jun 2020 15:04:50 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C0A10013C1;
 Tue,  9 Jun 2020 15:04:46 +0000 (UTC)
Date: Tue, 9 Jun 2020 17:04:44 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC v2 0/5] block: add block-dirty-bitmap-populate job
Message-ID: <20200609150444.GJ22354@angien.pipo.sk>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200518145245.GA2995787@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200518145245.GA2995787@angien.pipo.sk>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 16:52:45 +0200, Peter Krempa wrote:
> On Wed, May 13, 2020 at 23:49:17 -0400, John Snow wrote:
> > Hi,
> > 
> > This is a new (very small) block job that writes a pattern into a
> > bitmap. The only pattern implemented is the top allocation information.
> > 
> > This can be used to "recover" an incremental bitmap chain if an external
> > snapshot was taken without creating a new bitmap first: any writes made
> > to the image will be reflected by the allocation status and can be
> > written back into a bitmap.
> > 
> > This is useful for e.g. libvirt managing backup chains if a user creates
> > an external snapshot outside of libvirt.
> 
> I've dusted-off my patches for using this blockjob for this very
> specific case and it works for me.
> 
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> 
> For now I'll continue the integration with other blockjobs where we
> merge bitmaps.

I've posted the libvirt patches which make use of this blockjob as RFC
on the libvir-list:

https://www.redhat.com/archives/libvir-list/2020-June/msg00292.html

I also have a branch with the patchset rebased to master (except for one
of the test commits IIRC) linked from the cover-letter.


