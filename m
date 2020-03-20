Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD181C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796B720739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcEDS07c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796B720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFA8-0006ig-Mp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFF9I-000676-Jg
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFF9H-00007C-Fq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:45:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFF9H-00006u-CK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584701106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyKNZW5B1kOWaufE53FsqLDtJWs9vsvQfrGc74QTd+o=;
 b=WcEDS07cwDykq3e90UsN+8yrpSRV3Cw7kDK1vUR3HJQs6naSbMzDSn0hsoJj2Z5TW6nh6H
 9ApeMNyibr+hbkCT8S9hs81nKbT68MtgArBtZVS4XYdWAxlf/PGETLAXN6/OVOP72qBCw5
 ypqpLIznEdYPiCmQPa9a90QgMYgXyPM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-XGTDe-ZOOAqu-Doi3lKbhA-1; Fri, 20 Mar 2020 06:44:48 -0400
X-MC-Unique: XGTDe-ZOOAqu-Doi3lKbhA-1
Received: by mail-ed1-f69.google.com with SMTP id u1so4710648edr.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=egGpWAYXQG7oNsKr6fbAnfDNdOqsqnxNHNSjcUWjIyo=;
 b=iWq+LdNaAYLewRjgjTbAP/iOjuqYFa0afK5lWlZEoweiqSbZwFmN5RU7r2bv3ujrqd
 C+vzm+HAhFr0iKdWVRHTO2b59gs6VuB/hlcH/IF31cO/hGnbGXy0wf0bn4XXZCS7Xmnm
 feVpUmYkZYj1tA8RmIwWkahJsSvlroL89sDtB/OZhxUWedmy5zq+IcyK81SGaCQZhUck
 fwB18FVgg9funQ/qE9Py8RwUj5DgU6RnUhWbiI7o55hJQHsrUi0Y5MOkd1Y2QJG4DQ8C
 Z7XFgzfkxwKfnGjAXWn067PcBe3wmF5QgSZm6I2bBJ8TQvspbWw0J5BNWhXrSCwZDz5k
 D3Ug==
X-Gm-Message-State: ANhLgQ1keedx6kzc/phW3utuTGodtXZdQDXD9dj1RgOCHYZPReVo1KGq
 /x6y0XtiCjNNSI7+qji2PaC4CAnvfsfQ5dN4nlAr+1KG4HgMm3oe3GTlvSYWxJm2PFBIg7kGQfa
 xNX+Vus7ziz1EGNk=
X-Received: by 2002:aa7:cf01:: with SMTP id a1mr7277971edy.282.1584701086918; 
 Fri, 20 Mar 2020 03:44:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuRsdUrMRF7qzhNLda+YRxQzpDRUfUDtF2T0xvIjNF4tfxBaLb9EBKaVBOKldX8bP8jt0QWxQ==
X-Received: by 2002:aa7:cf01:: with SMTP id a1mr7277961edy.282.1584701086694; 
 Fri, 20 Mar 2020 03:44:46 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b15sm317067edn.69.2020.03.20.03.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 03:44:45 -0700 (PDT)
Subject: Re: [QUESTION] Getting configure options for a given QEMU executable?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <CAHiYmc4BaD+Bz3kchga2UCoernvvfq=Zc_wJyti05En-4QAKSA@mail.gmail.com>
 <20200320100325.GB2608355@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3939841b-388b-3241-27db-cda13462f1a6@redhat.com>
Date: Fri, 20 Mar 2020 11:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320100325.GB2608355@redhat.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 11:03 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 20, 2020 at 07:11:03AM +0100, Aleksandar Markovic wrote:
>> Hi,
>>
>> Given a QEMU executable, is there a way to find out the configure option=
s
>> it was built with?
>=20
> No, you need to get the original build logs.
>=20
> The binary should contain the full build version (ie the QEMU version
> and the distro specific package release).
>=20
> On Fedora we build with the "annobin" plugin, which records some info
> about GCC options in the binary, but that's still quite distinct from
> any configure args.
>=20
>> (context: we frequently get bugs involving QEMU built for a particular
>> Linux distribution, and knowledge about its configure options would
>> certainly be helpful while reproducing and debugging)

It should be fairly easy to add an array with the definitions filled by=20
./configure:

- config-host.h
- TARGET-softmmu/config-target.h
- TARGET-softmmu/config-devices.h

>=20
> For Fedora the logs are all publically available at a predictable URL e.g=
.
>=20
> https://kojipkgs.fedoraproject.org/packages/qemu/$VERSION/$RPM-RELEASE/da=
ta/logs/$ARCH/build.log
>=20
> so
>=20
> https://kojipkgs.fedoraproject.org/packages/qemu/4.0.0/5.fc31/data/logs/x=
86_64/build.log
>=20
> Not sure where other distros might store this info. If people have info
> for more distros, perhaps we could create a wiki page making a list of
> where each distro keeps its biuld logs ?
>=20
> Regards,
> Daniel
>=20


