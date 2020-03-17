Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291D120663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPdfHFkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291D120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9h0-0007RR-AL
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9Co-0006nM-K0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9Cn-0007xD-1u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:12:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9Cm-0007sc-SK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584439932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wczHtPnFUm/B8CYddn2fGF8jAaaMjSval7XhFyORwt4=;
 b=JPdfHFkvv9m/VNnlJ9EKuUkWJ0vrsZPOAtxA9bkKN2sHFeEIarnza2X/7SMmuQPkIdA882
 Lx76f4GNP1CeixdI/Q7rFrbhgZ6fMzPdkjZlJ3+5nUSbytI9B9lV+a4NZ5gp+WjsOGEfpZ
 ht7smb9qCzZiqjmiFmOhdxFQvy6Ya8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-MBbhNVwmOzyYMOCmuRfAXg-1; Tue, 17 Mar 2020 06:12:10 -0400
X-MC-Unique: MBbhNVwmOzyYMOCmuRfAXg-1
Received: by mail-wm1-f71.google.com with SMTP id s15so3969971wmc.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23YmDj573kSY71NN04yCleqJPaB6Ug3awN2eCamQcr4=;
 b=tHOooA/RM7jcCgV95cCR/bZK8GwQHuw1e6m5OWXARsaXIgSykX4d6xJsj4pv6TbQi9
 8yDVBBFEY7mzcW0NCMjsShexZtxodjxgDVuxkm8RhSwtabRWWEnqkMH0Cocs8vklFcl4
 jVH4QoqaHnE6wlBApt5tK2AC9pj/9VLocc50Sz2uA7XrdYC53cqCfKhdR84b6uq1JxaK
 TKcGEDv5mDGr9/lC8+wkQkmpnM8f5bGV8G+SHQttEOCQgJWvfxSjkPRCU11tlmtZF5Cd
 KANy3nwUpPy52wOktMa06JqE3i7j6YcVbnDVR+iaWDLb+rNvCEr7HIuib2rRaikGyiFO
 GxDA==
X-Gm-Message-State: ANhLgQ3uwAoYPAU9ttsM2+cbyrDkozBMQE1IcFSN88dSW7AEfgUgGo4g
 o/ixYOxHYcRmZnGr+vvOPsCURkHQHKzagj00aW4iE3tBcnEXfKRDrUdDeLF5u13mUZbhvVfnRPK
 8cazQzEZnhwCiooU=
X-Received: by 2002:adf:a40d:: with SMTP id d13mr5152969wra.336.1584439929528; 
 Tue, 17 Mar 2020 03:12:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvsj4FyWhYWEUpLTEsKcFXnH8NKbTvtbBKHav2XX35uKWdtDVmxL3PTBXDe37/50rUNt2I+8A==
X-Received: by 2002:adf:a40d:: with SMTP id d13mr5152925wra.336.1584439929198; 
 Tue, 17 Mar 2020 03:12:09 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id i12sm3990664wro.46.2020.03.17.03.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:12:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
To: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
 <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
 <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
 <20200317095222.GB492272@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eeede616-a22d-9d82-4c86-65f1ab4aef73@redhat.com>
Date: Tue, 17 Mar 2020 11:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317095222.GB492272@stefanha-x1.localdomain>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:52 AM, Stefan Hajnoczi wrote:
> On Mon, Mar 16, 2020 at 01:15:35PM -0500, Eric Blake wrote:
>> On 3/16/20 1:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
>>>> gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
>>>> reports the following error:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration/g=
lobal_state.o
>>>>  =C2=A0=C2=A0 In file included from /usr/include/string.h:495,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /home/stefanha/qemu/incl=
ude/qemu/osdep.h:101,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from migration/global_state.c=
:13:
>>>>  =C2=A0=C2=A0 In function =E2=80=98strncpy=E2=80=99,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inlined from =E2=80=98global_sta=
te_store_running=E2=80=99 at
>>>> migration/global_state.c:47:5:
>>>>  =C2=A0=C2=A0 /usr/include/bits/string_fortified.h:106:10: error:
>>>> =E2=80=98__builtin_strncpy=E2=80=99 specified bound 100 equals destina=
tion size
>>>> [-Werror=3Dstringop-truncation]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 106 |=C2=A0=C2=A0 return __builtin___strncpy=
_chk (__dest, __src, __len,
>>>> __bos (__dest));
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Use pstrcpy() instead of strncpy().=C2=A0 It is guaranteed to NUL-term=
inate
>>>> strings.
>>>
>>> There was a long discussion 1 year ago with it, and Eric suggested to
>>> use strpadcpy after the assert() and I sent this patch:
>>> https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
>>> Not sure what's best.
>>
>> strncpy() pads the tail, guaranteeing that for our fixed-size buffer, we
>> guarantee the contents of all bytes in the buffer.  pstrcpy() does not (=
but
>> pstrcpy() can be followed up with a memset() to emulate the remaining
>> effects of strncpy() - at which point you have reimplemented strpadcpy).
>>
>>>
>>>>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> ---
>>>>  =C2=A0 migration/global_state.c | 4 ++--
>>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/migration/global_state.c b/migration/global_state.c
>>>> index 25311479a4..cbe07f21a8 100644
>>>> --- a/migration/global_state.c
>>>> +++ b/migration/global_state.c
>>>> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *state =3D RunState_str(RUN=
_STATE_RUNNING);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(strlen(state) < sizeof(global_s=
tate.runstate));
>>>> -=C2=A0=C2=A0=C2=A0 strncpy((char *)global_state.runstate,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state, s=
izeof(global_state.runstate));
>>>> +=C2=A0=C2=A0=C2=A0 pstrcpy((char *)global_state.runstate,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
zeof(global_state.runstate), state);
>>
>> Can we guarantee that the padding bytes have been previously set to 0, o=
r do
>> we need to go the extra mile with a memset() or strpadcpy() to guarantee
>> that we have set the entire buffer?
>=20
> I don't understand GlobalState:
>=20
> 1. You ask if runstate[] must be padded with NULs but neither
>     global_state_store() nor register_global_state() do that.  Is it
>     really necessary to pad runstate[]?
>=20
>     If yes, is it safe for global_state_store() and
>     register_global_state() to not pad runstate[]?
>=20
>     If we decide the pad runstate[] to prevent information leaks to the
>     migration destination then I think it should be done in the pre-save
>     function so that it's guaranteed to happen no matter which of the 3
>     functions that write runstate[] has been called.
>=20
> 2. There is a GlobalState::size field that is only written and then
>     migrated but never read from what I can tell.  :?

Isn't it in process_incoming_migration_bh()?

     /* If global state section was not received or we are in running
        state, we need to obey autostart. Any other state is set with
        runstate_set. */
     ...
     runstate_set(global_state_get_runstate());

>=20
> Juan: Please clarify the above.  Thanks!
>=20


