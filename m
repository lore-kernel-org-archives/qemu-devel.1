Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F18C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908272073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJgFkhGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908272073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ULm-0005tL-Qr
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9UKE-0004Bm-CL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9UKD-0001yi-EI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:44:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9UKD-0001xu-BI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583329477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1KhDTV6bVBYBYHnWDxWWNOY+j5WAiV2buvrkHO4Q18=;
 b=HJgFkhGIA5UNCzAXOTqieyydn8Fj2xhUSE71aJ7dOmoWE0WXpiuB5QXmMzkybV0IQVcJRA
 +TPYinMOPWsUynWr8QSpE5tUrIBRmTEelybLr9uRBx5cJH6mBCCClkB/Pox93Myhn0aOyY
 RqjEOUuMzfzBdumoNUQelQQ6p+TzDSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-qfg_jnLvP7Kn4SHXjveR2Q-1; Wed, 04 Mar 2020 08:44:33 -0500
X-MC-Unique: qfg_jnLvP7Kn4SHXjveR2Q-1
Received: by mail-wr1-f69.google.com with SMTP id p11so873938wrn.10
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 05:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cwtpJISE4+PKDpLucCLSKmtD6ahPfpNV5KVXN5QcR7Q=;
 b=J7Z+N5KEboFFTVUAOoALs+mYzm4oiAKeAyVvPYwq+YG40TGFrfV0PE+eYNMDU4uF9C
 Iqi9QnnsJVJ446u/sGAgU7gXVPA6oaVm7EPBcgV5UuvGlDCzkm3Z5WOqI8g9eXOALPQf
 GLOTuCQeylaUva1oRMqejciLH18t9dz/vTW5/arllpSZ8KJxnQD8YWA1uIMXWfMzGTVt
 giUYr6etbv+/wLK/j/SS2AD9t2ObPbwJDmrEjM2/CGs9IBxABcFQS80ephQLCg5hN0tb
 50su24A0/2+eYJJvufD5qBZhhy9zf8f6rjfOOFN16JZbkjA9lzwJ2hpkdbZ5PVwqX5IT
 aASA==
X-Gm-Message-State: ANhLgQ2F+7vt2XFyzwm5tDBFCUPkOnq3AJ3tt2e/N8dZt/ykReN+Ecu8
 VetlG8LS59Bo6K4nyJBnax+zZ/iCJIY3htNtsep0RMm6VM8lAW6+15nd96B5JHj0h7dqnvEvna4
 57FfHcLQuBV9/H34=
X-Received: by 2002:a5d:6891:: with SMTP id h17mr4104457wru.259.1583329472410; 
 Wed, 04 Mar 2020 05:44:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt48cc8TTtIxgopyFld/NbXqNf525YLj9hGfthKiXB03jbieosY3tH7tKEB4JJ+vTQjVf6FYA==
X-Received: by 2002:a5d:6891:: with SMTP id h17mr4104420wru.259.1583329472179; 
 Wed, 04 Mar 2020 05:44:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id h20sm18051714wrc.47.2020.03.04.05.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 05:44:31 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: Replace zero-length arrays with flexible array
 member (automatic)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
 <20200304005105.27454-2-philmd@redhat.com>
 <1e1a1491-15ca-29d4-8bd6-1bf14edb4ad5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38b55649-b1cd-8891-5c13-ec4c6ef3ae5e@redhat.com>
Date: Wed, 4 Mar 2020 14:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1e1a1491-15ca-29d4-8bd6-1bf14edb4ad5@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 14:12, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized type
> 'union viosrp_iu' not at the end of a struct or class is a GNU extension
> [-Werror,-Wgnu-variable-sized-type-not-at-end]
> =C2=A0=C2=A0=C2=A0 union viosrp_iu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 iu;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
>=20
> Yay we found a bug! Thanks Gustavo :)
>=20
> union srp_iu {
> =C2=A0=C2=A0=C2=A0 struct srp_login_req login_req;
> =C2=A0=C2=A0=C2=A0 struct srp_login_rsp login_rsp;
> =C2=A0=C2=A0=C2=A0 struct srp_login_rej login_rej;
> =C2=A0=C2=A0=C2=A0 struct srp_i_logout i_logout;
> =C2=A0=C2=A0=C2=A0 struct srp_t_logout t_logout;
> =C2=A0=C2=A0=C2=A0 struct srp_tsk_mgmt tsk_mgmt;
> =C2=A0=C2=A0=C2=A0 struct srp_cmd cmd;
> =C2=A0=C2=A0=C2=A0 struct srp_rsp rsp;
> =C2=A0=C2=A0=C2=A0 uint8_t reserved[SRP_MAX_IU_LEN];
> };

It's variable-sized but it's okay as long as the total size doesn't
exceed SRP_MAX_IU_LEN.  So it's not a bug, but I agree it's a time bomb.
 Moving the field last should work, but it would still be quite
dangerous code.

Paolo


