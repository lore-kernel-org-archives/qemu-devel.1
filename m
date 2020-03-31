Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D57DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118DE2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S61R1k6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118DE2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHhL-00070e-8c
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHgD-00065F-J4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHgC-0005mM-2o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHgB-0005lz-Vd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585664147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oxso927x97hdHJlU+RKi6XuEqFvZ7OiSELmHUZUyRog=;
 b=S61R1k6fgesulD5rLavNzo/b8CZuiaYtEdFm1xDDoNi+ejenZBw1X31iQDzkbPCH6Fr6Cm
 y9LMgARhEh9CU3szl088V8s/7fabY3fyZnDUNBDNL1LaKw7UeuZH+HF3ODEYxvHP20pKnz
 +aQmOH1gHBhmrjTv9tFQoyX3a0UhsU8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-M4nP_K-QO_us4oDk2q3w_w-1; Tue, 31 Mar 2020 10:15:45 -0400
X-MC-Unique: M4nP_K-QO_us4oDk2q3w_w-1
Received: by mail-ed1-f69.google.com with SMTP id f11so6469845edc.4
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K3ROROyyjzmny0eR4g/9MTuKttnSw1HZfaAFtjP4boE=;
 b=tgJLsoY0xm+BB8LXBl+ZpSEAZRTaqA5blYx9povLbGKqDJG8hOhBUbVphNAPggNSA7
 ehdFzOlygNo46kw5hmBX8rqP9EKE1ncv6InN6yhh+t23+PoA1ktTufvSbO3LlnHXn34L
 ZlQK6V2Y5O31zsoK/IUEY5mj5mjZOugk2+MpvikvemVjIqz5NR2YNo1qVhF8d6rvCXek
 oCi0nqY3hy6eMeCT9pdE3/ZRu5ItTpIOoLYsqiuU1IJP2EjpUWNPkJ14nEHPRoLGc8hU
 jywj2EWhAA96iYEpgnihnnpqSF071WcAunpSeY9cqy+gt/RpPdbiSrdzzfpKZ0oWYpVS
 2Zcg==
X-Gm-Message-State: ANhLgQ1v9P6q/j+onos5uMsfJ4VjBplQ+HL9YuzrYCPI6ZgUHhbEUv2n
 VibB1pIMneSv1fbU7snjg01vUx18fGvhbck0rUj3+o4yHo85JBnNYL6BKauANocjKdtO7v/j6K4
 v3YX8Pj5gIhwXNSs=
X-Received: by 2002:a17:906:814b:: with SMTP id
 z11mr15926221ejw.270.1585664143945; 
 Tue, 31 Mar 2020 07:15:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstTtlxHOqnLB0sbjy8jacmQmae2uHpj5FwLvrwNk1iu0h40cLrH4h1rNrbjyV4sEzpQGs6Fg==
X-Received: by 2002:a17:906:814b:: with SMTP id
 z11mr15926186ejw.270.1585664143665; 
 Tue, 31 Mar 2020 07:15:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 9sm1557529ejv.54.2020.03.31.07.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 07:15:42 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 1/4] Revert "prevent crash when executing
 guest-file-read with large count"
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-2-philmd@redhat.com>
 <20200331141205.GI353752@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5c7a35b-c36f-1501-8060-1819be878c96@redhat.com>
Date: Tue, 31 Mar 2020 16:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331141205.GI353752@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Sameeh Jubran <sjubran@redhat.com>,
 Basil Salman <basil@daynix.com>, Dietmar Maurer <dietmar@proxmox.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 4:12 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 31, 2020 at 04:06:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> By using g_try_malloc() instead of g_malloc() the qemu-guest-agent
>> Denial-of-Service attack referred in commit 807e2b6fce is reduced,
>> but still triggerable:
>=20
> As explained previously, I believe there is *no* denial of service
> attack here. The described scenario is just a user hurting themselves
> by intentionally telling QEMU not to limit the amount of data returned.

Yes. Do you mind updating the BZ, eventually marking as NOTABUG? Then I=20
can adapt the patch descriptions.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054

>=20
>>
>>    - bisect file size S until g_try_malloc(S) fails,
>>    - use S - 1:
>>      g_try_malloc(S - 1) succeeds, but g_new0() few lines later will
>>      fail.
>>
>>   346     buf =3D g_try_malloc0(count + 1);
>>   347     if (!buf) {
>>   348         error_setg(errp,
>>   349                    "failed to allocate sufficient memory "
>>   350                    "to complete the requested service");
>>   351         return NULL;
>>   352     }
>>   353     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>>   354     if (!is_ok) {
>>   355         error_setg_win32(errp, GetLastError(), "failed to read fil=
e");
>>   356         slog("guest-file-read failed, handle %" PRId64, handle);
>>   357     } else {
>>   358         buf[read_count] =3D 0;
>>   359         read_data =3D g_new0(GuestFileRead, 1);
>>                           ^^^^^^
>>
>> Instead we are going to put a low hard limit on 'count' in the next
>> commits.
>> This reverts commit 807e2b6fce022707418bc8f61c069d91c613b3d2.
>>
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qga/commands-win32.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index b49920e201..46cea7d1d9 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -343,13 +343,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, =
bool has_count,
>>       }
>>  =20
>>       fh =3D gfh->fh;
>> -    buf =3D g_try_malloc0(count + 1);
>> -    if (!buf) {
>> -        error_setg(errp,
>> -                   "failed to allocate sufficient memory "
>> -                   "to complete the requested service");
>> -        return NULL;
>> -    }
>> +    buf =3D g_malloc0(count + 1);
>>       is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>>       if (!is_ok) {
>>           error_setg_win32(errp, GetLastError(), "failed to read file");
>> --=20
>> 2.21.1
>>
>=20
> Regards,
> Daniel
>=20


