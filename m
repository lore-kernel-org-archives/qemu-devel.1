Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D569EC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B3C20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFBOtHCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B3C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb4iR-0004pH-Ce
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1hb4gp-0003wT-2t
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hb4go-0004BO-4S
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:57:27 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hb4gn-00048m-QD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:57:26 -0400
Received: by mail-ed1-x541.google.com with SMTP id a14so24330949edv.12
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=maaG/VsmcOmNPmSIJfk0KdSl+hQuebXCFcz86964Ep0=;
 b=sFBOtHCj/WK/UnOFkfjvC4dcqMqNeM4bzg64ZzjW+ZwMsn22CQ2yS4UI0dwAX+jvcw
 Yr4FVIxcm4FOfQT2aBPiIlG9dBcIF21JA/ylD0Q8Yfhn+Dryd5sh0sP12rSxq6+ysSOn
 Msa9IezBmggfvzu4BUi4sohyTYKGbYuUM5SFbf8HXEufRbC7yvMOM4NuKreACJ/YE5nK
 SQkucOXXJnj40ARyEC3vVuMtc7PudhlBsmQthaCp9CjdhgReI2e96WdGeaBUmwH2znzZ
 +w0RIJeU3WL9IvB+SYl4iBlwsFEnSOTSpFpDiB7FVkeR4rnPH/tmlmYPi1ubHiIcG3Dj
 ig/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=maaG/VsmcOmNPmSIJfk0KdSl+hQuebXCFcz86964Ep0=;
 b=o2pt4BVbFTfd5adGeuogOSU04GWaPKSuG9CVsZII+Id204I9LWqXqyVQRIzhtyzM6y
 VDfB9Jon1+IJO2ap/ttbmlgHKY9i/WQFN+dBDnGQf4Ab9Q/Sbc760QV1lUDtDhWM+RU7
 a3GIYT5RwwAn7Dfh5c3KGYXDPPPe/yMSyyqzMJ23gWyuQY+9mzCOln6SbEbilWr/hvPg
 DzyOTgZRBnilWFbTszcpzI6ucHAKlKxgF4op1XtDzkjFIR2tZo4/E4H/8NlLQMuijabf
 +cguFGKGEugtWO/5ExLZZNchvDbtJqwIJApcqpwSTBcEF+A/jMZrxA5+ZGCM0Lk2NKph
 bbEg==
X-Gm-Message-State: APjAAAWp5HJnv2AqvY+LO4DKHdb4gFJl9MdaHlUrhxVcfb/ev0dFou95
 DZbxKTLX5RJ3hcnoKM4i3h8=
X-Google-Smtp-Source: APXvYqxDauTJH8f+kHlotU7Plk7uXRJ0NlHrldYtw7AEt7lUOju5YqBal77hT2TLa3joO/gXOquwgw==
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr7737914edq.124.1560351444497; 
 Wed, 12 Jun 2019 07:57:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id f3sm16790ejo.90.2019.06.12.07.57.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Jun 2019 07:57:23 -0700 (PDT)
Date: Wed, 12 Jun 2019 14:57:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190612145722.zlc3w773d4gcti6h@master>
References: <20190612014337.11255-1-richardw.yang@linux.intel.com>
 <871rzznma1.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rzznma1.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] migration/multifd: call
 multifd_send_sync_main when sending RAM_SAVE_FLAG_EOS
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 12:14:14PM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> On receiving RAM_SAVE_FLAG_EOS, multifd_recv_sync_main() is called to
>> synchronize receive threads. Current synchronization mechanism is to wait
>> for each channel's sem_sync semaphore. This semaphore is triggered by a
>> packet with MULTIFD_FLAG_SYNC flag. While in current implementation, we
>> don't do multifd_send_sync_main() to send such packet when
>> blk_mig_bulk_active() is true.
>>
>> This will leads to the receive threads won't notify
>> multifd_recv_sync_main() by sem_sync. And multifd_recv_sync_main() will
>> always wait there.
>>
>> [Note]: normal migration test works, while didn't test the
>> blk_mig_bulk_active() case. Since not sure how to produce this
>> situation.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>Block migration is weird.
>Block migration is weird.
>....

Block migration means migrate a whole disk?

-- 
Wei Yang
Help you, Help me

