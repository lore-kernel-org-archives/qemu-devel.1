Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93332C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6245D20707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eupJe6jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6245D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmMQ-0003ZN-Lx
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jkmLi-0002nk-0z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:28:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jkmLg-0005pa-IW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592216895;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEwHOEUVIsuITaUIIISThUPaugqQZ5HRCgo6EY/fF24=;
 b=eupJe6jx60h4cGOhS0gMMR9cia0fmdw8OpXiJDIDkFdaRV0sCFdt53uHzyTDgiavGdhyqt
 4Vp3eU664PR/m+u2qnfBNq9qUd0K+R8IoOEf4oXPRYExexuJ40DbDps1vPFxU5ckmkThLM
 DeVyonkyo3lHlLu5c4RtMU7/KWDROE8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388--cF4YfwbO9G7b8D6-0MB0w-1; Mon, 15 Jun 2020 06:28:11 -0400
X-MC-Unique: -cF4YfwbO9G7b8D6-0MB0w-1
Received: by mail-wm1-f72.google.com with SMTP id k185so4819644wme.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zEwHOEUVIsuITaUIIISThUPaugqQZ5HRCgo6EY/fF24=;
 b=DJ7OnQ3tiGypudWiE3Ad8Qd4Nqi33t4yaXDQWcPm+buaoTwdwz7DTelhBxOwTEaFKV
 qY/tP/ugnbTWh4Ryr9yaQVFMiMqQjjdPMgnUn+gkpviLjsqR8aCo7qnbkC6hKpDGQDe0
 pLUfYukMh9alJ2U3M48nLiizlQSzA1qRkv4qzz5ZK1ZYzdkeV7LpHaCa2GVm5PKEhilH
 BrJDNr53D2TZqaxCxn3yvWWQm9k1e2BZ7aTWwoYdTAHx4e4+eVSth3BOAc4Pa/uoig4T
 D1pyPkbOFqGwzKrnB7q2ZVUBPbcwMD/HbBmiIkJc5AJfhV7/H0aNrwVUUp43oaOr5i6Z
 /cUA==
X-Gm-Message-State: AOAM531py9MpAUggjjClIDZl55u+FsLFhKYMb0r3vN3s/l8K5Lh+ADuq
 DxEfM1igh6SjDjAxX6dVQwZpgJUnPO90oku7v9y3/6aMJTWPVui+PutyzPTQSBL6aTGJVqtiL4K
 EEpW3OaCOaj+CSow=
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr12057844wme.14.1592216890146; 
 Mon, 15 Jun 2020 03:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXZaVM8mnYQPDv9oJ62jKk46AqV6gjiZeFq/If6XKT6ORJLONLwMgXxzSqq2qzwKUh4cH5zA==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr12057822wme.14.1592216889906; 
 Mon, 15 Jun 2020 03:28:09 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id r12sm25091486wrc.22.2020.06.15.03.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 03:28:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: KVM call for 2016-06-16
In-Reply-To: <6324140e-8cc1-074d-8c02-ccce2f48a094@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 15 Jun 2020 11:45:17
 +0200")
References: <87wo48n047.fsf@secure.mitica>
 <6324140e-8cc1-074d-8c02-ccce2f48a094@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 15 Jun 2020 12:28:08 +0200
Message-ID: <87sgewmxmv.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, kvm-devel <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> Hi Juan,
>
> On 6/15/20 11:34 AM, Juan Quintela wrote:
>>=20
>> Hi
>>=20
>> Please, send any topic that you are interested in covering.
>> There is already a topic from last call:
>
> This topic was already discussed in the last call :)

Sorry.

My understanding from last call was that we wanted to discuss it with
more people from more organizations.

Later, Juan.


