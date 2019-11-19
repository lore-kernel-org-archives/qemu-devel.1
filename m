Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF57C208A1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSYJv7Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF57C208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7Le-0001Aq-T0
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX7KI-00006A-4y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX7KG-0000cl-Dp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:30:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX7KG-0000cI-Aa
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574184603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBxAwvsXa4TxW1oQr68Eo1VmhL9GWoBvkEcfV9WhuME=;
 b=SSYJv7Hf3DDNGdzaWt+JxXC5UDgyyUwYGx6qggOLYUafTsq7ZpzAUMVvZjjh4jQVrVcFNv
 ZETyMs7xVC6u5e81wAChmct8cv10rNyA1r0WMLtjijHkpF3jAcGo2M6jQ85FSTlvmaH9xm
 DO+xht2WFCpl+4bjKhRdfmUAMxiw1Lk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-HYvIr-RYNLOeTERTXKH4Wg-1; Tue, 19 Nov 2019 12:30:01 -0500
Received: by mail-wm1-f71.google.com with SMTP id m68so3004480wme.7
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v3AaFIbToAGa2HtfNZhu3xMgbpxJmJpr4z4yYqdnE6Q=;
 b=oRDoTLY0JhNplKQtHaNfrl9bNuItffo78jqt6qbnTabmFQDnhUP50WyvFAmzRpMwPu
 QLCQdRUZUoBOFqt0bGcF8mk3uA5HwDPWXYLhEoAYni+BH5seQFKnDh9cI9e/qksWO03q
 ap8XIJobTSXU+J0qNs153cLrOUAfV2f6Iib12PnUrQUAfhPuAGv7EtcPcJKOpJsrhKY2
 t3pNvVChyHix9eT3V1+iFTe8n030kqGn4A27E3Jh4o3MbFvp+Nkqbk0mZblLSkDU5J8I
 41raZUQIdfrKn8Sj+M60ee+21k78vU9J88kwYXPBW7inaKE7nk3+5mIpl5Zs+hQRTHF3
 ByQw==
X-Gm-Message-State: APjAAAWmpfWtbujYsRavkgIWD+t3EXAidJOHV52i1fqPGz3flbIkmL5y
 gfz3bVN2TMrjxzAxjOMtw4VGApWvyYEb9aiiouAnxRYkvJMfnSe9tKZx4RuOBVTZ0frT0BtpByu
 /mwV8vQ8+mKZi8Ls=
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr41196500wra.194.1574184599821; 
 Tue, 19 Nov 2019 09:29:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/ZWW0ZMdLfsFAnadn5wZ4LAc3k+BFOufsoHCwgr5xWl0d4cuxggmJurBDDMSvNq/C6acTVQ==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr41196481wra.194.1574184599633; 
 Tue, 19 Nov 2019 09:29:59 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id 13sm3757908wmk.1.2019.11.19.09.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:29:59 -0800 (PST)
Subject: Re: [PATCH 2/6] iotests: Skip test 079 if it is not possible to
 create large files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7242d268-6563-246f-4acc-2e714ebfd513@redhat.com>
Date: Tue, 19 Nov 2019 18:29:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119170822.45649-3-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: HYvIr-RYNLOeTERTXKH4Wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:08 PM, Thomas Huth wrote:
> Test 079 fails in the arm64, s390x and ppc64le LXD containers, which
> apparently do not allow large files to be created. Test 079 tries to
> create a 4G sparse file, so check first whether we can really create
> such files before executing the test.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/079 | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> index 81f0c21f53..e9b81419b7 100755
> --- a/tests/qemu-iotests/079
> +++ b/tests/qemu-iotests/079
> @@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   _supported_fmt qcow2
>   _supported_proto file nfs
>  =20
> +# Some containers (e.g. non-x86 on Travis) do not allow large files
> +if ! truncate --size=3D4G "$TEST_IMG"; then

Shouldn't we restrict that to Travis-CI by checking some environment var?

> +    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> +fi
> +rm "$TEST_IMG"
> +
>   echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
>   echo
>   cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152=
 4194304"
>=20


