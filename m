Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C61AC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 01:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA90820665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 01:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="H/gjzS7P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcTI7zlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA90820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxhxC-00026m-2U
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 21:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrew@aj.id.au>) id 1hxhwd-0001g8-ID
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 21:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1hxhwc-00056I-LH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 21:19:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1hxhwc-00055P-Ec
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 21:19:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 6E6FF22008;
 Tue, 13 Aug 2019 21:19:16 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 13 Aug 2019 21:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm3; bh=GDnpMMAO25OF9jBsiIiKTziKVwXOSbO
 n5ZzZ3upsCBA=; b=H/gjzS7P/Nm7jZrmzbVtMd7/WkmAbAsRMXjEtNkpU+22u46
 Nb/NjA5YDTPh2CKWDjaZ98UWJ5t6KqYuBEZyLkwHRmOSCdbhGzW5S+Gf20XtOk53
 61ZEvcZsfmXTvaU8wx7nRDcebVxx8ibRKOr6ib0IGmAtyEicViOQ4cCNPuYmMDrR
 tr5N8pJ/wycsduMZHRHcK9cBupN0ygLMW9IgdQ1fjz9Ln2dEBgIWO0Od6LVg5gj6
 Zlax/cSnmAvBgiSNRSI4REXv+m689owZvA6VOVLPXwDXDYGluydYHZ5MX5rmvFzX
 SSXzFlcvF0vAGWOe6pSDYxmBB7tZWfQia2shgWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GDnpMM
 AO25OF9jBsiIiKTziKVwXOSbOn5ZzZ3upsCBA=; b=hcTI7zlOpmXT2Xb2TqV48R
 pxX3qIelFp7d7KUT+GQfKqIxGmUCWTyZYqE5NnCWJkwu8RDy257a7GNQYs1cHUKb
 LUc51KaQnNfhyNYtvWVbo/6OgeJFwrgER/oXNGVEbEemQsi7+QlfJFP4Cfm7L4q1
 e6iQgmBq9p1/W50JMvt3jTs5RVPp2znqeDD8cEDgKkS5wpejiKj8s8y2y4xL8jZ1
 dox8gvYtOpJeQIeKaPwWxS5mgALntVpyQXaWUHny+LrDyW0Zde/RlKTWwxLN5UKP
 aRp4T4bO7ZYa0IoPRFHd0/BN9O0C1Qv5iMx7dgc0G+1LOZYWwmEvy6C+eYx5zJFw
 ==
X-ME-Sender: <xms:k2FTXXECi-KH-4i6zkuPib-IsXFhvP9wElpKEW2rs7XdNP0dOA2gQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvjedggeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:k2FTXbL1rTv1z1xbJchM6PT5rGnyvXNmwXdF2Ww9Y77VAGSmw0izMQ>
 <xmx:k2FTXSEfdW2nRlksWCuQccbz-uJhHOFipFJ-EzD-zL4NGsqeWTAOWQ>
 <xmx:k2FTXX6yQz1FxgJXNYGBwin6-uSB6alrtDBwZ0RkI6WPO8RayQScNw>
 <xmx:lGFTXW7oSRqJFSeIzVleZVIOYtvvUvqOCi-eITLUG1faOPOVE--XsA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 256B8E00A4; Tue, 13 Aug 2019 21:19:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-868-g07f9431-fmstable-20190813v2
Mime-Version: 1.0
Message-Id: <fa864f54-48e8-4b60-bbd6-2e1e4a8a7a73@www.fastmail.com>
In-Reply-To: <CAKmqyKNBPaGCRW-dFRtitfW97YPy8OsJYxHhVLkKa9qu8ySdrQ@mail.gmail.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-2-tao3.xu@intel.com>
 <CAKmqyKNBPaGCRW-dFRtitfW97YPy8OsJYxHhVLkKa9qu8ySdrQ@mail.gmail.com>
Date: Wed, 14 Aug 2019 10:49:44 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Alistair Francis" <alistair23@gmail.com>, Tao <tao3.xu@intel.com>
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: Re: [Qemu-devel] [PATCH v9 01/11] hw/arm: simplify arm_load_dtb
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jingqi.liu@intel.com,
 fan.du@intel.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 daniel@linux.ibm.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 14 Aug 2019, at 07:30, Alistair Francis wrote:
> On Fri, Aug 9, 2019 at 12:01 AM Tao <tao3.xu@intel.com> wrote:
> >
> > From: Tao Xu <tao3.xu@intel.com>
> >
> > In struct arm_boot_info, kernel_filename, initrd_filename and
> > kernel_cmdline are copied from from MachineState. This patch add
> > MachineState as a parameter into arm_load_dtb() and move the copy chunk
> > of kernel_filename, initrd_filename and kernel_cmdline into
> > arm_load_kernel().
> >
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Alistair
> 
> > ---
> >
> > No changes in v9
> > ---
> >  hw/arm/aspeed.c           |  5 +----

For the ASPEED machines:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

