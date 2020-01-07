Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA8AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E8A20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw6u/ELI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E8A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq52-00041K-Ku
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ioobT-0006mR-7E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ioobS-0002Qf-1K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:08:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ioobR-0002QF-U0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578402537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd5D1/Mo04YP1gum04D/CLbfkhw2V+UTQeme1m/yReQ=;
 b=Qw6u/ELIzGVaJdW2ZCY16HQBTGudrRBYXSsuunrjqHZfDGX5Bk2AUuKLa6oYH6/J+xzylX
 n0l6Ari1ZsgcS1seO/hVgMtzN0PMKoZ1o+PzvX6BPgp3uoGy4kZ4MnHipHVS4bua42RtGH
 XarNGvaLfCmMIU4QojqUaK+wOTDXyo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-jq76exXkPeuAYrsjsy0F7A-1; Tue, 07 Jan 2020 08:08:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E31DA10054E3
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:08:52 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 449C97DB3E;
 Tue,  7 Jan 2020 13:08:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 07/10] migration: Make no compression operations into
 its own structure
In-Reply-To: <20200103182038.GS3804@work-vm> (David Alan Gilbert's message of
 "Fri, 3 Jan 2020 18:20:38 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-8-quintela@redhat.com>
 <20200103182038.GS3804@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 14:08:47 +0100
Message-ID: <87r20bpg68.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jq76exXkPeuAYrsjsy0F7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> It will be used later.
>>=20
>> +static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error=
 **errp)
>> +{
>> +    if (p->flags !=3D MULTIFD_FLAG_NOCOMP) {
>> +        error_setg(errp, "multifd %d: flags received %x flags expected =
%x",
>> +                   p->id, MULTIFD_FLAG_NOCOMP, p->flags);
>
> That looks the wrong way around to me - shouldn't that be
>    p->flags, MULTIFD_FLAG_NOCOMP
> ?

Good catch.
>> =20
>>          qemu_mutex_init(&p->mutex);
>>          qemu_sem_init(&p->sem, 0);
>> @@ -1240,8 +1405,12 @@ int multifd_save_setup(Error **errp)
>>          p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
>>          p->name =3D g_strdup_printf("multifdsend_%d", i);
>>          socket_send_channel_create(multifd_new_send_channel_async, p);
>> +        res =3D multifd_send_state->ops->send_setup(p, errp);
>> +        if (ret =3D=3D 0) {
>> +            ret =3D res;
>
> How do you handle the errp's here - I think that if is so that you
> get the 'ret' from the first thread that fails; but I don't think you're
> allowed to call that twice if the first one set it's errp.

You are right.  I was doing the res/ret variable right, and failed with
the other.  Changed the code to two loops:
- Everything that can't fail, done in the 1st loop.
- Everything else on the second loop.  the time that we have one error,
  we just stop the loop.
>> @@ -1448,6 +1622,10 @@ int multifd_load_setup(Error **errp)
>>                        + sizeof(ram_addr_t) * page_count;
>>          p->packet =3D g_malloc0(p->packet_len);
>>          p->name =3D g_strdup_printf("multifdrecv_%d", i);
>> +        ret =3D multifd_recv_state->ops->recv_setup(p, errp);
>> +        if (ret !=3D 0) {
>> +            return ret;
>> +        }
>
> same question as the save case above

Same solution.

Thanks, Juan.


