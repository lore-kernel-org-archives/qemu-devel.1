Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9597CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05562225F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6MD2jd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05562225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIa1Z-0007xK-PG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1kIZxn-0004FV-Gb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1kIZxe-0005ua-IV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600272427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJUWeBrN1mimHICjLDJNenv7PW6U3my3QH8+7HKXpJ0=;
 b=M6MD2jd+3BQRs37jGWy0xGiJovStoK/MMYAD9doA/0T0Swh1+HdInDWV+SQaJs5xB4Woek
 CfYBpHu3h1un0NfyXnSWPkSWiDgLnwMzow7Oc9rFGKcnqQ9zMpfaF+E36sDeOS7HNPkEVd
 9kTrUnaKyNwTohIFpVlAJ8q9HZPBZ/Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-suOHZbg1NT6wps-ZVYxm2Q-1; Wed, 16 Sep 2020 12:05:51 -0400
X-MC-Unique: suOHZbg1NT6wps-ZVYxm2Q-1
Received: by mail-wr1-f69.google.com with SMTP id n15so2707463wrv.23
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=KchwzstyQlpdqhZJNK7fPbxbvRr8kNBzMwvR2EUZ0VU=;
 b=Sn3n0wVXMihs77SX1BmL5W5bhOvmIuxDwSq7d9o6ivmzhxv1LAj9VbwcvUJ//XaMGo
 FVz9kG7IRq0CBdGZAM6k2AfA/wD/tJ+KP/t/5+QRuaaZ71TLgKMU00a447Fg5sr0CVMx
 g0gPh/0G8nuldhzwMzyl6zT2OYb16sKqatxmVwg6ejXiZagyKSjDkstFlRpXB8U3jyj6
 jQREi2m3elo1ftfB+JmYr4ARjF4o8fcIgsljC6+VW+BUZsnkr34mP9OSdA07sT+QfImo
 GYavLYXyRWE0iwnCRwSqWMpBd4TfLUHdBVMpVGfDH/ChIwje1y/lnTcUracQ8YMmiUJu
 Xl5Q==
X-Gm-Message-State: AOAM531GXmCHR8yY14euAjhq5w0bw7y9fdVKYCGngu1OgWvn0C+xDpcl
 e7GRSyQC4kosDQSMUelXgGM6ZC8z3xheRYOvJ3xHy+rpADUadbELAoMR5TmwTi9zSadeU2AMIjy
 KAI9Tdrq6k3R4HHA=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr5682468wmi.79.1600272349916;
 Wed, 16 Sep 2020 09:05:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9QTVL/XIBWd36ARtCGDicAjMXl6VqXlP7aR7PNckfodE3gl5YlCyn2349agfTvgGqez8xVA==
X-Received: by 2002:a7b:c141:: with SMTP id z1mr5682436wmi.79.1600272349580;
 Wed, 16 Sep 2020 09:05:49 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:69d6:347:aa61:a2e9?
 ([2a01:e0a:466:71c0:69d6:347:aa61:a2e9])
 by smtp.gmail.com with ESMTPSA id o129sm6365682wmb.27.2020.09.16.09.05.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Sep 2020 09:05:49 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: Python docstrings and licensing/authorship
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <361aad7f-c2a3-524e-bd5a-2fc1fa6fe38a@redhat.com>
Date: Wed, 16 Sep 2020 18:05:48 +0200
Message-Id: <5C5765B1-3E0F-4577-B7B3-8BFFCB2D936F@redhat.com>
References: <361aad7f-c2a3-524e-bd5a-2fc1fa6fe38a@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0.501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 16 Sep 2020, at 17:47, John Snow <jsnow@redhat.com> wrote:
>=20
> For some of the Python cleanup work I am doing, I am moving preamble comm=
ents into docstrings. These docstrings are visible in interactive editors a=
nd may be visible when using Sphinx to generate documentation manuals for P=
ython code.
>=20
> My instinct is to remove the licensing and authorship information from th=
e preamble and leave the docstring only with information functionally relev=
ant to the module, while leaving licensing and authorship information in a =
comment (above? below?).
>=20
> The end effect would be that using e.g. `help(qapi.parser)` in the intera=
ctive Python shell would not show licensing or copyright for the module, bu=
t it would still be visible in the source file, as always.
>=20
> Is this in bad taste? Do we have strong feelings about authorship and lic=
ensing being visible in help output and generated documentation?

What about putting that in a separate pseudo-entity, so that help(copyright=
) would show it?

>=20
> --js
>=20
>=20


