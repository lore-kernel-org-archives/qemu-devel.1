Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29723C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89B0207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA3iypAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89B0207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7Hj-0001sE-76
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jl7GP-00019w-1B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:48:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jl7GM-0000fA-GE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8KB+cTLS7xorWY/8wkVIPQKcO1yqa/ZtcbOQCRk7fw=;
 b=QA3iypAmaAEJurC13tHN5Dmd6DCBNwPHBww6BlyckgiWvI518DFTCyw8q8/HKb+igdbLPC
 vwyaaY7mIQ0wNmQ9URQVjhiLytwhcnqrMkOp57GAIEhQpg/Z+UqNdP2tpXUCgdHzFf9irG
 0gYKn/Boe4kGEtuQBonq1vVlvuFPAxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-eZcy5y-bMHy6RFxH8VCgug-1; Tue, 16 Jun 2020 04:48:04 -0400
X-MC-Unique: eZcy5y-bMHy6RFxH8VCgug-1
Received: by mail-wr1-f71.google.com with SMTP id t5so7997893wro.20
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 01:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M8KB+cTLS7xorWY/8wkVIPQKcO1yqa/ZtcbOQCRk7fw=;
 b=pZPmgkels2j2gCrHZdF7BQR0BLaKT2L3J/r+9rIDn+FM13QY/sayH2B6+f9HwxUE9g
 nLObAcQt3JygZn3zev0NzN+n8tRmJceJDsVOimBoxYGMoaS5KHBpljr0IQN2AvEnI0LI
 vRT22+DU0P36JU3BZkrmQJ8Gn0+BFOkxYXiiNzpaWGp5voHFVASor3LI7cVVYyqefEMK
 t2MzuX06n/0mIITztDbdLJ3gu7M1DJbwlm49zkbkPTP33QD+ZQLnwZTrVTY6pzmJX1Bv
 IvI3fmcz4JCJhxkkoyQPWWB1HIBHBQZ8R/5ALJnlN+zLQFXvjXI5TjvlZFFgAvaXLBiB
 nPbA==
X-Gm-Message-State: AOAM530Ktx8+V8FLwPLnNRNRZDx2mJkKTnoPqj79H+ZzmBHEQ/zm3ykI
 XsC9vXFlxZrXEfLFRMtrK5xAMi3Ccv6UnyBxZ7IosOB6+qNIQKeRKCpqi1l4hTBtzW+bcPFMgwi
 an1buf9FS+fYDVRI=
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr2029652wmi.0.1592297283225;
 Tue, 16 Jun 2020 01:48:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvZnUjAE4GDabkYeFSd57AxeyTiGDyShyzrSQHYgdOvkCCTgddGvqjYyXzr8kCLBpWD5eVJA==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr2029638wmi.0.1592297282996;
 Tue, 16 Jun 2020 01:48:02 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id f185sm3009408wmf.43.2020.06.16.01.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 01:48:02 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>
Subject: Re: KVM call for 2016-06-16
In-Reply-To: <87wo48n047.fsf@secure.mitica> (Juan Quintela's message of "Mon, 
 15 Jun 2020 11:34:32 +0200")
References: <87wo48n047.fsf@secure.mitica>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 16 Jun 2020 10:48:01 +0200
Message-ID: <87h7vbxupq.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi

As there are no topics, this calls gets cancelled.

Happy hacking.

Later, Juan.


>
> Please, send any topic that you are interested in covering.
> There is already a topic from last call:
>
> Last minute suggestion after recent IRC chat with Alex Benn=C3=A9e and
> Thomas Huth:
>
> "Move some of the build/CI infrastructure to GitLab."
>
> Pro/Con?
>
>  - GitLab does not offer s390x/ppc64el =3D> keep Travis for these?
>
> How to coordinate efforts?
>
> What we want to improve? Priorities?
>
> Who can do which task / is motivated.
>
> What has bugged us recently:
> - Cross-build images (currently rebuilt all the time on Shippable)
>
> Long term interests:
>
> - Collect quality metrics
>   . build time
>   . test duration
>   . performances
>   . binary size
>   . runtime memory used
>
> - Collect code coverage
>
> Note, this is orthogonal to the "Gating CI" task Cleber is working on:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg688150.html
>
>
>
>
> At the end of Monday I will send an email with the agenda or the
> cancellation of the call, so hurry up.
>
> After discussions on the QEMU Summit, we are going to have always open a
> KVM call where you can add topics.
>
>  Call details:
>
> By popular demand, a google calendar public entry with it
>
>   https://www.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZwNzRoMHE=
4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
>
> (Let me know if you have any problems with the calendar entry.  I just
> gave up about getting right at the same time CEST, CET, EDT and DST).
>
> If you need phone number details,  contact me privately
>
> Thanks, Juan.


