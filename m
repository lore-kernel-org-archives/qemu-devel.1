Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579AC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41921214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FZW/lMvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41921214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8Fg-0007Bo-BK
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jT8Ew-0006Xm-W0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jT8Ew-0002eK-1d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:12:22 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jT8Ev-0001lL-4T; Mon, 27 Apr 2020 14:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Z6hHWnPQQBK556Vi7QKfULIUx19yERtz27tZk4rsWp0=; 
 b=FZW/lMvVEEsm/2LrnSGvq23DME8ytHxYHSfxc1r++6rVrApx9YDrGl78zDWfcXoxFQTnqzCYWGk2F3LbqXRNZZYOsn98k/Z7Aeg9jP9xVq/yUiE41MPGAIoDqQ8YfiHpJZ6+kpHWOogB6X038gIxfvDIA1qgQHTQ99fWXwFLXxLS4xGJdhwfPUvAYGq4xD+GUzJhz0WA+asd05/K1MiCWoxrsSz5LJSXqFl1ccaaKUooPTUelDxqC3evYg5/BZ9cOOdb506SyJ0QvHhAsMT0xurwhR0MjkrKiB1TpWpxh9FeFF6yWCvQpZ7cBKW+wILqr327BCJauJ7eAoNHlBAaxg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jT8En-0001D5-Js; Mon, 27 Apr 2020 20:12:13 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jT8En-0003KL-A9; Mon, 27 Apr 2020 20:12:13 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
In-Reply-To: <c6a86c0d-e7cc-2bee-d9ea-7fa8abb344be@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <w51lfmkn4ws.fsf@maestria.local.igalia.com>
 <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
 <w51imhon30t.fsf@maestria.local.igalia.com>
 <cc3301dc-14e0-1b1c-fb97-4f4b8a520dfd@redhat.com>
 <c6a86c0d-e7cc-2bee-d9ea-7fa8abb344be@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 27 Apr 2020 20:12:13 +0200
Message-ID: <w51k120u7b6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 14:12:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 27 Apr 2020 09:49:00 AM CEST, Max Reitz wrote:
>> The point is this: Consider 'write -P 0xff 0 64k', then 'write -z 16k
>> 16k', then 'read 0 64k'. For normal clusters, we can just do a
>> scatter-gather iov read of read 0-16k and 32-64k, plus a memset of
>> 16-32k. But for compressed clusters, we have to read and decompress
>> the entire 64k, AND also memset 16k-32k. But if zeroing after reading
>> is not that expensive, then the same technique for normal clusters is
>> fine (instead of a scatter-gather read of 48k, just read the whole
>> 64k cluster before doing the memset).
>
> It would also mean letting qcow2_co_preadv_part() special-handle such
> cases, i.e., whenever the whole clusters is compressed, it needs to
> read it as a whole, regardless of the subcluster status, and then
> memset() all areas to zero that are all-zero subclusters.  Otherwise
> we=E2=80=99d read and decompress the whole buffer twice (once for 0 to 16=
k,
> once for 32k to 64k).

This is actually a good reason against adding subcluster allocation to
compressed clusters.

I wouldn't like to complicate the code for this use case, so we either
don't support it at all, or we support it with the problem that you
mention (decompressing the whole buffer more than once if the cluster
contains holes).

> Not sure how bad the complexity is on the write side for not letting
> zero writes just zero the subcluster

It is not bad, I just have to check the cluster type and return
-ENOTSUP.

Berto

