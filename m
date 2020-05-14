Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D9E2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="vC4b0pIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D9E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGTF-0003ni-43
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZGRF-00019E-BM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:10:25 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:40387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZGRE-0003dP-1R
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Wdugl2i5oFNVcLwzxNnowffl27F7rDS9ksvKBJXsQgQ=; b=vC4b0pIGPco/4/q+/Qil7SOsbj
 CsNQQe2fn0cFZ7R82IXCnBBKtz9ZgxvRZto6O46iE5sdV7M0fdw5hrMCfuzqthtZscIIkJafWdX/F
 nki4BrBY/+tg2T3U9Vq2+PqxxzwM6+yRMaZPjdBrHzejrKYAhgxjfxbhGsuI44JnBjwEupKaleAC0
 OJ+winktQWY8T9Edt2MHtVOCJj9UPT24kVmazpu/sBjCE4m8h43SB7E8WdJcNmAvxpDhU86Y1yKSn
 78v4uWjep2k/uKZRd39LaqD7vZZDU90FX9ZsNt7sp3O2U+RXzPxiAPW/i7YpJTVXr2kefe7RTv+vZ
 oWD8eqMAA6U2VwO1y9CpaGhqAVt+6H7KcS95WnV4LXPXa5g+ylYFiO0Y2bvvngWFVszHxMKvAUbs2
 Atqx+t8pdRJJWd2EEjeU91PaPBgnJxFu1mSpNLcPOhagw9lBMgrWRYzRdnIfGWq2PYmm4n2/MMwzY
 FggRamSK2c3HsJoJZxiWfivcWPXTUczKcsaDNgRmzuT6hW6YPofSl6MXacwgtzJoDPaelTYdacASw
 yQv6aABim7d/yvP/Tn845bVMH0h4efo4QrPM7CBVpGqa0xge9UwWLQA7l00FFFBiqfctLDxyNBQD4
 HafOcxwAH9d/GAjBFDElkHobAUCsNb5mcAgA8nzEw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Greg Kurz <groug@kaod.org>,
 Paul Durrant <paul@xen.org>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
Date: Thu, 14 May 2020 18:10:20 +0200
Message-ID: <2330066.V6eqdYP2KO@silver>
In-Reply-To: <alpine.DEB.2.21.2005140846460.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <3966630.RI2PehbzW4@silver>
 <alpine.DEB.2.21.2005140846460.26167@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:10:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 14. Mai 2020 17:51:27 CEST Stefano Stabellini wrote:
> On Thu, 14 May 2020, Christian Schoenebeck wrote:
> > Looks like this issue will still take quite some time to be fixed with
> > Xen. If you don't mind I'll send out a patch to revert truncation on
> > virtio side, so that at least this bug is fixed with virtio ASAP.
> 
> Let me answer to this quickly so that if you want to get the patch out
> today you can.
> 
> 
> Yes, I think it is OK to revert truncation in virtio now. 

Good

> Only one
> thing: would there still be any value in doing for Xen:
> 
> +    if (pdu->id + 1 == P9_RREAD) {
> +        /* size[4] Rread tag[2] count[4] data[count] */
> +        const size_t hdr_size = 11;
> +        /*
> +         * If current transport buffer size is smaller than actually
> required +         * for this Rreaddir response, then truncate the response
> to the +         * currently available transport buffer size, however only
> if it would +         * at least allow to return 1 payload byte to client.
> +         */
> +        if (buf_size < hdr_size + 1) {
> 
> 
> like your patch here does? Although not a complete solution it looks
> like it would still be a good improvement over the current situation for
> Xen.

IMO in its current form, no. It would just move the problematic from a clearly 
visible 9pfs server termination with error, towards a silent data loss 
(without any error) on client side. Remember: this patch does not roll back 
the filesystem driver's read position.

Best regards,
Christian Schoenebeck



