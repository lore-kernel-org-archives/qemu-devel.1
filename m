Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66719C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 02:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317C120724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 02:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="isduqsbV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/U3uzef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317C120724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsGQo-0007le-Cn
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 22:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jsGQ9-0007Dv-A3; Sun, 05 Jul 2020 21:59:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jsGQ7-0004qS-Ij; Sun, 05 Jul 2020 21:59:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 1C8065C00CE;
 Sun,  5 Jul 2020 21:59:46 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Sun, 05 Jul 2020 21:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm3; bh=rir9q1V4XSPi8pCPlUzHKUaVsOAm/gi
 h4cY+mHrLsao=; b=isduqsbVfFbh+Z0YLZL2+C9zPdRGGQU2MvWqOBRzm7vbgXE
 0zG1ZyB7Xt5586K7pCBjgujrb7S20VKuwA1MLgT01KqGX1xeczyrooLEftWILC7S
 fM0BXEGTqRQ/fZiU6ejX9xVY/ifM1pwbbEGQcG9XduvRww9dFpzNtcRFzAA5i16s
 S3fCywCRR/3wZpZQm9r2qN9IIKfpkJ+2VfYAoSPxrK6yL0hqfBesw21QmA/Qnkvx
 dmOpzhtHUt3c19854Q2guGsf52/qmmy8h75AhWo6QLsa+C0WMiA6wk94fjtlzXVh
 +hD1Nd8yD+tg+mWgQp23J2RqxS/Bj5sYXsnjPHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rir9q1
 V4XSPi8pCPlUzHKUaVsOAm/gih4cY+mHrLsao=; b=U/U3uzefh+pL8+08CxZ/u/
 KAvNWp8Ani6KJDIq9si0noDsFP1OkviNhawfRWcH0g6orUnNQB4S2dAgIV9K2QgQ
 19sSFLNEvLy2CNUgz2CYqSsErCRvHH/9Cq2iGBYXytr2jrmKrmG14tok4JNkGoGg
 fI21lxVbPe2KLnbcW6d7vopB2nIJGj5YxUKIXerEPLEjUL/APETVCG8w63ddaa6Q
 9ba1IiSyrPL7WbNfbFIoQhxCm/um5uG0qhQtusb12rrs0//uWnrHlrauEkj+6SN1
 /OcZ9O56aa4pCrJfdpYLHlVDN35QIQca35M4NLdktS7DDa3tC1MXTYG9kIqkz5sg
 ==
X-ME-Sender: <xms:kYUCX6fAxgiGrb_swiIarlXbhrc3ap0L1BkBX7niFpDILTLU_hYWXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdehtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
 htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
 veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:kYUCX0MtoAEeK7npK_jMDfN5s9dwCXJh1vKgdc2FBm55gjq8OtWyxg>
 <xmx:kYUCX7jPAWWnyu-sbFA4jiuvNPp67o0FoIfyZDH5HqIfULZTb-rIHw>
 <xmx:kYUCX38t6PT_kZIEruiz1pGwTVtmc1jXS_YKInGKZhTXooOGFFeScg>
 <xmx:koUCX6Kle_lxgrJIJwzE7J12Qe9mRmUp0gr4ZiTF-19U_8xaqYIlfw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0C925E00AA; Sun,  5 Jul 2020 21:59:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-576-gfe2cd66-fm-20200629.001-gfe2cd668
Mime-Version: 1.0
Message-Id: <df64d8de-9d7f-474b-8b72-5d2e6c7df1f4@www.fastmail.com>
In-Reply-To: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
References: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
Date: Mon, 06 Jul 2020 11:29:24 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: erik-smit <erik.lucas.smit@gmail.com>
Subject: Re: [PATCH v2] ftgmac100: fix dblac write test
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.25; envelope-from=andrew@aj.id.au;
 helo=out1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 21:59:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Sun, 28 Jun 2020, at 23:56, erik-smit wrote:
> The test of the write of the dblac register was testing the old value
> instead of the new value. This would accept the write of an invalid value
> but subsequently refuse any following valid writes.
> 
> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> ---
> Changes since v1:
> 
> Changed %ld to HWADDR_PRIx to fix building on mingw

Bit of a nitpick, but the type of the value argument is uint64_t, so shouldn't 
the result of the expression captured by FTGMAC100_DBLAC_TXDES_SIZE() and 
FTGMAC100_DBLAC_RXDES_SIZE() be printed with a straight PRIx64 rather than 
HWADDR_PRIx?

Otherwise the change seems sensible, so:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

