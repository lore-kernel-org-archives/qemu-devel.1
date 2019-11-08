Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FBC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C5B218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFtXXCp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5B218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1yI-0002Q0-CV
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT1xC-0001Nr-KM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT1x8-0001mK-D9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT1wa-0001P2-2b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573210603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8CORNQ/Z/aRDcCrajii0EyWBb0MNU3yCo+4dGU3e3DY=;
 b=OFtXXCp5h1N23kZWkkqdsHtPaYVCXhTonp2Zu105OpR8cpeVRjroalGOerTK2A2QwO0Eoj
 D45LQa8O/qphYWWfIZr10ubCWKsmTJ4ED/q9wWnw4ceuxfyIZqAxiMC6tmB+cfemf5NIuU
 /IiyfisHo8CzjyUMqjhO3VbxlL2e3Ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-eYg-wAI_PluTPIa4jV_aUw-1; Fri, 08 Nov 2019 05:56:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F72A800C72
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 129D36084E;
 Fri,  8 Nov 2019 10:56:29 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-plug-test: fix leaks
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
 <20191107192731.17330-4-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <50882b6f-8270-2bb9-18f2-4a9ec49facaa@redhat.com>
Date: Fri, 8 Nov 2019 11:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191107192731.17330-4-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eYg-wAI_PluTPIa4jV_aUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2019 20.27, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/cpu-plug-test.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 058cef5ac1..30e514bbfb 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -99,6 +99,7 @@ static void test_plug_with_device_add(gconstpointer dat=
a)
>  =20
>           cpu =3D qobject_to(QDict, e);
>           if (qdict_haskey(cpu, "qom-path")) {
> +            qobject_unref(e);
>               continue;
>           }
>  =20
> @@ -107,6 +108,7 @@ static void test_plug_with_device_add(gconstpointer d=
ata)
>  =20
>           qtest_qmp_device_add_qdict(qts, td->device_model, props);
>           hotplugged++;
> +        qobject_unref(e);
>       }
>  =20
>       /* make sure that there were hotplugged CPUs */
>=20

Fixes: 021a007efc3 ("cpu-plug-test: fix device_add for pc/q35 machines")

Reviewed-by: Thomas Huth <thuth@redhat.com>


