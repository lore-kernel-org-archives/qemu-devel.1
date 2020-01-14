Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3611C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876CF24658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSgBZytc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876CF24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irQKu-0006Qu-JH
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 12:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1irQKA-0005KU-4X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1irQK8-0000Re-6M
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:49:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1irQK8-0000RQ-3P
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579024191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EX416NerlDQxec9DpVJFubjdmPfFRyqZlOPFLD2axFE=;
 b=fSgBZytctNhT6hEwdXlN+J7dyGl0QuVRwZwM4kJr6qOZwRtDDWItl6hVAdVujbegFcS6zt
 wvOZ2R+2qV/vRP4n2qoqoC/5fUD63AbAr/kakQd17t1VU7ZIQIjewT77N1dpHqfFNeD1pE
 +4kuAKTqTiQX9a0NNrRCGaONalBU21k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-f1Z4XV5ZNeikZOZeKYbVjQ-1; Tue, 14 Jan 2020 12:49:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id b9so3870810wmj.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 09:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=JPcgwjS0zw9klutryHr9lmsByuV68Cnf+nyPGn0wUHo=;
 b=VUj/scauriP0sWDk/M9Jgx6hO5wv6S8/rNMJ6Yg6t09gY6dmsp3UtaSyXZ6T2g6GBr
 714/ToJj7OS7/vl+IrLSikS/j0ZN23VM8z1sLGUiWcxHHGfw9uDINu5tEWzL7dp8OBJM
 s45a4jJQrERFKAAGRO0OqZEedw+CWcRFWfxraroJiNZfmGM7PegZbEQVTu9/tqrfk7CM
 G7PHGmCPHN60wXWAbqEg7bljpwy4RybJTE2jkZTTHaB4PVB169p9wEMJQV2tog0Z/Z/v
 q6sAQfTD0GdTtFS0KInwDk0e1SDOTyBt3VHVo55p16W7QdoIstCEnij1yP6qpViSKwsm
 Jsug==
X-Gm-Message-State: APjAAAVU4Sm88HnVjgGU/5lTlGdLj6VZbIfd89b2732KXm5Tus1xgF7+
 aEq7GEmFx2JXbWHh3PigG54L7KACkpi+TLEDYsxYkkSGAWj42wY+U5pflUFB7waa/2uoQC+jMOK
 CQ7ZefmFHhoiomNY=
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr27380263wmg.154.1579024187500; 
 Tue, 14 Jan 2020 09:49:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzze4YuGD9BsKChOBrM06U7nc24gDtzgjbFnrEUOIwxFYoGTOJ1uC/LFrPY6H5rt2OylFl3PQ==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr27380229wmg.154.1579024187243; 
 Tue, 14 Jan 2020 09:49:47 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:7440:4d06:49b0:1f79?
 ([2a01:e0a:466:71c0:7440:4d06:49b0:1f79])
 by smtp.gmail.com with ESMTPSA id i8sm21107296wro.47.2020.01.14.09.49.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jan 2020 09:49:46 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Priority of -accel
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
Date: Tue, 14 Jan 2020 18:49:45 +0100
Message-Id: <597F9FF3-382F-4580-85F9-7C755E1B7CCE@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <87d0bnwct1.fsf@dusky.pond.sub.org>
 <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: f1Z4XV5ZNeikZOZeKYbVjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 13 Jan 2020, at 17:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 13/01/20 17:17, Markus Armbruster wrote:
>> Perfect opportunity to change the default to something more useful.
>=20
> I am not sure acutally if it's that more useful, now that we have
> sanctioned qemu-kvm as the fast alternative.

OK, half a joke, but we should have tested on =E2=80=9Cq=E2=80=9D at the be=
ginning
rather than =E2=80=9C-kvm=E2=80=9D at the end ;-)

emu being the slow one ;-)


