Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E065C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F1E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ykh/IQj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F1E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BXi-0007FL-AY
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j5BQ2-0002qZ-QK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j5BQ1-0008Cw-KP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:44:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j5BQ1-0008CW-Fg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582303489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFjnHcSTZf8ccLeXweS5OLA9Y3XitkZpI4MudH6oxAk=;
 b=Ykh/IQj+XRM94erLrz1PSiPSL9zSLo77Ha+3FnrpuTsqPxLlO2Tm4P1b8k3PjgwR6N0f7h
 TJ5H9r31zvhSgtR0fNVFzA0MEmhWf03z59QJZfuf6NRhr7vtDPtDTdfFuz4I+9tGi6SjQ4
 Albm8vevMR6DQvbYXJYun/CBIoy/S3M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-J4p255N4OY6PaLdkijILSQ-1; Fri, 21 Feb 2020 11:44:44 -0500
X-MC-Unique: J4p255N4OY6PaLdkijILSQ-1
Received: by mail-qv1-f70.google.com with SMTP id e10so1706963qvq.18
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WD+egaXL79n8fyoJ4JTqJrgGl0BA5SEmN2Q+iUmm0zI=;
 b=r6Ypx4afWKlwkcnpJzjTV5OY2CRx4z+H4MDGs3wkJ9PtFn7VVuVTfFLCtymZLiHejD
 XVBUO/D6F2wb81eHmlRUQ9Vf5f6omcMHIin8Gx+8cNHSn+gbAr5wKKY+LPWYYFq/Ur45
 SqQLfcfC098qjHcv0ISjUgZbh36XQobglZeKMHRFAU10jJXjpFlkjqefr/X5kVvWA6Nq
 7MZc9aapArU/paLZI+DKP6X5pIR8hrbzi0kZOh9Ujl0fr6pQxGvpYkW3cs/43qaqx840
 XWJyvrhXomzyb3tflPfjYbuYN6VMFB8zyucTUWp6Zm4bc+75voTIRh02OSQpetNH7j+P
 wmCQ==
X-Gm-Message-State: APjAAAX7HJ6fDQd2jJR2wGcIlatpnvIZRY+ovg3O7V5hZRexP486RTNT
 CmpFycjrZ5Nk+mbuT/5sz0aE0ECNKRjKyXQAsCiMXMqkPz9oMMFG06xbWjnV6isEnyGgpbkHIua
 OteAZJkR2V6Ne01Q=
X-Received: by 2002:ac8:349d:: with SMTP id w29mr33243892qtb.386.1582303484279; 
 Fri, 21 Feb 2020 08:44:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQoOdWwadLGptmbzYnJV0Fm1g9q1W92mP2ra2dLjU3WlXAcaUfoHYvaEIMeYHVuFYpjg8gdg==
X-Received: by 2002:ac8:349d:: with SMTP id w29mr33243876qtb.386.1582303484083; 
 Fri, 21 Feb 2020 08:44:44 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id o7sm1769967qkd.119.2020.02.21.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:44:43 -0800 (PST)
Date: Fri, 21 Feb 2020 11:44:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION)
 return value
Message-ID: <20200221164442.GD37727@xz-x1>
References: <20200221163336.2362-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221163336.2362-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:33:36PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> kvm_vm_ioctl() can fail, check its return value, and log an error
> when it failed. This fixes Coverity CID 1412229:
>=20
>   Unchecked return value (CHECKED_RETURN)
>=20
>   check_return: Calling kvm_vm_ioctl without checking return value
>=20
> Reported-by: Coverity (CID 1412229)
> Fixes: 235e8982ad3 ("support using KVM_MEM_READONLY flag for regions")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


