Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A707C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4297B206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W78FLHJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4297B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgxZ-0007W6-IH
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jfgwf-0006dY-3n
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:41:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jfgwe-0007xh-9e
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591004482;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=7R4WkhjnWyeLH0UmRJ4/Cy6AU8TkX7D45y5OIgQ9Iqs=;
 b=W78FLHJP4pgzC3xYlKlmz766Sra2q8xZafMngtI1MkYFq01yYzv/V1db7CFgQ0OU+W7XcI
 HunAWKh0eJyQefODm4G6vTIft83tDcM0HXMGisYs4qY6KollzaGPmGQRnhNpZePp9oyrGI
 03KK02F53aqMocc4PhGfjpulavv6Mq0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-_aNYYLFrO3qKw91Ot2gvFA-1; Mon, 01 Jun 2020 05:41:19 -0400
X-MC-Unique: _aNYYLFrO3qKw91Ot2gvFA-1
Received: by mail-wm1-f72.google.com with SMTP id v23so2465527wmj.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7R4WkhjnWyeLH0UmRJ4/Cy6AU8TkX7D45y5OIgQ9Iqs=;
 b=nlQ7MsPpglk4tsnkfU5CcDENGz6xzg4l9/Gz6q+DqiDUetts5e/iCTVogXCK066XMN
 vI6BClLtb454oZrhmuQafN2bRaDoZhevqU9fMZs/TsQHIkpYddImdWtOP65pPvDD+I76
 yCLiwIo3IiOge1KkVSY6n0r+9WkfjVh0wPHKG5SaGiJFfAQ3ZjQlA3PoIi4bfzq0aiew
 rbJXbbrGTyubZRT/Ad1LCrPZ1PnA98/QuSdLJL7WIekY5b0PKiTi6xcfehRpkuljUaI1
 H64xM8e+7yv1z+BUFg2w3oxSMy06l3pnKNsID+xkIRT2M2dq8K8cQasOAjANFZ/cEk8F
 sUPQ==
X-Gm-Message-State: AOAM531UNFh6TZ3AahSTO1Fjr51QC0DED4s4AfZxANuTEVPcWGTvCmFp
 /JY+x+qQox46FqhxhxJ1KfYNTGFzc8kxpSLnUsdWLjjKzKrTZ7I7cjH3Ci4fYJjl+IxhH5YcMM3
 UnmZJ+EE6ZDH11Yc=
X-Received: by 2002:a1c:4189:: with SMTP id
 o131mr21627419wma.110.1591004478351; 
 Mon, 01 Jun 2020 02:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziNYdM6TkUvDrPEzTBfStQSm0MdutJAH9KY3s9OZM/1yICCnZTsfEWrLEkKI4yAzKNPgsN/Q==
X-Received: by 2002:a1c:4189:: with SMTP id
 o131mr21627407wma.110.1591004478098; 
 Mon, 01 Jun 2020 02:41:18 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id f11sm14276205wrj.2.2020.06.01.02.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 02:41:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: KVM call for 2020-06-02
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 01 Jun 2020 11:41:16 +0200
Message-ID: <87d06j6s3n.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Hi

Please, send any topic that you are interested in covering.
There is already a topic from last call:

Last minute suggestion after recent IRC chat with Alex Benn=C3=A9e and
Thomas Huth:

"Move some of the build/CI infrastructure to GitLab."

Pro/Con?

 - GitLab does not offer s390x/ppc64el =3D> keep Travis for these?

How to coordinate efforts?

What we want to improve? Priorities?

Who can do which task / is motivated.

What has bugged us recently:
- Cross-build images (currently rebuilt all the time on Shippable)

Long term interests:

- Collect quality metrics
  . build time
  . test duration
  . performances
  . binary size
  . runtime memory used

- Collect code coverage

Note, this is orthogonal to the "Gating CI" task Cleber is working on:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg688150.html




At the end of Monday I will send an email with the agenda or the
cancellation of the call, so hurry up.

After discussions on the QEMU Summit, we are going to have always open a
KVM call where you can add topics.

 Call details:

By popular demand, a google calendar public entry with it

  https://www.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a=
3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

(Let me know if you have any problems with the calendar entry.  I just
gave up about getting right at the same time CEST, CET, EDT and DST).

If you need phone number details,  contact me privately

Thanks, Juan.


