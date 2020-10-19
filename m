Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C633C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4E222260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="khj6hLEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4E222260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYKK-00055g-4Y
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUYIo-0003kQ-1d; Mon, 19 Oct 2020 12:46:30 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:32991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kUYIi-0007ZI-Nk; Mon, 19 Oct 2020 12:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=d1zGq+ljCzaWLg4xDF7ofeKRoMuJq6HFXyR0/RiFuAo=; 
 b=khj6hLEBpngwlKEkD0pdVI5N+yRfdSq8vr9xQ5rZCvu69WulNJcM+qBxSQxbLLM5mWWMI6C14+9yaMy7T+fCRhlqPEccnEBFcqoOF51fXpGad9O7u571qMV7VFa6t3/cUUA4oVmkH9IkovnXTgNS44TguvtBbgW2g8t/k4AH7BufkuYZFLL4PHTsz3lKGE35WW0+pOlifIRmZ/Yp3hNwlybSpD+koKBSY1a+Y/p2U1etLnFD7IJ0EeRfUTUojUSUaH0xTWjjNNN7+o5bXZrygRaFH5+qmhtZtjfnOOMp4KoYdYxEXxpeHVVH13arLFwIKwtQ0uQteFVl9kxWALrSPA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kUYIe-00072Q-Ae; Mon, 19 Oct 2020 18:46:20 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kUYIe-00053q-17; Mon, 19 Oct 2020 18:46:20 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: Plans to bring QMP 'x-blockdev-reopen' out of experimental?
In-Reply-To: <w51mu0ifbuf.fsf@maestria.local.igalia.com>
References: <20201006091001.GA64583@paraplu>
 <w51mu0ifbuf.fsf@maestria.local.igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 19 Oct 2020 18:46:20 +0200
Message-ID: <w51k0vmf9k3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 11:56:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 19 Oct 2020 05:56:56 PM CEST, Alberto Garcia wrote:
> And this one in particular:
>
>    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00601.html

I forgot to add, we still don't support changing bs->file with this
command, so I guess that would be one blocker?

There's no other way of inserting filter nodes, or is there?

Berto

