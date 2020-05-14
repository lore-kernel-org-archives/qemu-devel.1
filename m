Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FBA20675
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JbnXDvuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FBA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHZQ-0003FP-Ed
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZHYr-0002Yi-Oe
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:22:21 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:54989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZHYq-00040K-Cd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=mtN0R/ptMyE+mE3/AJdxZw2L0CMhN1Mw1lkJBm/6uXw=; b=JbnXDvuMuFjahDqG+yRVBUfCxF
 4vj71abu2CiHWILcFlBpCb7uvn9VPRLZNsRW8zMiL1BsijCBphvx7a9RWoeJeaD3tMhoJp2lbY1F1
 WYVdEk4PXT5lLEpiXjtG6iOoZ/jrQK0A/4Yv0jkemoEQ5G0rdaoKXfMDq1ixY/mJGWD6c7oLN9Trv
 G/4O5xBXuaGw7bGqijxcpSVFXMSKqamzlCzoRchlgkCgkK5LTC5FjXsjdY91ECBCwtJLmyqkeRiU7
 9dHbWeQgpXhyAUdam4ocZnzAlEUIzZjtKmchdwwBpsCT4BTSeLreFHV7G9Wf8K5Fg+wzu1xxTCsJM
 sosNZqH7APArQmgz0ovlZkLhFbagxcjIvdoVtuIOfqK/zQuNuA5SB/06AMTfNMozXnslyWEYEhemQ
 lrp0EhGvacyEkMO3sSWN4fyXiC53TcOGikTddk7ECxsRsD3nIKT+Z0yXJyt9QVkumzT1aVR51K5Iu
 UIOeRH/6h9pELTKAo78AV4x9zLIvzpIPNTzDMLMypRCXJw1qe6w1zZc7vFhiAZd3GSBbWd8Or6cqk
 h2AN4wKzPy5TY5SEVq8W3LXv+B4hpgMgHPh4kwwutWfIddnuEKRORvAEc2nwQQ8Gt50kexdRHNO6q
 g5sD/wuq65JSm1w1L/ByNTuCJx0M9LBjWjbSYmLuM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
Date: Thu, 14 May 2020 19:21:51 +0200
Message-ID: <3682218.KU1Dzr61pV@silver>
In-Reply-To: <alpine.DEB.2.21.2005140853310.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <3966630.RI2PehbzW4@silver>
 <alpine.DEB.2.21.2005140853310.26167@sstabellini-ThinkPad-T480s>
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

On Donnerstag, 14. Mai 2020 18:24:58 CEST Stefano Stabellini wrote:
> > > The Xen transport
> > > (https://xenbits.xenproject.org/docs/4.13-testing/misc/9pfs.html) has a
> > > shared memory area with 64 pages, so 256KB. It is split in half: 128KB
> > > for requests and 128KB for responses.
> > 
> > That's very little. That also means you won't be able to ever achieve
> > decent 9pfs performance with Xen, because that requires a much larger
> > msize of approximately msize >= 4MB, depending on the underlying I/O
> > hardware, tendency growing (due to rising I/O hardware bandwidth).
> 
> That's great feedback. Fortunately the size of the transport is
> configurable so it is one liner away from becoming much bigger (well,
> two oneliners, see net/9p/trans_xen.c:XEN_9PFS_RING_ORDER in Linux, and
> hw/9pfs/xen-9p-backend.c:MAX_RING_ORDER in QEMU.)
> 
> Would you recommend 4MB each way, so a total of 8MB?

It would be an improvement for Xen, sure. But what if a user picks e.g. 
msize=100MB? Then you are back at square one, because if guest does this on a 
huge file:

	const size_t sz = 5*1024*1024;
	char* buf = malloc(sz);
	// read file in 5MiB chunks
	while (read(fd, buf, sz) > 0) {
		...
	}

then you are still unable to handle this; the yield hack would loop forever.

> > As far as I understand you now, the problem with Xen transport seems to be
> > that clients can submit requests more quickly than the 9pfs server could
> > process. That would change the overall situation completely, because my
> > hack solution with delaying delivery (yield) suggested previously, was
> > based on the assumption that this low transport buffer scenario only
> > happens once on boot, but not possibly at any later point again and
> > again.
> 
> Yes I think it could happen at any time, not just at boot.
> 
> From my understanding, I don't think it is necessarily due to QEMU being
> slow. In fact, if QEMU was slow and the client fast, the reply ring
> would be empty because the client would be up to speed, therefore msize
> == transport_available_size, and there is no problem.

Right, if msize == transport_max_size then Xen easily runs into this 
situation, no matter how fast client is to pull responses. Because in this 
situation it requires just a single response still pending to be pulled by 
client to trigger this Xen transport buffer underrun situation.

> So maybe it is OK to delaying delivery because it seems to me that is
> the issue.
> 
> Also I am thinking that if we are going to increase the ring size to
> 4MB, maybe we should take the opportunity to set msize=transport_size/2
> just to reduce the likelihood of this kind of issue, in addition to a
> proper fix.

To prevent the yield hack to loop forever, yes, you would at least need to 
limit 'msize' according to Xen's maximum transport buffer size. This must be 
done when client opens a 9P session when client sends Tversion:

http://ericvh.github.io/9p-rfc/rfc9p2000.html#version

However I would make the Xen transport buffer size at least configurable for 
administrators. You'll never know how large people want to pick 'msize' for 
performance reasons.

> Yes, I think we want to do three things:
> - increase the transport size for performance
> - set msize=transport_size/2 to decrease the likehood of this kind of
>   issues

Sounds like a plan to me!

> - introduce a slow but safe fix when the issue happens, and
>   qemu_coroutine_yield() or yield_until_fd_readable() could be OK if it
>   is very rare

Yeah, and better test that this would not hang. ;-)

I would also call warn_report_once() in case this slow yield hack is 
triggered, to let admin know that Xen's transport buffer should be increased 
to avoid this performance issue.

Likewise call warn_report_once() if server's Tversion request handler had to 
reduce msize.

Best regards,
Christian Schoenebeck



