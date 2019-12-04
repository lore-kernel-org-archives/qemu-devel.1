Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811AC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766BB2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSNPhBZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766BB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXNT-0000N5-Uu
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icWyQ-0003To-S8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icWyP-0003Qf-TB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icWyP-0003QS-PO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQTcOZ4HrHsLxErFtodsI45x37pMfjEH1fuBkBccOKQ=;
 b=iSNPhBZowFFEtUGnqAIHqINEXIipx0DET0QuyvCBwjUwE67pq1iykBLR9M40bsWr5RNn1h
 TFwxXvs3ExjtqbEPnX3eRQtt8E3xsKc1VefsppQt/iJ+ClXmffhfFaZeldzQUdGpwyCa+w
 ZXCEGeNO3EwVuQMWQa0/BTwUXuvYluI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-cPgsrf6XPvePoRuGbIbgJQ-1; Wed, 04 Dec 2019 10:53:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so37284wrm.17
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M/F4oZpC7Pru9u+65cGoAEXtPkLHRwd50zVh2PM0fQ4=;
 b=U235um1y9miv051pLCXnx1Wan04pOFJahxigWVceig+1L1JaxOA467bBOwlzvTjBtk
 I5lSQHNciL6cXXjhAtGTPnsISWpJC31ZmyO5wmNBhDL1/+PxUJz1Arhh1G43FrxeLfGN
 eJ44JR/Lmf901W8iTiCWbQhvHeR7Hrsmqe9BH7daRfwgxtODrkbTFqmaAMwpxkuQuotw
 HhCTFUOcxqxMw/ALwS5oY5zmK6xTEK0RoTL+fW6DJtjgz/QL+kgiLfPiN4kgDIzsDam8
 PPxp953omxpL4tqsOG5OXuOZEp/npHWqZS9ntHyHByAAKaB7WGQUH5TlmEWP1hCfPFby
 KmzQ==
X-Gm-Message-State: APjAAAU0rs1BwqdNGxpaVi/Y/BEoMV/L0AbQkGnYsADHaW9WRt7dv079
 ipO5eC352jcAqbw2/4b0WpTPKOyGbnOAnNF1pwhb4wUDAniHhL8Qqy5NmABUcu5+7TquWbPYLBL
 5E3TkaDGWl3BavVk=
X-Received: by 2002:adf:fbc1:: with SMTP id d1mr4936030wrs.267.1575474830240; 
 Wed, 04 Dec 2019 07:53:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAC/Phis0uOI1Y9RSOI7OjjCTYyAuLd4CSistpYCl+wt9sEV8DlyC7WIvxEbpCIGkVnzsgeA==
X-Received: by 2002:adf:fbc1:: with SMTP id d1mr4936016wrs.267.1575474830087; 
 Wed, 04 Dec 2019 07:53:50 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x7sm8527396wrq.41.2019.12.04.07.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:53:49 -0800 (PST)
Subject: Re: [PATCH v2 3/7] iotests: Skip test 079 if it is not possible to
 create large files
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5be5c047-5777-4f88-407c-20fd2226cb5d@redhat.com>
Date: Wed, 4 Dec 2019 16:53:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-4-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: cPgsrf6XPvePoRuGbIbgJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-block@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 4:46 PM, Thomas Huth wrote:
> Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
> (which we will hopefully enable in our CI soon). These containers
> apparently do not allow large files to be created. Test 079 tries to
> create a 4G sparse file, which is apparently already too big for these
> containers, so check first whether we can really create such files before
> executing the test.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/079 | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> index 81f0c21f53..78536d3bbf 100755
> --- a/tests/qemu-iotests/079
> +++ b/tests/qemu-iotests/079
> @@ -39,6 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   _supported_fmt qcow2
>   _supported_proto file nfs
>  =20
> +# Some containers (e.g. non-x86 on Travis) do not allow large files
> +_require_large_file 4G
> +
>   echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
>   echo
>   cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152=
 4194304"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


