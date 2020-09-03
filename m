Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574DC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CBF20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="I2cRl3Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CBF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn4L-0003Vk-8g
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDmvW-0004Pk-PV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:57:10 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDmvU-0004dF-Fl
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=W/2lkrRkIyBo/QVdv7kuUCGeweBZ0qZUPsBVLhIU7Vg=; b=I2cRl3IjOZ3E5y5FR/t1vl/cHh
 7hH/bfsONFMNctI2o2QQt90ipIYmer10owbeVXEXieHrUU9U2AS2WsuMZM0YpChwUnjj22OYlvul+
 i+zy8oUWtXV8gUoCwDDZ1Qs5P6dxknVbvT16VZM8VlouhY0K7kww3uqjP4H1txwS3zN/butb/uBlh
 9qGpM7JjTqOoJ+H5fCjCHBDUOk2wKr9FWtHlQZr0Y18Xq9y1nSNXlwIzoaBeiTn0MAzy3txvuMUhZ
 YnXrO/MPs5fR8x0L62oYoz5bU9kVNNP0hdPAwxtZqVKSGrxs9os1x5OVbZXKqx6FsPd6o+pQ4pGhn
 R9SPqNig==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Date: Thu, 03 Sep 2020 12:57:04 +0200
Message-ID: <5477909.c10NYOVa74@silver>
In-Reply-To: <20200903113514.7a0a6ac8@bahia.lan>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <25793713.39nqsFcaVY@silver> <20200903113514.7a0a6ac8@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 06:57:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Donnerstag, 3. September 2020 11:35:14 CEST Greg Kurz wrote:
> > On the long term that would be possible, however only with a protocol
> > change allowing server to send minimum, maximum and recommended msize to
> > client.
> Hmm... not sure adding a new 9P protocol version for this is the
> way to go. Not speaking of all the hustle this would cause, these
> msizes rather look like properties of the device that the guest
> can use to configure the 9P session.
> 
> What about adding them to the virtio-9p device config along with
> the mount 'tag' and teach trans_virtio.c in linux to expose them
> as well in the sysfs entry of the device ?
> 
> This could also be the occasion to describe virtio-9p in the virtio
> spec [1]. Something that has been sitting on my TODO list for years
> but I could never find time to consider...
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html

Sounds like a good idea!

> > As you know, right now server only has a say in maximum msize.
> 
> I guess you mean minimum size ?

Well, it's ambiguous, but we mean the same thing: server may optionally lower 
the msize previously suggested by client; server must not raise client's 
suggested msize though.

If you see it in the context of Rversion response handling then that's a 
"minimum" operation, yes.

If you see it as prose then it is "maximum msize", e.g.:

	Server's max. supported msize: 20 MiB  <- covered by 9P protocol
	Server's min. supported msize: 4 kiB   <- not officially covered by 9P

Client suggests msize 100 MiB -> server lowers that to
min(100MiB, 20MiB) = 20MiB.

Best regards,
Christian Schoenebeck



