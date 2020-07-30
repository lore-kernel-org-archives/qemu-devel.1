Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5358C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675B620809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEqVLOs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675B620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1GHM-0000xK-OJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1GGh-0000Wt-2j
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:39:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1GGf-0005ON-0e
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596145151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YaSShEw13jtXhBgkKPIXmE/6WfDaxlSJ8NYlk4+rphY=;
 b=XEqVLOs8BiU7nZOUC6Z/pZ1SpWGFlCY+FeJouJALXT3ghGbdIUdMCYbcxUVbkVNubMHa3g
 znBU7/wjuw9hPcfC8SVUo2SBhkB6so2KvoVMF+oBakTGesMhKoso/Y3V82MDKSKSB5kyyF
 Opf0wfp5zfkQS1eU+5X8AGrQSV+eYxw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-QbDLe69JPdWQk907HWpXaw-1; Thu, 30 Jul 2020 17:39:09 -0400
X-MC-Unique: QbDLe69JPdWQk907HWpXaw-1
Received: by mail-wr1-f71.google.com with SMTP id f14so8322015wrm.22
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YaSShEw13jtXhBgkKPIXmE/6WfDaxlSJ8NYlk4+rphY=;
 b=aq+aACOy33AgOz0UViOsWZ1hnhIQNtB8RkWXqModvOZgcKNP8yZL2DXHEcklzAIGYH
 mkmFDu9jHyCSUFf5PlPJuXd25NZ+q7u20MZP/83GKhEyMhY3iI9aLAN8NzJVAvUeHabc
 swXNtdvyoHDgODRaXry4jhNfvqAWtK57oyzDLEusj9Np6DcQ1q+DPbCC2g7F7WiUkJeS
 qKUuO2/rLW6QIgcOJ7/ucP2le5GRTrWN4mMEe8gpSjg2PGH0XO3FvY+VNvD/fbo7N9H8
 cpJYWYHPgoqY0A/LRFRcDbgCE1qRhsRWgSPktxunL75ztgQsObaLzA/epJmZbY/91cB7
 itYQ==
X-Gm-Message-State: AOAM531IxrmFR6WXo8WMSIh0fyCmLJkUPshB104iyVabU+lygs4igjEX
 jgeFsNHniYOArLOD+ld+2KSeU/HBZMh19XgoWxU8RXQ4VCGlx2FkYM2/GXy+/eXNQAM3nbmCK4M
 gf2lG0xVOz5EeCPI=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr980532wmh.11.1596145148320;
 Thu, 30 Jul 2020 14:39:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzny5VRc06Zo8i0LfGZEls0DIzNfTN947zkrk/PKE1oehYco2WtSZ9Im71usPA3v1j0FzzUQQ==
X-Received: by 2002:a1c:e304:: with SMTP id a4mr980512wmh.11.1596145148046;
 Thu, 30 Jul 2020 14:39:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id p14sm11251904wrg.96.2020.07.30.14.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:39:07 -0700 (PDT)
Subject: Re: [PATCH V1 00/32] Live Update
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <37635d27-b63f-f200-fa89-ccb6f7eba7f6@redhat.com>
 <c7fe0c2e-045c-f50c-6429-7ceaeee7bd66@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fbcfbcc-0908-4957-d15b-4ba4494dde85@redhat.com>
Date: Thu, 30 Jul 2020 23:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7fe0c2e-045c-f50c-6429-7ceaeee7bd66@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/20 21:09, Steven Sistare wrote:
>> please spell it out.  Also, how does the functionality compare to
>> xen-save-devices-state and xen-load-devices-state?
>
> qmp_xen_save_devices_state serializes device state to a file which is loaded 
> on the target for a live migration.  It performs some of the same actions
> as cprsave/cprload but does not support live update-in-place.

So it is a subset, can code be reused across both?  Also, live migration
across versions is supported, so can you describe the special
update-in-place support more precisely?  I am confused about the use
cases, which require (or try) to keep file descriptors across re-exec,
which are for kexec, and so on.

>>> cprsave and cprload support guests with vfio devices if the caller first
>>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
>>> The guest drivers suspend methods flush outstanding requests and re-
>>> initialize the devices, and thus there is no device state to save and
>>> restore.
>> This probably should be allowed even for regular migration.  Can you
>> generalize the code as a separate series?
>
> Maybe.  I think that would be a distinct patch that ignores the vfio migration blocker 
> if the state is suspended.  Plus a qemu agent call to do the suspend.  Needs more
> thought.

The agent already supports suspend, so that should be relatively easy.
Only the code to add/remove the VFIO migration blocker from a VM state
change notifier, or something like that, would be needed.

Paolo


