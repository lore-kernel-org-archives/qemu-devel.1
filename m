Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3140AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69E20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GFrkDIep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69E20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQNp-0001nw-6u
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnQNE-0001KB-F6; Mon, 22 Jun 2020 13:36:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:56664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnQNB-0007qJ-NS; Mon, 22 Jun 2020 13:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=V8g8lE5tBFP60iRrOCNhRexT7MVBvO81Fkvt4xqiQ10=; 
 b=GFrkDIep2eRdYv1fcrX2D/1ImxWAIgxCcE7BcDaFy43aRGySxrvI6TFKjF5cpLJfmzB9Bsn0Z27aEIet/s5xW8yz8iv4+kQqo/RelbzkS9mZI+39Hp3PQmhkYNfLzbGxylTEYGckUL8WcMD6IvVzTqWO0AXV9vSmK884wQaui9OcWXdzTw9oRwxoeZwlFmaP2j85hc96WHKKrQ0pJYNSHM0yCG4fsN4W5WPci+SoYgodsNki2MLBRzOzboLNBRBEqhf1/fOBU4UkwsWcCiMDounP5RJrSxXdWI+Ee62XviiVh3APchGUJbHgzjAUAtkxVgYAe4TNIXTRw2yaUi678w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jnQN5-0000vn-UZ; Mon, 22 Jun 2020 19:36:40 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jnQN5-00074T-GF; Mon, 22 Jun 2020 19:36:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
In-Reply-To: <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
 <w51r1u788gg.fsf@maestria.local.igalia.com>
 <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 22 Jun 2020 19:36:39 +0200
Message-ID: <w51o8pb80k8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 13:36:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 22 Jun 2020 05:06:53 PM CEST, Max Reitz wrote:
>>> No, this is wrong.  This still wouldn=E2=80=99t fix the problem of havi=
ng a
>>> device file as the external data file, when it already has non-zero
>>> data during creation.  (Reading the qcow2 file would return zeroes,
>>> but reading the device would not.)
>>=20
>> But you wouldn't fix that preallocating the metadata either, you
>> would need to fill the device with zeroes.
>
> What it fixes is that reading the qcow2 image and the raw device
> returns the same data.
>
> Initially, I also thought that we should initialize raw data files to
> be zero during creation, but Eric changed my mind:
>
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00223.html

Then in that case you would indeed need to preallocate all the metadata,
both on creation and on resize.

Then if you read the image with an older version of QEMU you would get
the exact same contents in both cases.

You would still have problems with images created with raw data files
but without preallocation.

Coincidentally, data_file and data_file_raw were both introduced in QEMU
4.0 so in practice there's no official QEMU release that can read an
image with an external data file but does not support data_file_raw.

But in theory it could happen of course.

Berto

