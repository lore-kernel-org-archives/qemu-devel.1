Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB5CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C862B20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUbHtWCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C862B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkBU-0005ms-SS
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGk9T-0002gF-R5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGk9S-0007Pw-JB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:03:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGk9S-0007Oz-FL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585058609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juIMHLI96VCVyrxsRndVzMKR/HXrBBtiOY1aVuEcyuE=;
 b=EUbHtWCcVYZuh9NH/TAy+vcCqILa4w9egjESxgoMeQ49GUFTWPfKMz80OZU47TNY3NlsY5
 +nOheUGVMXdR5NQn9i0cr/yFbxXcD3n8Mu0AIZO0BzTVhUh6yky+2e3f6MOPtNAaY71tYK
 BfqskkZyYVZymDFob3MeLogDrTC0Vt4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-qYt6Io7bOu2pQjKE5gGJpg-1; Tue, 24 Mar 2020 10:03:25 -0400
X-MC-Unique: qYt6Io7bOu2pQjKE5gGJpg-1
Received: by mail-ed1-f70.google.com with SMTP id g7so8511421edm.20
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I8rYr82Z1o8Wwy+tcURzqQWWMz4RIV7JMG8uGtdc9Gc=;
 b=XvXh0DYR1/wMfxAf0ICZQgExV+53cG+1OabYrhLxbHT4JC6RHbhmiCq4wRxUQbsUWc
 8QdqjUbBVb0abyfVuFjaaSBEyu+OSSW/3ExNiQTTvvAyJEP4BgEiYfKVilpFubOT/x38
 VOw2M5wTyLTqmTZGzreHc/fzyJMFD1QQm9FzSCRujM9tu27MPirUi5soSEAU4LxK8hTj
 +m5Eos0XfTK4hJrsOjPXoDSGUhVoXAekrJGNKl8on2PwbcVz3h6NqEp2Z2Ul8oORzCpb
 lJ/SokthdaLhNldm8OiEx6TDQBDBQkwr/gkXdUGxUPwBg0dWIYHXVI0ETprXaV2VUgSj
 02Aw==
X-Gm-Message-State: ANhLgQ1pI+s3IlPOFtkD/3AUpaGmNQhoswMIGib8+GeMsS6Rs7d24stD
 idlf4Hk5VWk3yU2LCL3zUq+wg2HjuFjVx45ouBRlFhcngA4rtQfkqIX2vmUmw5vf+poaW040okH
 0vNySedZQIYkDQgw=
X-Received: by 2002:a05:6402:282:: with SMTP id
 l2mr26814137edv.269.1585058604253; 
 Tue, 24 Mar 2020 07:03:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu7BACwdQLLv/lBEquRaBlHdK3v0vmPY7/ZRrDmvYzPGsvim9LD2MTxjoEwkODF/vnCoWofmw==
X-Received: by 2002:a05:6402:282:: with SMTP id
 l2mr26814116edv.269.1585058604064; 
 Tue, 24 Mar 2020 07:03:24 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y12sm451128ejj.41.2020.03.24.07.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 07:03:23 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] qga: Installer: Wait for installation to finish
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200311170417.13415-1-basil@daynix.com>
 <20200311170417.13415-2-basil@daynix.com>
 <7d6f3f43-73c6-8500-6680-05ec059fd5ed@redhat.com>
 <CAJ+F1CJtMsXHGQAKS-FjFM-1i445uV7P0BfYCJ78d7TasUL+Ww@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6d24621-9f86-f0a1-944f-44b7acd0498d@redhat.com>
Date: Tue, 24 Mar 2020 15:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJtMsXHGQAKS-FjFM-1i445uV7P0BfYCJ78d7TasUL+Ww@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 3:00 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Mar 24, 2020 at 2:13 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Hi Basil,
>>
>> On 3/11/20 6:04 PM, Basil Salman wrote:
>>> Installation might fail if we don't wait for the provider
>>> unregisteration process to finish.
>>>
>>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>> Signed-off-by: Basil Salman <basil@daynix.com>
>>> ---
>>>    qga/installer/qemu-ga.wxs | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
>>> index 64bf90bd85..f6781752e6 100644
>>> --- a/qga/installer/qemu-ga.wxs
>>> +++ b/qga/installer/qemu-ga.wxs
>>> @@ -81,7 +81,7 @@
>>>                  Arguments=3D"-d --retry-path"
>>>                  >
>>>                </ServiceInstall>
>>> -            <ServiceControl Id=3D"StartService" Start=3D"install" Stop=
=3D"both" Remove=3D"uninstall" Name=3D"QEMU-GA" Wait=3D"no" />
>>> +            <ServiceControl Id=3D"StartService" Start=3D"install" Stop=
=3D"both" Remove=3D"uninstall" Name=3D"QEMU-GA" Wait=3D"yes" />
>>
>> As 'yes' is the default, can you simply remove 'Wait=3D"no"'?
>=20
> It looks like wixl doesn't follow the WiX default value though.
>=20
> tools/wixl/msi.vala:
> 574                 (Wait !=3D null && !rec.set_int (5, Wait ? 1 : 0)) ||

I trusted the documentation...
https://wixtoolset.org/documentation/manual/v3/xsd/wix/servicecontrol.html

Thanks for looking at the implementation.

So for this patch:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>
>>>              </Component>
>>>              <?ifdef var.InstallVss?>
>>>              <Component Id=3D"qga_vss_dll" Guid=3D"{CB19C453-FABB-4BB1-=
ABAB-6B74F687BFBB}">
>>>
>>
>>
>=20
>=20


