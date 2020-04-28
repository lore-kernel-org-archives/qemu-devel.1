Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA9C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCC820661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EK97ttN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCC820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTO0Z-0001sY-AD
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jTNza-0000Xs-Bu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jTNzV-0007PA-1j
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:01:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jTNzU-0007On-F0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588071686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHLPGXc409eUxZRDhpYEHBHNduJDHeD9ZouHUXYqzxU=;
 b=EK97ttN7lcdWhxYvASVEhL+YHKz45lXc4hCFz4WrkrTV7KcxoaEjJpHkegfYKuwAvYkPAM
 oen7oO5nPhUT3WQLNdtdv/Hi3KrlTQAO3S3nryr6XmGoIvROi8aOLwaoaTeM93zosFV4oN
 leyzSpM1ra2+V4j95WoAHgHESPed6OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-HqtvUGOPO_u8a9vt6omsWw-1; Tue, 28 Apr 2020 07:01:25 -0400
X-MC-Unique: HqtvUGOPO_u8a9vt6omsWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3971895910;
 Tue, 28 Apr 2020 11:01:23 +0000 (UTC)
Received: from [10.36.114.119] (ovpn-114-119.ams2.redhat.com [10.36.114.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA84611D4;
 Tue, 28 Apr 2020 11:01:19 +0000 (UTC)
Subject: Re: [PATCH 0/2] virt: Set tpm-tis-device ppi property to off by
 default
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 cohuck@redhat.com
References: <20200427143145.16251-1-eric.auger@redhat.com>
 <a5bb0ccb-2dc4-67e2-f0df-98c349e6e94f@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <df3080eb-80d6-5dab-6fd8-973a3764ab5c@redhat.com>
Date: Tue, 28 Apr 2020 13:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a5bb0ccb-2dc4-67e2-f0df-98c349e6e94f@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 4/27/20 10:21 PM, Stefan Berger wrote:
> On 4/27/20 10:31 AM, Eric Auger wrote:
>> Instead of using a compat in the mach-virt machine to force
>> PPI off for all virt machines (PPI not supported by the
>> tpm-tis-device device), let's simply change the default value
>> in the sysbus device.
>=20
> There is no change in behavior on any arm machine due to this patch,
> right? So backporting would not be necessary?

Indeed, there is no functional change as we keep PPI off. My
understanding is we can safely remove the compat mechanism. I tested
migration between virt machine with compat to virt machine without
compat and conversely (without tpm-tis-device though) and it passed.

Thanks

Eric
>=20
>=20
> =C2=A0=C2=A0 Stefan
>=20
>=20


