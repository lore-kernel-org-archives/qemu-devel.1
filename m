Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A094F20684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQEUosMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A094F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWBF-0006NF-Rg
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:42:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYWA8-0005cU-HC
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYWA7-0004fl-F2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:41:08 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYWA7-0004ee-7u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:41:07 -0400
Received: by mail-ed1-x542.google.com with SMTP id w13so5879000eds.4
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=v4wXfzzbpOMHputlZvC7LBpVOfc9l++RPwzjtU/Gy/w=;
	b=ZQEUosMdUrdNiJwwjLVvupLo77pG/arCEu7eKvcWufii6F54AYxVvBXNanSK2SFZ14
	+gWvNULc/FaJE7QsyzlhwIvwJJ1QNfMFDO7re6Gtl+n62o5Vz09STvDQPj6BvcBVRYEn
	wCdlYQ+4yzfT4QvxWvVZuUDzcXWlLbCIKeKrwwPS92bjRQYrNrO3171MQxeNP94unV8q
	5QgBD1xAedyKBk+dEB16rpZjG8k7qIQUIQaGk6DBmAUzH5FcmEtk7MtcMTgKOPVmZHHX
	C7p37qnbgPnlIMw+reskeW6R013s1lUWAtO+G66jxBS1pZ49k9BfRvWLlGD7Xv1GX7jB
	zMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=v4wXfzzbpOMHputlZvC7LBpVOfc9l++RPwzjtU/Gy/w=;
	b=j4Sn4+vVieF+cfrMAr4nZylnb31JdGt8v8MQOlZfvJIJD7GQobq1QSbxVHm9EmytFf
	kYe6kv8d0mQn0aNnpQY+Z/JP6HwWlwKXspAwOuW2OfA3I19HPT+TtqTgcx9oG9PDr1QA
	cy+SKGWgMk8zBVIuyZX0NqHOC6xKktD82AZW8vXOFGJ/1ykX0FRKcZMjfXKDoL5SWfXA
	+x/Uh7ZP6Ck8fLp8pU0l15Xx3CgBC30uPQg0y2zm7KYmW4L2ZiPd8jEWN5ZG9iuwa4Ss
	IleoKCkt8JCpXa0x6eifwaI5pbtVZ9mjM5BMVwjwGf/8qJ3Gb+zhSh8NUT6q2WROTooS
	ImSg==
X-Gm-Message-State: APjAAAXTL1kBcRpNc7sWtotxOBzs4AP5aAdnwEODIrNwJVbIkVgmfIbi
	Uhye0fPLP1MMzZUZuEwLbps=
X-Google-Smtp-Source: APXvYqwDfTkZ78Y/SzrFPodp2Aa4+0mCBcPuNhDpdrZch4iwIwC0fJm8Plng7GxSfarjFfSHtGynQg==
X-Received: by 2002:a17:906:3e8d:: with SMTP id
	a13mr35828013ejj.71.1559742066221; 
	Wed, 05 Jun 2019 06:41:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id v6sm471612eds.23.2019.06.05.06.41.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:41:05 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:41:05 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190605134105.tv7apqt4ekftqnyd@master>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<20190605064108.GH15459@xz-x1> <20190605085207.GA1804@richard>
	<20190605093819.GL15459@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605093819.GL15459@xz-x1>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram.c: reset complete_round
 when we gets a queued page
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 05:38:19PM +0800, Peter Xu wrote:
>On Wed, Jun 05, 2019 at 04:52:07PM +0800, Wei Yang wrote:
>> On Wed, Jun 05, 2019 at 02:41:08PM +0800, Peter Xu wrote:
>> >On Wed, Jun 05, 2019 at 09:08:28AM +0800, Wei Yang wrote:
>> >> In case we gets a queued page, the order of block is interrupted. We may
>> >> not rely on the complete_round flag to say we have already searched the
>> >> whole blocks on the list.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  migration/ram.c | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >> 
>> >> diff --git a/migration/ram.c b/migration/ram.c
>> >> index d881981876..e9b40d636d 100644
>> >> --- a/migration/ram.c
>> >> +++ b/migration/ram.c
>> >> @@ -2290,6 +2290,12 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
>> >>           */
>> >>          pss->block = block;
>> >>          pss->page = offset >> TARGET_PAGE_BITS;
>> >> +
>> >> +        /*
>> >> +         * This unqueued page would break the "one round" check, even is
>> >> +         * really rare.
>> >
>> >Why this is needed?  Could you help explain the problem first?
>> 
>> Peter, Thanks for your question.
>> 
>> I found this issue during code review and I believe this is a corner case.
>> 
>> Below is a draft chart for ram_find_and_save_block:
>> 
>>     ram_find_and_save_block
>>         do
>>             get_queued_page()
>>             find_dirty_block()
>>             ram_save_host_page()
>>         while
>> 
>> The basic logic here is : get a page need to migrate and migrate it.
>> 
>> In case we don't have get_queued_page(), find_dirty_block() will search the
>> whole ram_list.blocks by order. pss->complete_round is used to indicate
>> whether this search has looped.
>> 
>> Everything works fine after get_queued_page() involved. The block unqueued in
>> get_queued_page() could be any block in the ram_list.blocks. This means we
>> have very little chance to break the looped indicator.
>> 
>>                            unqueue_page()  last_seen_block
>>                                      |     |
>>     ram_list.blocks                  v     v
>>     ---------------------------------+=====+---
>> 
>> 
>> Just draw a raw picture to demonstrate a corner case.
>> 
>> For example, we start from last_seen_block and search till the end of
>> ram_list.blocks. At this moment, pss->complete_round is set to true. Then we
>> get a queued page from unqueue_page() at the point I pointed. So the loop
>> continues may just continue the range as I marked as "=". We will skip all the
>> other ranges.
>
>Ah I see your point, but I don't think there is a problem - note that
>complete_round will be reset for each ram_find_and_save_block(), so
>even if we have that iteration of ram_find_and_save_block() to return
>we'll still know we have dirty pages to migrate and in the next call
>we'll be fine, no?
>

This is really a rare case and hard to say whether it would be harmful.

The chance still exists.

>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

