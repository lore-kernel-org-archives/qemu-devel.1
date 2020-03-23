Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D90C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE222072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQA9cEsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE222072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJy4-0001Vc-Rk
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGJxM-0000wl-Br
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGJxH-0008HH-61
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:05:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGJxH-0008H0-2l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584957910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DleNS9L7x57oZSWz8W7lW6iYhxVh7KIWltpKzT0oU8=;
 b=CQA9cEsUKj4Pg9ajaE4Qy0mpTocZg3EhEts8d0ZgHOaRnbABLC/duLb6KEFvWqgPxvaL0x
 yGl487EBxVQgyAWz9yVLZBl2/FbiM3ym9e5SQjNMS0ABNSYFyrbj3kOl1XlLBCxyj+vPdI
 X9j9JHkyPI0eBscy+SNONcfu02KgVuY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-WE20AzZiPQOpE9X27Wp6zg-1; Mon, 23 Mar 2020 06:05:06 -0400
X-MC-Unique: WE20AzZiPQOpE9X27Wp6zg-1
Received: by mail-ed1-f69.google.com with SMTP id x1so11133045edv.14
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xUmdv2PR7wy33QBECDGMZhzPhB1NGJbAvvwO0wH1yvE=;
 b=iqD2nhLN2CmlmOLnPtWzW831mFDMo7hhFht6lj613sXiDTB94jWNNVW/DptKYP38N+
 pkeUucsYjeujk/a+vLSk8aIY2MCOLRQp9hpTmegF6anOgK7fbB4/XAFN0GsFGwEmSOJA
 naRWRJFaT8j12dBltBSxZFvElE9NJUGsaZ+mYBlmUYTL5t+jZlywHFolIpmWwklBuvQp
 dkWuJGUTEhgmDN1BxQeC7/3JjA1vy3RN3llTTPVnE3wN5tKMpSDI4YgmXGaxaXhANFNz
 Plookl6rqC7Et9aU3WiqW2m5GRmgtST65Vy3OxCieFkd+TBNbmjVBQOlogN3BfwAHmZE
 DgQg==
X-Gm-Message-State: ANhLgQ1VDv5qxe+jxIHagF05F60bay8aiRbCcXsGYBfNIy83YHxYhC7l
 Bplul2Qk91/huV69IUV2yHxiGkYurlnWeatOt5j23beC4rrperv5jDCWQ3WaWVc59pQPukfbxZO
 g6CK/J9kIipjCqoA=
X-Received: by 2002:a50:c25a:: with SMTP id t26mr20401635edf.20.1584957905539; 
 Mon, 23 Mar 2020 03:05:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuByPTBAFOM/kRuIU2X4gcAFSDYW9M38xNM+0JlHjckrJEiBRajF6X/wBRKngK8Hun5t7phEQ==
X-Received: by 2002:a50:c25a:: with SMTP id t26mr20401596edf.20.1584957905159; 
 Mon, 23 Mar 2020 03:05:05 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d20sm958529edn.12.2020.03.23.03.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 03:05:04 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Add a KVM-only s390x job
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200322154015.25358-1-philmd@redhat.com>
 <87k13bbdd2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a0ed626-c571-f1f2-1c4f-31eaaef84d6a@redhat.com>
Date: Mon, 23 Mar 2020 11:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k13bbdd2.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 10:59 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Add a job to build QEMU on s390x with TCG disabled, so
>> this configuration won't bitrot over time.
>=20
> Queued to testing/next, thanks.

Thanks!

>=20
> This only tests the build though - we don't exercise KVM doing this.

Yes, we need to fix the migration autoconverge test to run KVM tests.

>=20
>>
>> This job is quick, running check-unit: Ran for 5 min 30 sec
>> https://travis-ci.org/github/philmd/qemu/jobs/665456423
>>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 5672d129ec..e0c72210b7 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -525,6 +525,48 @@ jobs:
>>                 $(exit $BUILD_RC);
>>             fi
>>  =20
>> +    - name: "[s390x] GCC check (KVM)"
>> +      arch: s390x
>> +      dist: bionic
>> +      addons:
>> +        apt_packages:
>> +          - libaio-dev
>> +          - libattr1-dev
>> +          - libbrlapi-dev
>> +          - libcap-ng-dev
>> +          - libgcrypt20-dev
>> +          - libgnutls28-dev
>> +          - libgtk-3-dev
>> +          - libiscsi-dev
>> +          - liblttng-ust-dev
>> +          - libncurses5-dev
>> +          - libnfs-dev
>> +          - libnss3-dev
>> +          - libpixman-1-dev
>> +          - libpng-dev
>> +          - librados-dev
>> +          - libsdl2-dev
>> +          - libseccomp-dev
>> +          - liburcu-dev
>> +          - libusb-1.0-0-dev
>> +          - libvdeplug-dev
>> +          - libvte-2.91-dev
>> +          # Tests dependencies
>> +          - genisoimage
>> +      env:
>> +        - TEST_CMD=3D"make check-unit"
>> +        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --d=
isable-tools"
>> +      script:
>> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>> +        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
>> +        - |
>> +          if [ "$BUILD_RC" -eq 0 ] ; then
>> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
>> +              ${TEST_CMD} ;
>> +          else
>> +              $(exit $BUILD_RC);
>> +          fi
>> +
>>       # Release builds
>>       # The make-release script expect a QEMU version, so our tag must s=
tart with a 'v'.
>>       # This is the case when release candidate tags are created.
>=20
>=20


