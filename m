Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF750C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8987E2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxbnlUfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8987E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiXp-0006xL-OU
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieiWg-00068L-4L
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieiWc-0002OA-C3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:38:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieiWa-0002Nc-EP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575995891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tk9zUsPUOUkFHWSFqxNcwB5t8u11MSGyU2vMilOzNIA=;
 b=UxbnlUfxID8MlehoGKAXvC2tSP+GbtqatstMVMzP2N7N4oeLkBcPk7Vo1qHibLoS8oe355
 qAmAVYvKD08BsbzQU8NH9DiSuLCV1zyhvtjBtPX3FC1pdK+0AnUAjW3SXu0+Yx++ClV/ey
 VlgvyyteLakoAww7THcmNN8kfHzMpPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-h8PAnNy4OjiC2pG75VAYaA-1; Tue, 10 Dec 2019 11:38:09 -0500
Received: by mail-wm1-f71.google.com with SMTP id 18so1222751wmp.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mREBnZHOKeVpk5+/+P2sv7KE5LHLe6gTzu2pCFvlRnA=;
 b=P+eyEFEOTRDDUg7e5FlQzLeUnTICY6keOFrcNywUfrXcglSWDo/CcnnhkUNg5Q3b9s
 uFV95mpU6onIll/C5PyYaiKNI6Ccs7lORbsJT5avQ8rhAGcoMDR/FMwePK1HKlLuM+Tk
 UUAwKdw8OTSyRl3URV3n2G6Qc84SfI1HhUq5aaNJ+O51YaCCG4Hd0YVpEY08Li7O0D2d
 CpZ80xgr4NOljLgK2f2gTkqUjQE88Dinp8haQr6nElPuFYTEBT4Ha/GlCcQhOTqJIUSr
 PLYQEBy/MsPN8uIp2gYSjaKBNo3zuEx0V4CU174NlVIYcGuMu11WDrCs7aRHCBwd+Ry6
 laEw==
X-Gm-Message-State: APjAAAU3P+q278TbKzRv2uctwKZZo20hi8f3zj1g9rhe76kIvinahun+
 /aEqLjRmszurG92lVIMjfIyXuWjajNXs+UUnUtGKXOhXxkTF8IOlNP5ACiJrafZUQitEaPW9uZt
 lzug2T0RCcbEvm1Y=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr581018wma.138.1575995888289; 
 Tue, 10 Dec 2019 08:38:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCuMvjdC0fENOPCU8lKNcINoUMCz52bWa4TPg/wjVUlDUl75Q231H5dIrceVfy5GePr+PI6Q==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr581000wma.138.1575995888102; 
 Tue, 10 Dec 2019 08:38:08 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o15sm3908051wra.83.2019.12.10.08.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 08:38:07 -0800 (PST)
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
 <20191205141212.6cb05ac7.cohuck@redhat.com>
 <87d0d1orco.fsf@dusky.pond.sub.org>
 <20191209193305.7108b3e9.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef45f3a1-7683-3b14-1096-ec083b29ea5d@redhat.com>
Date: Tue, 10 Dec 2019 17:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209193305.7108b3e9.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: h8PAnNy4OjiC2pG75VAYaA-1
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 7:33 PM, Cornelia Huck wrote:
> On Fri, 06 Dec 2019 08:17:27 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
>> Cornelia Huck <cohuck@redhat.com> writes:
>>
>>> On Thu, 5 Dec 2019 14:05:19 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>  =20
>>>> Hi Cornelia,
>>>>
>>>> On 12/5/19 12:53 PM, Cornelia Huck wrote:
>>>>> The Posix implementation of guest-set-time invokes hwclock to
>>>>> set/retrieve the time to/from the hardware clock. If hwclock
>>>>> is not available, the user is currently informed that "hwclock
>>>>> failed to set hardware clock to system time", which is quite
>>>>> misleading. This may happen e.g. on s390x, which has a different
>>>>> timekeeping concept anyway.
>>>>>
>>>>> Let's check for the availability of the hwclock command and
>>>>> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>>>>>
>>>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>> ---
>>>>>
>>>>> v2->v3:
>>>>>     - added 'static' keyword to hwclock_path
>>>>>
>>>>> Not sure what tree this is going through; if there's no better place,
>>>>> I can also take this through the s390 tree.
>>>>
>>>> s390 or trivial trees seems appropriate.
>>>>   =20
>>>>>
>>>>> ---
>>>>>    qga/commands-posix.c | 13 ++++++++++++-
>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>>>> index 1c1a165daed8..0be301a4ea77 100644
>>>>> --- a/qga/commands-posix.c
>>>>> +++ b/qga/commands-posix.c
>>>>> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t t=
ime_ns, Error **errp)
>>>>>        pid_t pid;
>>>>>        Error *local_err =3D NULL;
>>>>>        struct timeval tv;
>>>>> +    static const char hwclock_path[] =3D "/sbin/hwclock";
>>>>> +    static int hwclock_available =3D -1;
>>>>> +
>>>>> +    if (hwclock_available < 0) {
>>>>> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
>>>>> +    }
>>>>> +
>>>>> +    if (!hwclock_available) {
>>>>> +        error_setg(errp, QERR_UNSUPPORTED);
>>>>
>>>> In include/qapi/qmp/qerror.h we have:
>>>>
>>>> /*
>>>>    * These macros will go away, please don't use in new code, and do n=
ot
>>>>    * add new ones!
>>>>    */
>>>
>>> Sigh, it is really hard to keep track here :( I just copied from other
>>> callers in this file...
>>
>> I'm not faulting you for that.
>>
>> I think this new use is acceptable.  For details, see my other reply in
>> this thread.
>=20
> Ok, thanks for your explanation there.
>=20
> I guess I'll queue this on s390-next... Philippe, any objections to
> adding your R-b to the unmodified patch?

Certainly, sorry for the delay/noise on this trivial patch, I learned=20
the subtle differences between comments in code and reality :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


