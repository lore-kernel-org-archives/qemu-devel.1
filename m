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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D463DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A141820684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qID1fwxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A141820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWA5-0005Hd-Vg
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:41:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW8x-0004aV-Ge
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW8w-0002z5-Fi
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:55 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYW8w-0002xt-9L
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:54 -0400
Received: by mail-ed1-x542.google.com with SMTP id h9so4457568edr.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=VbmCRYKsUP4jCpSvLuMwO7sTzwO5PaETxOELKD7AldQ=;
	b=qID1fwxuzydqYgKreM4I/Klr7uhNKTztEIF4j03ssoXICfIGo64SI7s5tucQqUeJeK
	p1cEkZ4UyQV6S+LCn38UKogcp3fF+GEKW94qur4DN2lSan1gciOS1wzOaZUaVjhT8STa
	M/Bv2DE8uuxhVPFhH2SlSsW+X0bt3EN1AY7Xd5DNpE6zeJ140dzSOgDqxTPq8AouUUln
	55ENhu6/2XWNWarFKreSpu6sMCayI+tfXVjYvtRqXJQ0BXPNsoaKgkg8C5qraHSvN1FV
	Z57JqPeNtspx1PleSQ/h/VhTFMxCgtGbH974DiSDHmcyeecvY093gvm1DxMx1hSvJBh7
	/vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=VbmCRYKsUP4jCpSvLuMwO7sTzwO5PaETxOELKD7AldQ=;
	b=XetmPWFC98sKueFCxvVoJbrIOmn6+6j0SWe/H3QdGZ+K/swkh49J790Ec/Tk6L2Qil
	/1unIeobIzKESbOklWXptNR9E68NBW+63i/yKHMS7rIATSlngWFUwVH8A390wD25u6l4
	8XuC+8flx0tedf5l0OxyFJ2KM1feOVqEbcSDiCSkuD89aRUAWSzdSzbMQScCtkNXP6Sv
	hYV8CZuzK2nHF45A6Vh+CrayzJBDbHIbffoJrQWuING+Eqs5Ayv8Rm+81Y45+ojWPN5s
	aJGiRKjXEZw1+uKo12ZcGBvcXrhoXb2DYwm26DvkgFXMFXA1ITG3y+R/LwISt1987L/P
	/VkA==
X-Gm-Message-State: APjAAAXrzathRTsOm7tRv0+3O5kHq9+rnsX/YoqFBrvlvVYoO5E2nXe8
	5T+jqh0H+Vk7XeikXTwpSps=
X-Google-Smtp-Source: APXvYqz60JrA3IlrxHlnRbOVdRw2NoIoJCFeWmaLagyQel3u+c5ods4wNxbxb4WRrsa8pIddPN2npQ==
X-Received: by 2002:aa7:c2d0:: with SMTP id m16mr4441115edp.94.1559741993230; 
	Wed, 05 Jun 2019 06:39:53 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	l26sm3742083eja.17.2019.06.05.06.39.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:39:52 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:39:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190605133951.saendlaiq4kfwoy3@master>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<20190605064108.GH15459@xz-x1> <20190605085207.GA1804@richard>
	<20190605093819.GL15459@xz-x1> <87d0js5njw.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0js5njw.fsf@trasno.org>
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
	Peter Xu <peterx@redhat.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 12:33:39PM +0200, Juan Quintela wrote:
>Peter Xu <peterx@redhat.com> wrote:
>> On Wed, Jun 05, 2019 at 04:52:07PM +0800, Wei Yang wrote:
>>> On Wed, Jun 05, 2019 at 02:41:08PM +0800, Peter Xu wrote:
>>> >On Wed, Jun 05, 2019 at 09:08:28AM +0800, Wei Yang wrote:
>>> >> In case we gets a queued page, the order of block is interrupted. We may
>>> >> not rely on the complete_round flag to say we have already searched the
>>> >> whole blocks on the list.
>>> >> 
>>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> >> ---
>>> >>  migration/ram.c | 6 ++++++
>>> >>  1 file changed, 6 insertions(+)
>>> >> 
>>> >> diff --git a/migration/ram.c b/migration/ram.c
>>> >> index d881981876..e9b40d636d 100644
>>> >> --- a/migration/ram.c
>>> >> +++ b/migration/ram.c
>>> >> @@ -2290,6 +2290,12 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
>>> >>           */
>>> >>          pss->block = block;
>>> >>          pss->page = offset >> TARGET_PAGE_BITS;
>>> >> +
>>> >> +        /*
>>> >> +         * This unqueued page would break the "one round" check, even is
>>> >> +         * really rare.
>>> >
>
>
>> Ah I see your point, but I don't think there is a problem - note that
>> complete_round will be reset for each ram_find_and_save_block(), so
>> even if we have that iteration of ram_find_and_save_block() to return
>> we'll still know we have dirty pages to migrate and in the next call
>> we'll be fine, no?
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>I *think* that peter is perhaps right, but it is not clear at all, and
>it is easier to be safe.  I think that the only case that this could
>matter is if:
>- all pages are clean (so complete_round will get as true)
>- we went a queue_page request
>
>Is that possible?  I am not completely sure after looking at the code.
>It *could* be if the page that got queued is the last page remaining,
>but ......  I fully agree that the case that _almost all_ pages are
>clean and we get a request for a queued page is really rare, so it
>should not matter in real life, but ....
>

Agree

>Later, Juan.

-- 
Wei Yang
Help you, Help me

