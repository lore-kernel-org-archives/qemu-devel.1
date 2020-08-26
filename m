Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12326C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC3E2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afL460Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC3E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxUw-0004ll-68
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxUC-0004FZ-Es
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:37:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxUA-0007Wm-RF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0oJ/z7WZGG75qeb7XsSaXaW3lQnYj4dNmTjkoDOzjg=;
 b=afL460Bjw3VOwnPMNR6OBqWyJd0oO7wiFPahT5QXiPvJHgi3tRjUVwoPpJ+wPoIQPK2bBt
 b0uyClGYPOhp1PwfCy5UGMvV1Y/XA9cyy/cxrKH2SOOfOhxC2iUzqWDiaaqLlCVAV+Gl0N
 u8hkW1UpsAOahQApokM8v2NLcZzkPX4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-7DpdQpy-OsOB8X_2IAsn5Q-1; Wed, 26 Aug 2020 11:37:08 -0400
X-MC-Unique: 7DpdQpy-OsOB8X_2IAsn5Q-1
Received: by mail-ej1-f69.google.com with SMTP id o10so1156044eji.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A0oJ/z7WZGG75qeb7XsSaXaW3lQnYj4dNmTjkoDOzjg=;
 b=JSAJkf4/UA2Lyg7JALVLkmFryDlQB7TeY7L2+VOPlEsP6sgn9/sCkIiJ1DBVr55ORz
 Z9QwWnkUrqB/cmwyFZNSiP2Kgnr4MsSmxeojiJLe47WkurEhCsmEnq/ojIpyMKHMmSag
 BOxBTAieBXQkD7VU3ABDwqZd3AbwXCApEFxOcw6lWQDkiOOYnp/OV7HZ7oOQlqYY8R60
 FjaX4SPHkDKspPDuYoFty/IIoYsbqLMqsYaBkvoEuoY+zGoD7XcIVg46jusoClx+ZDuY
 CtwXx+O5P6NZ00if68EZogGr6sRgIgi2dFEXnGehzwS7PHtfTPaMNa6I3YbProKWdKlN
 KdoQ==
X-Gm-Message-State: AOAM532cqUe/MoVd+3usIwvQTG1p6XrUgP7eTpmIyaoAKxU/sq646mL2
 WmxNz2tQQpW977x6/UlLPn6dKrnlnD6QjgaWcymNp7piKs8BfSFESHdrZt6RTViFad8U0VZnb74
 0Dl8UczLPLxtB3NawCFIyirBj7zyTRqE=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr15394399edt.76.1598456227005; 
 Wed, 26 Aug 2020 08:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxItwUFk+DI7hFuT1Qs0b4GvQp/6PQ4YDfl2FU/pQbBrgZsyCywn8xePBbFwYbCn60xXH/bci8M+bFoWo6bRcY=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr15394373edt.76.1598456226714; 
 Wed, 26 Aug 2020 08:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
In-Reply-To: <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:36:55 +0200
Message-ID: <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:31 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
> I can tell you build.ninja can contains $: symbol, that's the escape for =
Ninja,
> when ninjatool parse it, it will convert $: -> :, so that's not a problem=
.
> This is part of the build.ninja on my computer

Ok, that's useful. But can you just send the whole file (it's huge but
you can gzip it or something similar)?

Paolo

> ```
> build version.rc_version.o: CUSTOM_COMMAND_DEP ../qemu.org/version.rc | C=
$:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE ../qemu.org/p=
c-bios/qemu-nsis.ico
>  DEPFILE =3D "version.rc_version.o.d"
>  DEPFILE_UNQUOTED =3D version.rc_version.o.d
>  COMMAND =3D "C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.E=
XE" "-I./." "-I../qemu.org/." "../qemu.org/version.rc" "version.rc_version.=
o" "--preprocessor-arg=3D-MD" "--preprocessor-arg=3D-MQversion.rc_version.o=
" "--preprocessor-arg=3D-MFversion.rc_version.o.d"
>  description =3D Generating$ Windows$ resource$ for$ file$ 'version.rc'$ =
with$ a$ custom$ command
> ```
>
> On Wed, Aug 26, 2020 at 11:28 PM Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>>
>> On Wed, Aug 26, 2020 at 5:12 PM <luoyonggang@gmail.com> wrote:
>> >
>> > From: Yonggang Luo <luoyonggang@gmail.com>
>> >
>> > SIMPLE_PATH_RE should match the full path token.
>> > Or the $ and : contained in path would not matched if the path are sta=
rt with C:/ and E:/
>>
>> I don't understand this, SIMPLE_PATH_RE is used with re.match which
>> only matches at the beginning of the string. Can you send me your
>> build.ninja file offlist?
>>
>> Thanks,
>>
>> Paolo
>>
>
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo


